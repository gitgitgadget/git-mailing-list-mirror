Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363AFC33CB6
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F3122522
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 09:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="sqvIVZa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAUJZE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:25:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34219 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgAUJZD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 04:25:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so2342520wrr.1
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 01:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BS2MK4xzeLkqY0KJB65rz40drEUjXklaG0yoCJQUT2I=;
        b=sqvIVZa4YW91mhQaRkSWA6ZEWY93M9ISu8so5tMkR3zrICbHQSiiTSItLqwugWIKgp
         rCg7CxJl8q5+RcOITlxLjP2Gdqu0OJ+/Qrj6jFPq6JGUuxWZzCh05Kq8Pwqm9hfKO120
         8QLr2NFqlBkKvofsbLkATqNxmRzHDBSosjIP7ZpViCRCVCgaVcelZTFBWVEjNaQEEKzz
         vMX5gRkzwuElntDxvwIknnRWuv3o+FKmXHR9z7xB2Jmi5TTyELxTLrwyvtQxRZ5juZIW
         2yNhXyBOx8bDvW+qBoek5JBExRqlNKgUBkUkhycPK94X10WE2xb6bRUO8QUq4gthKWWH
         4Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BS2MK4xzeLkqY0KJB65rz40drEUjXklaG0yoCJQUT2I=;
        b=Hy/rGs9CiOsxerlrYKY2PLfUlPREQGloldOE11IugkCgQifdzi/uPGhh5K0bb0UIgL
         YwJi1UPjimzA/SS8xoxZB6zNLmloOp0mONSTQoVVUTWu6J1QpCA4rpAYx1IZMaX3BICd
         fwh9IVHuKIO7Q4RA6X31Tlvmrb8mYuMzu9K0sYJPCenXHyn28hzxEtvlfRf+MZdfgngh
         IstZoPFONyWcgnEYUFU28I32Qc4Z2wA9mnd+Wx6+/pD14Do/OrTxhngaFrX15gow1lbM
         CcmCiB2N3z5+lm1JuWEOpzOFSN+DkAeQbj9iUsDpzfAXfR8CBoFlkIhKoST5ILkK2uQf
         v86Q==
X-Gm-Message-State: APjAAAWRN0L4ZZtgF/M8u5Gc09OQMJawoTLYuatCkfwqDbPH5q12LZNr
        i/MOiFKsY6d9PKSKoPM=
X-Google-Smtp-Source: APXvYqxIHp21nkWPQwzjrtiz9N/JQBLwNiSm4uiBvxrB6WenG68k4gUXNJsjYsEbHi4jMZlDJ9lmAQ==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr4237578wrw.255.1579598700577;
        Tue, 21 Jan 2020 01:25:00 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id x10sm50831757wrp.58.2020.01.21.01.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jan 2020 01:25:00 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 4/7] remote rename: rename branch.<name>.pushRemote config values too
Date:   Tue, 21 Jan 2020 10:24:52 +0100
Message-Id: <686540e5cd8fa50f841af12425421bac4922ae5f.1579598053.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <cover.1579598053.git.bert.wesarg@googlemail.com>
References: <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When renaming a remote with

    git remote rename X Y

Git already renames any config values from

    branch.<name>.remote = X

to

    branch.<name>.remote = Y

As branch.<name>.pushRemote also names a remote, it now also renames
these config values from

    branch.<name>.pushRemote = X

to

    branch.<name>.pushRemote = Y

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c  | 15 ++++++++++++++-
 t/t5505-remote.sh |  4 +++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 9466e32b3d..0cb930fe00 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -250,6 +250,7 @@ struct branch_info {
 	char *remote_name;
 	struct string_list merge;
 	enum rebase_type rebase;
+	char *push_remote_name;
 };
 
 static struct string_list branch_list = STRING_LIST_INIT_NODUP;
@@ -270,7 +271,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 	char *name;
 	struct string_list_item *item;
 	struct branch_info *info;
-	enum { REMOTE, MERGE, REBASE } type;
+	enum { REMOTE, MERGE, REBASE, PUSH_REMOTE } type;
 	size_t key_len;
 
 	key += strlen("branch.");
@@ -280,6 +281,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		type = MERGE;
 	else if (strip_suffix(key, ".rebase", &key_len))
 		type = REBASE;
+	if (strip_suffix(key, ".pushremote", &key_len))
+		type = PUSH_REMOTE;
 	else
 		return 0;
 	name = xmemdupz(key, key_len);
@@ -311,6 +314,11 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 	case REBASE:
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
@@ -678,6 +686,11 @@ static int mv(int argc, const char **argv)
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

