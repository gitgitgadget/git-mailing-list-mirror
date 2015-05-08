From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri, 8 May 2015 13:10:57 -0400
Message-ID: <CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 19:11:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqlnj-0007AR-92
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbbEHRK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:10:58 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33685 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbbEHRK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:10:57 -0400
Received: by iepj10 with SMTP id j10so65228826iep.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=74lCHpnz3+6hnpLk3lRv6axyDWd/BjSwtyzNXtTGWmI=;
        b=qBdihQElfibxDuT43fL0sFD7TCPqdE5AbOb/szJ6u5bmP+xY0lWaBxOLlF5Xx95RDa
         r5Ee7gYdS1gxk9zG2G1mLA2v+KP6TgvTSd9taXqv2QOqW0glPMOASxSnO8caJFgK7oVv
         889SPmu6p84jxLZcytlG0ycY+BnhU8w8SFpeMiryHsrEu/1hA1nrxg6Osam5Z39tzCav
         7lrck1k4wzQTv8m6+LwJqzYXF4rb2o3L2XacWzYMS0POpg36nYLrMzActpMeZVvX7wCh
         evMSrMNjcmZoMSpt28AMAvT5jbiuL21UwEcQYjJ8Qt7xCBXZeMZ3oplI11bCuAR5PXgn
         1cZQ==
X-Received: by 10.42.67.80 with SMTP id s16mr5188265ici.25.1431105057072; Fri,
 08 May 2015 10:10:57 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 8 May 2015 10:10:57 -0700 (PDT)
In-Reply-To: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
X-Google-Sender-Auth: j8uRmu3j08UMGaWyXtUykn5QNXU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268625>

On Fri, May 8, 2015 at 12:53 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> sequencer.c: abbreviate hashs placed in the middle of messages

s/hashs/hashes/

> Printing a 40 character sha1 hash in the middle of a message
> stretches the sentence a lot. Print the abbreviated version
> instead.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> diff --git a/sequencer.c b/sequencer.c
> index c4f4b7d..2a39ab6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -498,20 +498,21 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>                 struct commit_list *p;
>
>                 if (!opts->mainline)
> -                       return error(_("Commit %s is a merge but no -m option was given."),
> -                               sha1_to_hex(commit->object.sha1));
> +                       return error(_("Commit %s... is a merge but no -m option was given."),
> +                               find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));

Are short SHA1's followed by "..." anywhere else in the project? It
seems strange to introduce such usage here.

>                 for (cnt = 1, p = commit->parents;
>                      cnt != opts->mainline && p;
>                      cnt++)
>                         p = p->next;
>                 if (cnt != opts->mainline || !p)
> -                       return error(_("Commit %s does not have parent %d"),
> -                               sha1_to_hex(commit->object.sha1), opts->mainline);
> +                       return error(_("Commit %s... does not have parent %d"),
> +                               find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
> +                               opts->mainline);
>                 parent = p->item;
>         } else if (0 < opts->mainline)
> -               return error(_("Mainline was specified but commit %s is not a merge."),
> -                       sha1_to_hex(commit->object.sha1));
> +               return error(_("Mainline was specified but commit %s... is not a merge."),
> +                       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
>         else
>                 parent = commit->parents->item;
>
> --
> 2.4.0.228.gc627b12
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
