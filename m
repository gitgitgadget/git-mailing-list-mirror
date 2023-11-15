Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A112E658
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxlrfw7H"
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197EE189
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:53 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50906f941so98288581fa.2
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058830; x=1700663630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E691cqJfsqH+4jSY4gnfdIU7rI78N7x762/MRRyf3VI=;
        b=Yxlrfw7HMS4ShAP0ENIN+GsVuJOP/y7M8qDZzAHeq4+Helsrk8eCi5TJYM5SqAQiKl
         r62TESIdp1q5At/JKFerAg+8QsP4oDwZwdtKRu2Zj71Qv/9oxyc48CViYcWI3VLTm4UR
         ObqYtKAMmhQrrrapKEa7tyU4M6q4ZtQGVTIh00nagcNisymJ77KYqLiIRm0hj4STjVSP
         VYMBTL+IlNWY9DheG5hDivXVpUf574YVPgVWqNUAMqnDMV/SciGtMTk4QUwd9E/kqdAv
         VcPqMapg+10+ajWSxGvV9xDoKuA1aOv4Gt/22yxAe6O2+F7MkPEOs130doV+60oKauE+
         h7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058830; x=1700663630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E691cqJfsqH+4jSY4gnfdIU7rI78N7x762/MRRyf3VI=;
        b=D+HOpXYrUtVbm39v/2qs5Xz4LPIQW+RG8Wsn6NlyprhYIdMlSEIKZJriCuPKHJSQT1
         et6VuoFSSatNb2ekgUdVy6T14/UbyGDvkGX5f+UDCjF5n2qyg/5XVPqn/3IKtL+sjUB3
         CT0sQ3QbtAwe6ca8M3JeEusuwSPoPWefVviaYDpJcyVLSIjRwYjvtv52uxVzTSuRW/+u
         ZJHNpLKjlBQ5A2zwrWsAx2mcQRA+1/XMP7gCK9sPt3lkbO/4Xux2U5htnw1MvOeiQ/m1
         VoGn1fFHVu1yuvXdthqRGnuT50WPLvFBYGYA/91iSul8e7U8mXcZaBLpHJEG3T0pSobR
         1L6Q==
X-Gm-Message-State: AOJu0Yx83tBVFbFsJI28caohTXroGTN5UH3Bj07CJbljeo3d9Pch4j3U
	NVhbvhxiwnkiIxioxzEeIRtQxa3Ymk4=
X-Google-Smtp-Source: AGHT+IHFk2ngDEoaUYi650Fud9eHQe2PyAOA8cNJlw6qkwoAk+wwd28+ugyYmLxSWk+DFTbnPr3UQg==
X-Received: by 2002:a2e:7811:0:b0:2c5:1e70:7d30 with SMTP id t17-20020a2e7811000000b002c51e707d30mr4488690ljc.30.1700058830434;
        Wed, 15 Nov 2023 06:33:50 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:33:48 -0800 (PST)
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
Subject: [PATCH v7 04/14] replay: die() instead of failing assert()
Date: Wed, 15 Nov 2023 15:33:17 +0100
Message-ID: <20231115143327.2441397-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231115143327.2441397-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
 <20231115143327.2441397-1-christian.couder@gmail.com>
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
index afabb844d3..32dbaaf028 100644
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
2.43.0.rc1.15.g29556bcc86

