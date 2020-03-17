Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D53AC0044D
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 02:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA9520674
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 02:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG0SHNM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgCQC6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:58:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35623 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgCQC6N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 22:58:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so11108471pfb.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 19:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OXSfdcJHJlVpdPa2gRHeD+j4Aq1atfLZjK1y7h9BEfk=;
        b=MG0SHNM0NYWFk5hqKUiThZ8e9JkO2awj9LiEONBVMqNN/Rb+Egasj6p7wgB4/api4O
         UcgxoJlFoExGG2Jk9b+5D5M435Fqzb6u5QUmojpuufB8rTrouenFVGheb4FvCa1djmRB
         EMPcC+Q2bqE+3+14oa2ho5XfsmEWZOVNRzH+QophgVxlL6X3FhlK1IzI6X05x5LKMCi7
         WKY0ShRgrtsGAqN17n8WPas1NzzHMX4DTHb1HpkYHWe905Ka1qkpBJZiyDZi0mqnBl4h
         yi5i0FKr6qrjTJJH6J/qrSpg6x0wwG5UOUDyRjSro113e1438LqaCv3cK6ziqyvfW+lq
         KJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OXSfdcJHJlVpdPa2gRHeD+j4Aq1atfLZjK1y7h9BEfk=;
        b=Hl5Qlwr2amqGQxNVyqAONsjSHEw6xgXnmtPN/RsaOkXTpVXy5M2TyQID+9YMxvSHbw
         pSRa/ICaVJJT5hK1S3/LZCBdMiInZtU/LOJxSBgKV7NX+IpwHthXkVap5nt7zPAUkstu
         141WyKLaSYfCxtIm8h8F/rz1MHDobcwEYVCDwXc7BBbFU+/0wRr73NJkvXTxfAGXs9Q7
         xOeSPTpN8xqIR1gYhbTsMJX2oHmsMCXCQiqsYnPOC3E8A3weD6qpPdZxWTzQuXyz2FqI
         WnGbs8z/oHHt0OW022Y3LjpliTLWd+J7y6ypC+GwyIfKl/q6M6y2NiBj1aOsCzDDRGkq
         LJZA==
X-Gm-Message-State: ANhLgQ15s+AXbOPxKPMJJirA00pEeg6s1jhNXhUoP/CBHY1imDjeYrjc
        n8/FEMAD6dHdXi+z3Ytyp0w=
X-Google-Smtp-Source: ADFU+vt4nzf2dJxrC4xidVx3g4a+/njDjBWzuxB52dGv3vLurWX6xyynY8KJLCWJ/Wx7HP4nFzoK6w==
X-Received: by 2002:aa7:909a:: with SMTP id i26mr2942088pfa.144.1584413890825;
        Mon, 16 Mar 2020 19:58:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id y13sm1135422pfp.88.2020.03.16.19.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 19:58:10 -0700 (PDT)
Date:   Mon, 16 Mar 2020 19:58:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
Message-ID: <20200317025808.GB31380@google.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
 <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com>
 <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
 <20200312175548.GC120942@google.com>
 <CABPp-BFLwpa019Prd3nf7s4BY2jWp8utOvJD9pzHcbg66b8fWw@mail.gmail.com>
 <20200312184621.GD120942@google.com>
 <CABPp-BHSAbJzWEsPSTM5Q6MPdmu4VSuOx-=6-MJkHUovg3_1=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHSAbJzWEsPSTM5Q6MPdmu4VSuOx-=6-MJkHUovg3_1=g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:
> On Thu, Mar 12, 2020 at 11:46 AM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Sorry for the lack of clarity.  I mean allowing
>>
>>         [rebase]
>>                 backend = am
>>                 backend = apply
>>                 backend = futuristic
>>
>> with behavior
>>
>> - on "git" that understands am but not apply or futuristic, use the am
>>   backend
>> - on "git" that understands apply but not am or futuristic, use the
>>   apply backend
>> - on "git" that understands apply and futuristic, use the futuristic
>>   backend
>>
>> That way, a single config file is usable on all three versions of Git.
>
> Ah, gotcha, that makes sense though we'd need to make the thing
> multi-valued which is a bit late for 2.26.  But we could at least
> extend the logic in that way for 2.27.

