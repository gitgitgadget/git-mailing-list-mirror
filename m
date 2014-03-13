From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] install_branch_config: simplify verbose messages logic
Date: Thu, 13 Mar 2014 18:36:29 -0400
Message-ID: <CAPig+cSh5qRyDnD3hAcdjswGZk+rGzU5ekDbNBTB-XNBSa806Q@mail.gmail.com>
References: <1394668065-14629-1-git-send-email-pawlo@aleg.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Pawe=C5=82_Wawruch?= <pawlo@aleg.pl>
X-From: git-owner@vger.kernel.org Thu Mar 13 23:36:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOEEt-0001K7-EP
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 23:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbaCMWga convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2014 18:36:30 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:60268 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbaCMWg3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2014 18:36:29 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so4537904ykp.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 15:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=+/82kFAW5/qk/QpX7LBYTdnwxSE0VKts1Qlm/vDau6I=;
        b=M1sWNmWpZyqQwMahedZ0pa3PAr5D2rz7fZPTHU2Mg7fo6HnUyGYdAij8lB8Z6R3Wnd
         XoNCaQb1jRUNWgQHWG1aXc3XqYWSBkCfrGNl3HN9cpreLjfMgDwCW/5qWQvbhonqVyjE
         Iy9NG4xQM4YVkIIXAQtzlhVMUL2kjr/Ba5NWvjOK4jBrkrZyxxFuL3uUopyowUi1+/JQ
         KK+cSNaBsEy7cbwP9ZAEOCRrsRqhp9QqGNUhZcTF7xgkF7SCruQrvqV4omZ/KnD1jkm+
         yqXZZj6qQQq4xEqabtm6dENu9UJBCvLVKw9SS+uq5RFRj7CEQBvlCHeKn17HfQBsF4ZC
         wuRw==
X-Received: by 10.236.132.48 with SMTP id n36mr221873yhi.149.1394750189154;
 Thu, 13 Mar 2014 15:36:29 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 13 Mar 2014 15:36:29 -0700 (PDT)
In-Reply-To: <1394668065-14629-1-git-send-email-pawlo@aleg.pl>
X-Google-Sender-Auth: A6P04-BRk441f3T16RNfvyu7L8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244058>

On Wed, Mar 12, 2014 at 7:47 PM, Pawe=C5=82 Wawruch <pawlo@aleg.pl> wro=
te:
> Replace the chain of if statements with table of strings.
>
> Signed-off-by: Pawe=C5=82 Wawruch <pawlo@aleg.pl>
> ---
> Thanks to Eric Sunshine and Junio C Hamano.
> Simplified printing logic. The name moved to a table.
>
> v4: http://thread.gmane.org/gmane.comp.version-control.git/243914
> v3: http://thread.gmane.org/gmane.comp.version-control.git/243865
> v2: http://thread.gmane.org/gmane.comp.version-control.git/243849
> v1: http://thread.gmane.org/gmane.comp.version-control.git/243502

Thanks. Using the vN notation makes these links self-explanatory.

>  branch.c | 42 +++++++++++++++++-------------------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..c17817c 100644
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

Some compilers may complain about the trailing comma. Ditto for the one=
s below.

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
> +       const char *name[] =3D {remote, shortname};

See [1] and the messages following it for commentary about this change.

>         if (remote_is_branch
>             && !strcmp(local, shortname)
> @@ -76,31 +90,9 @@ void install_branch_config(int flag, const char *l=
ocal, const char *origin, cons
>         }
>         strbuf_release(&key);
>
> -       if (flag & BRANCH_CONFIG_VERBOSE) {
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
> -               else
> -                       die("BUG: impossible combination of %d and %p=
",
> -                           remote_is_branch, origin);
> -       }
> +       if (flag & BRANCH_CONFIG_VERBOSE)
> +               printf_ln(_(message[!remote_is_branch][!origin][!reba=
sing]),
> +                               local, name[!remote_is_branch], origi=
n);

Much simpler than the previous versions (sans [1] commentary)

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243914/focu=
s=3D244043

>  }
>
>  /*
> --
> 1.8.3.2
