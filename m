From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] install_branch_config: simplify verbose messages logic
Date: Wed, 12 Mar 2014 01:36:57 -0400
Message-ID: <CAPig+cTmdF06PrWboJFNFEGKLCa=3rmGrcPusSsYZxdtfSEewA@mail.gmail.com>
References: <1394584412-7735-1-git-send-email-pawlo@aleg.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Pawe=C5=82_Wawruch?= <pawlo@aleg.pl>
X-From: git-owner@vger.kernel.org Wed Mar 12 06:37:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNbqh-00011a-3S
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 06:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbaCLFg7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2014 01:36:59 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:57552 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbaCLFg6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Mar 2014 01:36:58 -0400
Received: by mail-yk0-f176.google.com with SMTP id 19so25875345ykq.7
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 22:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=NTwsanduobmOsdWR0vCvI9AuGxprJlzzSedZQunbUwg=;
        b=OV8ABkl34Tb0Y6rTKDbxV8vw6/llZfcqxHej9wdiIKYqPPkiWqf3gk6+FXjR/KB9Oj
         nMF8OlP89J9DYbjZmhVoBoGjHFDOo/4IF8EK72SryOrWFFUMSnuFNGxvVVKg6lsVdP2s
         tp215268+yhiOgxF4yKZjxD8o2fGuuF4fksqqRmLbvR2kYYc7XqGYMW0T4bBoyWwu7cp
         BkQK0rqCWLzrSGvs5O9Fy99i9Mtzd39aeB2uJwFLX8GieLA9Zw63b8k6TEMr7gnC4ykX
         0N5mdiJgJvU/EnaqSjOYR2lj7qvezeBlLYN28GZD53jpB2qoSkJJ/Zo0Hm8sMKl+ZeYV
         CdBw==
X-Received: by 10.236.151.198 with SMTP id b46mr58977322yhk.3.1394602617534;
 Tue, 11 Mar 2014 22:36:57 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 11 Mar 2014 22:36:57 -0700 (PDT)
In-Reply-To: <1394584412-7735-1-git-send-email-pawlo@aleg.pl>
X-Google-Sender-Auth: KlIDyfgG7pOmd1uUaGn-NO-nn3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243920>

On Tue, Mar 11, 2014 at 8:33 PM, Pawe=C5=82 Wawruch <pawlo@aleg.pl> wro=
te:
> Replace the chain of if statements with table of strings.
>
> Signed-off-by: Pawe=C5=82 Wawruch <pawlo@aleg.pl>
> ---
> The changes proposed by Junio C Hamano:
> Improvement of indentations. Removed an unused variable.

Better, thanks. More below.

> [1]: http://thread.gmane.org/gmane.comp.version-control.git/243502
> [2]: http://thread.gmane.org/gmane.comp.version-control.git/243849
> [3]: http://thread.gmane.org/gmane.comp.version-control.git/243865

The [n]: notation typically is used for footnotes which you reference
in the running text as [n] (or sometimes [*n*], depending upon
preference). If you're simply listing links to previous attempts, it
would be less confusing to say:

v3: http://...
v2: http://...
v1: http://...

>  branch.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..2a4b911 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -53,6 +53,20 @@ void install_branch_config(int flag, const char *l=
ocal, const char *origin, cons
>         int remote_is_branch =3D starts_with(remote, "refs/heads/");
>         struct strbuf key =3D STRBUF_INIT;
>         int rebasing =3D should_setup_rebase(origin);
> +       const char *message[][2][2] =3D {{{
> +               N_("Branch %s set up to track remote branch %s from %=
s by rebasing."),
> +               N_("Branch %s set up to track remote branch %s from %=
s."),
> +               },{
> +               N_("Branch %s set up to track local branch %s by reba=
sing."),
> +               N_("Branch %s set up to track local branch %s."),
> +               }},{{
> +               N_("Branch %s set up to track remote ref %s by rebasi=
ng."),
> +               N_("Branch %s set up to track remote ref %s."),
> +               },{
> +               N_("Branch %s set up to track local ref %s by rebasin=
g."),
> +               N_("Branch %s set up to track local ref %s.")
> +       }}};
> +       const char *name =3D remote_is_branch ? remote : shortname;
>
>         if (remote_is_branch
>             && !strcmp(local, shortname)
> @@ -77,29 +91,12 @@ void install_branch_config(int flag, const char *=
local, const char *origin, cons
>         strbuf_release(&key);
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote=
 branch %s from %s by rebasing.") :
> -                                 _("Branch %s set up to track remote=
 branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local =
branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local =
branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote=
 ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote=
 ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local =
ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local =
ref %s."),
> -                                 local, remote);
> +               if (origin && remote_is_branch)
> +                       printf_ln(_(message[!remote_is_branch][!origi=
n][!rebasing]),
> +                               local, name, origin);
>                 else
> -                       die("BUG: impossible combination of %d and %p=
",
> -                           remote_is_branch, origin);
> +                       printf_ln(_(message[!remote_is_branch][!origi=
n][!rebasing]),
> +                               local, name);

Shouldn't this logic also be encoded in the table? After all, the
point of making the code table-driven is so that such hard-coded logic
can be avoided. It shouldn't be difficult to do.

The same argument also applies to computation of the 'name' variable
above. It too can be pushed into the the table.

>         }
>  }
>
> --
> 1.8.3.2
