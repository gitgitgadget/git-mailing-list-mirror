From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 33/83] builtin/apply: move 'root' global into 'struct apply_state'
Date: Mon, 25 Apr 2016 14:50:09 -0700
Message-ID: <CAGZ79kaaATDzOHFOmCAANcZmrF_5JGAUYW3Ub1WJ7vSLODVP_g@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-34-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:50:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auoOZ-0005E4-MG
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965212AbcDYVuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:50:12 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38510 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965002AbcDYVuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:50:10 -0400
Received: by mail-ig0-f170.google.com with SMTP id m9so75267120ige.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=RIoHch5UYarzAPNbMU/tIgepr4DJWwO9oN5wA1Huz5g=;
        b=L2EbXIO2oxF3KX1MnFFxmYNcHTWdk1Fym0We9ItrQZ3Nf1nR8z09Z3QEdb/5FQOOBa
         YvZ+v85FLsaexZm9jTviBs1VaePfjMQYPGGJhFCwbsSImoMZeIw25MrIQzYjVfjG3hIi
         7LSoBYrrpvU56xOkGx5MAssvlbMrcx/mgWTlsKdYsTXCUQYvQuwtbxcBpLg5IWRWJYuH
         UEc59+Dl3wPiah1y6KsRZGMm5Slagu32ldj7IEz9xqkC+Bn0D7bwa4AsDl4bA2BT7pRy
         a3O5g5hcTSdPxBWg/TfhvT0i7PLLcE1e4YWjLVzugJqS7+NdyE+gNA4t4IxAhCHBNd/O
         xtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RIoHch5UYarzAPNbMU/tIgepr4DJWwO9oN5wA1Huz5g=;
        b=bs4qIbsDIH8n/sIE6BNAHgviz/ZfFFScTTIi7N5UECPUXiA1pMyJS98SvKFsN4xQjQ
         o3caCa1IM0+YFtfyl7Mutfpp+josisaJJ/7il+HE2dfK4LiDRdHjnHlap8IM4oakWrD9
         Esh/DAkHwhhat+6SgGHhiMzH5+UXZLftpZ7ISZhxvyhsRa/hwKFeOSjIVuK/YQUHVqvq
         qLcTDHrsRzVQR8VkbVjubBj3p5HGQzfN7lvDE0XpVWpcmDfXSUBJxrC/af+zWiKCe+OX
         o8dMvhWRTxpa3g084oE8vPBH4EGLLKQFPKlxpSJrVJMuSAwXrTmFY4BdXg0HqS0EQLkv
         Li6g==
X-Gm-Message-State: AOPr4FXg4ypZFF+vYq0Jy+IBbUVuj5TJz74rC0nLZ7Auq0DOAL3HuAiqPe5pRfVuRV84pVfg1TvtfBgLhGLnGyAF
X-Received: by 10.50.102.207 with SMTP id fq15mr10129118igb.94.1461621009344;
 Mon, 25 Apr 2016 14:50:09 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 14:50:09 -0700 (PDT)
In-Reply-To: <1461504863-15946-34-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292571>

