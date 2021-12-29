Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB189C433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 06:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhL2GTa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 01:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbhL2GT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 01:19:29 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8706C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 22:19:28 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so6781303wmb.1
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 22:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JAnrdiCCV7Yc0FGWBhr31FTw7pGBYTQXrQ1b/pkSFX0=;
        b=blHHbSziyYkt6nQPGHfQ7cspk92y8Yj1iXqMIxSQIWLYRWW1uLKR7KVqiXb9DFnpiC
         n6Mecu6eIminLZpjBUU6Uaim9WYgqVZ9S/0KHo0rSmtlpzComMWMcCbumb8bwLhxDdPP
         OAIDVrGxJhGF3zcl9AzcdGzBPGE1w4YH3OHzjqhhVVzBwS9CON6Ww5UBTYgAEgzqePDj
         AxV4xlc1Ruh1FeL8h8MtcTp57c23xhYl8XCIMdXNheS1etrVez/Abe63ca0JRppVtSfl
         O/i6mM0gjKcBFj5USTs09y8NzXqAkiIgIdf2UnzXB1eKw6IsjSHGZN5eS7akXr9cSYNf
         e+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JAnrdiCCV7Yc0FGWBhr31FTw7pGBYTQXrQ1b/pkSFX0=;
        b=7ZdhCAg5FgnEN4CUnLtBdjBlJhsaGfw6Clo14RIZ2r9ceV6z6VZZHA9Z1G3QSeQdB8
         yy8JHAK2vdtc8vFDbslRArcjs9IWn2clE9msYJsUci3kgfybSU6tTkhPHyJ7OzOMYX2L
         IxzQYyogvJmDe0IFFqDzoNy0imBa3WuNVQLbjvw3gDl4Tj52RFnq8cpIyEAc8yznlRTF
         OUg/i6O2SNp8NkxPtQ8Rx0I8exgclUr9/ndgMOMnczTffubBsXAJPbn15tZpftU1IE7g
         OdgsT+NnGDdoHJLP1GXDPRAvfC1/yHN4tpjiVcGBRJCtZElwFDQKBtQfbuWRWJFRbR20
         0EUQ==
X-Gm-Message-State: AOAM532RFh0TbN5Vojg5tj0d896UbwEYZlzc1T7dBct3ipDpyujwuPOO
        cuA8R9UvTVoVcHD4OwCS8N+TFKnO/V4=
X-Google-Smtp-Source: ABdhPJzzBRFJxXkLuRWMuG4GpESjKmpKkIV2y/poXRb4XyeKo+Jv6RyZZxWtPLHrLHLRRzWmSEVNmA==
X-Received: by 2002:a05:600c:35d3:: with SMTP id r19mr20387683wmq.29.1640758767115;
        Tue, 28 Dec 2021 22:19:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm19448094wru.87.2021.12.28.22.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 22:19:26 -0800 (PST)
Message-Id: <pull.1125.v2.git.git.1640758765723.gitgitgadget@gmail.com>
In-Reply-To: <pull.1125.git.git.1640629598.gitgitgadget@gmail.com>
References: <pull.1125.git.git.1640629598.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 06:19:25 +0000
Subject: [PATCH v2] receive-pack.c: consolidate find header logic
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
    
    Changes since v1:
    
     * got rid of renaming from find_commit_header -> find_header since the
       renaming did not provide much value
     * simplified logic in find_header
     * introduce find_header_max function, which is what find_commit_header
       was before except it adds a "len" parameter to determine how much of
       the buffer to read.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1125%2Fjohn-cai%2Fjc%2Freplace-find-header-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1125/john-cai/jc/replace-find-header-v2
Pull-Request: https://github.com/git/git/pull/1125

