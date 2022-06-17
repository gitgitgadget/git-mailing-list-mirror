Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D682C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 10:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380673AbiFQKDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiFQKDP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 06:03:15 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C31D0C6
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 03:03:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e11so3772481pfj.5
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 03:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILFi+FoKSjMptf82V4J5Vr6dHQi1saTjMRf8hPTEcow=;
        b=lhV8LkG8pcnBDo6z+uHll1T79rOPU88t/rD434HbIMGd6jo9hVKGzDYr8X0i2nrMfa
         N+6P1htA23IWFxqnKBrRHWSmCsdf0vMWuhCULegTYAjZNw8iuj5lCza7jGOcCTDLuaZu
         46zwezrELaArV9IRI1IoAEvTCO1aDDR+CN+nPjCU1XKAyYl+gcqJyFE68t2TXjbeRyVa
         m2ocniyMXKDqd/Odlep5IvpixZb0QGzdJEa4UDT+EXCQibSTILhthOvr6qH0I8aIA1P2
         L4SwWY8ORslfGnRGAsDmoAKsxN/jf6uOA/Qy/TuRgFEiy4h+ZDfmHfeamSZNwuuqyi5G
         onZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ILFi+FoKSjMptf82V4J5Vr6dHQi1saTjMRf8hPTEcow=;
        b=PPfUeveyF6lwH3eaar6eKKAPi+AyKi+niCQUQ9mIGNDf1YyAjCJWKvkekqPEIzxgHh
         tq63uupoaBxTnKMa+uIvXFewmQibUHg+0ZIAJlLhJS90gG2b1TOfqp1Nqfbz/7Q+MJlQ
         h/bhYmGFqFFSmPzTtBc+IB6A8T6PcbhuNL+UdZTGN7nAYuNnl2d1sNCPq4Qzb8Nmg1iQ
         xlP6ZsIjpTXOWlNlRgVBhoh28VRtFq6p+1FDSnNgslZIRIGIW6piWRUgLzHiB27L3YZx
         y3lwoErVOsoIYhAvqQt0U4dEoYw3AEZEeQZm7958L2bBIuP+vKcAvQ0QiV/9e8Z+oqx5
         rrGQ==
X-Gm-Message-State: AJIora8Pkl+alxUi3JVFaHAlxBqeYPS2DW/NsL4ZN0bKywbfF3Z+2NQg
        rW3w1dmiGZRpnAKz+XlN+Hg=
X-Google-Smtp-Source: AGRyM1uTbERV29O8R0CpSNoY+KkQ3/5sLJP+CfYYgSYYZfAR96ho5PxZBWi/cmt7wW7djQeee6pJeg==
X-Received: by 2002:a05:6a00:1584:b0:51c:7932:975a with SMTP id u4-20020a056a00158400b0051c7932975amr9249132pfk.80.1655460193725;
        Fri, 17 Jun 2022 03:03:13 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id h192-20020a6283c9000000b0050dc7628138sm3394506pfe.18.2022.06.17.03.03.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 03:03:13 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        =?UTF-8?q?S=C3=A9bastien=20Helleu?= <flashcode@flashtux.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Sihyeon Jang <uneedsihyeon@gmail.com>,
        Arusekk <arek_koz@o2.pl>, Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        insolor <insolor@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Ray Chen <oldsharp@gmail.com>,
        =?UTF-8?q?=E4=BE=9D=E4=BA=91?= <lilydjwg@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Franklin Weng <franklin@goodhorse.idv.tw>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Git List <git@vger.kernel.org>
Subject: [PATCH] i18n: fix mismatched camelCase config variables
Date:   Fri, 17 Jun 2022 18:03:09 +0800
Message-Id: <20220617100309.3224-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>


Some config variables are combinations of multiple words, and we
typically write them in camelCase forms in manpage and translatable
strings. It's not easy to find mismatches for these camelCase config
variables during code reviews, but occasionally they are identified
during localization translations.

To check for mismatched config variables, I introduced a new feature
in the helper program for localization[^1]. The following mismatched
config variables have been identified by running the helper program,
such as "git-po-helper check-pot".

Lowercase in manpage should use camelCase:

 * Documentation/config/http.txt: http.pinnedpubkey

Lowercase in translable strings should use camelCase:

 * builtin/fast-import.c:  pack.indexversion
 * builtin/gc.c:           gc.logexpiry
 * builtin/index-pack.c:   pack.indexversion
 * builtin/pack-objects.c: pack.indexversion
 * builtin/repack.c:       pack.writebitmaps
 * commit.c:               i18n.commitencoding
 * gpg-interface.c:        user.signingkey
 * http.c:                 http.postbuffer
 * submodule-config.c:     submodule.fetchjobs

Mismatched camelCases, choose the former:

 * Documentation/config/fetch.txt: fetch.credentialsInUrl
   remote.c:                       fetch.credentialsInURL

[^1]: https://github.com/git-l10n/git-po-helper

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Documentation/config/http.txt | 2 +-
 builtin/fast-import.c         | 2 +-
 builtin/gc.c                  | 2 +-
 builtin/index-pack.c          | 2 +-
 builtin/pack-objects.c        | 2 +-
 builtin/repack.c              | 2 +-
 commit.c                      | 2 +-
 gpg-interface.c               | 2 +-
 http.c                        | 2 +-
 remote.c                      | 2 +-
 submodule-config.c            | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 179d03e57b..afeeccfbfa 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -203,7 +203,7 @@ http.schannelUseSSLCAInfo::
 	when the `schannel` backend was configured via `http.sslBackend`,
 	unless `http.schannelUseSSLCAInfo` overrides this behavior.
 
