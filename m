Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6FA1BDED
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POA2rJt3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d51ba18e1bso82908285ad.0
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 05:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705412377; x=1706017177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX+1DBLKTnyVMt/iObLdOwJH8HehaYVHlLjcOyCJsKA=;
        b=POA2rJt3qww4HyTKMav3H2yMRStKBMdrsHK7rXwyY0nEx6Sd6D0gRm/BrJN9avhwIg
         s8SwF3tAZwcPTrQ0h3JV2O/xzykc9EiCUBt3pqVjHfjHBVMKJqp3RRU5FDAq9+uMBbuq
         Xf0/b+nbOwDH68XUDozfPQP5h22VrQOrT1x1JpLIY9VhhhnmwcnFUfp14Ragnn3nQtlo
         w6qCwWths8K4XimQn/va6uHG/Z67NUqVPHVyurBJTUXcu+1F1LMLl4kfzIuGnzjtvIx1
         8ejbktMTxxWmWOAZ2PEsNVxSkHOORE+T1sBHLFBi7g5GWxveBHGby5ZyFO70Zv4lSv2u
         wj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705412377; x=1706017177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nX+1DBLKTnyVMt/iObLdOwJH8HehaYVHlLjcOyCJsKA=;
        b=r7Klr0VoXaL70zn9/LiA9D5Y8/6kUETSUBRGtueJqmKgWjMnTlUNd7gFmA5JUYMGIx
         5m92/Tnm6FVgf+uZkSCbNFWiM6Tc8+HB9Ntl/Nurezdg8dGENakZap6ZI4wip6nm/NBa
         2O+23nFx+EtIWOGocwBlqKeX/Ol8UIhwf4yKkiudmvIiUGlj3k0l1JnzYUdFT9Azwczs
         1I/4Q+QEDBTi4B6YnJMbBQeIogrjdYkCRG4h51/N+cwVwgz0emhoDJbAbjuFt8fEachq
         j5nKxV5OO3yAMg4eE7/Akv9Jwcd9SB49k93IfM3pFfcztlj9n+vRJGbhRW+WrF4wfdTo
         OFbg==
X-Gm-Message-State: AOJu0Yx3Bxd8z8agPmivHtfp+/6l6opf+Ne/T24eCLP9+HY/Hcffd/a1
	59851cziiqmL7B74OjomwR1oMYvc+7OTvg==
X-Google-Smtp-Source: AGHT+IHrc7/sjCSPbGthBeTzbNQ/qn1AEQWjZlflAU86HENfJ4skABwnDEztRNKKZVdjYPeBYUpLyg==
X-Received: by 2002:a17:903:32cf:b0:1d5:aed4:b4c2 with SMTP id i15-20020a17090332cf00b001d5aed4b4c2mr9516404plr.35.1705412377335;
        Tue, 16 Jan 2024 05:39:37 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001d5c38bfa33sm4303351plg.307.2024.01.16.05.39.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 05:39:37 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 5/6] transport-helper: call do_take_over() in connect_helper
Date: Tue, 16 Jan 2024 21:39:29 +0800
Message-Id: <6ac0c8e105febe526dc64182845832297656a8a5.1705411391.git.zhiyou.jx@alibaba-inc.com>
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

After successfully connecting to the smart transport by calling
process_connect_service() in connect_helper(), run do_take_over() to
replace the old vtable with a new one which has methods ready for the
smart transport connection. This will fix the exit code of git-archive
in test case "archive remote http repository" of t5003.

The connect_helper() function is used as the connect method of the
vtable in "transport-helper.c", and it is called by transport_connect()
in "transport.c" to setup a connection. The only place that we call
transport_connect() so far is in "builtin/archive.c". Without running
do_take_over(), it may fail to call transport_disconnect() in
run_remote_archiver() of "builtin/archive.c". This is because for a
stateless connection and a service like "git-upload-archive", the
remote helper may receive a SIGPIPE signal and exit early. To have a
graceful disconnect method by calling do_take_over() will solve this
issue.

Helped-by: Linus Arver <linusa@google.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5003-archive-zip.sh | 2 +-
 transport-helper.c     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 6f85bd3463..961c6aac25 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -268,7 +268,7 @@ test_expect_success 'remote archive does not work with protocol v1' '
 '
 
 test_expect_success 'archive remote http repository' '
-	test_must_fail git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
+	git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
 		--output=remote-http.zip HEAD &&
 	test_cmp_bin d.zip remote-http.zip
 '
diff --git a/transport-helper.c b/transport-helper.c
index 6fe9f4f208..91381be622 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -669,6 +669,8 @@ static int connect_helper(struct transport *transport, const char *name,
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
+
+	do_take_over(transport);
 	return 0;
 }
 
-- 
2.43.0

