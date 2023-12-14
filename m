Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHVnJWwx"
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9185A7
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 06:13:49 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3300205a12.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 06:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702563229; x=1703168029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adGc6EGVmjIPNKTg+encN8li33DZ1VDLOfTu31s9f6E=;
        b=QHVnJWwx8wm17GV5IXYZcexRW5Wrouhe81fohmUM2kyiHMtdqcW2DX4kwLdoe95yCl
         yQMWWe2D23HZx8huxoq3GeRqVwwJUWTuxQFv9Ln6Go3AHhOqK0ThoSN/5sjvhTR4lJHl
         Oig+YhTZwabsOFP3temMXclVL5yogAjM18saCi+HDZGiY0GMN6Sthz1NnfA2KLwt5l6A
         J53uYRbozP7VeSQ1Vg9VHqN5jxnk7r8973wj75r/oIjocG1vGlgXN0Jkhe49lnvxX3V8
         cX0hY9SJbkOXxoxvbb/lw4OqINg9OadCCpHCe9DeXsBwjg/8R/JO/L+FPFEmOgtoPfJa
         9m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563229; x=1703168029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adGc6EGVmjIPNKTg+encN8li33DZ1VDLOfTu31s9f6E=;
        b=EXyoi7jAtvFuVreTK9M1/v5fhb8N/ejt5TLz7ROosbMPAXTtcOTDvj8gJEnF59ZyXX
         rQsgxtASg+y/lVIv0pX1S6ZrloAsV7/oe781JDYsbSyJqMjD5bYnn3Sdd7q19TBYw0gf
         RKY44BzvrDRJP/Mev1xSXXvze8lQmcGDhXvhL4slRUJQYmz/QaLEQPmVaazY6FQrwjw0
         +ZpJ0q9UGwFiOII20+0YJ+2Tx2KUKaEwp8rqig2GYrRtwUJtmfhyQlm6cgyrxEcwmDkI
         lXePW1lNfLckmp9IaAFgeYu20OMoEcILHUEDuDWPTRBKLNBjEI2v3QoadFqQ7SLA3jnU
         ykrw==
X-Gm-Message-State: AOJu0Ywq889ppEZMfXuu4sF2QLLWT6KQKMypY27EsPPow5AFwE2IAULw
	C6nsp7sXX+z+ZQ523cf9rtd/6H1INmQ=
X-Google-Smtp-Source: AGHT+IFuaaHA+vwUPKzLEFhKLRkL4LQyjQQBD3ggFBrKSEb7+SuYzV591X4ia3achs+t+g/rCddGcw==
X-Received: by 2002:a05:6a20:7f9b:b0:18f:97c:8a3b with SMTP id d27-20020a056a207f9b00b0018f097c8a3bmr13662317pzj.102.1702563229009;
        Thu, 14 Dec 2023 06:13:49 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006ce921da705sm11806232pfl.136.2023.12.14.06.13.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2023 06:13:48 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 1/4] transport-helper: no connection restriction in connect_helper
Date: Thu, 14 Dec 2023 22:13:42 +0800
Message-Id: <d343585cb5e696f521c2ee1dd6c0f0c2d86de113.1702562879.git.zhiyou.jx@alibaba-inc.com>
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

When commit b236752a (Support remote archive from all smart transports,
2009-12-09) added "remote archive" support for "smart transports", it
was for transport that supports the ".connect" method. The
"connect_helper()" function protected itself from getting called for a
transport without the method before calling process_connect_service(),
which did not work with such a transport.

Later, commit edc9caf7 (transport-helper: introduce stateless-connect,
2018-03-15) added a way for a transport without the ".connect" method
to establish a "stateless" connection in protocol-v2, which
process_connect_service() was taught to handle the "stateless"
connection, making the old safety valve in its caller that insisted
that ".connect" method must be defined too strict, and forgot to loosen
it.

Remove the restriction in the "connect_helper()" function and give the
function "process_connect_service()" the opportunity to establish a
connection using ".connect" or ".stateless_connect" for protocol v2. So
we can connect with a stateless-rpc and do something useful. E.g., in a
later commit, implements remote archive for a repository over HTTP
protocol.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 transport-helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 49811ef176..2e127d24a5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -662,8 +662,6 @@ static int connect_helper(struct transport *transport, const char *name,
 
 	/* Get_helper so connect is inited. */
 	get_helper(transport);
-	if (!data->connect)
-		die(_("operation not supported by protocol"));
 
 	if (!process_connect_service(transport, name, exec))
 		die(_("can't connect to subservice %s"), name);
-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

