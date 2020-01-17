Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A5FC33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 09:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC152082F
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 09:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="vCfWss3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAQJdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:33:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45501 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAQJdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 04:33:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so21927623wrj.12
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 01:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Uu5LHdnC/Fa3Co9FVpVF4UVXiNZ4RuYJ38eZnoE1ZA=;
        b=vCfWss3wOpQ7vD4d8qyOw62s3yCq7c4B6qrqqLCD2tvMYiW3pgpraFmPQk+BLhYZ3U
         6cByehCcJMrwY0kQumxgWns3dB4Ga+3tIM3QF7oUjq7VJdAsA4/rntCovp8t5hUWwdIm
         Cq5Siv485M5fHIcV/PzQvIuKIgOSBCilNhZRX1q2R+Mcpicvka9CjRA7L4haXxuJXGIY
         JGlKlqB3OSLSK/p/eD3Rg5PmW9Bg9DhhRaUXCdoGTNF3qul7TjqsgYqCjAR2L9qNqDW6
         fowexqQy8vtdGRgPdI0QW+DMQ3+047P509ipQm6Rvy/GbP6eJ60wjAFh1cP84lc5y9h8
         rQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Uu5LHdnC/Fa3Co9FVpVF4UVXiNZ4RuYJ38eZnoE1ZA=;
        b=nJAugN5LhtVfFXmboeTxa1GJzNcbq77TleG5r+w09vAkKV8Ym158wvXa4xRUr8ovMe
         bw9XaMEYrrgQ3t9cLSVkqEd0UN3qPYuHDPBqPBr2WFX38XZoN+eTZkoydY/ZH9DHXcFi
         lw6OBXGb5NPw3XXRPzJLshlI/o2wMWnUgON40pb2UP+ruhESoINENEOE09I5EauzEtyQ
         64oXjLXWVUuayyveavHi3MZPMOkaJD2drF/rDzuIllXGfnd5bkYF60KafFuJi+BNxDrv
         MNKQ7yEeIwr7ssFp/1pT87rxKSQgMzjc5twMyRiP+xR0sA8oeQMr1OHGYvc3S6SWxy2F
         8x0Q==
X-Gm-Message-State: APjAAAU9Tv+7h47j5rG+Hm9v+4bw4cQed6oOZ2GEIfNfYIurzVIHru7g
        uphSvf35Yr8GmCeup4A=
X-Google-Smtp-Source: APXvYqz9TgPV31Kqi6d3RFN4Lck+98jJjmY5j6EwAUF+mAIsRCP5brt/3FVzzBSDTKgOMfg8FSooSg==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr2060362wrn.155.1579253588372;
        Fri, 17 Jan 2020 01:33:08 -0800 (PST)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id f12sm2053935wmf.28.2020.01.17.01.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Jan 2020 01:33:07 -0800 (PST)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] remote rename: rename branch.<name>.pushRemote config values too
Date:   Fri, 17 Jan 2020 10:33:07 +0100
Message-Id: <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.24.1.497.g9abd7b20b4.dirty
In-Reply-To: <xmqq7e1rf0zg.fsf@gitster-ct.c.googlers.com>
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
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
 builtin/remote.c  | 17 +++++++++++++++--
 t/t5505-remote.sh |  4 +++-
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 96bbe828fe..a74aac344f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -251,6 +251,7 @@ struct branch_info {
 	enum {
 		NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE, REBASE_MERGES
 	} rebase;
+	char *push_remote_name;
 };
 
 static struct string_list branch_list = STRING_LIST_INIT_NODUP;
@@ -269,7 +270,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		char *name;
 		struct string_list_item *item;
 		struct branch_info *info;
-		enum { REMOTE, MERGE, REBASE } type;
+		enum { REMOTE, MERGE, REBASE, PUSH_REMOTE } type;
 		size_t key_len;
 
 		key += 7;
@@ -282,6 +283,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		} else if (strip_suffix(key, ".rebase", &key_len)) {
 			name = xmemdupz(key, key_len);
 			type = REBASE;
+		} else if (strip_suffix(key, ".pushremote", &key_len)) {
+			name = xmemdupz(key, key_len);
+			type = PUSH_REMOTE;
 		} else
 			return 0;
 
@@ -305,7 +309,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				space = strchr(value, ' ');
 			}
 			string_list_append(&info->merge, xstrdup(value));
-		} else {
+		} else if (type == REBASE) {
 			int v = git_parse_maybe_bool(value);
 			if (v >= 0)
 				info->rebase = v;
@@ -315,6 +319,10 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 				info->rebase = REBASE_MERGES;
 			else if (!strcmp(value, "interactive"))
 				info->rebase = INTERACTIVE_REBASE;
+		} else {
+			if (info->push_remote_name)
+				warning(_("more than one %s"), orig_key);
+			info->push_remote_name = xstrdup(value);
 		}
 	}
 	return 0;
@@ -680,6 +688,11 @@ static int mv(int argc, const char **argv)
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

