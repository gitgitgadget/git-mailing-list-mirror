Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA71BC5A
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDEISxyk"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d480c6342dso74772985ad.2
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 05:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705412374; x=1706017174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X3uz/zjGS6q2PRVI/WvWaSPUaq9er1s6Ew94X99/y8=;
        b=FDEISxykXlDVEjRBzwYwHFmy0JLMCDIMBH9X5fj95RLXUANGociOxPQ8L40n3xKBFM
         +zSz8fzAmGt2qVPia3sHYW82ummuAwwTxnV+PE1Esgmg3LOBi/l31AGsUj9xiH+q23l/
         Ly5pAW8u2Pv/+VX2Fzoat/BW2roC4CVHOwkmREB/Eafg0m+GzRL6hHhr5WCBxEZIYKdy
         SqQoaAScxY/+QQQjGln4S6o5GMhdl0nYPx1mDMmASfAw2+kMJJzD1NyC+rEqD9K8KcHW
         OYbPhFaXgZPhlUVRFe2BycKtEzmCptdfn9IGvVnFMpTq4wv2MLwigOOxwcKIi68knXqG
         bblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705412374; x=1706017174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X3uz/zjGS6q2PRVI/WvWaSPUaq9er1s6Ew94X99/y8=;
        b=ix/CKM+1IIuKnYfT2RrCSB4EDgK5gTrUV3jMADA9Fis9oeN7hbWm/oU4l6n4WmM1mn
         YotzJIbrxSaAySwE8vguUFfZV2HSJahiPN2sn7ZSGV/2BtkUCAF8EJvPgf3XJ/Juh3y2
         wgxW2uQOlT7a5SM79hR0DffZQizH9RknQHv/UBStKC3Ri1jCP9NP8cO9kxH1yAUMBd6a
         o3I84ML3qw/zfyQC/ZB6+swtHloWuXSrQwM3rET6gTViSCOZ1/TU7KnhpyIwk8Mu8FDi
         PlPkgK/2pAgi9xEElJyHCdZ1WZkcm3APzn7aAK5LkxXWGAPzJ9/DDeCZ1V70uPed3djg
         4dlQ==
X-Gm-Message-State: AOJu0YzhHT3BYGjPyCN7BynYTwQ4re5omccVWlLFN0bvc3ab12duTCga
	2AFZv1MRQ/6VNUdxn3rZ08TCiMC9Gb+5jw==
X-Google-Smtp-Source: AGHT+IHq+So+kkstmufV/5yQ9BB/SK1ZA2SMcp7ZJTQcIvlzGZr+CSDNWPHfZEhj4PCjYS+gj7dLsQ==
X-Received: by 2002:a17:902:76c2:b0:1d5:167:48d0 with SMTP id j2-20020a17090276c200b001d5016748d0mr7817899plt.47.1705412374424;
        Tue, 16 Jan 2024 05:39:34 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001d5c38bfa33sm4303351plg.307.2024.01.16.05.39.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 05:39:33 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 1/6] transport-helper: no connection restriction in connect_helper
Date: Tue, 16 Jan 2024 21:39:25 +0800
Message-Id: <f3fef46c058968f6d0ad5a48776bd2f59ab45868.1705411391.git.zhiyou.jx@alibaba-inc.com>
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

When commit b236752a (Support remote archive from all smart transports,
2009-12-09) added "remote archive" support for "smart transports", it
was for transport that supports the ".connect" method. The
"connect_helper()" function protected itself from getting called for a
transport without the method before calling process_connect_service(),
which only worked with the ".connect" method.

Later, commit edc9caf7 (transport-helper: introduce stateless-connect,
2018-03-15) added a way for a transport without the ".connect" method
to establish a "stateless" connection in protocol-v2, where
process_connect_service() was taught to handle the ".stateless_connect"
method, making the old protection too strict. But commit edc9caf7 forgot
to adjust this protection accordingly.

Remove the restriction in the "connect_helper()" function and give the
function "process_connect_service()" the opportunity to establish a
connection using ".connect" or ".stateless_connect" for protocol v2. So
we can connect with a stateless-rpc and do something useful. E.g., in a
later commit, implements remote archive for a repository over HTTP
protocol.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Linus Arver <linusa@google.com>
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
2.43.0

