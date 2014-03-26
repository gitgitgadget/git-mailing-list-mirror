From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/17] ls_colors.c: add function to color a file name
Date: Wed, 26 Mar 2014 15:14:44 -0400
Message-ID: <CAPig+cSSrc6=nX2=2BpaFRzT4Evf67kuXM8rKBTSkB6JrNN0yQ@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:14:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WStHm-0001Le-7U
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 20:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbaCZTOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 15:14:45 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:35393 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbaCZTOp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 15:14:45 -0400
Received: by mail-yh0-f41.google.com with SMTP id v1so2569105yhn.28
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 12:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=B/xl6GFQVGo9u6F07hld2aITW8+0QM1jU4yaxSqA/fE=;
        b=wEWPQ4AThr5FlfnKJmhictNbgpJR0K4W6PZzBiWw6AT+nxX0qu7/9zRFU/p2RmzPTU
         xMeaHw3x6L+PA4s72OKJkhupzDgpqOpFw2Hx0X7Hxxw7UT851pksULjLyiSQoWLurkbx
         Cu+2RLyPA77HBR29Vh5CmwsnbXxhwLu7aBf3I6o+7YQsgH9Ch1VKjgOQ4G8FJ/VSzcm+
         aNXxQRiqi6t3BCwKiDSTAqxFr7crjAX5wk7SWP3+RhPo1JWbIfvTLN34QkR/x8rZ1FPy
         9gz70Rv7DNa7kMtw86Fn7mtkQ0pDbCtXNrtpnR3Aox3HnONgQQpbM4XTA1bUH0CiFV6a
         WdYw==
X-Received: by 10.236.137.8 with SMTP id x8mr82797266yhi.4.1395861284587; Wed,
 26 Mar 2014 12:14:44 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 26 Mar 2014 12:14:44 -0700 (PDT)
In-Reply-To: <1395841697-11742-4-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: pRenAtlA3RAADUE9jv9BBMARljo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245212>

On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Tthe new function is based on print_color_indicator() from commit

s/Tthe/The/

> 7326d1f1a67edf21947ae98194f98c38b6e9e527 in coreutils.git.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  color.h     |  2 ++
>  ls_colors.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/color.h b/color.h
> index 640fc48..398369a 100644
> --- a/color.h
> +++ b/color.h
> @@ -94,5 +94,7 @@ void color_print_strbuf(FILE *fp, const char *color=
, const struct strbuf *sb);
>  int color_is_nil(const char *color);
>
>  void parse_ls_color(void);
> +void color_filename(struct strbuf *sb, const char *name,
> +                   const char *display_name, mode_t mode, int linkok=
);
>
>  #endif /* COLOR_H */
> diff --git a/ls_colors.c b/ls_colors.c
> index cef5a92..1125329 100644
> --- a/ls_colors.c
> +++ b/ls_colors.c
> @@ -422,3 +422,69 @@ void parse_ls_color(void)
>                 color_symlink_as_referent =3D 1;
>         git_config(ls_colors_config, NULL);
>  }
> +
> +void color_filename(struct strbuf *sb, const char *name,
> +                   const char *display_name, mode_t mode, int linkok=
)
> +{
> +       int type;
> +       struct color_ext_type *ext;     /* Color extension */
> +
> +       if (S_ISREG (mode)) {
> +               type =3D LS_FL;
> +               if ((mode & S_ISUID) !=3D 0)
> +                       type =3D LS_SU;
> +               else if ((mode & S_ISGID) !=3D 0)
> +                       type =3D LS_SG;
> +               else if ((mode & (S_IXUSR | S_IXGRP | S_IXOTH)) !=3D =
0)
> +                       type =3D LS_EX;
> +       } else if (S_ISDIR (mode)) {
> +               if ((mode & S_ISVTX) && (mode & S_IWOTH))
> +                       type =3D LS_TW;
> +               else if ((mode & S_IWOTH) !=3D 0)
> +                       type =3D LS_OW;
> +               else if ((mode & S_ISVTX) !=3D 0)
> +                       type =3D LS_ST;
> +               else
> +                       type =3D LS_DI;
> +       } else if (S_ISLNK (mode))
> +               type =3D (!linkok && *ls_colors[LS_OR]) ? LS_OR : LS_=
LN;
> +       else if (S_ISFIFO (mode))
> +               type =3D LS_PI;
> +       else if (S_ISSOCK (mode))
> +               type =3D LS_SO;
> +       else if (S_ISBLK (mode))
> +               type =3D LS_BD;
> +       else if (S_ISCHR (mode))
> +               type =3D LS_CD;
> +#ifdef S_ISDOOR
> +       else if (S_ISDOOR (mode))
> +               type =3D LS_DO;
> +#endif
> +       else
> +               /* Classify a file of some other type as C_ORPHAN.  *=
/
> +               type =3D LS_OR;
> +
> +       /* Check the file's suffix only if still classified as C_FILE=
=2E  */
> +       ext =3D NULL;
> +       if (type =3D=3D LS_FL) {
> +               /* Test if NAME has a recognized suffix.  */
> +               size_t len =3D strlen(name);
> +               const char *p =3D name + len;             /* Pointer =
to final \0.  */
> +               for (ext =3D color_ext_list; ext !=3D NULL; ext =3D e=
xt->next) {
> +                       if (ext->ext.len <=3D len &&
> +                           !strncmp(p - ext->ext.len, ext->ext.strin=
g, ext->ext.len))
> +                               break;
> +               }
> +       }
> +
> +       if (display_name)
> +               name =3D display_name;
> +       if (ext)
> +               strbuf_addf(sb, "\033[%.*sm%s%s",
> +                           (int)ext->seq.len, ext->seq.string,
> +                           name, GIT_COLOR_RESET);
> +       else if (*ls_colors[type])
> +               strbuf_addf(sb, "%s%s%s", ls_colors[type], name, GIT_=
COLOR_RESET);
> +       else
> +               strbuf_addstr(sb, name);
> +}
> --
> 1.9.1.345.ga1a145c
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
