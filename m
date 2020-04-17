Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38923C2BA2B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 02:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AF121841
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 02:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMNxcmiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgDQCEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725800AbgDQCE3 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 22:04:29 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB2C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 19:04:29 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i3so360386pgk.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 19:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=swW1IxF4sy6bYXWIBbFX6a0TIfAtPIy8pAad5c3Kc4w=;
        b=TMNxcmiP11Lsq0Prnb75M0dm+v2UVvPiK9/ZbIfaX4IGEyOLDaCcAj/S0IragVEk45
         UPXQZGA6G38DLE2Pc/HD6xLexDPXio//ybQ2rEly2i6l+o3iGXZ5KUymf0K4szawOM9j
         RPojOz8ZV3/fGWCphdHNhRi7o5IP39H7/ACDIIw/w31DdgTRHEB0mJaWGOy2sjOU+IS/
         aW4c+1uggB6xI0cvvdnrYubc3bvIEGNVpLFC7kqkpJGzSoU+mXa0Qe9zDd7qY7H5hahY
         Tw0NEcX+NGtAXDVosQckgGubqpzVIYaCRmrVnuEnjoNwfvG7mhaizJq2i7MorCuH2Cc/
         7Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=swW1IxF4sy6bYXWIBbFX6a0TIfAtPIy8pAad5c3Kc4w=;
        b=HQ2jvtl45IhBX0Qr7JfFq7hwzZp2ej5NC3Zvw61/dcuHtK1vy75fFMnc2IK3U4v5eC
         ovSKLgQY4wJX4MTzNJa7boUmPyeVgJ3/5Dz5f6WyQEjamkWqtDDIEJ2/Oi10cNBNDWmM
         ewcDc8NdxzmN3x9a2zwTAMC9n1JY6OaXDEcknGuOakms16yS0aEWl5rlunts/V4s4R2V
         zE6kD0TsnF1u9YLHfgv3nqUuZDBcdfchTW19Gy4JNy8YIGHBz0izcY5UiPBGIiG5+6do
         tCS/URByzl3DQeYTAozqMw1pAIbPS9gBHDlsQ87dx6CaITgJJjciCA04eL8jJZchZasn
         Oq4g==
X-Gm-Message-State: AGi0PubVv2x4D96vRf2Pgr1zK4eZPbtccKaidA+PbUkj6tYewMEeveaN
        WJQgjAq4olstjvc6kWuuQYc=
X-Google-Smtp-Source: APiQypKk4NpjNqN1HbT6TtR6FgBLrUbz2bbnfcSoX8IG4A6VfEWuTCokHJcWehjYgFxkaJOOQuq+PA==
X-Received: by 2002:a65:64cb:: with SMTP id t11mr754105pgv.62.1587089068705;
        Thu, 16 Apr 2020 19:04:28 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id a19sm3011442pfd.91.2020.04.16.19.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 19:04:28 -0700 (PDT)
