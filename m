Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47D24204
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEBhl2HH"
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE019B
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:12:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso30382865e9.2
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698099120; x=1698703920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJp/q/ZEUO49STF++3yf9/VRpHPtJGlQEiwgRkLc/M8=;
        b=JEBhl2HHFYm3dUBxqBbwmINgpT/ZcYvBEvxUBlt3oEBWP853Fir+MoLvs8bZcKPToQ
         Qych0DIahMCm4seuKnsVBuSWx4R6Pg8pQgpNw0TSx+1KT0lKZlKvf/pbonWMJQjMc0kW
         DDs6Hk/fpDX3SaoQWxLSy8rIKBpJwybfsAO8rrZxNbEVcMz7P6MDXlMCiANlxS+MhfDx
         n+xxqW+k+UldxCjg5WWOJh/y26qDFwKCSXxTT/BKse/bVPPLXCczDFetDbRVr5y/pEg9
         blaOHb6X06fbnPoD7v0cwS/uW5lPr6r6L2a0fDdnVKK0Mve/fSXIH1usHbKsL+QZ98ig
         CRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698099120; x=1698703920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJp/q/ZEUO49STF++3yf9/VRpHPtJGlQEiwgRkLc/M8=;
        b=adY9xV8tWt8oAEBmLEh4r5xKdi/eLBs768s1D8AJrCi8WiRl30BqVN/pddcf0stCLd
         YtsSfssidDBH7B8Q85Ew2/0PK5VSsBUnrVvUbJdI4eJX/jhVIa0DGNy7y2bOEcKWGsBg
         WH6n3s7bXeuk9BhVU2+QOZlIwEX+Kh7Vivk8lPfWDh6s5On7Z7tZyLnYqzukFf5DH9lO
         9n63R74LBq32vmTdeviADJnjOkqXI5wHYtYsiH9ZxAABp3Sm0paGQqSIHSF0652f2HIS
         aQJ3FVSw4Ins9pC8RciIvv4RPety3Zc9c71hzZNUVApIIIISQw3nTUE20oNLnSfpr13a
         s1cQ==
X-Gm-Message-State: AOJu0Yze1aA6QNOHjlJrnTr5gBUf1senEtpCTV5R0sDBh8NlEbGBsEsD
	+AFEgJ5DvKGyqWyDmfAT9KIbAdS5VyKyCg==
X-Google-Smtp-Source: AGHT+IGaLJqaT4nvGOWUpsWvwoDQlKlvHwW6J/5Bkhva5HZc7r0fVt22F86aO3WaipBPk+3FlVvuEA==
X-Received: by 2002:a05:600c:45cb:b0:401:daf2:2737 with SMTP id s11-20020a05600c45cb00b00401daf22737mr8337698wmo.30.1698099120078;
        Mon, 23 Oct 2023 15:12:00 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b0032008f99216sm8559953wrt.96.2023.10.23.15.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:11:59 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 6/7] refs: exempt pseudorefs from pattern prefixing
Date: Mon, 23 Oct 2023 23:11:42 +0100
Message-ID: <20231023221143.72489-7-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231023221143.72489-1-andy.koppe@gmail.com>
References: <20231022214432.56325-1-andy.koppe@gmail.com>
 <20231023221143.72489-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In normalize_glob_ref(), don't prefix pseudorefs with "refs/", thereby
implementing a NEEDSWORK from b877e617e6e5.

This is in preparation for showing pseudorefs in log decorations, as
they are not matched as intended in decoration filters otherwise. The
function is only used in load_ref_decorations().

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 refs.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index aa7e4c02c5..fbd15a8cff 100644
--- a/refs.c
+++ b/refs.c
@@ -565,13 +565,16 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 
 	if (prefix)
 		strbuf_addstr(&normalized_pattern, prefix);
-	else if (!starts_with(pattern, "refs/") &&
-		   strcmp(pattern, "HEAD"))
-		strbuf_addstr(&normalized_pattern, "refs/");
-	/*
-	 * NEEDSWORK: Special case other symrefs such as REBASE_HEAD,
-	 * MERGE_HEAD, etc.
-	 */
+	else if (!starts_with(pattern, "refs/") && strcmp(pattern, "HEAD")) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(pseudorefs); i++)
+			if (!strcmp(pattern, pseudorefs[i]))
+				break;
+
+		if (i == ARRAY_SIZE(pseudorefs))
+			strbuf_addstr(&normalized_pattern, "refs/");
+	}
 
 	strbuf_addstr(&normalized_pattern, pattern);
 	strbuf_strip_suffix(&normalized_pattern, "/");
-- 
2.42.GIT