Here's a patch implementing that.  I'm not convinced it's worth the
complexity, mostly because I'm not convinced that rebase is going to
have to select between additional new backends in the future.  But if
you think it will, then I think this would be a reasonable thing to do
(maybe even without the documentation part of the patch).

Thoughts?

Thanks,
Jonathan

-- >8 --
Subject: rebase: allow specifying unrecognized rebase.backend with a fallback

In 8295ed690bf (rebase: make the backend configurable via config
setting, 2020-02-15), Git learned a new rebase.backend setting that
can be used to specify which implementation should be used for
non-interactive rebases: "am" (now called "apply"), which uses "git
am", or "merge", which uses the three-way merge machinery.

Most likely those are the only two backends that rebase will ever need
to learn, so this level of configurability would be sufficient.  At
some point the "apply" backend would be retired, and the setting would
be removed altogether.

Suppose, though, that rebase learns another backend --- e.g. "faster".
In that case, a user might set configuration to request it:

	[rebase]
		backend = faster

If their configuration is shared between multiple versions of Git
(think "home directory on NFS shared between machines"), this would
produce errors when read by older versions of Git:

	fatal: Unknown rebase backend: faster

On the other hand, if we ignore unrecognized rebase backend settings,
then Git would fail to realize that

	[rebase]
		backend = appply

is a typo, producing a confusing user experience.  Let's do something
in between: when a rebase backend setting is unrecognized, fall back
to the last earlier recognized value, but if no value was recognized,
print an error message allowing the user to catch their typo.

Reported-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/config/rebase.txt |  5 ++
 builtin/rebase.c                | 52 +++++++++++++++---
 t/t3435-rebase-backend.sh       | 97 +++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 8 deletions(-)
 create mode 100755 t/t3435-rebase-backend.sh

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index 7f7a07d22f8..c92adbdcc69 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -10,6 +10,11 @@ rebase.backend::
 	'apply' or 'merge'.  In the future, if the merge backend gains
 	all remaining capabilities of the apply backend, this setting
 	may become unused.
++
+If set multiple times, the last value corresponding to a recognized
+backend is used. This is for forward compatibility, as it allows
+specifying a rebase backend that Git does not know about yet along
+with a backend known today as a fallback.
 
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ffa467aad52..5b0fab9741f 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -56,10 +56,18 @@ enum empty_type {
 	EMPTY_ASK
 };
 
+enum rebase_backend {
+	BACKEND_UNSPECIFIED = 0,
+	BACKEND_UNRECOGNIZED,
+	BACKEND_APPLY,
+	BACKEND_MERGE,
+};
+
 struct rebase_options {
 	enum rebase_type type;
 	enum empty_type empty;
-	const char *default_backend;
+	enum rebase_backend configured_backend;
+	const char *last_specified_backend;
 	const char *state_dir;
 	struct commit *upstream;
 	const char *upstream_name;
@@ -100,7 +108,6 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
-		.default_backend = "merge",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -1224,6 +1231,15 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	return status ? -1 : 0;
 }
 
+static enum rebase_backend parse_rebase_backend(const char *value)
+{
+	if (!strcmp(value, "apply"))
+		return BACKEND_APPLY;
+	if (!strcmp(value, "merge"))
+		return BACKEND_MERGE;
+	return BACKEND_UNRECOGNIZED;
+}
+
 static int rebase_config(const char *var, const char *value, void *data)
 {
 	struct rebase_options *opts = data;
@@ -1264,7 +1280,18 @@ static int rebase_config(const char *var, const char *value, void *data)
 	}
 
 	if (!strcmp(var, "rebase.backend")) {
-		return git_config_string(&opts->default_backend, var, value);
+		enum rebase_backend val;
+		if (!value)
+			return config_error_nonbool(var);
+		val = parse_rebase_backend(value);
+		if (opts->configured_backend == BACKEND_UNSPECIFIED)
+			opts->configured_backend = val;
+		else if (val == BACKEND_UNRECOGNIZED)
+			; /* Unrecognized rebase backend. Ignore it. */
+		else
+			opts->configured_backend = val;
+		opts->last_specified_backend = value;
+		return 0;
 	}
 
 	return git_default_config(var, value, data);
