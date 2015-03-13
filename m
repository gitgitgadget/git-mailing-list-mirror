From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/2] reset: enable '-' short-hand for previous branch
Date: Fri, 13 Mar 2015 06:11:48 -0400
Message-ID: <CAPig+cQWZ7_ayMRFnm1U-Xza6FS9aTbHnyXYpAx-2-H4e6vcNA@mail.gmail.com>
References: <CAPig+cSU7X=1Ket8bAXU2JivaSVWw7C_M9ttAhJ_gQur3utsUA@mail.gmail.com>
	<1426025006-18669-1-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:11:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWMZP-0003BO-Lc
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 11:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbbCMKLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 06:11:51 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:44487 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbbCMKLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 06:11:50 -0400
Received: by ykbq200 with SMTP id q200so10000291ykb.11
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zGtqSZLRcXtWBTvatHYRkSZOsfSrA+qVF1OLsfYwukg=;
        b=hkbksgatBbx1uaIYqrSR/YumR0zCMrTZHudigaS5gWZNX6i4Nif+MS/NbesHH5/F2N
         LGjv1B8GsNbqYtJxfHbLRkC5hu4u1HmRPzINjNmehdKdjDMVy/f7LNTGS+Rcx3wKdY1V
         LZGGRMGrZ69mZ/d7usH0ryhP+08YLegLuTnqnkfAoK1ENNpNGMCDtnJv3EkmLgCEeH0X
         WBBa8vLeH+/fYQYJw/JU/c83zfS+LBiknnXnDWK20y8QElkMqTcznaM1ieV31PdRPVws
         eFM4oABzHDAcM2OPwlcSDIUqxRiRbolCz9/JCfIhQ89KIkFDGowD4FL8HYhYqe6AHke6
         7ATQ==
X-Received: by 10.236.10.5 with SMTP id 5mr45891546yhu.148.1426241508983; Fri,
 13 Mar 2015 03:11:48 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Fri, 13 Mar 2015 03:11:48 -0700 (PDT)
In-Reply-To: <1426025006-18669-1-git-send-email-sudshekhar02@gmail.com>
X-Google-Sender-Auth: ehel27AOWuO-dQgNAIJLwk8Hkco
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265411>

On Tue, Mar 10, 2015 at 6:03 PM, Sudhanshu Shekhar
<sudshekhar02@gmail.com> wrote:
> [PATCH v3 1/2] reset: enable '-' short-hand for previous branch

This should be v4, I think, not v3.

> git reset -' will reset to the previous branch. It will behave similar
> to @{-1} except when a file named '@{-1}' is present.

The way this is phrased, the reader is left hanging: "What happens
when a file named @{-1} is present?"

> To refer to a file named '-', use ./- or the -- flag.

A documentation update to reflect this change would be appropriate.
See, for instance, 696acf45 (checkout: implement "-" abbreviation, add
docs and tests;  2009-01-17).

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
> ---
> Eric, I have added a user_input variable to record the input entered
> by the user. This way I can avoid the multiple 'if' clauses. Thank you
> for the suggestion.
>
> I have also removed the unrelated change that I had unintentionally
> committed. I am sending this patch on the thread for further review.
> Once both the patches are reviewed and accepted, I will create a new
> mail for it. Hope that is okay.

Please wrap commentary to about 72 columns, just as you would the
commit message, rather than typing it all on a single line. (I wrapped
it manually here in order to reply to it.)

> diff --git a/builtin/reset.c b/builtin/reset.c
> index 4c08ddc..b428241 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -192,6 +192,8 @@ static void parse_args(struct pathspec *pathspec,
>  {
>         const char *rev = "HEAD";
>         unsigned char unused[20];
> +       int substituted_minus = 0;
> +       char *user_input = argv[0];

You're assigning a 'const char *' to a 'char *'. The compiler should
have warned about it.

This variable name is not as expressive as it could be. Try to name
the variable after what you expect it to represent, for instance
"maybe_rev" or "rev_or_path" or something more suitable. Even
"orig_argv0" would be more informative than "user_input".

>         /*
>          * Possible arguments are:
>          *
> @@ -205,6 +207,10 @@ static void parse_args(struct pathspec *pathspec,
>          */
>
>         if (argv[0]) {
> +               if (!strcmp(argv[0], "-")) {
> +                       argv[0] = "@{-1}";
> +                       substituted_minus = 1;
> +               }
>                 if (!strcmp(argv[0], "--")) {
>                         argv++; /* reset to HEAD, possibly with paths */
>                 } else if (argv[1] && !strcmp(argv[1], "--")) {
> @@ -222,9 +228,12 @@ static void parse_args(struct pathspec *pathspec,
>                          * Ok, argv[0] looks like a commit/tree; it should not
>                          * be a filename.
>                          */
> -                       verify_non_filename(prefix, argv[0]);
> +                       verify_non_filename(prefix, user_input);
>                         rev = *argv++;
>                 } else {
> +                       /* We were treating "-" as a commit and not a file */
> +                       if (substituted_minus)
> +                               argv[0] = "-";

In my review of the previous version[1], I mentioned that it was ugly
to muck with argv[0]; moreover that it was particularly ugly to have
to muck with it multiple times, undoing and redoing assignments.
Although you've eliminated some reassignments via 'user_input', my
intent, by asking if you could rework the logic, was to prompt you to
take a couple steps back and examine the overall logic of the function
more closely. The munging of argv[0] is effectively a fragile and
undesirable band-aid approach. It is possible to support '-' as an
alias for '@{-1}' without having to resort to such kludges at all.

One other concern: When there is no previous branch, and no file named
"-", then 'git reset -' misleadingly complains "bad flag '-' used
after filename", rather than the more appropriate "ambiguous argument
'-': unknown revision or path".

[1]: http://article.gmane.org/gmane.comp.version-control.git/265255

>                         /* Otherwise we treat this as a filename */
>                         verify_filename(prefix, argv[0], 1);
>                 }
> --
> 2.3.1.278.ge5c7b1f.dirty
