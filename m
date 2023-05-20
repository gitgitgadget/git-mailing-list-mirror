Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAF6C77B7F
	for <git@archiver.kernel.org>; Sat, 20 May 2023 07:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjETHUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 03:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjETHUw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 03:20:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21261BC
        for <git@vger.kernel.org>; Sat, 20 May 2023 00:20:50 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so39431365e9.1
        for <git@vger.kernel.org>; Sat, 20 May 2023 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684567249; x=1687159249;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CrY16vv9nHNasQB+4kB0KYCzGWKearOFuO1iXX8dF/4=;
        b=fQNyBHRJQtegXpnzI90T3Y301VBNNF0Rtq00Bc2stiiL2bEVSk5aWia0GxicDzDa+a
         kkcmeLdjQtFFxRKSLnK/qG8kpoU0GSRGMx7YFJImvnOlDrRAEi5POid6nHaTuCEtCSXA
         JkaHVqV7XgdrJF4idIu7D2kl3l4NbdD8AAGrFdieBSJr/E3TPgSWn1OBBFkFhi80uBZw
         0a/pOBTP6w3vltiecWhaKqFpUcqyQHk0zg6qzmTCbks29nGOhHs5EZceF5r0f0tkTIJt
         bUdhl7IUCoycmf3e0j67KVAAyN48e3IaLUxRPzepYzQ6CVXT20Eift8HmBx/VnsAZmEm
         U5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684567249; x=1687159249;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrY16vv9nHNasQB+4kB0KYCzGWKearOFuO1iXX8dF/4=;
        b=jjyjBBPrtwQV3RT6nAGKF0yFKA1FhKyb0esTP4WJH+tJllpw39h1usmTnRZi/DdTAw
         VDbbEq2MWXir9zdYQw+65nhsYrN4UbQgBVp5YSwZqmlVQS2J/agDvw5vOTjHDSnRxiuR
         m8vvczzzCLoERZjulGjYEvZ+WyXgHWx8veYcwuLRimXTxHyWnpalFGIasscS+ADAbJRn
         PqIcKMzsV1kOq58ZOme5yje0D9uS2odhPyyheXk+KkJLgEHxUVkOGWm/D1SCphrcb4lC
         m5uCuNUb2XLZxTF6fm9XHy4+wVdV3lt5kEUIfj4Wlhvosit+R0jvi6StqjKT6zXNYmR4
         x4gw==
X-Gm-Message-State: AC+VfDwBU/4N8NOL0PXxbUnME0lcSRWR+jDdEQbls8PvMRrEQbbqkHHt
        IMOYDEjeR6ZlxVS5+xQ0U+0t19WTPIM=
X-Google-Smtp-Source: ACHHUZ6PsrG9sDNTMa+66hM/C70GKKDp3aRowoIEyFm/Fpc4qDYH8NNp38LggYl9DTV7RhFojmsLcg==
X-Received: by 2002:a05:600c:2284:b0:3f4:2186:91c0 with SMTP id 4-20020a05600c228400b003f4218691c0mr3383775wmf.29.1684567248736;
        Sat, 20 May 2023 00:20:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c28d300b003f427cba193sm4562101wmd.41.2023.05.20.00.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 00:20:48 -0700 (PDT)
Message-Id: <pull.1534.git.1684567247339.gitgitgadget@gmail.com>
From:   "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 07:20:47 +0000
Subject: [PATCH] credential/wincred: store oauth_refresh_token
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: M Hickford <mirth.hickford@gmail.com>

a5c7656 (credential: new attribute oauth_refresh_token) introduced
a new confidential credential attribute for helpers to store.

We encode the new attribute in the CredentialBlob, separated by
newline:

    hunter2
    oauth_refresh_token=xyzzy

This is extensible and backwards compatible. The credential protocol
already assumes that attribute values do not contain newlines.

Alternatives considered: store oauth_refresh_token in a wincred
attribute. This would be insecure because wincred assumes attribute
values to be non-confidential.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential/wincred: store oauth_refresh_token
    
    I'm not confident in C and found string manipulation difficult, so
    please review carefully.
    
    I tested on Linux, cross compiling with Zig make CC="zig cc -target
    x86_64-windows-gnu" and tested make GIT_TEST_CREDENTIAL_HELPER=wincred
    t0303-credential-external.sh (with a shell script git-credential-wincred
    that wraps wine64 git-credential-wincred.exe "$@")
    
    See also similar patch for credential-libsecret "[PATCH v4]
    credential/libsecret: store new attributes"
    https://lore.kernel.org/git/pull.1469.v4.git.git.1684306540947.gitgitgadget@gmail.com/T/#u

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1534%2Fhickford%2Fwincred-refresh-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1534/hickford/wincred-refresh-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1534

 .../wincred/git-credential-wincred.c          | 40 ++++++++++++++++---
 t/t0303-credential-external.sh                |  1 +
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index 96f10613aee..dc34283b85e 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -35,7 +35,7 @@ static void *xmalloc(size_t size)
 }
 
 static WCHAR *wusername, *password, *protocol, *host, *path, target[1024],
