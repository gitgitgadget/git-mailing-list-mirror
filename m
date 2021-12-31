Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A3AC433F5
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 06:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbhLaGRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 01:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbhLaGRo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 01:17:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B6C06173E
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 22:17:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i22so54359570wrb.13
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 22:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MrjNb+i7BZP0py4zESLdJ3gwot0MY5gt7+ZEuteSCtI=;
        b=Tpts8pMjhpt9yeRQosODu6votxFNRW7m0wvHDF+rLlm0+7bSWsZCAxJgz5SxqwAmst
         0Vlrub9lh6knFDmgbs/CDBOjoeugDA4x9XDVkcJGkMJgCj1wFg2zw2qmH2d/luGetTHg
         L+Vi1ei92WRJYo0SJEEalYIvsqJ9oTAhxi1+ycDThGlN/Acag9iRsd8jkbJIQbItVExB
         0I8POjC1pMlYkpsuwrw/sjcd4K6qqW6xou0mpa3eX3SU/kZc32UZ7KSxGVS1IlMdEOw9
         +zHGJ/cDfVFNDc+Fugdo/yxoePciDM+mumVhO4m0SFIs1SrtvlqrxQyZbzt651erROp7
         Ohzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MrjNb+i7BZP0py4zESLdJ3gwot0MY5gt7+ZEuteSCtI=;
        b=ndUrZYoqIZn6GsfLxHWnowKzWoayKQhMQG5978iV+37/t5bcrRoijSmFUmpgwT+Kd4
         egq37lxDKaQrNISuchFwF2vpcfMlMg86FIjXoxiS9YzGuiqqv6S241TNJMn8AytMjnGz
         Xz2uweKV24y275djqGcyjTQ47sj7xjwLvvpDdELNR9mCKzMNidIfvU5y1WxzYAT61Ugp
         QcAjQBV0yCetNVT21MsldbsShg3kd1f/+L8kDz/0rtpidJJSIQD7RgXU4JOwEION1Grz
         00xbiUqPUoF7F3HTeW/ju8uMIGWkrhfFJcC+cfACYeZ+yk316Fx20FZEWsC9EOwVo0CB
         d8pw==
X-Gm-Message-State: AOAM532T1d+t761wc0ols9dhR2Nv1/1Djy8zK0KQgyON4DZvTk9kyMHO
        nTw55xzIXlAZAaIL8gLn6W2UnHFllzA=
X-Google-Smtp-Source: ABdhPJxtc7RgXVH1y9gzIIaNT4PYnMvL56r3V8+1xFJTnL7//bS4bDHepTCpzy4vkjvoqzTsAGusXA==
X-Received: by 2002:adf:fe0f:: with SMTP id n15mr27862253wrr.705.1640931462049;
        Thu, 30 Dec 2021 22:17:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b132sm26092080wmd.38.2021.12.30.22.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 22:17:41 -0800 (PST)
Message-Id: <pull.1125.v3.git.git.1640931460758.gitgitgadget@gmail.com>
In-Reply-To: <pull.1125.v2.git.git.1640758765723.gitgitgadget@gmail.com>
References: <pull.1125.v2.git.git.1640758765723.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 06:17:40 +0000
Subject: [PATCH v3] receive-pack.c: consolidate find header logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

There are two functions that have very similar logic of finding a header
value. find_commit_header, and find_header. We can conslidate the logic
by using find_commit_header and replacing the logic in find_header.

Introduce a new function find_header_max, which is equivalent to
find_commit_header except it takes a len parameter that determines how
many bytes to read. find_commit_header can then call find_header_max
with 0 as the len.

This cleans up duplicate logic, as the logic for finding header values
is now all in one place.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    Consolidate find_header logic into one function
    
    This addresses the NEEDSWORK comment in builtin/receive-pack.c:
    
     /**
       * NEEDSWORK: reuse find_commit_header() from jk/commit-author-parsing
       * after dropping "_commit" from its name and possibly moving it out
       * of commit.c
       **/
    
    
    There is some duplicated logic between find_header and
    find_commit_header that can be consolidated instead of having two places
    in the code that do essentially the same thing. For the sake of simpler
    and more DRY code, use find_commit_header and rename it to find_header
    since it is not limited to finding headers for only commits.
    
    Changes since v2:
    
     * s/find_header_max/find_header_mem
     * moved "len" argument right next to "msg" agument in find_header_mem
     * removed special condition in find_header_mem to check for line == 0

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1125%2Fjohn-cai%2Fjc%2Freplace-find-header-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1125/john-cai/jc/replace-find-header-v3
Pull-Request: https://github.com/git/git/pull/1125

