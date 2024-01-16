Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5311BDFD
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALr+pH9e"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d427518d52so71476035ad.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 05:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705412378; x=1706017178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CozsLbOmwkgZRdoKGjxxiV76kRVAqRlsUpx1KPOtBJg=;
        b=ALr+pH9e2XZ9NPW6HhO24x911codgs8kffhNMBNA/wpzxtdIHER1nGMIJBgX6N+edS
         imdWj92pe+Gx6aAPDYGhzwrPlM1qut/xUqfa2Re1sqLp1Ll6NVXfsN3N6nRg2AbB1VsW
         J1rA2Dx1CpO37VLVpepsqM6twIlpSyCSFwdPAy6O9fpDHAnCqLOakyNg0ap6GgSCYrgr
         bDtJhsJ8JWbPWbB3jNwGPRy/QiAzObV2Apc/M5yEG18d9VfrXU8I0QxZ7MUrd1N/qkWB
         a9PA9g7us+NSCci56Q8RKUo28Sxlm1tVraDwsMqKpTTtd8ondIsE64/mJrzWph7VMR4x
         ebzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705412378; x=1706017178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CozsLbOmwkgZRdoKGjxxiV76kRVAqRlsUpx1KPOtBJg=;
        b=Qvky0mFpXz4B7BdUpbfWBdKQCgBFt7EdZRgCqqEyGSAC1oOABs6wIm3jbiw+wnKZxr
         A8aExlvKq18KdzuNXU48PaDiMuZcv7QaKwQ+edPq+Jfy2Y4hP+I57G4f8XbXC+urWmmQ
         TxcjIgP/G+OUHsRwytc4kcONbgtWuDgEC4BzAedyN/HsmCrszdm7Kual0BWuDiqMJks+
         bAZ3tQKPZ+Da+ptWhWPqnqLPnYzzE9N0LbOntS5UW6r6qG5H3EO+2PPsH+6wjYlLlKKX
         Q7yvQ+CIPcDNbcYkCrSdI2yq4RecWC38V9DQzdzoE6HhrPLzbKK/rCPTISHnch51/XAg
         t/pQ==
X-Gm-Message-State: AOJu0YwIbkHXkyK5TYPyyGgvIDjVI/SzFX5RQBIVG3Q4CKm7X7RiRLPC
	z+eCRxICA2eg081YERxCV1ADdkNaxqALmQ==
X-Google-Smtp-Source: AGHT+IH/hiN2plMLZpOHAQoqW3J+w2Cl0TqdVgsi+qPyeJyV9AG+wq3UXZtKYE1oQNyaazjoqFGFlw==
X-Received: by 2002:a17:902:ed04:b0:1d5:4df5:df9b with SMTP id b4-20020a170902ed0400b001d54df5df9bmr8710108pld.4.1705412378106;
        Tue, 16 Jan 2024 05:39:38 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001d5c38bfa33sm4303351plg.307.2024.01.16.05.39.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 05:39:37 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 6/6] transport-helper: call do_take_over() in process_connect
Date: Tue, 16 Jan 2024 21:39:30 +0800
Message-Id: <423a89c59306e9c33851b7d36c685ddfce45736c.1705411391.git.zhiyou.jx@alibaba-inc.com>
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
index 91381be622..566f7473df 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -646,6 +646,7 @@ static int process_connect(struct transport *transport,
 	struct helper_data *data = transport->data;
 	const char *name;
 	const char *exec;
+	int ret;
 
 	name = for_push ? "git-receive-pack" : "git-upload-pack";
 	if (for_push)
@@ -653,7 +654,10 @@ static int process_connect(struct transport *transport,
 	else
 		exec = data->transport_options.uploadpack;
 
-	return process_connect_service(transport, name, exec);
+	ret = process_connect_service(transport, name, exec);
+	if (ret)
+		do_take_over(transport);
+	return ret;
 }
 
 static int connect_helper(struct transport *transport, const char *name,
@@ -685,10 +689,8 @@ static int fetch_refs(struct transport *transport,
 
 	get_helper(transport);
 
-	if (process_connect(transport, 0)) {
-		do_take_over(transport);
+	if (process_connect(transport, 0))
 		return transport->vtable->fetch_refs(transport, nr_heads, to_fetch);
-	}
 
 	/*
 	 * If we reach here, then the server, the client, and/or the transport
@@ -1145,10 +1147,8 @@ static int push_refs(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 
-	if (process_connect(transport, 1)) {
-		do_take_over(transport);
+	if (process_connect(transport, 1))
 		return transport->vtable->push_refs(transport, remote_refs, flags);
-	}
 
 	if (!remote_refs) {
 		fprintf(stderr,
@@ -1189,11 +1189,9 @@ static struct ref *get_refs_list(struct transport *transport, int for_push,
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
@@ -1277,10 +1275,8 @@ static int get_bundle_uri(struct transport *transport)
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
2.43.0

