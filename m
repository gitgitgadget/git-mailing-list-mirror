Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD7BA1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeHMS6i (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41647 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbeHMS6i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so13024715ljy.8
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BfSuj4rSOFwDodZklLkc23NeXpDXQu+PQpdWkHWQpo=;
        b=eN1xzZ6dH2YE5T6P5W/FDtYpQoTnEkbLTg3YfQITv3+xpchOXh0Xa4AeIylHBzhF41
         0QPnBnPUi0sqU5hCR5HeD/hKuRyBGkzM0IKDIH/Mc456iX/szkg/R6qSQmqldWajOMDM
         U41p7RT8ZmXs+mfYA5yDKaKsbXFmFsrf2q2EPQPWsLsGhvVwrTNuAyxYahlhuSkAZxAN
         TmeL77vH4/UCdCFtAZIuj9ZOpy0xVRpEirU9mB1l82Ui9B0lXM/2O30HkhCAJugWohDj
         k2KEKTX3r0AsgNBPgnlo+X+QXsC49tw2R+zOiU28vuH7ERbFGrHhfZmSGGjG7XgmrDt+
         alEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BfSuj4rSOFwDodZklLkc23NeXpDXQu+PQpdWkHWQpo=;
        b=JtEoC+y0VQ9TUgTgN76UslH1T8p9/QmuzUJwuYSuEmy/A/hqFiJSVMkcptzfbZZdFI
         UOEV9qbDOCL4ttDkuLPSY1qjFtcMdzTs19bhqCwbVjj/mMhBruAsqJNlnsUGRCYC5KW5
         Vbw19kE6kOXtOtSF9U43bkR9w/1xiq4SNyD3dPXHtP1XkkFZSvIy+3YVnISvNb/i0ThG
         bUjeh1v66Y7Xd9nsATMjlKiMIOLbHa5kyieHzrQFzz7b+gGnf7Ds3gvd0mkCmw+fSOZx
         r8cGW8T3iuW8ark4k1IOar38L6hVxs2LfU5eVcHBq1tM7ZO5aW3rNi9ibNId+LHDwqAs
         cCkA==
X-Gm-Message-State: AOUpUlGVTqDKDDVDRi4w+e7AHqeo2eWynodKQfEzjyQqawut3ugEa8e5
        gBCg31cckYNg6uKueIrvTFd0YU+w
X-Google-Smtp-Source: AA+uWPzUoEc8sayrnLkbsRKUPsvpWzLuoKgrG3eOfUrWxpLzS7hmW1Oq+PaxN7E/iIYIUBHglspS3Q==
X-Received: by 2002:a2e:990b:: with SMTP id v11-v6mr12216992lji.87.1534176943355;
        Mon, 13 Aug 2018 09:15:43 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:42 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/24] apply.c: pass struct apply_state to more functions
Date:   Mon, 13 Aug 2018 18:14:38 +0200
Message-Id: <20180813161441.16824-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

we're going to remove the dependency on the_index by moving 'struct
index_state *' to somewhere inside struct apply_state. Let's make sure
relevant functions have access to this struct now and reduce the diff
noise when the actual conversion happens.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index 2476f06ebd..572cd639a6 100644
--- a/apply.c
+++ b/apply.c
@@ -3374,7 +3374,9 @@ static struct patch *previous_patch(struct apply_state *state,
 	return previous;
 }
 
-static int verify_index_match(const struct cache_entry *ce, struct stat *st)
+static int verify_index_match(struct apply_state *state,
+			      const struct cache_entry *ce,
+			      struct stat *st)
 {
 	if (S_ISGITLINK(ce->ce_mode)) {
 		if (!S_ISDIR(st->st_mode))
@@ -3524,7 +3526,7 @@ static int load_current(struct apply_state *state,
 		if (checkout_target(&the_index, ce, &st))
 			return -1;
 	}
-	if (verify_index_match(ce, &st))
+	if (verify_index_match(state, ce, &st))
 		return error(_("%s: does not match index"), name);
 
 	status = load_patch_target(state, &buf, ce, &st, patch, name, mode);
@@ -3694,7 +3696,7 @@ static int check_preimage(struct apply_state *state,
 			if (checkout_target(&the_index, *ce, st))
 				return -1;
 		}
-		if (!state->cached && verify_index_match(*ce, st))
+		if (!state->cached && verify_index_match(state, *ce, st))
 			return error(_("%s: does not match index"), old_name);
 		if (state->cached)
 			st_mode = (*ce)->ce_mode;
@@ -4313,7 +4315,9 @@ static int add_index_file(struct apply_state *state,
  *   0 if everything went well
  *   1 if a recoverable error happened
  */
-static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
+static int try_create_file(struct apply_state *state, const char *path,
+			   unsigned int mode, const char *buf,
+			   unsigned long size)
 {
 	int fd, res;
 	struct strbuf nbuf = STRBUF_INIT;
@@ -4371,7 +4375,7 @@ static int create_one_file(struct apply_state *state,
 	if (state->cached)
 		return 0;
 
-	res = try_create_file(path, mode, buf, size);
+	res = try_create_file(state, path, mode, buf, size);
 	if (res < 0)
 		return -1;
 	if (!res)
@@ -4380,7 +4384,7 @@ static int create_one_file(struct apply_state *state,
 	if (errno == ENOENT) {
 		if (safe_create_leading_directories(path))
 			return 0;
-		res = try_create_file(path, mode, buf, size);
+		res = try_create_file(state, path, mode, buf, size);
 		if (res < 0)
 			return -1;
 		if (!res)
@@ -4402,7 +4406,7 @@ static int create_one_file(struct apply_state *state,
 		for (;;) {
 			char newpath[PATH_MAX];
 			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
-			res = try_create_file(newpath, mode, buf, size);
+			res = try_create_file(state, newpath, mode, buf, size);
 			if (res < 0)
 				return -1;
 			if (!res) {
-- 
2.18.0.1004.g6639190530

