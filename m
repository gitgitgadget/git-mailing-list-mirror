Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ADFC433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 00:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344256AbiAFAz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 19:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344357AbiAFAzA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 19:55:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCC6C0258D6
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 16:51:52 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h23so1630425wrc.1
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 16:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Si0p7y8fu/rgK8v1Spchti2bVOdv/+SnmdJchn+tx+c=;
        b=gBIhKvaE77ZWzmML/DiwYSCVfwuH31IOn+iG44PVTisAUaju42N8dcULWm8DdVU2UF
         Wgvj0R72Y9JXVE3j3ZFYa90Ox7rqGpa1OmJmYXOeEkaMhBwC3sEm4DDTLqynaKGzhLaM
         hdYCJ542KhWQfTjhn+6FWEE1TxiaE79Ca9FDWYtFZvrKQdLxmBaRRNGjpCsIf94qwyPF
         Z6MKhEx8bx7TSGcHfj4Hz1zAuwFfa0GbTLPVx9BfcRPk6gCxsvIcGga4yJAcyEb4x0aN
         gUz6wcw0Rs9mPvmpo0/HDGcBQ2JYwgrmK+UuflcwVyQU4k223wT3awLmhFrGAjDyuWKd
         M85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Si0p7y8fu/rgK8v1Spchti2bVOdv/+SnmdJchn+tx+c=;
        b=iHwoIrGwh3OU+HsvzJBP9zS5vLUhUB8laDB76A/yoVTGFVR/a3A6vYUS0CpX6I8G1U
         Qvzvp/z/a7l9utlPwLWGD1q+ZKx5Ie6OIJp0Gr+XAGgyxKvbxKKC8XCHYgXBsVrRamHu
         QYROPEkosOBjRbL6wHSIWt/kPyTji9lI1BWZpwF+gIMFpxxAOPID8bXb0QkFT4K66C1s
         /MQeilHcTYmp9Hh5EcWDOWdg6udJPN6A2++SNvRE0TU8lt0PAEoWUsSVdVtitpNkf+qF
         UOFmPwx+ldWSgzlk+88xekYDnmv/HuN6YpdXnSZws0JjVJDZdhrTIHr48KrAedBpevHy
         lSvg==
X-Gm-Message-State: AOAM530xfkgtYcwYDo2OmEA8phoDvW/s8KGmFh9Q260HMcm1mMPuUJ33
        qt2qbdy84xILOsMVg/myjH59fBQuMr4=
X-Google-Smtp-Source: ABdhPJx6BRKDsR/cfwCZqqDLSS70iMealg9dvknmTGg6Sc0RVx3mymtkjeylGFoJobKJ0VFW0cRgyQ==
X-Received: by 2002:a5d:4dca:: with SMTP id f10mr49285523wru.595.1641430311015;
        Wed, 05 Jan 2022 16:51:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d11sm540584wri.101.2022.01.05.16.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 16:51:50 -0800 (PST)
Message-Id: <pull.1125.v5.git.git.1641430309837.gitgitgadget@gmail.com>
In-Reply-To: <pull.1125.v4.git.git.1641396098056.gitgitgadget@gmail.com>
References: <pull.1125.v4.git.git.1641396098056.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Jan 2022 00:51:49 +0000
Subject: [PATCH v5] receive-pack.c: consolidate find header logic
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
by introducing a new function find_header_mem, which is equivalent to
find_commit_header except it takes a len parameter that determines how
many bytes will be read. find_commit_header and find_header can then both
call find_header_mem.

This reduces duplicate logic, as the logic for finding header values
can now all live in one place.

Signed-off-by: John Cai <johncai86@gmail.com>
---
    Consolidate find_header logic into one function
    
    This addresses the NEEDSWORK comment in builtin/receive-pack.c:
    
     /**
       * NEEDSWORK: reuse find_commit_header() from jk/commit-author-parsing
       * after dropping "_commit" from its name and possibly moving it out
       * of commit.c
       **/
    
    
    There are two functions that have very similar logic of finding a header
    value. find_commit_header, and find_header. We can conslidate the logic
    by introducing a new function find_header_mem, which is equivalent to
    find_commit_header except it takes a len parameter that determines how
    many bytes will be read. find_commit_header and find_header can then
    both call find_header_mem.
    
    This reduces duplicate logic, as the logic for finding header values can
    now all live in one place.
    
    Changes since v4:
    
     * adjust verbiage of NEEDSWORK comment block
    
    Changes since v3:
    
     * added NEEDSWORK block detailing what needs to be done to clean up
       find_header_mem
     * fixed verbiage in commit message
     * adjusted style of an if block (based on Junio's feedback)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1125%2Fjohn-cai%2Fjc%2Freplace-find-header-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1125/john-cai/jc/replace-find-header-v5
Pull-Request: https://github.com/git/git/pull/1125

Range-diff vs v4:

 1:  a7b00022b00 ! 1:  02da3136c43 receive-pack.c: consolidate find header logic
     @@ commit.c: struct commit_list **commit_list_append(struct commit *commit,
       
      -	while (line) {
      +	/*
     -+	 * NEEDSWORK: Between line[0] and msg[len], there may not be a LF nor NUL
     -+	 * at all, and strchrnul() will scan beyond the range we were given
     -+	 * Make this operation safer and abide by the contract to only read up to len.
     ++	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
     ++	 * given by len. However, current callers are safe because they compute
     ++	 * len by scanning a NUL-terminated block of memory starting at msg.
     ++	 * Make this function safer by checking if the input is NUL-terminated
     ++	 * or has a NL between line[0] and msg[len].
      +	 */
      +	while (line && line < msg + len) {
       		const char *eol = strchrnul(line, '\n');


 builtin/receive-pack.c | 33 ++++++++++-----------------------
 commit.c               | 16 ++++++++++++++--
 commit.h               |  5 +++++
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9f4a0b816cf..5c2732a0d07 100644
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
+	if (!val)
+		return NULL;
+
+	if (next_line)
+		*next_line = val + out_len + 1;
+
+	return xmemdupz(val, out_len);
 }
 
 /*
diff --git a/commit.c b/commit.c
index a348f085b2b..f5224e65de2 100644
--- a/commit.c
+++ b/commit.c
@@ -1631,12 +1631,20 @@ struct commit_list **commit_list_append(struct commit *commit,
 	return &new_commit->next;
 }
 
-const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
+const char *find_header_mem(const char *msg, size_t len,
+			const char *key, size_t *out_len)
 {
 	int key_len = strlen(key);
 	const char *line = msg;
 
-	while (line) {
+	/*
+	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
+	 * given by len. However, current callers are safe because they compute
+	 * len by scanning a NUL-terminated block of memory starting at msg.
+	 * Make this function safer by checking if the input is NUL-terminated
+	 * or has a NL between line[0] and msg[len].
+	 */
+	while (line && line < msg + len) {
 		const char *eol = strchrnul(line, '\n');
 
 		if (line == eol)
@@ -1653,6 +1661,10 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
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
 

base-commit: c8b2ade48c204690119936ada89cd938c476c5c2
-- 
gitgitgadget