Date:   Fri, 17 Apr 2020 09:04:26 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 1/5] help: move list_config_help to builtin/help
Message-ID: <20200417020426.GD2285@danh.dev>
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-2-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416211807.60811-2-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-16 14:18:03-0700, Emily Shaffer <emilyshaffer@google.com> wrote:
> Starting in 3ac68a93fd2, help.o began to depend on builtin/branch.o,
> builtin/clean.o, and builtin/config.o. This meant that help.o was
> unusable outside of the context of the main Git executable.
> 
> To make help.o usable by other commands again, move list_config_help()
> into builtin/help.c (where it makes sense to assume other builtin libraries
> are present).
> 
> When command-list.h is included but a member is not used, we start to
> hear a compiler warning. Since the config list is generated in a fairly
> different way than the command list, and since commands and config
> options are semantically different, move the config list into its own
> header and move the generator into its own script and build rule.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> 
> msvc: the bugreport topic depends on a generated config-list.h file
> 
> For reasons explained in 976aaedc (msvc: add a Makefile target to
> pre-generate the Visual Studio solution, 2019-07-29), some build
> artifacts we consider non-source files cannot be generated in the
> Visual Studio environment, and we already have some Makefile tweaks
> to help Visual Studio to use generated command-list.h header file.
> 
> As this topic starts to depend on another such generated header file,
> config-list.h, let's do the same to it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  .gitignore             |  1 +
>  Makefile               | 13 +++++--
>  builtin/help.c         | 86 ++++++++++++++++++++++++++++++++++++++++++
>  compat/vcbuild/README  |  4 +-
>  config.mak.uname       |  6 +--
>  generate-cmdlist.sh    | 19 ----------
>  generate-configlist.sh | 21 +++++++++++
>  help.c                 | 85 -----------------------------------------
>  help.h                 |  1 -
>  9 files changed, 123 insertions(+), 113 deletions(-)
>  create mode 100755 generate-configlist.sh
> 
> diff --git a/.gitignore b/.gitignore
> index 188bd1c3de..61bf5142a9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -188,6 +188,7 @@
>  /gitweb/gitweb.cgi
>  /gitweb/static/gitweb.js
>  /gitweb/static/gitweb.min.*
> +/config-list.h
>  /command-list.h
>  *.tar.gz
>  *.dsc
> diff --git a/Makefile b/Makefile
> index ef1ff2228f..d4aff7f9b5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -815,6 +815,7 @@ LIB_FILE = libgit.a
>  XDIFF_LIB = xdiff/lib.a
>  VCSSVN_LIB = vcs-svn/lib.a
>  
> +GENERATED_H += config-list.h
>  GENERATED_H += command-list.h
>  
>  LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
> @@ -2133,7 +2134,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>  
>  help.sp help.s help.o: command-list.h
>  
> -builtin/help.sp builtin/help.s builtin/help.o: command-list.h GIT-PREFIX
> +builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
>  builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
>  	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
>  	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
> @@ -2153,6 +2154,12 @@ $(BUILT_INS): git$X
>  	ln -s $< $@ 2>/dev/null || \
>  	cp $< $@
>  
> +config-list.h: generate-configlist.sh
> +
> +config-list.h:
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
> +		>$@+ && mv $@+ $@
> +
>  command-list.h: generate-cmdlist.sh command-list.txt
>  
>  command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
> @@ -2786,7 +2793,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>  
> -EXCEPT_HDRS := command-list.h unicode-width.h compat/% xdiff/%
> +EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
>  ifndef GCRYPT_SHA256
>  	EXCEPT_HDRS += sha256/gcrypt.h
>  endif
> @@ -2808,7 +2815,7 @@ hdr-check: $(HCO)
>  style:
>  	git clang-format --style file --diff --extensions c,h
>  
> -check: command-list.h
> +check: config-list.h command-list.h
>  	@if sparse; \
>  	then \
>  		echo >&2 "Use 'make sparse' instead"; \
> diff --git a/builtin/help.c b/builtin/help.c
> index e5590d7787..1c5f2b9255 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -8,6 +8,7 @@
>  #include "parse-options.h"
>  #include "run-command.h"
>  #include "column.h"
> +#include "config-list.h"
>  #include "help.h"
>  #include "alias.h"
>  
> @@ -62,6 +63,91 @@ static const char * const builtin_help_usage[] = {
>  	NULL
>  };
>  
> +struct slot_expansion {
> +	const char *prefix;
> +	const char *placeholder;
> +	void (*fn)(struct string_list *list, const char *prefix);
> +	int found;
> +};
> +
> +static void list_config_help(int for_human)
> +{
> +	struct slot_expansion slot_expansions[] = {
> +		{ "advice", "*", list_config_advices },
> +		{ "color.branch", "<slot>", list_config_color_branch_slots },
> +		{ "color.decorate", "<slot>", list_config_color_decorate_slots },
> +		{ "color.diff", "<slot>", list_config_color_diff_slots },
> +		{ "color.grep", "<slot>", list_config_color_grep_slots },
> +		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
> +		{ "color.remote", "<slot>", list_config_color_sideband_slots },
> +		{ "color.status", "<slot>", list_config_color_status_slots },
> +		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
> +		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
> +		{ NULL, NULL, NULL }
> +	};
> +	const char **p;
> +	struct slot_expansion *e;
> +	struct string_list keys = STRING_LIST_INIT_DUP;
> +	int i;
> +
> +	for (p = config_name_list; *p; p++) {
> +		const char *var = *p;
> +		struct strbuf sb = STRBUF_INIT;
> +
> +		for (e = slot_expansions; e->prefix; e++) {
> +
> +			strbuf_reset(&sb);
> +			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
> +			if (!strcasecmp(var, sb.buf)) {
> +				e->fn(&keys, e->prefix);
> +				e->found++;
> +				break;
> +			}
> +		}
> +		strbuf_release(&sb);
> +		if (!e->prefix)
> +			string_list_append(&keys, var);
> +	}
> +
> +	for (e = slot_expansions; e->prefix; e++)
> +		if (!e->found)
> +			BUG("slot_expansion %s.%s is not used",
> +			    e->prefix, e->placeholder);
> +
> +	string_list_sort(&keys);
> +	for (i = 0; i < keys.nr; i++) {
> +		const char *var = keys.items[i].string;
> +		const char *wildcard, *tag, *cut;
> +
> +		if (for_human) {
> +			puts(var);
> +			continue;
> +		}
> +
> +		wildcard = strchr(var, '*');
> +		tag = strchr(var, '<');
> +
> +		if (!wildcard && !tag) {
> +			puts(var);
> +			continue;
> +		}
> +
> +		if (wildcard && !tag)
> +			cut = wildcard;
> +		else if (!wildcard && tag)
> +			cut = tag;
> +		else
> +			cut = wildcard < tag ? wildcard : tag;
> +
> +		/*
> +		 * We may produce duplicates, but that's up to
> +		 * git-completion.bash to handle
> +		 */
> +		printf("%.*s\n", (int)(cut - var), var);
> +	}
> +	string_list_clear(&keys, 0);
> +}
> +
>  static enum help_format parse_help_format(const char *format)
>  {
>  	if (!strcmp(format, "man"))
> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
> index 1b6dabf5a2..42292e7c09 100644
> --- a/compat/vcbuild/README
> +++ b/compat/vcbuild/README
> @@ -92,8 +92,8 @@ The Steps of Build Git with VS2008
>     the git operations.
>  
>  3. Inside Git's directory run the command:
> -       make command-list.h
> -   to generate the command-list.h file needed to compile git.
> +       make command-list.h config-list.h
> +   to generate the header file needed to compile git.
>  
>  4. Then either build Git with the GNU Make Makefile in the Git projects
>     root
> diff --git a/config.mak.uname b/config.mak.uname
> index 0ab8e00938..f880cc2792 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -721,9 +721,9 @@ vcxproj:
>  	 echo '</Project>') >git-remote-http/LinkOrCopyRemoteHttp.targets
>  	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRemoteHttp.targets
>  
> -	# Add command-list.h
> -	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 command-list.h
> -	git add -f command-list.h
> +	# Add command-list.h and config-list.h
> +	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 config-list.h command-list.h

