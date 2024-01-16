Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F501BC5C
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxIsoNMN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d5efddb33dso2925515ad.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 05:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705412375; x=1706017175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAUGC2z588o0P2pXwul4EzAT8d2kTMFHkZMpn6Ua8qs=;
        b=WxIsoNMN3q3neu4fhlTzKxYNMnPP+eeJKQdGKxn2y3AOefwSumscrgf27Zn58ixcPT
         DkduOn57eY8nXWJrbx+HTStBYaSN8P9iW1un4LIrHxx1+xevI9KXEESfSfzGNHHLidcg
         eGxAQ4AR4SKC95PWDXOOINbx8mHmkhpp7rmJLHtNzX2tOw+A/2PwkBQUixL6OVxOc7pf
         IM677sc27as1GJcfjW+9dCAVbeVobJJVEskNCIUdPtLnxxlCEL5nwfhTLNIQMFmfKAdm
         InuapjCPAHeOWIYBolTXwSSEV2ESoKUl4QJI1xvYFnHIewXcHqE/u7ehY8+Zqr0tG0uY
         uVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705412375; x=1706017175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAUGC2z588o0P2pXwul4EzAT8d2kTMFHkZMpn6Ua8qs=;
        b=sChVZCKUqX5LyL1BqlYNNqB73ib6fh7lRiZhCxAiLRM1tvQecgUyJGcBynUoLlWBTm
         W4vx2FloVssWuUwG/q2aXV6eGHGETLcVCqLqb4eIw5HIR0psHlhJL867R0K7Lv7JbjwL
         +4HG/z5dI+0Lcw8pNnJVCBrlQYsXDhKjICYnaYta12lWAxgbn8Zz35CgczpUbcZHM4Si
         Cb0ey4NrxCc7MdCbOeUVlhOvIRXGhRlgoyg5Xeq4tDJSuExY7KmgXTYfXqqWihQGztd4
         o78PFJF5i3qr71y0xyWqreFMR8O1tkvaBFp4K+nOdtm+XhzND0uyDICE9662Lc5Y6llA
         GaYQ==
X-Gm-Message-State: AOJu0Yxr8gU75THkOhyRLVVtQ9H1Sc4FEOgZLYvaQ67d+hl0lr7HOf2P
	4hf5HT8hr/D0WUs/X6A0JvEUqQo6I3Q6zg==
X-Google-Smtp-Source: AGHT+IFYgKtMdmiDFLIt4v8MHor8bgHgHuF4FGqvS/qlfJveDobZweGViWxU3950ZEtS05YDgtNAIA==
X-Received: by 2002:a17:902:d485:b0:1d4:d5bb:5d7e with SMTP id c5-20020a170902d48500b001d4d5bb5d7emr4569322plg.58.1705412375099;
        Tue, 16 Jan 2024 05:39:35 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001d5c38bfa33sm4303351plg.307.2024.01.16.05.39.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 05:39:34 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 2/6] remote-curl: supports git-upload-archive service
Date: Tue, 16 Jan 2024 21:39:26 +0800
Message-Id: <6be331b22d51e1f6f96cb0035d99db5b8cede676.1705411391.git.zhiyou.jx@alibaba-inc.com>
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

Add new service (git-upload-archive) support in remote-curl, so we can
support remote archive over HTTP/HTTPS protocols. Differences between
git-upload-archive and other serices:

 1. The git-archive command does not expect to see protocol version and
    capabilities when connecting to remote-helper, so do not send them
    in remote-curl for the git-upload-archive service.

 2. We need to detect protocol version by calling discover_refs(),
    Fallback to use the git-upload-pack service (which, like
    git-upload-archive, is a read-only operation) to discover protocol
    version.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 remote-curl.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index ef05752ca5..ce6cb8ac05 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1447,8 +1447,14 @@ static int stateless_connect(const char *service_name)
 	 * establish a stateless connection, otherwise we need to tell the
 	 * client to fallback to using other transport helper functions to
 	 * complete their request.
+	 *
+	 * The "git-upload-archive" service is a read-only operation. Fallback
+	 * to use "git-upload-pack" service to discover protocol version.
 	 */
-	discover = discover_refs(service_name, 0);
+	if (!strcmp(service_name, "git-upload-archive"))
+		discover = discover_refs("git-upload-pack", 0);
+	else
+		discover = discover_refs(service_name, 0);
 	if (discover->version != protocol_v2) {
 		printf("fallback\n");
 		fflush(stdout);
@@ -1486,9 +1492,11 @@ static int stateless_connect(const char *service_name)
 
 	/*
 	 * Dump the capability listing that we got from the server earlier
-	 * during the info/refs request.
+	 * during the info/refs request. This does not work with the
+	 * "git-upload-archive" service.
 	 */
-	write_or_die(rpc.in, discover->buf, discover->len);
+	if (strcmp(service_name, "git-upload-archive"))
+		write_or_die(rpc.in, discover->buf, discover->len);
 
 	/* Until we see EOF keep sending POSTs */
 	while (1) {
-- 
2.43.0

