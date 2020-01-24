Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBE5C2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211DD208C4
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 09:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JbS2Ta5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgAXJZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:25:39 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38245 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbgAXJZf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 04:25:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so1106416wrh.5
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 01:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6TDBqYHH2nVMXOOZqKEGbpyRYQDDl87BGG8RFhwR7I=;
        b=JbS2Ta5h8o1Ieje71CfkWnN0ULUgLi8/DNz/k+EwiZwRMeKFNKfr6biYpLsjCZd11u
         vcRiQRy9ExU/7BeMiHkvAXt3rQ3+7eBwSfAccTmP+ZnAY3ahmYo/Jo0f8VQasxGZRJ/Q
         YZhUBEIuqOV2KgT68tteHKUdlGbejKplpM6evcFePV7qGSX464lo72h2Z5PQ/SAmFefQ
         Oi9NmpiYXZwt6zy4Q6ohn/EAXHV7Or2QgcQDre4ewvZYD1Q6pr9BqxB1cpFtZCKYQrru
         dqR2o2qQDtYnOtu1WqvEqOaPwu3Q6JElilwRVuz0lJcuEuMA2QmxXvMNlMRtOVVyxs6r
         RKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6TDBqYHH2nVMXOOZqKEGbpyRYQDDl87BGG8RFhwR7I=;
        b=fxl0ZjVQSsKpMq9iDDWz96kucHr/3GDLX/GFjw6iy6+3ziEIhIFjYoxSPyHi9iuY3G
         5ktbaYbmf6Plcp5NMDsQ9ad8HqJU7qb/MpBJx0tg5fC+f0y+bnaGFX5EUWCyASEuvJa/
         lW1NvB0jGO0VneEHXCe1lW9bc8pPIFGl09AHF7fdE5Ay5oz9GU9pMdwtT0ZjG0r2P/Ej
         oYPapADWbkYzuOpZVlEOJA/9rWLaOe+aN8o1yzMghDIUyIi7oBrPCF4bK5s9P3C57mf5
         GX3VIiuMcmQh6F6HRg2JGPRoVpHv4TLTcJcjHuJHl/qWD+GbjtOGpaNvFJJIt1Q5DnZm
         9Bww==
X-Gm-Message-State: APjAAAVPh38a7EwqDnbEUoWBtBAPhMarjGYEUfD+7N3UvBHM78ppTfhq
        iuYKg4vNC+rbQ54iNWM=
X-Google-Smtp-Source: APXvYqzr2RM4IpOQDQrHczTC/TEzZrESjBHrNFfSH9CK4davOH7JVVJB+RRkX0OkjeJ/aZYELvl4yg==
X-Received: by 2002:adf:fe50:: with SMTP id m16mr3320459wrs.217.1579857933306;
        Fri, 24 Jan 2020 01:25:33 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id n187sm6200792wme.28.2020.01.24.01.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jan 2020 01:25:32 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 4/7] remote rename/remove: handle branch.<name>.pushRemote config values
Date:   Fri, 24 Jan 2020 10:25:24 +0100
Message-Id: <9c2110eda64ab7bf0cb780dafe1f13b28fee5ca0.1579857394.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579857394.git.bert.wesarg@googlemail.com>
References: <cover.1579857394.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When renaming or removing a remote with

    git remote rename X Y
    git remote remove X

Git already renames/removes any config values from

    branch.<name>.remote = X

to

    branch.<name>.remote = Y

As branch.<name>.pushRemote also names a remote, it now also renames
or removes these config values from

    branch.<name>.pushRemote = X

to

    branch.<name>.pushRemote = Y

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

Changes since v3:

 * handle also 'git remote remove'

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c  | 22 +++++++++++++++++++++-
 t/t5505-remote.sh | 16 +++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 9ee44c9f6c..a2379a14bf 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -250,6 +250,7 @@ struct branch_info {
 	char *remote_name;
 	struct string_list merge;
 	enum rebase_type rebase;
+	char *push_remote_name;
 };
 
 static struct string_list branch_list = STRING_LIST_INIT_NODUP;
@@ -267,7 +268,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 	char *name;
 	struct string_list_item *item;
 	struct branch_info *info;
-	enum { REMOTE, MERGE, REBASE } type;
+	enum { REMOTE, MERGE, REBASE, PUSH_REMOTE } type;
 	size_t key_len;
 
 	if (!starts_with(key, "branch."))
@@ -280,6 +281,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		type = MERGE;
 	else if (strip_suffix(key, ".rebase", &key_len))
 		type = REBASE;
+	else if (strip_suffix(key, ".pushremote", &key_len))
+		type = PUSH_REMOTE;
 	else
 		return 0;
 	name = xmemdupz(key, key_len);
@@ -315,6 +318,11 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		 */
 		info->rebase = rebase_parse_value(value);
 		break;
+	case PUSH_REMOTE:
+		if (info->push_remote_name)
+			warning(_("more than one %s"), orig_key);
+		info->push_remote_name = xstrdup(value);
+		break;
 	default:
 		BUG("unexpected type=%d", type);
 	}
@@ -682,6 +690,11 @@ static int mv(int argc, const char **argv)
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
@@ -783,6 +796,13 @@ static int rm(int argc, const char **argv)
 					die(_("could not unset '%s'"), buf.buf);
 			}
 		}
+		if (info->push_remote_name && !strcmp(info->push_remote_name, remote->name)) {
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "branch.%s.pushremote", item->string);
+			result = git_config_set_gently(buf.buf, NULL);
+			if (result && result != CONFIG_NOTHING_SET)
+				die(_("could not unset '%s'"), buf.buf);
+		}
 	}
 
 	/*
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 883b32efa0..082042b05a 100755
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
 
@@ -784,6 +786,18 @@ test_expect_success 'rename succeeds with existing remote.<target>.prune' '
 	git -C four.four remote rename origin upstream
 '
 
+test_expect_success 'remove a remote' '
+	git clone one four.five &&
+	(
+		cd four.five &&
+		git config branch.master.pushRemote origin &&
+		git remote remove origin &&
+		test -z "$(git for-each-ref refs/remotes/origin)" &&
+		test_must_fail git config branch.master.remote &&
+		test_must_fail git config branch.master.pushRemote
+	)
+'
+
 cat >remotes_origin <<EOF
 URL: $(pwd)/one
 Push: refs/heads/master:refs/heads/upstream
-- 
2.24.1.497.g9abd7b20b4.dirty

