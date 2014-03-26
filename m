From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 06/17] ls-files: add --color to highlight file names
Date: Wed, 26 Mar 2014 15:13:42 -0400
Message-ID: <CAPig+cTMRHi2sWQLZzdHZGWT6GBX-3v8exx8B4jpWm0Tgvg6+Q@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-1-git-send-email-pclouds@gmail.com>
	<1395841697-11742-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 20:13:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WStGn-0000Lq-7L
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 20:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218AbaCZTNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 15:13:44 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35043 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbaCZTNn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 15:13:43 -0400
Received: by mail-yk0-f172.google.com with SMTP id 200so1183273ykr.17
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=oX9lQQ4/+O9WsgwFt5aWaI6UvScYzvAvjCTxq8HNHoQ=;
        b=GrdEBU+dPnbAcFZw/Y2p0vxh3tzHEx7o+ULmToh1mBQ0r+ECyrBfyyi7sX59Xm5m0N
         BLYgHxyxv16d5m+F3kAJHlJQmUXRFqRXno59so+9YxWCse6Ve6YFUoyVfqMqWT9CjSio
         e6sB9V9kWB+e/WhaNDJKSm5tUvLoReGgn9yBAMNdUpnueXKwg51eXtY/tFysqxW66ztK
         DApL1VDknmm4YARopnu/20TPzDwVe/wuspnYQvoho39vnd+f3Z0ZkbUaYma2urYs8B/e
         I8N6AAdoi2SLufBLAFidnG9wmibp8tvNrZPkLvh8RlO37nfhh9HkIQ+hKAHBtOcriNQJ
         NBrQ==
X-Received: by 10.236.122.99 with SMTP id s63mr85116804yhh.19.1395861222931;
 Wed, 26 Mar 2014 12:13:42 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 26 Mar 2014 12:13:42 -0700 (PDT)
In-Reply-To: <1395841697-11742-7-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: AweOT3nSbmJbffTZDqQuFqi6t3I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245211>

On Wed, Mar 26, 2014 at 9:48 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/git-ls-files.txt |  9 +++++++++
>  builtin/ls-files.c             | 38 ++++++++++++++++++++++++++++++++=
+++---
>  2 files changed, 44 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-fi=
les.txt
> index c0856a6..5c1b7f3 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -147,6 +147,15 @@ a space) at the start of each line:
>         possible for manual inspection; the exact format may change a=
t
>         any time.
>
> +--color[=3D<when>]::
> +       Color file names. The value must be always (default), never,
> +       or auto.

Here, the default is "always"...

> +--no-color::
> +       Turn off coloring, even when the configuration file gives the
> +       default to color output, same as `--color=3Dnever`. This is t=
he
> +       default.

But, here the default is "never".

> +
>  \--::
>         Do not interpret any more arguments as options.
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 6e30592..2857b38 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -14,6 +14,7 @@
>  #include "resolve-undo.h"
>  #include "string-list.h"
>  #include "pathspec.h"
> +#include "color.h"
>
>  static int abbrev;
>  static int show_deleted;
> @@ -27,6 +28,7 @@ static int show_killed;
>  static int show_valid_bit;
>  static int line_terminator =3D '\n';
>  static int debug_mode;
> +static int use_color;
>
>  static const char *prefix;
>  static int max_prefix_len;
> @@ -60,7 +62,6 @@ static void write_name(struct strbuf *sb, const cha=
r *name)
>                 strbuf_release(&sb2);
>         } else
>                 quote_path_relative(name, real_prefix, sb);
> -       strbuf_addch(sb, line_terminator);
>  }
>
>  static void strbuf_fputs(struct strbuf *sb, FILE *fp)
> @@ -68,6 +69,21 @@ static void strbuf_fputs(struct strbuf *sb, FILE *=
fp)
>         fwrite(sb->buf, sb->len, 1, fp);
>  }
>
> +static void write_dir_entry(struct strbuf *sb, const struct dir_entr=
y *ent)
> +{
> +       struct strbuf quoted =3D STRBUF_INIT;
> +       struct stat st;
> +       if (stat(ent->name, &st))
> +               st.st_mode =3D 0;
> +       write_name(&quoted, ent->name);
> +       if (want_color(use_color))
> +               color_filename(sb, ent->name, quoted.buf, st.st_mode,=
 1);
> +       else
> +               strbuf_addbuf(sb, &quoted);
> +       strbuf_addch(sb, line_terminator);
> +       strbuf_release(&quoted);
> +}
> +
>  static void show_dir_entry(const char *tag, struct dir_entry *ent)
>  {
>         static struct strbuf sb =3D STRBUF_INIT;
> @@ -81,7 +97,7 @@ static void show_dir_entry(const char *tag, struct =
dir_entry *ent)
>
>         strbuf_reset(&sb);
>         strbuf_addstr(&sb, tag);
> -       write_name(&sb, ent->name);
> +       write_dir_entry(&sb, ent);
>         strbuf_fputs(&sb, stdout);
>  }
>
> @@ -146,6 +162,18 @@ static void show_killed_files(struct dir_struct =
*dir)
>         }
>  }
>
> +static void write_ce_name(struct strbuf *sb, const struct cache_entr=
y *ce)
> +{
> +       struct strbuf quoted =3D STRBUF_INIT;
> +       write_name(&quoted, ce->name);
> +       if (want_color(use_color))
> +               color_filename(sb, ce->name, quoted.buf, ce->ce_mode,=
 1);
> +       else
> +               strbuf_addbuf(sb, &quoted);
> +       strbuf_addch(sb, line_terminator);
> +       strbuf_release(&quoted);
> +}
> +
>  static void show_ce_entry(const char *tag, const struct cache_entry =
*ce)
>  {
>         static struct strbuf sb =3D STRBUF_INIT;
> @@ -186,7 +214,7 @@ static void show_ce_entry(const char *tag, const =
struct cache_entry *ce)
>                             find_unique_abbrev(ce->sha1,abbrev),
>                             ce_stage(ce));
>         }
> -       write_name(&sb, ce->name);
> +       write_ce_name(&sb, ce);
>         strbuf_fputs(&sb, stdout);
>         if (debug_mode) {
>                 const struct stat_data *sd =3D &ce->ce_stat_data;
> @@ -523,6 +551,7 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
>                         N_("if any <file> is not in the index, treat =
this as an error")),
>                 OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish")=
,
>                         N_("pretend that paths removed since <tree-is=
h> are still present")),
> +               OPT__COLOR(&use_color, N_("show color")),
>                 OPT__ABBREV(&abbrev),
>                 OPT_BOOL(0, "debug", &debug_mode, N_("show debugging =
data")),
>                 OPT_END()
> @@ -570,6 +599,9 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
>         if (require_work_tree && !is_inside_work_tree())
>                 setup_work_tree();
>
> +       if (want_color(use_color))
> +               parse_ls_color();
> +
>         parse_pathspec(&pathspec, 0,
>                        PATHSPEC_PREFER_CWD |
>                        PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
> --
> 1.9.1.345.ga1a145c
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
