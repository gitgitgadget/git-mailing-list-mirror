Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82962C2D0C3
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 21:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A6B218AC
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 21:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIGOkts+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfLPVgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:36:32 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37143 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfLPVgb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 16:36:31 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep17so3587339pjb.4
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 13:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S9y3KfaMHtwXnZqI1DWAYN8lHqkeI/p+216trSgB75U=;
        b=KIGOkts+A9wpT91pV8qd6qIqncvLaNS5v1n5iDlxx6Sjq7rQmBJoqWaVE6QQge8rQx
         AV8jr6cIfEZpxvj7J9DUsPZlfaTIVCOfzcpS83oruQfv6m83jbhrAwV/D0XnMYTMDkH1
         4c1V/oG3YTym6f5Xvz+9y14e6CyBbKimRRXkxFfFDDHWKiydQKd06W79LXNfs2kwRqaP
         j7xRjaYYdG4zx4ztRcx5CFztRHHeuu7+xqvBGZ1z0Byn7H2ndMzb/iCqMyVtY0+6cX6x
         gco4c6Ps+5zgHaz4JL/wvYUzepUs6j35+pDU2Wq4f1wAg9Gj/EmVXjeSrmGBoE4XivX4
         eI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S9y3KfaMHtwXnZqI1DWAYN8lHqkeI/p+216trSgB75U=;
        b=TJtxJ00NoKGMueXIp4uu8bai8ufpEURxIa+i0+1LUPglolaCR1iPk2z8RZj/Xl8ndd
         pLJNbWSkihA24dO9GiReNBC/K3F3aAkJMHqRXiJASy0ellaL9ENYjdoZlrTkS2nUCY56
         HGaUtFGyxO68qig+4Pyj3vR1LLlRHgfIYA7NDlRk2VKX0Mz7kzevdzNCtAAIoQu/8+vH
         X1luv61JIEk/c179XQrAeke+UnmVPU5l2/KnYDl7kSgGadjSouN3qGdhlV9bjj4QMxMG
         uiB+WcskBqAhyNKNka+KmYqROyXAlnq/MHcchcGBC3yJiqOEaryeIchOBmlFmUYCidnO
         0I2A==
X-Gm-Message-State: APjAAAUoMJQR+0lVeHREroVL7PAfbsXcsvILzH5FLYHAunnjzqobonER
        JS7IpDgZALwrFKEcYEyOkQvKAIp+qdI=
X-Google-Smtp-Source: APXvYqxet6t+rDMQHUFJ7t7wo6AJrcQKXtSTAatcBWzXE4RdZBLxj0ukolC0Bt6FQ7wBEsmRFI803g==
X-Received: by 2002:a17:90a:6587:: with SMTP id k7mr1706531pjj.40.1576532189928;
        Mon, 16 Dec 2019 13:36:29 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id s128sm19034894pfb.167.2019.12.16.13.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 13:36:29 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:36:25 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 02/15] help: move list_config_help to builtin/help
Message-ID: <20191216213625.GE135450@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-3-emilyshaffer@google.com>
 <xmqqv9qkhrtd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9qkhrtd.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 12:51:58PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Starting in 3ac68a93fd2, help.o began to depend on builtin/branch.o,
> > builtin/clean.o, and builtin/config.o. This meant that help.o was
> > unusable outside of the context of the main Git executable.
> >
> > To make help.o usable by other commands again, move list_config_help()
> > into builtin/help.c (where it makes sense to assume other builtin libraries
> > are present).
> >
> > When command-list.h is included but a member is not used, we start to
> > hear a compiler warning. Since the config list is generated in a fairly
> > different way than the command list, and since commands and config
> > options are semantically different, move the config list into its own
> > header and move the generator into its own script and build rule.
> >
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> 
> OK.  Looks like a clean-up that is very worthy even without the
> remainder of the topic.
> 
> Thanks.

Ok. Are you going to take it on its own? If so, I'll be relying on two
branches in pu/ - what's the best way to let you know I need them both
if/when I send another version of this chain?

