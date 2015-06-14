From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 09/11] parse-options.h: add macros for '--contains' option
Date: Sun, 14 Jun 2015 08:13:07 +0200
Message-ID: <CAP8UFD02qxKJYJ=hg7ZWsvUZfJe85CY-v2V-64swdxnibF=mmg@mail.gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
	<1434226706-3764-1-git-send-email-karthik.188@gmail.com>
	<1434226706-3764-9-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 08:13:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z41Ac-0004BJ-QA
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 08:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbbFNGNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2015 02:13:11 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35866 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbFNGNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2015 02:13:09 -0400
Received: by wigg3 with SMTP id g3so47996387wig.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dtoslDKPQB2PKbNe1ZPGtLxoACkubUNU+XuvNqExbGE=;
        b=Ll8OXAO4JAUw/fztV96paLaBRKdISCXhaXvVjDm9bPQRHyBjFuEjyhpW9LhABJri4I
         XawRA3kKeYsHfyvPWnGIyM+fqHqNGl4/h+ZQlymNVRYQhUw6aJovz5fJPSHU+ZZIypNJ
         JS9Y3K2BSxxwddwS2vvqOblCLvmDGXEjeQUyRBcsBtDW4T1ckgcKIkc8wiVfIG+tesEQ
         eRPZxe4ws8ktPQ58eoPxamGJ5xrrdN7je7CxB/UiLlQDjdKHRrYnT3Xo7VHEYFRnhFC8
         /yse+atTe+1cQ7ClZiWsCWpZRrTzbSjRQDKGlD9ujJzrBYWTonA8PNscVHHUTcQQwtTt
         Q16A==
X-Received: by 10.180.95.10 with SMTP id dg10mr20997432wib.41.1434262387998;
 Sat, 13 Jun 2015 23:13:07 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sat, 13 Jun 2015 23:13:07 -0700 (PDT)
In-Reply-To: <1434226706-3764-9-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271605>

On Sat, Jun 13, 2015 at 10:18 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add a macro for using the '--contains' option in parse-options.h
> also include an optional '--with' option macro which performs the
> same action as '--contains'.
>
> Make tag.c use this new macro
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/tag.c   | 14 ++------------
>  parse-options.h |  7 +++++++
>  2 files changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 2d6610a..767162e 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -595,23 +595,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>
>                 OPT_GROUP(N_("Tag listing options")),
>                 OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
> +               OPT_CONTAINS(&with_commit, N_("print only tags that contain the commit")),
> +               OPT_WITH(&with_commit, N_("print only tags that contain the commit")),
>                 {
>                         OPTION_CALLBACK, 0, "sort", &tag_sort, N_("type"), N_("sort tags"),
>                         PARSE_OPT_NONEG, parse_opt_sort
>                 },
>                 {
> -                       OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
> -                       N_("print only tags that contain the commit"),
> -                       PARSE_OPT_LASTARG_DEFAULT,
> -                       parse_opt_commit_object_name, (intptr_t)"HEAD",
> -               },
> -               {
> -                       OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
> -                       N_("print only tags that contain the commit"),
> -                       PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,

The PARSE_OPT_HIDDEN flag is removed below. This means that "--with"
will appear in the "git tag -h" output, which means that "--with"
should appear in the documentation...
The commit message may also want to tell that with is not hidden any more.

> -                       parse_opt_commit_object_name, (intptr_t)"HEAD",
> -               },
> -               {
>                         OPTION_CALLBACK, 0, "points-at", &points_at, N_("object"),
>                         N_("print only tags of the object"), 0, parse_opt_object_name
>                 },
> diff --git a/parse-options.h b/parse-options.h
> index 8542d9c..d76e907 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -243,5 +243,12 @@ extern int parse_opt_noop_cb(const struct option *, const char *, int);
>         OPT_COLOR_FLAG(0, "color", (var), (h))
>  #define OPT_COLUMN(s, l, v, h) \
>         { OPTION_CALLBACK, (s), (l), (v), N_("style"), (h), PARSE_OPT_OPTARG, parseopt_column_callback }
> +#define _OPT_CONTAINS_OR_WITH(name, variable, help) \
> +       { OPTION_CALLBACK, 0, name, (variable), N_("commit"), (help), \
> +         PARSE_OPT_LASTARG_DEFAULT, \
> +         parse_opt_commit_object_name, (intptr_t) "HEAD" \
> +       }
> +#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h)
> +#define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h)

Shouldn't it be "with" instead of "contains"?