Range-diff vs v2:

 1:  5e0d90d642b ! 1:  463df42e7e0 receive-pack.c: consolidate find header logic
     @@ builtin/receive-pack.c: static char *prepare_push_cert_nonce(const char *path, t
      -	}
      -	return NULL;
      +	size_t out_len;
     -+	const char *val = find_header_max(msg, key, len, &out_len);
     ++	const char *val = find_header_mem(msg, len, key, &out_len);
      +
      +	if (val == NULL)
      +		return NULL;
     @@ commit.c: struct commit_list **commit_list_append(struct commit *commit,
       }
       
      -const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
     -+const char *find_header_max(const char *msg, const char *key,
     -+			size_t len,
     -+			size_t *out_len)
     ++const char *find_header_mem(const char *msg, size_t len,
     ++			const char *key, size_t *out_len)
       {
       	int key_len = strlen(key);
       	const char *line = msg;
       
      -	while (line) {
     -+	while (line && (len == 0 || line < msg + len)) {
     ++	while (line && line < msg + len) {
       		const char *eol = strchrnul(line, '\n');
       
       		if (line == eol)
     @@ commit.c: const char *find_commit_header(const char *msg, const char *key, size_
       
      +const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
      +{
     -+	return find_header_max(msg, key, 0, out_len);
     ++	return find_header_mem(msg, strlen(msg), key, out_len);
      +}
       /*
        * Inspect the given string and determine the true "end" of the log message, in
     @@ commit.h: void free_commit_extra_headers(struct commit_extra_header *extra);
        * Note that some headers (like mergetag) may be multi-line. It is the caller's
        * responsibility to parse further in this case!
        */
     -+const char *find_header_max(const char *msg, const char *key,
     -+			size_t len,
     ++const char *find_header_mem(const char *msg, size_t len,
     ++			const char *key,
      +			size_t *out_len);
      +
       const char *find_commit_header(const char *msg, const char *key,


 builtin/receive-pack.c | 33 ++++++++++-----------------------
 commit.c               |  9 +++++++--
 commit.h               |  5 +++++
 3 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816cf..b661c51a538 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -581,32 +581,19 @@ static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 	return strbuf_detach(&buf, NULL);
 }
 
-/*
- * NEEDSWORK: reuse find_commit_header() from jk/commit-author-parsing
- * after dropping "_commit" from its name and possibly moving it out
- * of commit.c
- */
 static char *find_header(const char *msg, size_t len, const char *key,
 			 const char **next_line)
 {
-	int key_len = strlen(key);
-	const char *line = msg;
-
-	while (line && line < msg + len) {
-		const char *eol = strchrnul(line, '\n');
-
-		if ((msg + len <= eol) || line == eol)
-			return NULL;
-		if (line + key_len < eol &&
-		    !memcmp(line, key, key_len) && line[key_len] == ' ') {
-			int offset = key_len + 1;
-			if (next_line)
-				*next_line = *eol ? eol + 1 : eol;
-			return xmemdupz(line + offset, (eol - line) - offset);
-		}
-		line = *eol ? eol + 1 : NULL;
-	}
-	return NULL;
+	size_t out_len;
+	const char *val = find_header_mem(msg, len, key, &out_len);
+
+	if (val == NULL)
+		return NULL;
+
+	if (next_line)
+		*next_line = val + out_len + 1;
+
+	return xmemdupz(val, out_len);
 }
 
 /*
diff --git a/commit.c b/commit.c
index a348f085b2b..8ac32a4d7b5 100644
--- a/commit.c
+++ b/commit.c
@@ -1631,12 +1631,13 @@ struct commit_list **commit_list_append(struct commit *commit,
 	return &new_commit->next;
 }
 
-const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
+const char *find_header_mem(const char *msg, size_t len,
+			const char *key, size_t *out_len)
 {
 	int key_len = strlen(key);
 	const char *line = msg;
 
-	while (line) {
+	while (line && line < msg + len) {
 		const char *eol = strchrnul(line, '\n');
 
 		if (line == eol)
@@ -1653,6 +1654,10 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
 	return NULL;
 }
 
+const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
+{
+	return find_header_mem(msg, strlen(msg), key, out_len);
+}
 /*
  * Inspect the given string and determine the true "end" of the log message, in
  * order to find where to put a new Signed-off-by trailer.  Ignored are
diff --git a/commit.h b/commit.h
index 3ea32766bcb..38cc5426615 100644
--- a/commit.h
+++ b/commit.h
@@ -290,12 +290,17 @@ void free_commit_extra_headers(struct commit_extra_header *extra);
 
 /*
  * Search the commit object contents given by "msg" for the header "key".
+ * Reads up to "len" bytes of "msg".
  * Returns a pointer to the start of the header contents, or NULL. The length
  * of the header, up to the first newline, is returned via out_len.
  *
  * Note that some headers (like mergetag) may be multi-line. It is the caller's
  * responsibility to parse further in this case!
  */
+const char *find_header_mem(const char *msg, size_t len,
+			const char *key,
+			size_t *out_len);
+
 const char *find_commit_header(const char *msg, const char *key,
 			       size_t *out_len);
 

base-commit: 55b058a8bbcc54bd93c733035c995abc7967e539
-- 
gitgitgadget