In <nycvar.QRO.7.76.6.2004161406480.46@tvgsbejvaqbjf.bet>,
Dscho suggested to squash his patch instead:

https://lore.kernel.org/git/nycvar.QRO.7.76.6.2002261649550.46@tvgsbejvaqbjf.bet/

> +	git add -f config-list.h command-list.h
>  
>  	# Add scripts
>  	rm -f perl/perl.mak
> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> index 71158f7d8b..45fecf8bdf 100755
> --- a/generate-cmdlist.sh
> +++ b/generate-cmdlist.sh
> @@ -76,23 +76,6 @@ print_command_list () {
>  	echo "};"
>  }
>  
> -print_config_list () {
> -	cat <<EOF
> -static const char *config_name_list[] = {
> -EOF
> -	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
> -	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
> -	sort |
> -	while read line
> -	do
> -		echo "	\"$line\","
> -	done
> -	cat <<EOF
> -	NULL,
> -};
> -EOF
> -}
> -
>  exclude_programs=
>  while test "--exclude-program" = "$1"
>  do
> @@ -113,5 +96,3 @@ echo
>  define_category_names "$1"
>  echo
>  print_command_list "$1"
> -echo
> -print_config_list
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> new file mode 100755
> index 0000000000..8692fe5cf4
> --- /dev/null
> +++ b/generate-configlist.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +
> +echo "/* Automatically generated by generate-configlist.sh */"
> +echo
> +
> +print_config_list () {
> +	cat <<EOF
> +static const char *config_name_list[] = {
> +EOF
> +	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
> +	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
> +	sort |
> +	sed 's/^.*$/	"&",/'
> +	cat <<EOF
> +	NULL,
> +};
> +EOF
> +}
> +
> +echo
> +print_config_list
> diff --git a/help.c b/help.c
> index cf67624a94..a21487db77 100644
> --- a/help.c
> +++ b/help.c
> @@ -407,91 +407,6 @@ void list_common_guides_help(void)
>  	putchar('\n');
>  }
>  
> -struct slot_expansion {
> -	const char *prefix;
> -	const char *placeholder;
> -	void (*fn)(struct string_list *list, const char *prefix);
> -	int found;
> -};
> -
> -void list_config_help(int for_human)
> -{
> -	struct slot_expansion slot_expansions[] = {
> -		{ "advice", "*", list_config_advices },
> -		{ "color.branch", "<slot>", list_config_color_branch_slots },
> -		{ "color.decorate", "<slot>", list_config_color_decorate_slots },
> -		{ "color.diff", "<slot>", list_config_color_diff_slots },
> -		{ "color.grep", "<slot>", list_config_color_grep_slots },
> -		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
> -		{ "color.remote", "<slot>", list_config_color_sideband_slots },
> -		{ "color.status", "<slot>", list_config_color_status_slots },
> -		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
> -		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
> -		{ NULL, NULL, NULL }
> -	};
> -	const char **p;
> -	struct slot_expansion *e;
> -	struct string_list keys = STRING_LIST_INIT_DUP;
> -	int i;
> -
> -	for (p = config_name_list; *p; p++) {
> -		const char *var = *p;
> -		struct strbuf sb = STRBUF_INIT;
> -
> -		for (e = slot_expansions; e->prefix; e++) {
> -
> -			strbuf_reset(&sb);
> -			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
> -			if (!strcasecmp(var, sb.buf)) {
> -				e->fn(&keys, e->prefix);
> -				e->found++;
> -				break;
> -			}
> -		}
> -		strbuf_release(&sb);
> -		if (!e->prefix)
> -			string_list_append(&keys, var);
> -	}
> -
> -	for (e = slot_expansions; e->prefix; e++)
> -		if (!e->found)
> -			BUG("slot_expansion %s.%s is not used",
> -			    e->prefix, e->placeholder);
> -
> -	string_list_sort(&keys);
> -	for (i = 0; i < keys.nr; i++) {
> -		const char *var = keys.items[i].string;
> -		const char *wildcard, *tag, *cut;
> -
> -		if (for_human) {
> -			puts(var);
> -			continue;
> -		}
> -
> -		wildcard = strchr(var, '*');
> -		tag = strchr(var, '<');
> -
> -		if (!wildcard && !tag) {
> -			puts(var);
> -			continue;
> -		}
> -
> -		if (wildcard && !tag)
> -			cut = wildcard;
> -		else if (!wildcard && tag)
> -			cut = tag;
> -		else
> -			cut = wildcard < tag ? wildcard : tag;
> -
> -		/*
> -		 * We may produce duplicates, but that's up to
> -		 * git-completion.bash to handle
> -		 */
> -		printf("%.*s\n", (int)(cut - var), var);
> -	}
> -	string_list_clear(&keys, 0);
> -}
> -
>  static int get_alias(const char *var, const char *value, void *data)
>  {
>  	struct string_list *list = data;
> diff --git a/help.h b/help.h
> index 7a455beeb7..9071894e8c 100644
> --- a/help.h
> +++ b/help.h
> @@ -22,7 +22,6 @@ static inline void mput_char(char c, unsigned int num)
>  void list_common_cmds_help(void);
>  void list_all_cmds_help(void);
>  void list_common_guides_help(void);
> -void list_config_help(int for_human);
>  
>  void list_all_main_cmds(struct string_list *list);
>  void list_all_other_cmds(struct string_list *list);
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 

-- 
Danh
