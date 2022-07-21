Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B9C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiGUTyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGUTyU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:54:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F9B6D569
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:54:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b10-20020a170902d50a00b0016c56d1f90fso1599938plg.21
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=v99VjBoijyxfKxwGG/8+USLE/3+GhzeeY2ntly+2NcA=;
        b=V2/4H/5VyuAxs9SpIg1uZkqIO1Ugp1mHwAnriICv5U29ZiUIPZ5SqsUKa8OlD98NCG
         c5YX494qP8WU9+Tbl1yQZD7vZ54oSrJgIIlPaeeWaOTsVyKMBVm0MiY9TZX4CtIWQZ4b
         nUX3Zu3RkHNdMWWQK0ZOA3ksFZhtQgGBnbhrY7qIoBvFsrBt7Y5kIG9XVb0F3HDJA/dr
         PyEplR+EJPmJIVdbhJxrhPkgKnocnODjn99lDmi+lsI2llXSmQUYRxyJqqxu0DkQF9o3
         cemccTYY3/EHMkt/9ZfyT7/p7FUkz8Bqu0ji81xBMAG8Rp0F5g/iGJLolUkBXAuH/wtn
         phQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=v99VjBoijyxfKxwGG/8+USLE/3+GhzeeY2ntly+2NcA=;
        b=2lfrNhUk9Svd4AwOLzZAIq3+kdqNVuX1bYM4KdtyvVh1P7njpdXTKrxd2iCsUqWYGv
         Jflo8jvCdjaQA+OQ/0KH2rpBDLPB4S4UqPb1Ev9Us1+OrP6TZL81WzqreD1x+6vlULyP
         bydV+hhnvcjHWKR+bP90cQNDgVE8mwGfCz409mipCRblHhxMr8GRbmd2ddURGIiUnTrG
         eOAV/zi0ulbXiYhMDOhV262NmE49W6rqCAgzocc+WAQvmxjvy0EVjUZMmqZJCV0FynUB
         g2rrwbhB7aIXdxSiK/WCrhOstMOeJsqVFeOqR+/Jl236gZTpLDwiXsLlYTIpdigBRc61
         CyEA==
X-Gm-Message-State: AJIora/lUkLlaxiCUeZ+ww200CTvSnc8HjJu5EZCuz2KzuZRVwQUSX+D
        wqoMREmmkSLTnf48CO+02g5HFRXB0Q506w==
X-Google-Smtp-Source: AGRyM1v9omFYFav35XTBDJ222jfU/ku+U4CHwc4jM/f/m6qZXbqA+eRcoBR83+gDjrnqdbSkktJdCywMq1K1KA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:870b:0:b0:522:c223:5c5e with SMTP id
 b11-20020aa7870b000000b00522c2235c5emr45979258pfo.6.1658433259175; Thu, 21
 Jul 2022 12:54:19 -0700 (PDT)
Date:   Thu, 21 Jul 2022 12:54:17 -0700
In-Reply-To: <patch-v2-05.24-a4672aa9c94-20220719T204458Z-avarab@gmail.com>
Message-Id: <kl6lbktitf6e.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <patch-v2-05.24-a4672aa9c94-20220719T204458Z-avarab@gmail.com>
Subject: Re: [PATCH v2 05/24] submodule--helper: "struct pathspec" memory leak
 in module_update()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The module_update() function calls module_list_compute() twice, which
> in turn will reset the "struct pathspec" passed to it. Let's instead
> track two of them, and clear them both.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 28c5fdb8954..7466e781e97 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2602,6 +2602,7 @@ static int update_submodules(struct update_data *up=
date_data)
>  static int module_update(int argc, const char **argv, const char *prefix=
)
>  {
>  	struct pathspec pathspec =3D { 0 };
> +	struct pathspec pathspec2 =3D { 0 };
>  	struct update_data opt =3D UPDATE_DATA_INIT;
>  	struct list_objects_filter_options filter_options =3D { 0 };
>  	int ret;
> @@ -2692,7 +2693,7 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
>  		struct init_cb info =3D INIT_CB_INIT;
> =20
>  		if (module_list_compute(argc, argv, opt.prefix,
> -					&pathspec, &list) < 0) {
> +					&pathspec2, &list) < 0) {
>  			ret =3D 1;
>  			goto cleanup;
>  		}

This change looks good, but we should do more refactoring in the future.

This bit of code inside "if (opt.init)" was copied over from
module_init() in 29a5e9e1ff (submodule--helper update-clone: learn
--init, 2022-03-04). Prior to that commit, we used to just invoke "git
submodule init" in git-submodule.sh.

