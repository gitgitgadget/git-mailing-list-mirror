Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMBppE0u"
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988F4AF
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 06:13:50 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so4439018a12.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 06:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702563230; x=1703168030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xAmt5WN8yEdP5hRVdxogyrRphFntMC1QeO0Ts32bmE=;
        b=bMBppE0ulPdRiYwQTifs/HuVy218Y84+yuf/IukzNr10AXBXPr+iLB4ie+lkl/rS/b
         6hKHsWfysYpbVhmdLSBEd/kRFtKfprTg8fjrBReiJQXF3Q4Y9hwCq4dIICAVTj0+SGDW
         /WPxI4wiVCuySKnT144jK/TnWre8dLWnBMgRiHrCcmcP1pTGCF8txLN/NVePpR7/LuyZ
         /qbqSod3ZkxzXA61+kJssYVIqUI1/YTEefWmi/m4osRnlbKZ1dolp2z8jDARDL4gmgoQ
         1RRAouRrWeBtHtATKRGdIucIo+MXr0EZD/pwZa6FIQCOn7KOJeA3i2IOdd6muqriWOPD
         M6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563230; x=1703168030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xAmt5WN8yEdP5hRVdxogyrRphFntMC1QeO0Ts32bmE=;
        b=XqM2E+PYWwDHp6qmjdL4/1r9kN/YHj+w9NzKR9klB+ZEbBrFEdZnGksFblAF2uB/qA
         1DF0liTvmlLi3rPqAxoqoenMHDG5rMvR6Rnx6fMPvllaSh5MT3s+GaOJuh4OSURYbAco
         lYWm/gBefc/glzPWcEKYoBiEjY/MGB9Vgj7GFemTuq6z2weETo5lmVvu/jCEyCxm7SJa
         99EOtmEW9bnDhMv+12PPH2lpmI6pZqWmpnSIUvUaq/6x+1iGwt9NWWQsqFz9uBy0lT5B
         YNS6G7b/btG7yciLVWHu2D79u66VgTHvgXX74O5UPe3s/eICVmHb6Szdq/sdtvrMisih
         4DUA==
X-Gm-Message-State: AOJu0Yyl30i2H9hOpSZQDSp6TKxfeC+KlYMMQnCg23tuOObo0T/mxR+P
	wrA+uG8knJVzAk8AGUSbnb9fjV5S70o=
X-Google-Smtp-Source: AGHT+IGUX7+FB9oB3RXhs0BUL9KeUvCLyyrnZyKnHvzMg15PgT9wNRO2GAHz4vGl2lpcjMzr4loI5g==
X-Received: by 2002:a05:6a20:734f:b0:18c:5795:669e with SMTP id v15-20020a056a20734f00b0018c5795669emr5187137pzc.19.1702563229780;
        Thu, 14 Dec 2023 06:13:49 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006ce921da705sm11806232pfl.136.2023.12.14.06.13.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:13:49 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 2/4] transport-helper: call do_take_over() in process_connect
Date: Thu, 14 Dec 2023 22:13:43 +0800
Message-Id: <65fb67523c5c052fae466cbd8ce966e0f6265297.1702562879.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com> <cover.1702562879.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The existing pattern among all callers of process_connect() seems to be

        if (process_connect(...)) {
                do_take_over();
                ... dispatch to the underlying method ...
        }
        ... otherwise implement the fallback ...

where the return value from process_connect() is the return value of the
call it makes to process_connect_service().

Move the call of do_take_over() inside process_connect(), so that
calling the process_connect() function is more concise and will not
miss do_take_over().

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 2e127d24a5..51088cc03a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -645,6 +645,7 @@ static int process_connect(struct transport *transport,
 	struct helper_data *data = transport->data;
 	const char *name;
 	const char *exec;
+	int ret;
 
 	name = for_push ? "git-receive-pack" : "git-upload-pack";
 	if (for_push)
@@ -652,7 +653,10 @@ static int process_connect(struct transport *transport,
 	else
 		exec = data->transport_options.uploadpack;
 
-	return process_connect_service(transport, name, exec);
+	ret = process_connect_service(transport, name, exec);
+	if (ret)
+		do_take_over(transport);
+	return ret;
 }
 
 static int connect_helper(struct transport *transport, const char *name,
@@ -682,10 +686,8 @@ static int fetch_refs(struct transport *transport,
 
 	get_helper(transport);
 
-	if (process_connect(transport, 0)) {
-		do_take_over(transport);
+	if (process_connect(transport, 0))
 		return transport->vtable->fetch_refs(transport, nr_heads, to_fetch);
-	}
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
@@ -1142,10 +1144,8 @@ static int push_refs(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 
-	if (process_connect(transport, 1)) {
-		do_take_over(transport);
+	if (process_connect(transport, 1))
 		return transport->vtable->push_refs(transport, remote_refs, flags);
-	}
 
 	if (!remote_refs) {
 		fprintf(stderr,
@@ -1186,11 +1186,9 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
 {
 	get_helper(transport);
 
-	if (process_connect(transport, for_push)) {
-		do_take_over(transport);
+	if (process_connect(transport, for_push))
 		return transport->vtable->get_refs_list(transport, for_push,
 							transport_options);
-	}
 
 	return get_refs_list_using_list(transport, for_push);
 }
@@ -1274,10 +1272,8 @@ static int get_bundle_uri(struct transport *transport)
 {
 	get_helper(transport);
 
-	if (process_connect(transport, 0)) {
-		do_take_over(transport);
+	if (process_connect(transport, 0))
 		return transport->vtable->get_bundle_uri(transport);
-	}
 
 	return -1;
 }
-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