Range-diff vs v1:

 1:  9465c20d4bd ! 1:  5e0d90d642b receive-pack.c: consolidate find header logic
     @@ Commit message
          There are two functions that have very similar logic of finding a header
          value. find_commit_header, and find_header. We can conslidate the logic
          by using find_commit_header and replacing the logic in find_header.
     -    This helps clean up the code, as the logic for finding header values can
     -    stay in one place.
     +
     +    Introduce a new function find_header_max, which is equivalent to
     +    find_commit_header except it takes a len parameter that determines how
     +    many bytes to read. find_commit_header can then call find_header_max
     +    with 0 as the len.
     +
     +    This cleans up duplicate logic, as the logic for finding header values
     +    is now all in one place.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     @@ builtin/receive-pack.c: static char *prepare_push_cert_nonce(const char *path, t
      - * after dropping "_commit" from its name and possibly moving it out
      - * of commit.c
      - */
     --static char *find_header(const char *msg, size_t len, const char *key,
     --			 const char **next_line)
     -+static char *find_header_value(const char *msg, const char *key, const char **next_line)
     + static char *find_header(const char *msg, size_t len, const char *key,
     + 			 const char **next_line)
       {
      -	int key_len = strlen(key);
      -	const char *line = msg;
     @@ builtin/receive-pack.c: static char *prepare_push_cert_nonce(const char *path, t
      -			return xmemdupz(line + offset, (eol - line) - offset);
      -		}
      -		line = *eol ? eol + 1 : NULL;
     +-	}
     +-	return NULL;
      +	size_t out_len;
     -+	const char *eol;
     -+	char *ret;
     ++	const char *val = find_header_max(msg, key, len, &out_len);
      +
     -+	const char *val = find_commit_header(msg, key, &out_len);
      +	if (val == NULL)
      +		return NULL;
      +
     -+	eol = strchrnul(val, '\n');
     -+	if (next_line) {
     -+		*next_line = *eol ? eol + 1: eol;
     - 	}
     --	return NULL;
     -+
     -+	ret = xmalloc(out_len+1);
     -+	memcpy(ret, val, out_len);
     -+	ret[out_len] = '\0';
     ++	if (next_line)
     ++		*next_line = val + out_len + 1;
      +
     -+	return ret;
     ++	return xmemdupz(val, out_len);
       }
       
       /*
     -@@ builtin/receive-pack.c: static int constant_memequal(const char *a, const char *b, size_t n)
     +
     + ## commit.c ##
     +@@ commit.c: struct commit_list **commit_list_append(struct commit *commit,
     + 	return &new_commit->next;
     + }
       
     - static const char *check_nonce(const char *buf, size_t len)
     +-const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
     ++const char *find_header_max(const char *msg, const char *key,
     ++			size_t len,
     ++			size_t *out_len)
       {
     --	char *nonce = find_header(buf, len, "nonce", NULL);
     -+	char *nonce = find_header_value(buf, "nonce", NULL);
     -+
     - 	timestamp_t stamp, ostamp;
     - 	char *bohmac, *expect = NULL;
     - 	const char *retval = NONCE_BAD;
     -@@ builtin/receive-pack.c: static int check_cert_push_options(const struct string_list *push_options)
     - 	if (!len)
     - 		return 1;
     + 	int key_len = strlen(key);
     + 	const char *line = msg;
       
     --	while ((option = find_header(buf, len, "push-option", &next_line))) {
     --		len -= (next_line - buf);
     -+	while ((option = find_header_value(buf, "push-option", &next_line))) {
     - 		buf = next_line;
     - 		options_seen++;
     - 		if (options_seen > push_options->nr
     -
     - ## commit.c ##
     +-	while (line) {
     ++	while (line && (len == 0 || line < msg + len)) {
     + 		const char *eol = strchrnul(line, '\n');
     + 
     + 		if (line == eol)
      @@ commit.c: const char *find_commit_header(const char *msg, const char *key, size_t *out_len
     - 		if (eol - line > key_len &&
     - 		    !strncmp(line, key, key_len) &&
     - 		    line[key_len] == ' ') {
     --			*out_len = eol - line - key_len - 1;
     -+			if (out_len != NULL)
     -+				*out_len = eol - line - key_len - 1;
     - 			return line + key_len + 1;
     - 		}
     - 		line = *eol ? eol + 1 : NULL;
     + 	return NULL;
     + }
     + 
     ++const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
     ++{
     ++	return find_header_max(msg, key, 0, out_len);
     ++}
     + /*
     +  * Inspect the given string and determine the true "end" of the log message, in
     +  * order to find where to put a new Signed-off-by trailer.  Ignored are
     +
     + ## commit.h ##
     +@@ commit.h: void free_commit_extra_headers(struct commit_extra_header *extra);
     + 
     + /*
     +  * Search the commit object contents given by "msg" for the header "key".
     ++ * Reads up to "len" bytes of "msg".
     +  * Returns a pointer to the start of the header contents, or NULL. The length
     +  * of the header, up to the first newline, is returned via out_len.
     +  *
     +  * Note that some headers (like mergetag) may be multi-line. It is the caller's
     +  * responsibility to parse further in this case!
     +  */
     ++const char *find_header_max(const char *msg, const char *key,
     ++			size_t len,
     ++			size_t *out_len);
     ++
     + const char *find_commit_header(const char *msg, const char *key,
     + 			       size_t *out_len);
     + 
 2:  384a635daa2 < -:  ----------- commit.c: rename find_commit_header to find_header


 builtin/receive-pack.c | 33 ++++++++++-----------------------
 commit.c               | 10 ++++++++--
 commit.h               |  5 +++++
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816cf..b69ead8dcda 100644
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
+	const char *val = find_header_max(msg, key, len, &out_len);
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
index a348f085b2b..2ed115e04a0 100644
--- a/commit.c
+++ b/commit.c
@@ -1631,12 +1631,14 @@ struct commit_list **commit_list_append(struct commit *commit,
 	return &new_commit->next;
 }
 
-const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
+const char *find_header_max(const char *msg, const char *key,
+			size_t len,
+			size_t *out_len)
 {
 	int key_len = strlen(key);
 	const char *line = msg;
 
-	while (line) {
+	while (line && (len == 0 || line < msg + len)) {
 		const char *eol = strchrnul(line, '\n');
 
 		if (line == eol)
@@ -1653,6 +1655,10 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
 	return NULL;
 }
 
+const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
+{
+	return find_header_max(msg, key, 0, out_len);
+}
 /*
  * Inspect the given string and determine the true "end" of the log message, in
  * order to find where to put a new Signed-off-by trailer.  Ignored are
diff --git a/commit.h b/commit.h
index 3ea32766bcb..41ec89af5b5 100644
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
+const char *find_header_max(const char *msg, const char *key,
+			size_t len,
+			size_t *out_len);
+
 const char *find_commit_header(const char *msg, const char *key,
 			       size_t *out_len);
 

base-commit: 55b058a8bbcc54bd93c733035c995abc7967e539
-- 
gitgitgadget
