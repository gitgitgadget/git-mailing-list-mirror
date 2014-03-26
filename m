From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 07/17] ls-files: add --column
Date: Wed, 26 Mar 2014 15:46:57 -0400
Message-ID: <CAPig+cTj_ZM3OOn1ZHwYQQYRtQevhAA33wUH9op_r_u+yLorrg@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WStn9-0007CQ-PR
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 20:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076AbaCZTrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 15:47:05 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:47149 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbaCZTq6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 15:46:58 -0400
Received: by mail-yk0-f174.google.com with SMTP id 20so1240869yks.33
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=iLQpspowlwZya8ffMeDEfwov6C88On19Yn9k0Q12g4g=;
        b=xtc2euzpuXdTrULmVTeuKeN0fZgCPoxWThLvXFUP8VTPLFLwWbbc2FHmfdI1KcEvGj
         fve+gpdXt6Qzo++UoF9mGLRulZtvA4ym0ENVHS2Tu2O0NS6rkRTey2EDIXEaA/yTTSGC
         0tcKeLyKh782Qjabmw9jqfWZpICZOpu6kchdpRatBl1UcCTtw9KN4u3QUrRgNHR9mQVH
         I2pVuBumsannHhJOnn6wKaPGDmAYIUSzVf0u0EFGXjS+U1A3IW4dMcRCEwIXMWZvvvrz
         3WvrU1CB6hm+PsECCOTrFGCA84K15Fr+UvjsLdi5/ys8zSNj/VGiEyZXdjnfjw/MfCou
         ACcg==
X-Received: by 10.236.122.99 with SMTP id s63mr85322061yhh.19.1395863217352;
 Wed, 26 Mar 2014 12:46:57 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 26 Mar 2014 12:46:57 -0700 (PDT)
In-Reply-To: <1395841697-11742-8-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: I8_jSJQ0RNdLsXaKJ10GDFwv4Rs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245219>

On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-ls-files.txt |  6 ++++++
>  builtin/ls-files.c             | 25 +++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-fi=
les.txt
> index 5c1b7f3..cd52461 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -156,6 +156,12 @@ a space) at the start of each line:
>         default to color output, same as `--color=3Dnever`. This is t=
he
>         default.
>
> +--column[=3D<options>]::
> +--no-column::
> +       Display files in columns. See configuration variable column.u=
i
> +       for option syntax.`--column` and `--no-column` without option=
s

Missing space after period.

> +       are equivalent to 'always' and 'never' respectively.
> +
>  \--::
>         Do not interpret any more arguments as options.
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 2857b38..335d3b0 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -15,6 +15,7 @@
>  #include "string-list.h"
>  #include "pathspec.h"
>  #include "color.h"
> +#include "column.h"
>
>  static int abbrev;
>  static int show_deleted;
> @@ -29,6 +30,7 @@ static int show_valid_bit;
>  static int line_terminator =3D '\n';
>  static int debug_mode;
>  static int use_color;
> +static unsigned int colopts;
>
>  static const char *prefix;
>  static int max_prefix_len;
> @@ -39,6 +41,7 @@ static char *ps_matched;
>  static const char *with_tree;
>  static int exc_given;
>  static int exclude_args;
> +static struct string_list output =3D STRING_LIST_INIT_NODUP;
>
>  static const char *tag_cached =3D "";
>  static const char *tag_unmerged =3D "";
> @@ -66,6 +69,10 @@ static void write_name(struct strbuf *sb, const ch=
ar *name)
>
>  static void strbuf_fputs(struct strbuf *sb, FILE *fp)
>  {
> +       if (column_active(colopts)) {
> +               string_list_append(&output, strbuf_detach(sb, NULL));
> +               return;
> +       }
>         fwrite(sb->buf, sb->len, 1, fp);
>  }
>
> @@ -552,6 +559,7 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
>                 OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish")=
,
>                         N_("pretend that paths removed since <tree-is=
h> are still present")),
>                 OPT__COLOR(&use_color, N_("show color")),
> +               OPT_COLUMN(0, "column", &colopts, N_("show files in c=
olumns")),
>                 OPT__ABBREV(&abbrev),
>                 OPT_BOOL(0, "debug", &debug_mode, N_("show debugging =
data")),
>                 OPT_END()
> @@ -596,6 +604,18 @@ int cmd_ls_files(int argc, const char **argv, co=
nst char *cmd_prefix)
>         if (dir.exclude_per_dir)
>                 exc_given =3D 1;
>
> +       finalize_colopts(&colopts, -1);
> +       if (explicitly_enable_column(colopts)) {
> +               if (!line_terminator)
> +                       die(_("--column and -z are incompatible"));
> +               if (show_resolve_undo)
> +                       die(_("--column and --resolve-undo are incomp=
atible"));
> +               if (debug_mode)
> +                       die(_("--column and --debug are incompatible"=
));
> +       }
> +       if (column_active(colopts))
> +               line_terminator =3D 0;
> +
>         if (require_work_tree && !is_inside_work_tree())
>                 setup_work_tree();
>
> @@ -638,6 +658,11 @@ int cmd_ls_files(int argc, const char **argv, co=
nst char *cmd_prefix)
>         if (show_resolve_undo)
>                 show_ru_info();
>
> +       if (column_active(colopts)) {
> +               print_columns(&output, colopts, NULL);
> +               string_list_clear(&output, 0);
> +       }
> +
>         if (ps_matched) {
>                 int bad;
>                 bad =3D report_path_error(ps_matched, &pathspec, pref=
ix);
> --
> 1.9.1.345.ga1a145c
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
