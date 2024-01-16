Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075C1BDCB
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob41tJL6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d5f5a2e828so657405ad.3
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 05:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705412376; x=1706017176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhTtqH48/C86XL/TwWluZBelSMih1M4GmOBqLA2IEew=;
        b=Ob41tJL6DJ+dnf/IqUAv1RC0DYJzIgsb3BB2wDQ7QJgywEFIwPqyYmeVKHZbwLi4yG
         X8cTdlZTWOj3PNUSCP1uTyyEDwioaT+WiP3WVlHmzfqX7yWmn8E89CYuxQoeCnu4l9Jt
         g5B+hNHHP7ZSj4R0kC3gUBd0kLMmPeFMglXkxwgOaefCYaziSKrDRf48yAk6K2kGzS03
         Q/pO0chwMEeDikBSoQhWV4pYyNQUZ8f7I7FW8ZHPjdd0LeWyR6wr76q8DK2cZHftBHC8
         WgEgF5ph7E4zTif3jxti4+keyIHck7Ux42eeEPU/2By5CnQ1Sw0syhpWWnBq2XZ4xXV5
         5wDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705412376; x=1706017176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhTtqH48/C86XL/TwWluZBelSMih1M4GmOBqLA2IEew=;
        b=K1pi/q5icWWaA2kHIPIvsh1e5gAQgKL3W6iwo7661EaDhfvksG1bSKTt9InkfraDvf
         TGBQMtdaaqLCd5nRSme+m/fZvvnYUulaIzZLzD9NwrvKmtLN6ercVOPN51lZ4W7cI409
         f+LO44BNXEbffbyvZk+f/58d+/6BvURj/7pDb7PrZey1uS6sv6IN7aFXOYDPUGe8kKqB
         nPiWOmdKywHATXSpGzSFjMljFnzRGORFqQY+/vX1UzR3hYh6IuKY83tglrm361GpswpD
         9SBteqrH9g1zV2DLNCEGadrWUqOFqZF4G019U615XHw2rXtB4YWtgYm286SSLcJa0fu4
         IO/w==
X-Gm-Message-State: AOJu0YyHpS3Z5bMpe49MdCy2n11MPW85k+MFXLYfOAW7R8ymk4MuiQGf
	yTpZLdgh9nCa+IiJMkB3acPN7QXtTQSnFw==
X-Google-Smtp-Source: AGHT+IGmos3/7eBWVW5F7ZQ2WX7bFSaGe5HUeeIrUfTTxU4074E9N/aW2LzBUORWs5GgGpRDgK2VWQ==
X-Received: by 2002:a17:902:d4d2:b0:1d3:77c4:59db with SMTP id o18-20020a170902d4d200b001d377c459dbmr4601365plg.139.1705412375841;
        Tue, 16 Jan 2024 05:39:35 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001d5c38bfa33sm4303351plg.307.2024.01.16.05.39.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 05:39:35 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 3/6] transport-helper: protocol-v2 supports upload-archive
Date: Tue, 16 Jan 2024 21:39:27 +0800
Message-Id: <aabc8e1a2a191059b88b439d53bc7b3735b979ca.1705411391.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <cover.1705411391.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We used to support only git-upload-pack service for protocol-v2. In
order to support remote archive over HTTP/HTTPS protocols, add new
service support for git-upload-archive in protocol-v2.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 2e127d24a5..6fe9f4f208 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -628,7 +628,8 @@ static int process_connect_service(struct transport *transport,
 		ret = run_connect(transport, &cmdbuf);
 	} else if (data->stateless_connect &&
 		   (get_protocol_version_config() == protocol_v2) &&
-		   !strcmp("git-upload-pack", name)) {
+		   (!strcmp("git-upload-pack", name) ||
+		    !strcmp("git-upload-archive", name))) {
 		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
 		ret = run_connect(transport, &cmdbuf);
 		if (ret)
-- 
2.43.0

