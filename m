Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C6A1D548
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoEzTyV3"
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2E910CB
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f7c44f6a7so2491311f8f.1
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871068; x=1700475868; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEms6WLIUqM/ctvGUmXYH20+c1jatg0saT8hXhEJ0Vs=;
        b=CoEzTyV3hj9i3e1Vi4KKW3WI4/8pY3pJArvfKjVlv1TzwR17HFHiBp7FSIIBzg7lIq
         +GYV+rj2UA7c/c9V7KeunSNuupIW0pzboZ/Bn+cQz9jWo6heBOJILlfHJxjCAchvSLh9
         a4zIqErSE+oJHiGPE16FNIIUhx3dZnsKI/LJnFhfCjyF27qVrcQiL6geM+5DwH7PZdml
         XVbi1fjmoGI/S5GZfHfxXK9TZKkMEv8XX+JJT1tKOibc/eHD3dOLR1Zzx4jFpW8MdDU6
         MGvDSP/BuRSeFqerZkb+BQpr1L2tkysHNJqJddSjApA5doTM6/7JqGuQZFGGWHwwrWgi
         Cskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871068; x=1700475868;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEms6WLIUqM/ctvGUmXYH20+c1jatg0saT8hXhEJ0Vs=;
        b=SzjvBhYOAeojBueaMgWRHcOo8LJqCbdUltrQpG+caqCuZmJIdaNT3U4/t21mdIVAW1
         po1jSMS9J/RjZ5kD1XcbSL31YTcQl94HlDJoiX/K+RClRNvkXtEj0GuoVV1NEHiwpv1h
         ZFuXI0QSbT+fEsUIAtIcugYqi0PN8GI0XgS1X7EWz78AI6p2rGp2CedMWC7Ed9ujdB2F
         huuPk33DyYAD1UGcMfE2Sm3g2/7oo7zBrm2BUk2BNZqiyGn00c2BITmAgcP/V4LJHR4S
         lM59B9OHfxS2bX1t0I8BhfrPtZDjqfy8ZY3ZqcFlfCLFyO2ty4K0jFKfsUdc7DmILWL2
         D1cQ==
X-Gm-Message-State: AOJu0YziXoEdW8i5k9p2UPd2jds2i+ERKCWlz6t2hHACpafr7hu4bq9b
	kBqEOJIAr/uSS7Mjpsf9IIhrsz/dS98=
X-Google-Smtp-Source: AGHT+IGMDv1zYmkU/56CGS6MIiacHPAHru4MJA5XsfAmaGn+CEE1yhDTjhBLHW7qQmpSjWYD25kG3Q==
X-Received: by 2002:adf:d1e2:0:b0:32d:7162:7ffe with SMTP id g2-20020adfd1e2000000b0032d71627ffemr6327971wrd.69.1699871068025;
        Mon, 13 Nov 2023 02:24:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d63ca000000b0032d81837433sm5062977wrw.30.2023.11.13.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:27 -0800 (PST)
Message-ID: <06658ebad1027cdc72d9dc013b7a022245dd22c9.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:14 +0000
Subject: [PATCH 12/13] Handled git pipeline errors - Memory leak
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

This PR has fixes to enable build on z/OS

Signed-off-by: Harithamma D <harithamma.d@ibm.com>
---
 convert.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/convert.c b/convert.c
index 16173a1caf6..4c034bb714c 100644
--- a/convert.c
+++ b/convert.c
@@ -1313,9 +1313,9 @@ static int git_path_check_ident(struct attr_check_item *check)
 
 static struct attr_check *check;
 
-static const char* get_platform(void) {
+static void get_platform(char** result) {
 	struct utsname uname_info;
-	char *result = NULL;
+	*result = NULL;
 
 	if (uname(&uname_info) < 0)
 		die(_("uname() failed with error '%s' (%d)\n"),
@@ -1325,10 +1325,10 @@ static const char* get_platform(void) {
 	if(*uname_info.sysname != '\0')
 	{
 		int index=0;
-		result = (char *)malloc(strlen(uname_info.sysname)+1);
+		*result = (char *)malloc(strlen(uname_info.sysname)+1);
 		while(index <= strlen(uname_info.sysname))
 		{
-			result[index] = uname_info.sysname[index];
+			(*result)[index] = uname_info.sysname[index];
 			index++;
 		}
 	}
@@ -1336,9 +1336,8 @@ static const char* get_platform(void) {
 
 #ifdef __MVS__
 	if (!strcmp(uname_info.sysname, "OS/390"))
-		result="zos";
+		*result = "zos";
 #endif
-	return (char*)result;
 }
 
 
@@ -1347,8 +1346,11 @@ void convert_attrs(struct index_state *istate,
 {
 	struct attr_check_item *ccheck = NULL;
 	struct strbuf platform_working_tree_encoding = STRBUF_INIT;
-
-	strbuf_addf(&platform_working_tree_encoding, "%s-working-tree-encoding", get_platform());
+	char* result=NULL;
+	get_platform(&result);
+	strbuf_addf(&platform_working_tree_encoding, "%s-working-tree-encoding", result);
+	if (result != NULL)
+		free (result);
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-- 
gitgitgadget

