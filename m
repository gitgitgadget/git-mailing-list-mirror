From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/2] git add <pathspec>... defaults to "-A"
Date: Mon, 22 Apr 2013 20:42:13 -0400
Message-ID: <CAPig+cTQyxacsCpUs+bSotusOb16kXwGgmxssongr237i=89iA@mail.gmail.com>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
	<1366663435-13598-1-git-send-email-gitster@pobox.com>
	<7vr4i2mbmb.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 02:42:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UURJP-0004gz-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 02:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab3DWAmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 20:42:17 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:60588 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184Ab3DWAmP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 20:42:15 -0400
Received: by mail-la0-f49.google.com with SMTP id ei20so54351lab.8
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 17:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=2jFKYAXEeNSssdk/1IUhD4Ln33Ls8KmlvLW8eW17uQQ=;
        b=U3j0a6wXFv5EqI/DWw2KAbTCN0NCbEIYpiNQMEmfjCi1nu+Y+/Nztep0wosVlEM0Pm
         rhLliO/Uoop2idPPTboBcTCD1DBmgtMxYgPeqAWE38HaAdVlW+s0YlZHyB0S/P9S/V9o
         BlrbQUYQY6lCXKKIB6wfeZ9SxeOveKJr9piEOHZuPN3KZ6QUIwwiSb+f5X4qnHYN1e5a
         7oq4w3zPlkBWUTYbw1thdOt39MfBGBywbCLlFrNXsU9SKBwZGsJYqEhPoMrOAYZQ+qxo
         tASLFHeujBZgDdThKAHI5m9tDRYBAaHRE6LYAK0OmlPdhl8cpP78xFsNYMMnU1W9xIIS
         jJig==
X-Received: by 10.112.172.68 with SMTP id ba4mr14312561lbc.11.1366677733870;
 Mon, 22 Apr 2013 17:42:13 -0700 (PDT)
Received: by 10.114.199.11 with HTTP; Mon, 22 Apr 2013 17:42:13 -0700 (PDT)
In-Reply-To: <7vr4i2mbmb.fsf_-_@alter.siamese.dyndns.org>
X-Google-Sender-Auth: TpaQBV_BXd6ANZBT6dUImzhv1QE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222133>

On Mon, Apr 22, 2013 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 48754cb..77ad391 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -53,8 +53,14 @@ OPTIONS
>         Files to add content from.  Fileglobs (e.g. `*.c`) can
>         be given to add all matching files.  Also a
>         leading directory name (e.g. `dir` to add `dir/file1`
> -       and `dir/file2`) can be given to add all files in the
> -       directory, recursively.
> +       and `dir/file2`) can be given to update the index to
> +       match the current state of the directory as a whole (e.g.
> +       specifying `dir` will record not just a file `dir/file1`
> +       modified in the working tree, a file `dir/file2` added to
> +       the working tree, but also a file `dir/file3` removed from
> +       the working tree.  Note that older versions of  Git used

s/of\s+Git/of Git/

> +       to ignore removed files; use `--no-all` option if you want
> +       to add modified or new files but ignore removed ones.
>
>  -n::
>  --dry-run::
> @@ -129,11 +135,9 @@ of Git, hence the form without <pathspec> should not be used.
>         files that have been removed from the working tree.  This
>         option is a no-op when no <pathspec> is used.
>  +
> -This option is primarily to help the current users of Git, whose
> -"git add <pathspec>..." ignores removed files.  In future versions
> -of Git, "git add <pathspec>..." will be a synonym to "git add -A
> -<pathspec>..." and "git add --ignore-removal <pathspec>..." will behave like
> -today's "git add <pathspec>...", ignoring removed files.
> +This option is primarily to help users who are used to older
> +versions of Git, whose "git add <pathspec>..." was a synonym
> +to "git add --no-all <pathspec>...", i.e. ignored removed files.

s/to/for/ [or] s/to/of/

>
>  -N::
>  --intent-to-add::
