From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Fri, 30 Oct 2015 14:12:54 -0400
Message-ID: <CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEAd-00009y-OH
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760225AbbJ3SMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:12:55 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33353 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbbJ3SMz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:12:55 -0400
Received: by vkgy127 with SMTP id y127so52842582vkg.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 11:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QBlqFs176hbU/hjYySnAkPaJnIU+v4pUs7XCgVH43jc=;
        b=EqIM4DA/g3PoJkP7sbQV3KbsnKp0kjlQ9a7h4E3NPwwXCZ/IlDtGfiWBarahweuLPS
         1fpG18MvfP8mUl+VBvwOoSzybBDVDcvMIUSgjfJUE+YdIaFbXR7CaNMR5AqHVAobjp0u
         l9kpQi0S7OpihTyHUCcVhqIT/CXeDHyQ4NkhYRbfJhKGn/XWNv7M0mVS6SMfP2CVXT6l
         s47DSWtJpMeGesxqxNlMieYKlzHaf24gafqgq+sQeSZe1phoqqALQspVSDsgWCmQmCDi
         gap7j7Alj1aqXmUxnMT4hqJzepsexHB06zRbrmKx7wjRZMS1UWdJbfdEkT08B5fofzVS
         idrg==
X-Received: by 10.31.56.75 with SMTP id f72mr6387563vka.115.1446228774428;
 Fri, 30 Oct 2015 11:12:54 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Fri, 30 Oct 2015 11:12:54 -0700 (PDT)
In-Reply-To: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
X-Google-Sender-Auth: oMTtbw5HFnLULKUGqiNHaSvJMnI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280503>

On Thu, Oct 29, 2015 at 9:23 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Under normal circumstances, and like other git commands,
> git checkout will write progress info to stderr if
> attached to a terminal. This option allows progress
> to be forced even if not using a terminal. Also,
> progress can be skipped if using option --no-progress.
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
> -       opts.verbose_update = !o->quiet && isatty(2);
> +       /**
> +        * Rules to display progress:
> +        * -q is selected
> +        *      no verbiage
> +        * -q is _not_ selected and --no-progress _is_ selected,
> +        *      progress will be skipped
> +        * -q is _not_ selected and --progress _is_ selected,
> +        *      progress will be printed to stderr
> +        * -q is _not_ selected and --progress is 'undefined'
> +        *      progress will be printed to stderr _if_ working on a terminal
> +        */
> +       opts.verbose_update = !o->quiet && (option_progress > 0 ||
> +                                          (option_progress < 0 && isatty(2)));

Does this logic also need to be applied to the other instance where
isatty() is consulted in merge_working_tree()?
