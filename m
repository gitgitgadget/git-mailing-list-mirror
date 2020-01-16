Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CAEC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA002075B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oIJmiRJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgAPVZ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:25:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36785 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbgAPVZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:25:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so20661544wru.3
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 13:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j11rS4kRL91OHZx7HyKUVk1CXHTQEKH+moyLWh0l6r4=;
        b=oIJmiRJikyuL+Q08o3AVI0CKl4Zk4gFbiyAJwWQPr1E+VBMQs87FkE+uWTDbhYw8IN
         asU53vloivSh3A/BvA8o1dURlvAY0HTfOqjgJv1NIuJATs2CnCrpW9Xci/l/OXByCQCN
         4x9RntjEUjf5YO08Oty5RjLT9VW0/NrZHGvERD9BdI5ua6YkvIVduhL2/GZGpfPrmrY0
         5loae1x4zPYiikuqQFJdvDOS5BDh3EC4unCPh6zQkvhn8O27ALlN31eYZB/URUwCilp/
         8UWKpH6NUr0SNRw/tVBDycRogsSP3vTAp/Otu3uxcQtMasSvihEs8NH+NCDYEnTq4CPb
         0XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j11rS4kRL91OHZx7HyKUVk1CXHTQEKH+moyLWh0l6r4=;
        b=KjAHz/3yGMleOxnNfdPsyPMdmsLdDR6lBtOwjnosgD1n75uQZuhwl5Ys5DOQLI2ub4
         WufUlvAtOqO2MRZc9YUjT4tZh5QtOS79Tf+yuDwbk8Q7FDa/+95+EDYO1zT2kxCfPpmB
         6AyNVDFwt7WhQCmNZdjv4ftmNcj9sARbVzIqsFTdKOvo3HHbPcKRGJNM7YztLbhoanhd
         LedOp4wvoqxCEqu3KJRNxaNFdoiD6tyofBtrNWnMxFIDxm6q6N1oa4VaI8RHY+dQTmF3
         Decjtrc24KfC+RTHgw8LjDhOqnEXBm2xf4tuIGsrEDSF2ol0mU0lK1WSxtE6G0hOu4gr
         wFaA==
X-Gm-Message-State: APjAAAXBm/rhspILy6Oker7d4IEG0tfcstbxtsnmTu6wgRLLHwh1XYgB
        6gY1vK9VqqPxBP65Rfk=
X-Google-Smtp-Source: APXvYqyIdZIOtFVb+xuq6UMlXW5o7e9GnJBN9nsAFADUzr8A7eDAsdj8aBWGOErbCEVwNpGYL0T8Sw==
X-Received: by 2002:adf:8150:: with SMTP id 74mr5550050wrm.114.1579209927268;
        Thu, 16 Jan 2020 13:25:27 -0800 (PST)
Received: from localhost ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id e18sm31351124wrr.95.2020.01.16.13.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 13:25:26 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] remote: rename also remotes in the branch.<name>.pushRemote config
Date:   Thu, 16 Jan 2020 22:25:26 +0100
Message-Id: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c  | 16 ++++++++++++++--
 t/t5505-remote.sh |  4 +++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 96bbe828fe..ddceba868a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -246,7 +246,7 @@ static int add(int argc, const char **argv)
 }
 
 struct branch_info {
-	char *remote_name;
+	char *remote_name, *push_remote_name;
 	struct string_list merge;
 	enum {
 		NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
@@ -269,13 +269,16 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		char *name;
 		struct string_list_item *item;
 		struct branch_info *info;
-		enum { REMOTE, MERGE, REBASE } type;
+		enum { REMOTE, PUSH_REMOTE, MERGE, REBASE } type;
 		size_t key_len;
 
 		key += 7;
 		if (strip_suffix(key, ".remote", &key_len)) {
 			name = xmemdupz(key, key_len);
 			type = REMOTE;
+		} else if (strip_suffix(key, ".pushremote", &key_len)) {
+			name = xmemdupz(key, key_len);
+			type = PUSH_REMOTE;
 		} else if (strip_suffix(key, ".merge", &key_len)) {
 			name = xmemdupz(key, key_len);
 			type = MERGE;
@@ -294,6 +297,10 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			if (info->remote_name)
 				warning(_("more than one %s"), orig_key);
 			info->remote_name = xstrdup(value);
+		} else if (type == PUSH_REMOTE) {
+			if (info->push_remote_name)
+				warning(_("more than one %s"), orig_key);
+			info->push_remote_name = xstrdup(value);
 		} else if (type == MERGE) {
 			char *space = strchr(value, ' ');
 			value = abbrev_branch(value);
@@ -680,6 +687,11 @@ static int mv(int argc, const char **argv)
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
 			git_config_set(buf.buf, rename.new_name);
 		}
+		if (info->push_remote_name && !strcmp(info->push_remote_name, rename.old_name)) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "branch.%s.pushremote", item->string);
+			git_config_set(buf.buf, rename.new_name);
+		}
 	}
 
 	if (!refspec_updated)
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 883b32efa0..59a1681636 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -737,12 +737,14 @@ test_expect_success 'rename a remote' '
 	git clone one four &&
 	(
 		cd four &&
+		git config branch.master.pushRemote origin &&
 		git remote rename origin upstream &&
 		test -z "$(git for-each-ref refs/remotes/origin)" &&
 		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" = "refs/remotes/upstream/master" &&
 		test "$(git rev-parse upstream/master)" = "$(git rev-parse master)" &&
 		test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*" &&
-		test "$(git config branch.master.remote)" = "upstream"
+		test "$(git config branch.master.remote)" = "upstream" &&
+		test "$(git config branch.master.pushRemote)" = "upstream"
 	)
 '
 
-- 
2.24.1.497.g9abd7b20b4.dirty

