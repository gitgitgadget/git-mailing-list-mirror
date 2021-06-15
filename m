Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF71AC48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC236162F
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFOQVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhFOQVL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:21:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC86C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:19:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v9so2700286wrx.6
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qxCvKPwWS2aQofvI4ShA4mZyh/7/hisn2HMNxgYeTVs=;
        b=r0oc4B6RWxNDQqYpF+NGhazMIcvRXKa0M9623f53q3YQ9RC17pjFuPakydWBWE1DTN
         k7MyGNRUAqf6tRdp+4rPVsaG0SpuuFBKckZUDhSFMbwpEB19hetESZP+az18Lof4KuIv
         2yXyoggJATRVFCWBKuIp9stnAt8JG7gt3D6WddHAUpVOrmmOMLwtb8eL/f1fLeGpU3O0
         gaHekudvYJrXMF4hclobueVlBCfvcui7eKvza9BuzLDKW7INgj+xALfON+7DRBQtuWC/
         MxPz9wRJDmGIUHpThCtMnQv3jjsPTkfiaAMJ2WmWq96K1tulRzA53B/cJjvvViev7h7+
         Wjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxCvKPwWS2aQofvI4ShA4mZyh/7/hisn2HMNxgYeTVs=;
        b=D9APIxwvuPD8AmTkeTjVlNURLRnGAENp9jUGLcm67Lln++4GTFFSClPFZ0jQbJ6sym
         o4yr/I8+Ji/k6f1ZIjI97pv/DNB1gc5QwNuJbvhMNIQR76bY4pvKrDdOf+G5uUFZCnKx
         wmnbvB2hdbBK3ltznYPSk13PTnSwQoccNFZ54xsisA4oc2SqPZGTjphURr8qKZWeZjfr
         nzHLMW0HTq9c89GGeAY1+HDe4a14ZIvlmU+Co7ilFwjDSjxirQto69MlBUopM8V0B3bS
         yekscYmJ2G0zIGPkYK2WiZ2+977T8vkM5YF5Bd0go6oCbjL7w+inKFghfOcjfv9TKwON
         LE3w==
X-Gm-Message-State: AOAM532rvf9Di1gh9JVxinI18ldWxEApwX4s5jdftbiOZyvKGCIxnTAp
        S0o0BhUl1JlgLlM/FE7my0/clH57/RD34Q==
X-Google-Smtp-Source: ABdhPJzENxHIJ522Btx9OQ5NvbY8g8L6KqQuVLLlpaKiUDWuudUAYM/xify5/stW5Tmn+HfkaJ0Smg==
X-Received: by 2002:a5d:47a6:: with SMTP id 6mr26103745wrb.203.1623773945526;
        Tue, 15 Jun 2021 09:19:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b8sm2671901wmd.35.2021.06.15.09.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:18:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] daemon doc + code comments: reword "alice" example
Date:   Tue, 15 Jun 2021 18:18:00 +0200
Message-Id: <patch-3.6-30cffc12410-20210615T161330Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210615T161330Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve on the "alice" example added in 603968d22b1 (daemon: extend
user-relative path notation., 2006-02-04). I found the previous
version of this documentation a bit confusing, and had to read the
code to see what it was doing.

I think explicitly spelling out that the --user-path option can be
user to provide an infix to stash in-between what we'll resolve
"~user" and the path after that is clearer, especially when coupled
with explicit examples of path resolution.

Finally, the previous documentation didn't mention that `path/foo`
could actually resolve to `path/foo.git`. That's implicitly covered
earlier in the documentation, let's make an explicit reference to that
here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-daemon.txt | 13 ++++++++-----
 daemon.c                     | 10 +++++-----
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index fdc28c041c7..a109189756d 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -139,11 +139,14 @@ otherwise `stderr`.
 --user-path=<path>::
 	Allow {tilde}user notation to be used in requests.  When
 	specified with no parameter, requests to
-	git://host/{tilde}alice/foo is taken as a request to access
-	'foo' repository in the home directory of user `alice`.
-	If `--user-path=path` is specified, the same request is
-	taken as a request to access `path/foo` repository in
-	the home directory of user `alice`.
+	git://host/{tilde}user/foo is taken as a request to access
+	'foo' repository in the home directory of user `user`.
++
+If `--user-path=infix` is specified, the `infix` is appended to the path
+found with the {tilde}user notation. E.g. a request to access a `some/foo`
+repository (git://host/{tilde}user/some/foo) will resolve to (assuming that
+`$HOME` is `/home`) either `/home/user/infix/some/foo` (or `[...]/foo.git`
+etc., see `--strict-paths` above).
 
 --verbose::
 	Log details about the incoming connections and requested files.
diff --git a/daemon.c b/daemon.c
index 5c4cbad62d0..a939e5ee0e0 100644
--- a/daemon.c
+++ b/daemon.c
@@ -46,8 +46,8 @@ static const char *interpolated_path;
 static int base_path_relaxed;
 
 /* If defined, ~user notation is allowed and the string is inserted
- * after ~user/.  E.g. a request to git://host/~alice/frotz would
- * go to /home/alice/pub_git/frotz with --user-path=pub_git.
+ * after ~user/.  E.g. a request to git://host/~user/frotz would
+ * go to /home/user/pub_git/frotz with --user-path=pub_git.
  */
 static const char *user_path;
 
@@ -188,9 +188,9 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 			return NULL;
 		}
 		if (*user_path) {
-			/* Got either "~alice" or "~alice/foo";
-			 * rewrite them to "~alice/%s" or
-			 * "~alice/%s/foo".
+			/* Got either "~user" or "~user/foo";
+			 * rewrite them to "~user/%s" or
+			 * "~user/%s/foo".
 			 */
 			int namlen, restlen = strlen(dir);
 			const char *slash = strchr(dir, '/');
-- 
2.32.0.555.g0268d380f7b

