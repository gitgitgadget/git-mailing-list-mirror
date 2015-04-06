From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 15/25] list-files: add --ignored
Date: Mon, 6 Apr 2015 17:34:17 -0400
Message-ID: <CAPig+cQrzNT8pL9CiLKxJu0+qEmefeoUV8j2_7Ax9_JzGm4Q3Q@mail.gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
	<1428328354-14897-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 23:34:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfEf2-0005ZZ-0V
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 23:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbbDFVeT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 17:34:19 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:35466 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbDFVeT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2015 17:34:19 -0400
Received: by lbbuc2 with SMTP id uc2so25413339lbb.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Q5ATwO6NzAlHjGHtkxwv0ETA9mnZTAZXOLIp8CzIt5Y=;
        b=fdG1KnM6+eB5TiiV09S/fitVJ1+/E9tbwq5Q/Ui5oAySdMzo59u22+EL8Nm9qOaThP
         Y2E2nSBuRVyHO7utT2xa1O3OK3nPvZG4HzdBJw3SrZo5KCwLl1HuOYX3afPWntRhlE2o
         oYn9fDTa6OU8zdrDw2NSeKtTI0FeXHvauBoBJUu8tfI2goKwk8d8/BysmWCIHiv+K2EM
         DLzddFuypTkSpmWyGezhOh1wm5YnkPcw3GD2fKGXMHfl8P+3vgM7SaL3oCVdDcksMtKa
         4Syj46Apq7Aq7jKV0M9mL1Ms8yEsYav4t5X7l/7SHs90xFY09apqlORZJywN0yzllxqH
         StUg==
X-Received: by 10.112.163.229 with SMTP id yl5mr15095474lbb.60.1428356057266;
 Mon, 06 Apr 2015 14:34:17 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 14:34:17 -0700 (PDT)
In-Reply-To: <1428328354-14897-16-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 28bd2leliUTQ-7kUtSvyooFwCDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266883>

On Mon, Apr 6, 2015 at 9:52 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/list-files.c b/builtin/list-files.c
> index 3cbd30d..31991a4 100644
> --- a/builtin/list-files.c
> +++ b/builtin/list-files.c
> @@ -39,6 +39,7 @@ static int show_dirs;
>  static int use_color =3D -1;
>  static int show_indicator;
>  static int show_cached, show_untracked;
> +static int show_ignored;
>
>  static const char * const ls_usage[] =3D {
>         N_("git list-files [options] [<pathspec>...]"),
> @@ -51,6 +52,8 @@ struct option ls_options[] =3D {
>                  N_("show cached files (default)")),
>         OPT_BOOL('o', "others", &show_untracked,
>                  N_("show untracked files")),
> +       OPT_BOOL('i', "ignored", &show_ignored,
> +                N_("show ignored files")),
>
>         OPT_GROUP(N_("Other")),
>         OPT_BOOL(0, "tag", &show_tag, N_("show tags")),
> @@ -202,7 +205,8 @@ static void add_wt_item(struct item_list *result,
>  }
>
>  static void populate_untracked(struct item_list *result,
> -                              const struct string_list *untracked)
> +                              const struct string_list *untracked,
> +                              const char *tag)

Minor: I could easily see patch 14/25 declaring populate_untracked()
this way in the first place...

>  {
>         int i;
>
> @@ -217,7 +221,7 @@ static void populate_untracked(struct item_list *=
result,
>                 if (!matched(result, name, st.st_mode))
>                         continue;
>
> -               add_wt_item(result, FROM_WORKTREE, name, "??", &st);
> +               add_wt_item(result, FROM_WORKTREE, name, tag, &st);

=2E..since doing so would eliminate this change from 15/25 and...
(continued below)

>         }
>  }
>
> @@ -226,18 +230,22 @@ static void wt_status_populate(struct item_list=
 *result,
>  {
>         struct wt_status ws;
>
> -       if (!show_untracked)
> +       if (!show_untracked && !show_ignored)
>                 return;
>
>         wt_status_prepare(&ws);
>         copy_pathspec(&ws.pathspec, &recursive_pathspec);
> +       if (show_ignored)
> +               ws.show_ignored_files =3D 1;

Simpler:

    ws.show_ignored_files =3D show_ignored;

>         ws.relative_paths =3D 0;
>         ws.use_color =3D 0;
>         ws.fp =3D NULL;
>         wt_status_collect(&ws);
>
>         if (show_untracked)
> -               populate_untracked(result, &ws.untracked);
> +               populate_untracked(result, &ws.untracked, "??");

(continued from above) ...and this change.

More below.

> +       if (show_ignored)
> +               populate_untracked(result, &ws.ignored, "!!");
>
>         remove_duplicates(result);
>  }
> @@ -251,7 +259,9 @@ static void cleanup_tags(struct item_list *result=
)
>                 result->tag_len =3D 0;
>                 return;
>         }
> -       if (show_tag > 0 || show_cached + show_untracked > 1) {
> +
> +       if (show_tag > 0 ||
> +           show_cached + show_untracked + show_ignored > 1) {
>                 result->tag_pos =3D 0;
>                 result->tag_len =3D 2;
>                 return;
> @@ -388,7 +398,7 @@ int cmd_list_files(int argc, const char **argv, c=
onst char *cmd_prefix)
>
>         argc =3D parse_options(argc, argv, prefix, ls_options, ls_usa=
ge, 0);
>
> -       if (!show_cached && !show_untracked)
> +       if (!show_cached && !show_untracked && !show_ignored)
>                 show_cached =3D 1;
>
>         if (want_color(use_color))
> diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
> index 53dc745..6b76d1f 100755
> --- a/t/t7013-list-files.sh
> +++ b/t/t7013-list-files.sh
> @@ -44,6 +44,21 @@ test_expect_success 'list-files --others' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'list-files --others' '

s/others/ignored/

> +       git list-files --ignored >actual &&
> +       cat >expect <<-\EOF &&
> +       !! foo
> +          sa
> +       EOF
> +       test_cmp expect actual &&
> +       git list-files --ignored -R >actual &&
> +       cat >expect <<-\EOF &&
> +       foo
> +       sa/foo
> +       EOF
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'list-files -R from index' '
>         git list-files -R >actual &&
>         cat >expect <<-\EOF &&
> --
> 2.3.0.rc1.137.g477eb31
