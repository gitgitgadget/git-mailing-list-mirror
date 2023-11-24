Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqzVRoqc"
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E4610CA
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:09 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c8880fbb33so23341821fa.0
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 03:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700824267; x=1701429067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d62sj1HCXoj1MVKCLNAzSaWSoT8zo2+t1TVHqufirFs=;
        b=AqzVRoqc4Kenw9GRLZ7aYS4VHvbf4h1NrzPrhBlDCWhGsWbHy/sWVpn6d9eu6L3ovD
         Ng9fxkDH0gaSLxuGaEYObLUYo1umjYh1MijL+NXhDfiQKcUEc3FD4CPk65TeQ2d0dYCr
         wI6keLu52nginGnjkD0LD+t5L59CSa8Dy/6Kpc9Me0dUl0iWNy67HdEcjjqgeYzW184v
         E46jWoNeYU6FPHIpce+HU8BQbKBgsXCNYg5p7mH2lDdApSdu5n8IBsSeFq4gOqpzOZqX
         qm0I2MqEJpdeqbeAe4yFE0EFVm1LjYhXRU4BikZCC47+PEuTlqNUz7ELXXgcl1U5dd1D
         hQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824267; x=1701429067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d62sj1HCXoj1MVKCLNAzSaWSoT8zo2+t1TVHqufirFs=;
        b=fJPs6Dw4/UsJw/vamnd4Jx0IUqOQC7SFHr4BPUV6XyuUQ3aWoGMEtOak2wU3Ofstv4
         P403a5OiYpShSH0ZT15DUO1MHiNpAsqxrHkqiwK8n0qbm5QtUkSGGk64YCxq1SiC1p2f
         50/dzSEUHzUf45O2GmOZGS2o4vtU2mH++eVCQT82BS2XtIqolQF34foZ1yZ14qjaMXkm
         IUqFT1XkBvVXBy+OXffj6w/g1IqWJLjIbUJt2A7CpyQffZzk84DoEMWkMaWAxvN+Z/M/
         KIEOzp2JubhJIs5GMQLp/luzKzTtgLOu8p8TF07OSerNHQnj9UmBqVz1Yp2YrdLK8lNX
         5Huw==
X-Gm-Message-State: AOJu0Yw4sB62YdUtMDOusNYVk3XXhMlQUe2gH6ISv9ZmCxVtADBJguzu
	GM4vHiJ9BvNF4uc5RYPwrgtcc7lOOLg=
X-Google-Smtp-Source: AGHT+IH4Jwmt9iKJ7tOj2lj6LJ/7bwzsezezsKc27L6+xghNn1/BfL5xF6zbQ9EWKWFCwX+cnLu99Q==
X-Received: by 2002:a2e:9685:0:b0:2c6:ecde:337a with SMTP id q5-20020a2e9685000000b002c6ecde337amr1774283lji.4.1700824267091;
        Fri, 24 Nov 2023 03:11:07 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:c06d:3245:2b4d:9ec5])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c458400b0040648217f4fsm5390295wmo.39.2023.11.24.03.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:11:06 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 04/14] replay: die() instead of failing assert()
Date: Fri, 24 Nov 2023 12:10:33 +0100
Message-ID: <20231124111044.3426007-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.14.g93e034faee
In-Reply-To: <20231124111044.3426007-1-christian.couder@gmail.com>
References: <20231115143327.2441397-1-christian.couder@gmail.com>
 <20231124111044.3426007-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elijah Newren <newren@gmail.com>

It's not a good idea for regular Git commands to use an assert() to
check for things that could happen but are not supported.

Let's die() with an explanation of the issue instead.

Co-authored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replay.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/replay.c b/builtin/replay.c
index 7998f6ed04..f48c5ed255 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -179,7 +179,12 @@ int cmd_replay(int argc, const char **argv, const char *prefix)
 
 		fprintf(stderr, "Rebasing %s...\r",
 			oid_to_hex(&commit->object.oid));
-		assert(commit->parents && !commit->parents->next);
+
+		if (!commit->parents)
+			die(_("replaying down to root commit is not supported yet!"));
+		if (commit->parents->next)
+			die(_("replaying merge commits is not supported yet!"));
+
 		base = commit->parents->item;
 
 		next_tree = repo_get_commit_tree(the_repository, commit);
-- 
2.43.0.14.g93e034faee

