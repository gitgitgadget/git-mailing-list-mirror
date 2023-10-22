Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1B13FF3
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bws11Ie7"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659F114
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:12 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so1839469f8f.2
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698011111; x=1698615911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJp/q/ZEUO49STF++3yf9/VRpHPtJGlQEiwgRkLc/M8=;
        b=bws11Ie7sME2gV1AQzfNZ7HNaYl0KnzzFt/LRqnGjOi9whMLRNKpohl/h7YHY8CC/1
         BcB07GF5wWlFW53/VY31Zyo8HCrxh51BvYFvsYkLaOwzI8iwnSIILBpjyxxfHi1G1PXY
         VsccURsrgPWp1UGmGkngqzswUcQJFQXetlk1hWHH816zRcpNIS0Paf3ftkBPOBzMmGeY
         ihoIoRyh1hbwMvEfqBBeJAi9OQuiS2kCfpoRIhIAg97h43pEfK0JlP7AnicSpdFc9B9M
         bn0AUwjWXcLYnS/j4t7Jq1BaWFX5mX+/T+lel/ERxdSuwAko2O1lxTYh5iDWEqCqWhZW
         KmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698011111; x=1698615911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJp/q/ZEUO49STF++3yf9/VRpHPtJGlQEiwgRkLc/M8=;
        b=wHEhLuK8cgEKpPgko2ChEnl+VpR+N0CAR7RgZmvxdlJ5DCpy4UlpUnbS7GiFftdHS5
         BZOUIizgywDS3N2ebWePPx7YdlhBtt/64ksiC8eO3XngPicQlBRW0u4q/InkUR8D4PzP
         8DPDPv0byPOPZt4G0+oq+5o/caTcUz9pftlUfwWQN81IuqGk06BLU9Zo/bI0ubUdiwXZ
         NevFIAvt+AARRYUNlbb24NrpKcSRTdW/+TcSzpz6k8X4oBKujw4WcsvFn9AhHBe9h0we
         SXa5BVeE5CNxS8Z9cPfM2pobSEMUIGBdM+GRN3YLnY8TBb0KsEdq74uSlc58njIAef1Y
         FZ9Q==
X-Gm-Message-State: AOJu0Yxpd6Pr5TCyjtbnAEaTarIUbAE54y7F7KUH4iwYee/RwKeJOi5S
	o4A63rhfeoT8abVSepgQrvrj/onnWf0=
X-Google-Smtp-Source: AGHT+IFqcGaIFyweuVv9+FFxtdMme2265K8SjfgiTBbess4dd1IVuDFhJ98sxbUGiAOS95RcckTJeA==
X-Received: by 2002:a5d:650f:0:b0:32d:ad8b:2a04 with SMTP id x15-20020a5d650f000000b0032dad8b2a04mr5489510wru.14.1698011111002;
        Sun, 22 Oct 2023 14:45:11 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id v3-20020adff683000000b0032d9523de65sm6291972wrp.48.2023.10.22.14.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 14:45:10 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2 5/6] refs: exempt pseudorefs from pattern prefixing
Date: Sun, 22 Oct 2023 22:44:31 +0100
Message-ID: <20231022214432.56325-6-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231022214432.56325-1-andy.koppe@gmail.com>
References: <20231019193911.1669705-1-andy.koppe@gmail.com>
 <20231022214432.56325-1-andy.koppe@gmail.com>
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