@@ -1903,14 +1930,23 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (options.configured_backend == BACKEND_UNRECOGNIZED)
+		die(_("unknown rebase backend: %s"),
+		    options.last_specified_backend);
+
 	if (options.type == REBASE_UNSPECIFIED) {
-		if (!strcmp(options.default_backend, "merge"))
+		switch (options.configured_backend) {
+		case BACKEND_UNSPECIFIED:
+		case BACKEND_MERGE:
 			imply_merge(&options, "--merge");
-		else if (!strcmp(options.default_backend, "apply"))
+			break;
+		case BACKEND_APPLY:
 			options.type = REBASE_APPLY;
-		else
-			die(_("Unknown rebase backend: %s"),
-			    options.default_backend);
+			break;
+		default:
+			BUG("unexpected backend %d",
+			    (int) options.configured_backend);
+		}
 	}
 
 	switch (options.type) {
diff --git a/t/t3435-rebase-backend.sh b/t/t3435-rebase-backend.sh
new file mode 100755
index 00000000000..8b9ba6f1894
--- /dev/null
+++ b/t/t3435-rebase-backend.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+
+test_description='rebase.backend tests
+
+Checks of config parsing for the [rebase] backend setting.  We detect
+which backend was used by checking which directory was created to hold
+state.'
+
+. ./test-lib.sh
+
+# usage: test_backend_choice <expectation> <command>
+#
+# Tests that the chosen backend for rebase command <command>
+# is <expectation> ("merge" or "apply").
+test_backend_choice () {
+	expect=$1 &&
+	shift &&
+
+	test_must_fail git "$@" master topic &&
+	case $expect in
+	apply)
+		test_path_is_dir .git/rebase-apply &&
+		test_path_is_missing .git/rebase-merge
+		;;
+	merge)
+		test_path_is_dir .git/rebase-merge &&
+		test_path_is_missing .git/rebase-apply
+		;;
+	*)
+		error "unrecognized expectation $expect"
+	esac
+}
+
+test_expect_success 'setup' '
+	test_commit base &&
+	test_commit sidea conflict.txt myway &&
+	git checkout -b topic base &&
+	test_commit sideb conflict.txt thehighway
+'
+
+test_expect_success '--apply uses apply backend' '
+	test_when_finished "git rebase --abort" &&
+	test_backend_choice apply rebase --apply
+'
+
+test_expect_success '--merge uses merge backend' '
+	test_when_finished "git rebase --abort" &&
+	test_backend_choice merge rebase --merge
+'
+
+test_expect_success 'default to merge backend' '
+	test_when_finished "git rebase --abort" &&
+	test_backend_choice merge rebase
+'
+
+test_expect_success 'config overrides default' '
+	test_when_finished "git rebase --abort" &&
+	test_backend_choice apply -c rebase.backend=apply rebase
+'
+
+test_expect_success 'option overrides config' '
+	test_when_finished "git rebase --abort" &&
+	test_backend_choice merge -c rebase.backend=apply rebase --merge
+'
+
+test_expect_success 'last config value wins' '
+	test_when_finished "git rebase --abort" &&
+	test_backend_choice merge \
+		-c rebase.backend=apply \
+		-c rebase.backend=merge \
+		rebase
+'
+
+test_expect_success 'last config value wins' '
+	test_when_finished "git rebase --abort" &&
+	test_backend_choice merge \
+		-c rebase.backend=apply \
+		-c rebase.backend=merge \
+		rebase
+'
+
+test_expect_success 'misspelled backend without fallback is diagnosed' '
+	test_must_fail \
+		git -c rebase.backend=appply rebase master topic 2>message &&
+	test_i18ngrep "unknown rebase backend" message &&
+	grep appply message
+'
+
+test_expect_success 'forward compatibility by skipping unrecognized values' '
+	test_when_finished "git rebase --abort" &&
+	test_backend_choice apply \
+		-c rebase.backend=apply \
+		-c rebase.backend=futuristic \
+		rebase
+'
+
+test_done
-- 
2.25.1.481.gfbce0eb801

