Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB1BC35247
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05F720842
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iqtDuGrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgA0HEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:04:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54239 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgA0HEk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 02:04:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10so2062800wmh.3
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 23:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6TDBqYHH2nVMXOOZqKEGbpyRYQDDl87BGG8RFhwR7I=;
        b=iqtDuGrTXVG0I3bTl/jJJ9O9r8Pz5AA81VqclUGlzJTNzi9kwoDYiHOqjeQoac/Uyn
         nS+/d0IydkHAHXH7JGd+1RjNSvozTQ+yzDJYoS/Sw5Y4fA4as4fY3T2ohpv1NEkquhh2
         eh9vC4VI7CgsPPBRt59b0Z14BHPf5YX6qVfkA50mFzYMBoDw+Bhwtppf0Kc9iTkH8Vse
         p2TxL3Wo1WzsPNQyrwtKsucITxWv4kk4ZGtetrpEJBRgCAKw2dcNkzp+OOC9PK1MOjYS
         u3b081AFKrsE9v/MLVn1rrIXVXB7XiGLEmm2HsDarkZnO3F5MhDZ7QhpS5nqhXDOWNsj
         jRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6TDBqYHH2nVMXOOZqKEGbpyRYQDDl87BGG8RFhwR7I=;
        b=YJkSu6+Lsctd+pQoqrJrRUQqBS4UlpsU4lVYOL1Lqdp97q80p8/Nc0Qdkh9GeXF4qY
         MO8NXK3f1AdrqtkE321aq+o1QBWoMua0rR2fR025TXl970TGs1XTPG+7rJhdfNbrdJM5
         HeHHEpoMgdgm7ncZJe4Qr95iA+RA0CmEhcMxkBoaIe2y6Pg3zPYO24Blr9sN/uE7+rVP
         dyC+CgsFLYDO1mwpq1eDHYNDMV6FCh51S0cICvWuVZaDkJ3tXAlSJykDxzcQFfZR7hVA
         8ftCABYMkY5aPhnSjmo+r2KcaXIlON8RdDJTx4G0Zi/n97rdzLMftDhTg9CRBZatSxaP
         4Y+A==
X-Gm-Message-State: APjAAAUOH98M73eMue4ao2czqUJh19v4qhcRYbOz1diro6Er7Hiy9GkR
        l5bxo8zaeCCNq0xBwWU=
X-Google-Smtp-Source: APXvYqz54kjjnxJ324M8BIYESxddTQSvEH32VBJO4k0lmq9ivS6iv3Zzl3T5mJueiC+5gZiVPhmMZA==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr12558310wmi.31.1580108678305;
        Sun, 26 Jan 2020 23:04:38 -0800 (PST)
Received: from localhost ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id e12sm19587249wrn.56.2020.01.26.23.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 23:04:37 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 4/6] remote rename/remove: handle branch.<name>.pushRemote config values
Date:   Mon, 27 Jan 2020 08:04:30 +0100
Message-Id: <9e1883c14e8ada27394d83b164d9dab5d8a9c61f.1580108477.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1580108477.git.bert.wesarg@googlemail.com>
References: <cover.1580108477.git.bert.wesarg@googlemail.com>
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