> 
> >  .gitignore             |  1 +
> >  Makefile               | 16 ++++++--
> >  builtin/help.c         | 86 ++++++++++++++++++++++++++++++++++++++++++
> >  generate-cmdlist.sh    | 19 ----------
> >  generate-configlist.sh | 24 ++++++++++++
> >  help.c                 | 85 -----------------------------------------
> >  help.h                 |  1 -
> >  7 files changed, 123 insertions(+), 109 deletions(-)
> >  create mode 100755 generate-configlist.sh
> >
> > diff --git a/.gitignore b/.gitignore
> > index 055a84c4a8..5dde2cc4c8 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -189,6 +189,7 @@
> >  /gitweb/gitweb.cgi
> >  /gitweb/static/gitweb.js
> >  /gitweb/static/gitweb.min.*
> > +/config-list.h
> >  /command-list.h
> >  *.tar.gz
> >  *.dsc
> > diff --git a/Makefile b/Makefile
> > index 9dff91436e..c49f55a521 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -815,6 +815,7 @@ LIB_FILE = libgit.a
> >  XDIFF_LIB = xdiff/lib.a
> >  VCSSVN_LIB = vcs-svn/lib.a
> >  
> > +GENERATED_H += config-list.h
> >  GENERATED_H += command-list.h
> >  
> >  LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
> > @@ -2127,7 +2128,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
> >  
> >  help.sp help.s help.o: command-list.h
> >  
> > -builtin/help.sp builtin/help.s builtin/help.o: command-list.h GIT-PREFIX
> > +builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
> >  builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
> >  	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
> >  	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
> > @@ -2147,6 +2148,12 @@ $(BUILT_INS): git$X
> >  	ln -s $< $@ 2>/dev/null || \
> >  	cp $< $@
> >  
> > +config-list.h: generate-configlist.sh
> > +
> > +config-list.h:
> > +	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
> > +		>$@+ && mv $@+ $@
> > +
> >  command-list.h: generate-cmdlist.sh command-list.txt
> >  
> >  command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
> > @@ -2784,7 +2791,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
> >  .PHONY: sparse $(SP_OBJ)
> >  sparse: $(SP_OBJ)
> >  
> > -GEN_HDRS := command-list.h unicode-width.h
> > +GEN_HDRS := config-list.h command-list.h unicode-width.h
> >  EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
> >  ifndef GCRYPT_SHA256
> >  	EXCEPT_HDRS += sha256/gcrypt.h
> > @@ -2807,7 +2814,7 @@ hdr-check: $(HCO)
> >  style:
> >  	git clang-format --style file --diff --extensions c,h
> >  
> > -check: command-list.h
> > +check: config-list.h command-list.h
> >  	@if sparse; \
> >  	then \
> >  		echo >&2 "Use 'make sparse' instead"; \
> > @@ -3110,7 +3117,8 @@ clean: profile-clean coverage-clean cocciclean
> >  	$(RM) $(HCC)
> >  	$(RM) -r bin-wrappers $(dep_dirs)
> >  	$(RM) -r po/build/
> > -	$(RM) *.pyc *.pyo */*.pyc */*.pyo command-list.h $(ETAGS_TARGET) tags cscope*
> > +	$(RM) *.pyc *.pyo */*.pyc */*.pyo config-list.h command-list.h
> > +	$(RM) $(ETAGS_TARGET) tags cscope*
> >  	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
> >  	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
> >  	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
> > diff --git a/builtin/help.c b/builtin/help.c
> > index e5590d7787..1c5f2b9255 100644
> > --- a/builtin/help.c
> > +++ b/builtin/help.c
> > @@ -8,6 +8,7 @@
> >  #include "parse-options.h"
> >  #include "run-command.h"
> >  #include "column.h"
> > +#include "config-list.h"
> >  #include "help.h"
> >  #include "alias.h"
> >  
> > @@ -62,6 +63,91 @@ static const char * const builtin_help_usage[] = {
> >  	NULL
> >  };
> >  
> > +struct slot_expansion {
> > +	const char *prefix;
> > +	const char *placeholder;
> > +	void (*fn)(struct string_list *list, const char *prefix);
> > +	int found;
> > +};
> > +
> > +static void list_config_help(int for_human)
> > +{
> > +	struct slot_expansion slot_expansions[] = {
> > +		{ "advice", "*", list_config_advices },
> > +		{ "color.branch", "<slot>", list_config_color_branch_slots },
> > +		{ "color.decorate", "<slot>", list_config_color_decorate_slots },
> > +		{ "color.diff", "<slot>", list_config_color_diff_slots },
> > +		{ "color.grep", "<slot>", list_config_color_grep_slots },
> > +		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
> > +		{ "color.remote", "<slot>", list_config_color_sideband_slots },
> > +		{ "color.status", "<slot>", list_config_color_status_slots },
> > +		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
> > +		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
> > +		{ NULL, NULL, NULL }
> > +	};
> > +	const char **p;
> > +	struct slot_expansion *e;
> > +	struct string_list keys = STRING_LIST_INIT_DUP;
> > +	int i;
> > +
> > +	for (p = config_name_list; *p; p++) {
> > +		const char *var = *p;
> > +		struct strbuf sb = STRBUF_INIT;
> > +
> > +		for (e = slot_expansions; e->prefix; e++) {
> > +
> > +			strbuf_reset(&sb);
> > +			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
> > +			if (!strcasecmp(var, sb.buf)) {
> > +				e->fn(&keys, e->prefix);
> > +				e->found++;
> > +				break;
> > +			}
> > +		}
> > +		strbuf_release(&sb);
> > +		if (!e->prefix)
> > +			string_list_append(&keys, var);
> > +	}
> > +
> > +	for (e = slot_expansions; e->prefix; e++)
> > +		if (!e->found)
> > +			BUG("slot_expansion %s.%s is not used",
> > +			    e->prefix, e->placeholder);
> > +
> > +	string_list_sort(&keys);
> > +	for (i = 0; i < keys.nr; i++) {
> > +		const char *var = keys.items[i].string;
> > +		const char *wildcard, *tag, *cut;
> > +
> > +		if (for_human) {
> > +			puts(var);
> > +			continue;
> > +		}
> > +
> > +		wildcard = strchr(var, '*');
> > +		tag = strchr(var, '<');
> > +
> > +		if (!wildcard && !tag) {
> > +			puts(var);
> > +			continue;
> > +		}
> > +
> > +		if (wildcard && !tag)
> > +			cut = wildcard;
> > +		else if (!wildcard && tag)
> > +			cut = tag;
> > +		else
> > +			cut = wildcard < tag ? wildcard : tag;
> > +
> > +		/*
> > +		 * We may produce duplicates, but that's up to
> > +		 * git-completion.bash to handle
> > +		 */
> > +		printf("%.*s\n", (int)(cut - var), var);
> > +	}
> > +	string_list_clear(&keys, 0);
> > +}
> > +
> >  static enum help_format parse_help_format(const char *format)
> >  {
> >  	if (!strcmp(format, "man"))
> > diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> > index 71158f7d8b..45fecf8bdf 100755
> > --- a/generate-cmdlist.sh
> > +++ b/generate-cmdlist.sh
> > @@ -76,23 +76,6 @@ print_command_list () {
> >  	echo "};"
> >  }
> >  
> > -print_config_list () {
> > -	cat <<EOF
> > -static const char *config_name_list[] = {
> > -EOF
> > -	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
> > -	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
> > -	sort |
> > -	while read line
> > -	do
> > -		echo "	\"$line\","
> > -	done
> > -	cat <<EOF
> > -	NULL,
> > -};
> > -EOF
> > -}
> > -
> >  exclude_programs=
> >  while test "--exclude-program" = "$1"
> >  do
> > @@ -113,5 +96,3 @@ echo
> >  define_category_names "$1"
> >  echo
> >  print_command_list "$1"
> > -echo
> > -print_config_list
> > diff --git a/generate-configlist.sh b/generate-configlist.sh
> > new file mode 100755
> > index 0000000000..eca6a00c30
> > --- /dev/null
> > +++ b/generate-configlist.sh
> > @@ -0,0 +1,24 @@
> > +#!/bin/sh
> > +
> > +echo "/* Automatically generated by generate-configlist.sh */"
> > +echo
> > +
> > +print_config_list () {
> > +	cat <<EOF
> > +static const char *config_name_list[] = {
> > +EOF
> > +	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
> > +	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
> > +	sort |
> > +	while read line
> > +	do
> > +		echo "	\"$line\","
> > +	done
> > +	cat <<EOF
> > +	NULL,
> > +};
> > +EOF
> > +}
> > +
> > +echo
> > +print_config_list
> > diff --git a/help.c b/help.c
> > index cf67624a94..a21487db77 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -407,91 +407,6 @@ void list_common_guides_help(void)
> >  	putchar('\n');
> >  }
> >  
> > -struct slot_expansion {
> > -	const char *prefix;
> > -	const char *placeholder;
> > -	void (*fn)(struct string_list *list, const char *prefix);
> > -	int found;
> > -};
> > -
> > -void list_config_help(int for_human)
> > -{
> > -	struct slot_expansion slot_expansions[] = {
> > -		{ "advice", "*", list_config_advices },
> > -		{ "color.branch", "<slot>", list_config_color_branch_slots },
> > -		{ "color.decorate", "<slot>", list_config_color_decorate_slots },
> > -		{ "color.diff", "<slot>", list_config_color_diff_slots },
> > -		{ "color.grep", "<slot>", list_config_color_grep_slots },
> > -		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
> > -		{ "color.remote", "<slot>", list_config_color_sideband_slots },
> > -		{ "color.status", "<slot>", list_config_color_status_slots },
> > -		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
> > -		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
> > -		{ NULL, NULL, NULL }
> > -	};
> > -	const char **p;
> > -	struct slot_expansion *e;
> > -	struct string_list keys = STRING_LIST_INIT_DUP;
> > -	int i;
> > -
> > -	for (p = config_name_list; *p; p++) {
> > -		const char *var = *p;
> > -		struct strbuf sb = STRBUF_INIT;
> > -
> > -		for (e = slot_expansions; e->prefix; e++) {
> > -
> > -			strbuf_reset(&sb);
> > -			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
> > -			if (!strcasecmp(var, sb.buf)) {
> > -				e->fn(&keys, e->prefix);
> > -				e->found++;
> > -				break;
> > -			}
> > -		}
> > -		strbuf_release(&sb);
> > -		if (!e->prefix)
> > -			string_list_append(&keys, var);
> > -	}
> > -
> > -	for (e = slot_expansions; e->prefix; e++)
> > -		if (!e->found)
> > -			BUG("slot_expansion %s.%s is not used",
> > -			    e->prefix, e->placeholder);
> > -
> > -	string_list_sort(&keys);
> > -	for (i = 0; i < keys.nr; i++) {
> > -		const char *var = keys.items[i].string;
> > -		const char *wildcard, *tag, *cut;
> > -
> > -		if (for_human) {
> > -			puts(var);
> > -			continue;
> > -		}
> > -
> > -		wildcard = strchr(var, '*');
> > -		tag = strchr(var, '<');
> > -
> > -		if (!wildcard && !tag) {
> > -			puts(var);
> > -			continue;
> > -		}
> > -
> > -		if (wildcard && !tag)
> > -			cut = wildcard;
> > -		else if (!wildcard && tag)
> > -			cut = tag;
> > -		else
> > -			cut = wildcard < tag ? wildcard : tag;
> > -
> > -		/*
> > -		 * We may produce duplicates, but that's up to
> > -		 * git-completion.bash to handle
> > -		 */
> > -		printf("%.*s\n", (int)(cut - var), var);
> > -	}
> > -	string_list_clear(&keys, 0);
> > -}
> > -
> >  static int get_alias(const char *var, const char *value, void *data)
> >  {
> >  	struct string_list *list = data;
> > diff --git a/help.h b/help.h
> > index 7a455beeb7..9071894e8c 100644
> > --- a/help.h
> > +++ b/help.h
> > @@ -22,7 +22,6 @@ static inline void mput_char(char c, unsigned int num)
> >  void list_common_cmds_help(void);
> >  void list_all_cmds_help(void);
> >  void list_common_guides_help(void);
> > -void list_config_help(int for_human);
> >  
> >  void list_all_main_cmds(struct string_list *list);
> >  void list_all_other_cmds(struct string_list *list);
