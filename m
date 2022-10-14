Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F85C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiJNPkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJNPkb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:40:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798DBCC804
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j16so8174975wrh.5
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFNlsgYQ0dsoh8dgONvx5+5zKAaU+exnmxKZ1k1Ogcg=;
        b=LsE4oG4tx63agiaXg9Ky0gVQIJ5ZbjgkYpkq1GEtvMY+6VnhR/lGzygVb1WnaA6TAm
         lYZXRzicMMQaOGlzCZs1hgFuVRNnU1Lo+GG5roZMR0Tp3G2WXpcWtPcdUhPuP8Or6J2H
         0hmNx9+WnvFy3uaDTH/Ql5/lUUCjj3EJL8PImRpx0g/WOuqMRVGjj7BbK337qV74675w
         ilTBXInwNkIHQyFeQMhs4H5kVEkD2j+Gs6HhTP3vPNn7QgCymSl1UOX0hYS5pH1WRCzu
         otmROduf5HpJenX9cXJmqJDs2uW36qCO/rSeK3VgAY4dcdw3kOUyvF1zB1oFoYTQGg3G
         LhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFNlsgYQ0dsoh8dgONvx5+5zKAaU+exnmxKZ1k1Ogcg=;
        b=lViLlHdlfi7A+NWCq7nHM3cRzRLYVZVQLy37Fk5tiluGt3uvS9LVZVKD2SFOiMHM9W
         CRAS0B+Jjk3PTuE3Ra339Mo9eMnba/TQx6s8eHRyO3bqSSOtqgYx5+rkJi3FtuHwWI96
         1aFiUNHOIFiMilb+jx4PsAr+iFz4/loH4znmS2/Sy0LiJT6lUqeE5e0f8fYvjbmBrccH
         gLIG4hK6MQnzQhlJZdm3R/4v9v26nOnGkiYyfWaAYB5tk3HwsDWoCw0KpanywF80dckF
         TXjSyVo87HUuGmRjTtvf54F6/xj4JbIQgbfbbJUCcjqjRFF2kJkkhn6SZu7it8wXxqBX
         /sQQ==
X-Gm-Message-State: ACrzQf0HzY9nw0Fu1DX2i4pi2UM8nd2u+LeNwIvqimbQF6Wab+AOvsk7
        bZkMEE5wI6FV4al23JCImbV99DSlm5sc0g==
X-Google-Smtp-Source: AMsMyM6I0grl+wEQa1bjhTPcb9nTEf2u0TH3rMQa/8CoYv4E9SChNSK3b0mqRWB3vlWzFUxmhq2Kew==
X-Received: by 2002:adf:ee88:0:b0:22e:330a:f741 with SMTP id b8-20020adfee88000000b0022e330af741mr3750679wro.199.1665762028550;
        Fri, 14 Oct 2022 08:40:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm2385391wmz.34.2022.10.14.08.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:40:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/10] merge: remove always-the-same "verbose" arguments
Date:   Fri, 14 Oct 2022 17:40:14 +0200
Message-Id: <patch-02.10-543ccbb1ee1-20221014T153426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the code that builds the arguments for the "read-tree"
invocation in reset_hard() and read_empty() to remove the "verbose"
parameter.

Before 172b6428d06 (do not overwrite untracked during merge from
unborn branch, 2010-11-14) there was a "reset_hard()" function that
would be called in two places, one of those passed a "verbose=1", the
other a "verbose=0".

After 172b6428d06 when read_empty() was split off from reset_hard()
both of these functions only had one caller. The "verbose" in
read_empty() would always be false, and the one in reset_hard() would
always be true.

There was never a good reason for the code to act this way, it
happened because the read_empty() function was a copy/pasted and
adjusted version of reset_hard().

Since we're no longer conditionally adding the "-v" parameter
here (and we'd only add it for "reset_hard()" we'll be able to move to
a simpler and safer run-command API in the subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5900b81729d..3bb49d805b4 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -345,14 +345,12 @@ static int save_state(struct object_id *stash)
 	return rc;
 }
 
-static void read_empty(const struct object_id *oid, int verbose)
+static void read_empty(const struct object_id *oid)
 {
 	int i = 0;
 	const char *args[7];
 
 	args[i++] = "read-tree";
-	if (verbose)
-		args[i++] = "-v";
 	args[i++] = "-m";
 	args[i++] = "-u";
 	args[i++] = empty_tree_oid_hex();
@@ -363,14 +361,13 @@ static void read_empty(const struct object_id *oid, int verbose)
 		die(_("read-tree failed"));
 }
 
-static void reset_hard(const struct object_id *oid, int verbose)
+static void reset_hard(const struct object_id *oid)
 {
 	int i = 0;
 	const char *args[6];
 
 	args[i++] = "read-tree";
-	if (verbose)
-		args[i++] = "-v";
+	args[i++] = "-v";
 	args[i++] = "--reset";
 	args[i++] = "-u";
 	args[i++] = oid_to_hex(oid);
@@ -385,7 +382,7 @@ static void restore_state(const struct object_id *head,
 {
 	struct strvec args = STRVEC_INIT;
 
-	reset_hard(head, 1);
+	reset_hard(head);
 
 	if (is_null_oid(stash))
 		goto refresh_cache;
@@ -1470,7 +1467,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 					       check_trust_level);
 
 		remote_head_oid = &remoteheads->item->object.oid;
-		read_empty(remote_head_oid, 0);
+		read_empty(remote_head_oid);
 		update_ref("initial pull", "HEAD", remote_head_oid, NULL, 0,
 			   UPDATE_REFS_DIE_ON_ERR);
 		goto done;
-- 
2.38.0.1092.g8c0298861b0