On Sun, Apr 24, 2016 at 6:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 82 ++++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 33 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index fecdb66..209a1b4 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -73,6 +73,8 @@ struct apply_state {
>
>         struct string_list limit_by_name;
>         int has_include;
> +
> +       struct strbuf root;
>  };
>
>  static int newfd = -1;
> @@ -98,8 +100,6 @@ static enum ws_ignore {
>  } ws_ignore_action = ignore_ws_none;
>
>
> -static struct strbuf root = STRBUF_INIT;
> -
>  static void parse_whitespace_option(const char *option)
>  {
>         if (!option) {
> @@ -489,7 +489,10 @@ static char *squash_slash(char *name)
>         return name;
>  }
>
> -static char *find_name_gnu(const char *line, const char *def, int p_value)
> +static char *find_name_gnu(struct apply_state *state,
> +                          const char *line,
> +                          const char *def,
> +                          int p_value)
>  {
>         struct strbuf name = STRBUF_INIT;
>         char *cp;
> @@ -513,8 +516,8 @@ static char *find_name_gnu(const char *line, const char *def, int p_value)
>         }
>
>         strbuf_remove(&name, 0, cp - name.buf);
> -       if (root.len)
> -               strbuf_insert(&name, 0, root.buf, root.len);
> +       if (state->root.len)
> +               strbuf_insert(&name, 0, state->root.buf, state->root.len);
>         return squash_slash(strbuf_detach(&name, NULL));
>  }
>
> @@ -677,8 +680,12 @@ static size_t diff_timestamp_len(const char *line, size_t len)
>         return line + len - end;
>  }
>
> -static char *find_name_common(const char *line, const char *def,
> -                             int p_value, const char *end, int terminate)
> +static char *find_name_common(struct apply_state *state,
> +                             const char *line,
> +                             const char *def,
> +                             int p_value,
> +                             const char *end,
> +                             int terminate)
>  {
>         int len;
>         const char *start = NULL;
> @@ -716,32 +723,39 @@ static char *find_name_common(const char *line, const char *def,
>                         return squash_slash(xstrdup(def));
>         }
>
> -       if (root.len) {
> -               char *ret = xstrfmt("%s%.*s", root.buf, len, start);
> +       if (state->root.len) {
> +               char *ret = xstrfmt("%s%.*s", state->root.buf, len, start);
>                 return squash_slash(ret);
>         }
>
>         return squash_slash(xmemdupz(start, len));
>  }
>
> -static char *find_name(const char *line, char *def, int p_value, int terminate)
> +static char *find_name(struct apply_state *state,
> +                      const char *line,
> +                      char *def,
> +                      int p_value,
> +                      int terminate)
>  {
>         if (*line == '"') {
> -               char *name = find_name_gnu(line, def, p_value);
> +               char *name = find_name_gnu(state, line, def, p_value);
>                 if (name)
>                         return name;
>         }
>
> -       return find_name_common(line, def, p_value, NULL, terminate);
> +       return find_name_common(state, line, def, p_value, NULL, terminate);
>  }
>
> -static char *find_name_traditional(const char *line, char *def, int p_value)
> +static char *find_name_traditional(struct apply_state *state,
> +                                  const char *line,
> +                                  char *def,
> +                                  int p_value)
>  {
>         size_t len;
>         size_t date_len;
>
>         if (*line == '"') {
> -               char *name = find_name_gnu(line, def, p_value);
> +               char *name = find_name_gnu(state, line, def, p_value);
>                 if (name)
>                         return name;
>         }
> @@ -749,10 +763,10 @@ static char *find_name_traditional(const char *line, char *def, int p_value)
>         len = strchrnul(line, '\n') - line;
>         date_len = diff_timestamp_len(line, len);
>         if (!date_len)
> -               return find_name_common(line, def, p_value, NULL, TERM_TAB);
> +               return find_name_common(state, line, def, p_value, NULL, TERM_TAB);
>         len -= date_len;
>
> -       return find_name_common(line, def, p_value, line + len, 0);
> +       return find_name_common(state, line, def, p_value, line + len, 0);
>  }
>
>  static int count_slashes(const char *cp)
> @@ -777,7 +791,7 @@ static int guess_p_value(struct apply_state *state, const char *nameline)
>
>         if (is_dev_null(nameline))
>                 return -1;
> -       name = find_name_traditional(nameline, NULL, 0);
> +       name = find_name_traditional(state, nameline, NULL, 0);
>         if (!name)
>                 return -1;
>         cp = strchr(name, '/');
> @@ -902,17 +916,17 @@ static void parse_traditional_patch(struct apply_state *state,
>         if (is_dev_null(first)) {
>                 patch->is_new = 1;
>                 patch->is_delete = 0;
> -               name = find_name_traditional(second, NULL, state->p_value);
> +               name = find_name_traditional(state, second, NULL, state->p_value);
>                 patch->new_name = name;
>         } else if (is_dev_null(second)) {
>                 patch->is_new = 0;
>                 patch->is_delete = 1;
> -               name = find_name_traditional(first, NULL, state->p_value);
> +               name = find_name_traditional(state, first, NULL, state->p_value);
>                 patch->old_name = name;
>         } else {
>                 char *first_name;
> -               first_name = find_name_traditional(first, NULL, state->p_value);
> -               name = find_name_traditional(second, first_name, state->p_value);
> +               first_name = find_name_traditional(state, first, NULL, state->p_value);
> +               name = find_name_traditional(state, second, first_name, state->p_value);
>                 free(first_name);
>                 if (has_epoch_timestamp(first)) {
>                         patch->is_new = 1;
> @@ -957,7 +971,7 @@ static void gitdiff_verify_name(struct apply_state *state,
>                                 int side)
>  {
>         if (!*name && !isnull) {
> -               *name = find_name(line, NULL, state->p_value, TERM_TAB);
> +               *name = find_name(state, line, NULL, state->p_value, TERM_TAB);
>                 return;
>         }
>
> @@ -967,7 +981,7 @@ static void gitdiff_verify_name(struct apply_state *state,
>                 if (isnull)
>                         die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
>                             *name, linenr);
> -               another = find_name(line, NULL, state->p_value, TERM_TAB);
> +               another = find_name(state, line, NULL, state->p_value, TERM_TAB);
>                 if (!another || memcmp(another, *name, len + 1))
>                         die((side == DIFF_NEW_NAME) ?
>                             _("git apply: bad git-diff - inconsistent new filename on line %d") :
> @@ -1042,7 +1056,7 @@ static int gitdiff_copysrc(struct apply_state *state,
>  {
>         patch->is_copy = 1;
>         free(patch->old_name);
> -       patch->old_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
> +       patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
>         return 0;
>  }
>
> @@ -1052,7 +1066,7 @@ static int gitdiff_copydst(struct apply_state *state,
>  {
>         patch->is_copy = 1;
>         free(patch->new_name);
> -       patch->new_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
> +       patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
>         return 0;
>  }
>
> @@ -1062,7 +1076,7 @@ static int gitdiff_renamesrc(struct apply_state *state,
>  {
>         patch->is_rename = 1;
>         free(patch->old_name);
> -       patch->old_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
> +       patch->old_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
>         return 0;
>  }
>
> @@ -1072,7 +1086,7 @@ static int gitdiff_renamedst(struct apply_state *state,
>  {
>         patch->is_rename = 1;
>         free(patch->new_name);
> -       patch->new_name = find_name(line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
> +       patch->new_name = find_name(state, line, NULL, state->p_value ? state->p_value - 1 : 0, 0);
>         return 0;
>  }
>
> @@ -1331,8 +1345,8 @@ static int parse_git_header(struct apply_state *state,
>          * the default name from the header.
>          */
>         patch->def_name = git_header_name(state, line, len);
> -       if (patch->def_name && root.len) {
> -               char *s = xstrfmt("%s%s", root.buf, patch->def_name);
> +       if (patch->def_name && state->root.len) {
> +               char *s = xstrfmt("%s%s", state->root.buf, patch->def_name);
>                 free(patch->def_name);
>                 patch->def_name = s;
>         }
> @@ -4630,9 +4644,10 @@ static int option_parse_whitespace(const struct option *opt,
>  static int option_parse_directory(const struct option *opt,
>                                   const char *arg, int unset)
>  {
> -       strbuf_reset(&root);
> -       strbuf_addstr(&root, arg);
> -       strbuf_complete(&root, '/');
> +       struct apply_state *state = opt->value;

Or even

    struct strbuf root = ((state*)opt->value)->root;

and then keep the next lines as is?

> +       strbuf_reset(&state->root);
> +       strbuf_addstr(&state->root, arg);
> +       strbuf_complete(&state->root, '/');
>         return 0;
>  }
>
> @@ -4711,7 +4726,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>                 OPT_BIT(0, "recount", &options,
>                         N_("do not trust the line counts in the hunk headers"),
>                         RECOUNT),
> -               { OPTION_CALLBACK, 0, "directory", NULL, N_("root"),
> +               { OPTION_CALLBACK, 0, "directory", &state, N_("root"),
>                         N_("prepend <root> to all filenames"),
>                         0, option_parse_directory },
>                 OPT_END()
> @@ -4724,6 +4739,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>         state.line_termination = '\n';
>         state.p_value = 1;
>         state.p_context = UINT_MAX;
> +       strbuf_init(&state.root, 0);

Eventually we want to have some sort of `init_apply_state` function or
a define which has all the values, I guess?

Compare for example to sliding_window.h, where
we have

    struct sliding_view {
        ...
        struct strbuf buf;
    };

    #define SLIDING_VIEW_INIT(..., STRBUF_INIT }

>
>         git_apply_config();
>         if (apply_default_whitespace)
> --
> 2.8.1.300.g5fed0c0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