-	*password_expiry_utc;
+	*password_expiry_utc, *oauth_refresh_token;
 
 static void write_item(const char *what, LPCWSTR wbuf, int wlen)
 {
@@ -128,6 +128,11 @@ static void get_credential(void)
 	DWORD num_creds;
 	int i;
 	CREDENTIAL_ATTRIBUTEW *attr;
+	WCHAR *secret;
+	WCHAR *line;
+	WCHAR *remaining_lines;
+	WCHAR *part;
+	WCHAR *remaining_parts;
 
 	if (!CredEnumerateW(L"git:*", 0, &num_creds, &creds))
 		return;
@@ -137,9 +142,17 @@ static void get_credential(void)
 		if (match_cred(creds[i])) {
 			write_item("username", creds[i]->UserName,
 				creds[i]->UserName ? wcslen(creds[i]->UserName) : 0);
-			write_item("password",
-				(LPCWSTR)creds[i]->CredentialBlob,
-				creds[i]->CredentialBlobSize / sizeof(WCHAR));
+			secret = xmalloc(creds[i]->CredentialBlobSize);
+			wcsncpy_s(secret, creds[i]->CredentialBlobSize, (LPCWSTR)creds[i]->CredentialBlob, creds[i]->CredentialBlobSize / sizeof(WCHAR));
+			line = wcstok_s(secret, L"\r\n", &remaining_lines);
+			write_item("password", line, wcslen(line));
+			while(line != NULL) {
+				part = wcstok_s(line, L"=", &remaining_parts);
+				if (!wcscmp(part, L"oauth_refresh_token")) {
+					write_item("oauth_refresh_token", remaining_parts, wcslen(remaining_parts));
+				}
+				line = wcstok_s(NULL, L"\r\n", &remaining_lines);
+			}
 			for (int j = 0; j < creds[i]->AttributeCount; j++) {
 				attr = creds[i]->Attributes + j;
 				if (!wcscmp(attr->Keyword, L"git_password_expiry_utc")) {
@@ -148,6 +161,7 @@ static void get_credential(void)
 					break;
 				}
 			}
+			free(secret);
 			break;
 		}
 
@@ -158,16 +172,26 @@ static void store_credential(void)
 {
 	CREDENTIALW cred;
 	CREDENTIAL_ATTRIBUTEW expiry_attr;
+	WCHAR *secret;
+	int wlen;
 
 	if (!wusername || !password)
 		return;
 
+	if (oauth_refresh_token) {
+		wlen = _scwprintf(L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
+		secret = xmalloc(sizeof(WCHAR) * wlen);
+		_snwprintf_s(secret, sizeof(WCHAR) * wlen, wlen, L"%s\r\noauth_refresh_token=%s", password, oauth_refresh_token);
+	} else {
+		secret = _wcsdup(password);
+	}
+
 	cred.Flags = 0;
 	cred.Type = CRED_TYPE_GENERIC;
 	cred.TargetName = target;
 	cred.Comment = L"saved by git-credential-wincred";
-	cred.CredentialBlobSize = (wcslen(password)) * sizeof(WCHAR);
-	cred.CredentialBlob = (LPVOID)password;
+	cred.CredentialBlobSize = wcslen(secret) * sizeof(WCHAR);
+	cred.CredentialBlob = (LPVOID)_wcsdup(secret);
 	cred.Persist = CRED_PERSIST_LOCAL_MACHINE;
 	cred.AttributeCount = 0;
 	cred.Attributes = NULL;
@@ -182,6 +206,8 @@ static void store_credential(void)
 	cred.TargetAlias = NULL;
 	cred.UserName = wusername;
 
+	free(secret);
+
 	if (!CredWriteW(&cred, 0))
 		die("CredWrite failed");
 }
@@ -253,6 +279,8 @@ static void read_credential(void)
 			password = utf8_to_utf16_dup(v);
 		else if (!strcmp(buf, "password_expiry_utc"))
 			password_expiry_utc = utf8_to_utf16_dup(v);
+		else if (!strcmp(buf, "oauth_refresh_token"))
+			oauth_refresh_token = utf8_to_utf16_dup(v);
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do
diff --git a/t/t0303-credential-external.sh b/t/t0303-credential-external.sh
index f028fd14182..51886b8e259 100755
--- a/t/t0303-credential-external.sh
+++ b/t/t0303-credential-external.sh
@@ -45,6 +45,7 @@ test -z "$GIT_TEST_CREDENTIAL_HELPER_SETUP" ||
 helper_test_clean "$GIT_TEST_CREDENTIAL_HELPER"
 
 helper_test "$GIT_TEST_CREDENTIAL_HELPER"
+helper_test_oauth_refresh_token "$GIT_TEST_CREDENTIAL_HELPER"
 
 if test -z "$GIT_TEST_CREDENTIAL_HELPER_TIMEOUT"; then
 	say "# skipping timeout tests (GIT_TEST_CREDENTIAL_HELPER_TIMEOUT not set)"

base-commit: 9e49351c3060e1fa6e0d2de64505b7becf157f28
-- 
gitgitgadget