-http.pinnedpubkey::
+http.pinnedPubkey::
 	Public key of the https service. It may either be the filename of
 	a PEM or DER encoded public key file or a string starting with
 	'sha256//' followed by the base64 encoded sha256 hash of the
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 28d3193c38..14113cfd82 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3465,7 +3465,7 @@ static void git_pack_config(void)
 		pack_idx_opts.version = indexversion_value;
 		if (pack_idx_opts.version > 2)
 			git_die_config("pack.indexversion",
-					"bad pack.indexversion=%"PRIu32, pack_idx_opts.version);
+					"bad pack.indexVersion=%"PRIu32, pack_idx_opts.version);
 	}
 	if (!git_config_get_ulong("pack.packsizelimit", &packsizelimit_value))
 		max_packsize = packsizelimit_value;
diff --git a/builtin/gc.c b/builtin/gc.c
index 4ea70089c9..021e9256ae 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -581,7 +581,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	/* default expiry time, overwritten in gc_config */
 	gc_config();
 	if (parse_expiry_date(gc_log_expire, &gc_log_expire_time))
-		die(_("failed to parse gc.logexpiry value %s"), gc_log_expire);
+		die(_("failed to parse gc.logExpiry value %s"), gc_log_expire);
 
 	if (pack_refs < 0)
 		pack_refs = !is_bare_repository();
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3e385b4800..6648f2daef 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1575,7 +1575,7 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "pack.indexversion")) {
 		opts->version = git_config_int(k, v);
 		if (opts->version > 2)
-			die(_("bad pack.indexversion=%"PRIu32), opts->version);
+			die(_("bad pack.indexVersion=%"PRIu32), opts->version);
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cc5f41086d..39e28cfcaf 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3170,7 +3170,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 	if (!strcmp(k, "pack.indexversion")) {
 		pack_idx_opts.version = git_config_int(k, v);
 		if (pack_idx_opts.version > 2)
-			die(_("bad pack.indexversion=%"PRIu32),
+			die(_("bad pack.indexVersion=%"PRIu32),
 			    pack_idx_opts.version);
 		return 0;
 	}
diff --git a/builtin/repack.c b/builtin/repack.c
index c957b2959f..4a7ae4cf48 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -41,7 +41,7 @@ static const char *const git_repack_usage[] = {
 
 static const char incremental_bitmap_conflict_error[] = N_(
 "Incremental repacks are incompatible with bitmap indexes.  Use\n"
-"--no-write-bitmap-index or disable the pack.writebitmaps configuration."
+"--no-write-bitmap-index or disable the pack.writeBitmaps configuration."
 );
 
 struct pack_objects_args {
diff --git a/commit.c b/commit.c
index 73865fee15..1fb1b2ea90 100644
--- a/commit.c
+++ b/commit.c
@@ -1526,7 +1526,7 @@ static int verify_utf8(struct strbuf *buf)
 static const char commit_utf8_warn[] =
 N_("Warning: commit message did not conform to UTF-8.\n"
    "You may want to amend it after fixing the message, or set the config\n"
-   "variable i18n.commitencoding to the encoding your project uses.\n");
+   "variable i18n.commitEncoding to the encoding your project uses.\n");
 
 int commit_tree_extended(const char *msg, size_t msg_len,
 			 const struct object_id *tree,
diff --git a/gpg-interface.c b/gpg-interface.c
index 280f1fa1a5..947b58ad4d 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -985,7 +985,7 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 
 	if (!signing_key || signing_key[0] == '\0')
 		return error(
-			_("user.signingkey needs to be set for ssh signing"));
+			_("user.signingKey needs to be set for ssh signing"));
 
 	if (is_literal_ssh_key(signing_key, &literal_key)) {
 		/* A literal ssh key */
diff --git a/http.c b/http.c
index 11c6f69fac..168ca30c55 100644
--- a/http.c
+++ b/http.c
@@ -349,7 +349,7 @@ static int http_options(const char *var, const char *value, void *cb)
 	if (!strcmp("http.postbuffer", var)) {
 		http_post_buffer = git_config_ssize_t(var, value);
 		if (http_post_buffer < 0)
-			warning(_("negative value for http.postbuffer; defaulting to %d"), LARGE_PACKET_MAX);
+			warning(_("negative value for http.postBuffer; defaulting to %d"), LARGE_PACKET_MAX);
 		if (http_post_buffer < LARGE_PACKET_MAX)
 			http_post_buffer = LARGE_PACKET_MAX;
 		return 0;
diff --git a/remote.c b/remote.c
index 9b9bbfe80e..d50b83e7eb 100644
--- a/remote.c
+++ b/remote.c
@@ -633,7 +633,7 @@ static void validate_remote_url(struct remote *remote)
 	else if (!strcmp("allow", value))
 		return;
 	else
-		die(_("unrecognized value fetch.credentialsInURL: '%s'"), value);
+		die(_("unrecognized value fetch.credentialsInUrl: '%s'"), value);
 
 	for (i = 0; i < remote->url_nr; i++) {
 		struct url_info url_info = { 0 };
diff --git a/submodule-config.c b/submodule-config.c
index ce3beaf5d4..4a9780856c 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -302,7 +302,7 @@ int parse_submodule_fetchjobs(const char *var, const char *value)
 {
 	int fetchjobs = git_config_int(var, value);
 	if (fetchjobs < 0)
-		die(_("negative values not allowed for submodule.fetchjobs"));
+		die(_("negative values not allowed for submodule.fetchJobs"));
 	return fetchjobs;
 }
 
-- 
2.36.GIT