What I wished I had done instead is to create a helper function that can
be used by both module_init() and module_update(). Something like:

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
  diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
  index 28c5fdb895..2040cde4ba 100644
  --- a/builtin/submodule--helper.c
  +++ b/builtin/submodule--helper.c
  @@ -481,14 +481,14 @@ static int starts_with_dot_dot_slash(const char *co=
nst path)
          PATH_MATCH_XPLATFORM);
  }

  -struct init_cb {
  +struct init_opts {
    const char *prefix;
  -	unsigned int flags;
  +	int quiet;
  };
  #define INIT_CB_INIT { 0 }

  static void init_submodule(const char *path, const char *prefix,
  -			   unsigned int flags)
  +			   int quiet)
  {
    const struct submodule *sub;
    struct strbuf sb =3D STRBUF_INIT;
  @@ -538,7 +538,7 @@ static void init_submodule(const char *path, const ch=
ar *prefix,
      if (git_config_set_gently(sb.buf, url))
        die(_("Failed to register url for submodule path '%s'"),
            displaypath);
  -		if (!(flags & OPT_QUIET))
  +		if (!quiet)
        fprintf(stderr,
          _("Submodule '%s' (%s) registered for path '%s'\n"),
          sub->name, url, displaypath);
  @@ -567,15 +567,39 @@ static void init_submodule(const char *path, const =
char *prefix,

  static void init_submodule_cb(const struct cache_entry *list_item, void *=
cb_data)
  {
  -	struct init_cb *info =3D cb_data;
  -	init_submodule(list_item->name, info->prefix, info->flags);
  +	struct init_opts *info =3D cb_data;
  +	init_submodule(list_item->name, info->prefix, info->quiet);
  }

  -static int module_init(int argc, const char **argv, const char *prefix)
  +static int init_submodules(int argc, const char **argv, struct init_opts=
 *opts)
  {
  -	struct init_cb info =3D INIT_CB_INIT;
  -	struct pathspec pathspec =3D { 0 };
    struct module_list list =3D MODULE_LIST_INIT;
  +	struct pathspec pathspec =3D { 0 };
  +	int ret =3D 0;
  +
  +	if (module_list_compute(argc, argv, opts->prefix,
  +				&pathspec, &list) < 0) {
  +		ret =3D 1;
  +		goto cleanup;
  +	}
  +
  +	/*
  +	 * If there are no path args and submodule.active is set then,
  +	 * by default, only initialize 'active' modules.
  +	 */
  +	if (!argc && git_config_get_value_multi("submodule.active"))
  +		module_list_active(&list);
  +
  +	for_each_listed_submodule(&list, init_submodule_cb, opts);
  +
  + cleanup:
  +	clear_pathspec(&pathspec);
  +	return ret;
  +}
  +
  +static int module_init(int argc, const char **argv, const char *prefix)
  +{
  +	struct init_opts info =3D INIT_CB_INIT;
    int quiet =3D 0;

    struct option module_init_options[] =3D {
  @@ -587,33 +611,14 @@ static int module_init(int argc, const char **argv,=
 const char *prefix)
      N_("git submodule init [<options>] [<path>]"),
      NULL
    };
  -	int ret;

    argc =3D parse_options(argc, argv, prefix, module_init_options,
            git_submodule_helper_usage, 0);

  -	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0) {
  -		ret =3D 1;
  -		goto cleanup;
  -	}
  -
  -	/*
  -	 * If there are no path args and submodule.active is set then,
  -	 * by default, only initialize 'active' modules.
  -	 */
  -	if (!argc && git_config_get_value_multi("submodule.active"))
  -		module_list_active(&list);
  -
    info.prefix =3D prefix;
  -	if (quiet)
  -		info.flags |=3D OPT_QUIET;
  -
  -	for_each_listed_submodule(&list, init_submodule_cb, &info);
  +	info.quiet =3D quiet;

  -	ret =3D 0;
  -cleanup:
  -	clear_pathspec(&pathspec);
  -	return ret;
  +	return init_submodules(argc, argv, &info);
  }

  struct status_cb {
  @@ -2688,27 +2693,13 @@ static int module_update(int argc, const char **a=
rgv, const char *prefix)
      opt.warn_if_uninitialized =3D 1;

    if (opt.init) {
  -		struct module_list list =3D MODULE_LIST_INIT;
  -		struct init_cb info =3D INIT_CB_INIT;
  -
  -		if (module_list_compute(argc, argv, opt.prefix,
  -					&pathspec, &list) < 0) {
  -			ret =3D 1;
  +		struct init_opts init_opts =3D {
  +			.quiet =3D opt.quiet,
  +			.prefix =3D opt.prefix,
  +		};
  +		ret =3D init_submodules(argc, argv, &init_opts);
  +		if (ret)
        goto cleanup;
  -		}
  -
  -		/*
  -		 * If there are no path args and submodule.active is set then,
  -		 * by default, only initialize 'active' modules.
  -		 */
  -		if (!argc && git_config_get_value_multi("submodule.active"))
  -			module_list_active(&list);
  -
  -		info.prefix =3D opt.prefix;
  -		if (opt.quiet)
  -			info.flags |=3D OPT_QUIET;
  -
  -		for_each_listed_submodule(&list, init_submodule_cb, &info);
    }

    ret =3D update_submodules(&opt);
----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

I don't think we need to do this now; it's already pretty noisy for just
a "leak cleanup" series, and it isn't even complete (IIRC you mentioned
that we could probably drop init_submodule_cb(), but I can't find the
message any more).

Hopefully someone will pick this up. I doubt I'll have the time to do
it, but maybe.

> @@ -2715,6 +2716,7 @@ static int module_update(int argc, const char **arg=
v, const char *prefix)
>  cleanup:
>  	list_objects_filter_release(&filter_options);
>  	clear_pathspec(&pathspec);
> +	clear_pathspec(&pathspec2);
>  	return ret;
>  }
> =20
> --=20
> 2.37.1.1062.g385eac7fccf
