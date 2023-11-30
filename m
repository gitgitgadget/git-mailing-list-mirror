Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHcUxCJy"
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63701197
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 09:37:11 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso1300842a12.2
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 09:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701365829; x=1701970629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll9aUAXk2aRm/C025KdPWLPd3yDTxT6JJTLTAuCYD4k=;
        b=JHcUxCJyyZpiSVlM/Perf08i2DMfDb74CSPq3x9LRd6wkJZrNm3hye/B36JIuHk9ar
         Khsi8iM2p7orV+wHCSMt7sMBBTZrCZBBQc2kWq/d3eXrhD1l8O2e86ushQL6djDE/EGS
         v4kdejzunTM3Ac8LAYAcC3YulpwI1aZ+aJb/XOWmahF2aolvs/5ckmVoMXDtRmIp6Bfx
         SIKDxveeW1p2p+dFpd3j14tBJf7dF5JSB2SN1IMpwn5qPSU5Jyrf+dEfOIoKtUGqVhMk
         mtBqA+Ub9lyDJpverPvgnlkDvfBrjm5x6VWfKnyl1cenffrm3adHQ44OoiwUzLFoxVWT
         NYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365829; x=1701970629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll9aUAXk2aRm/C025KdPWLPd3yDTxT6JJTLTAuCYD4k=;
        b=hZyiJgEExiFD34Khwf6kEQ3yF3L7ua5ghhnnvbVJvMRf9KsBlODKzFICU7gfmCGvz1
         jo5nAUAikG3QoP+/bnuJZKP/jk5uaveQRl7CjPFKzoxj1p3jPmal0CteXDr+7DwDd5VD
         KK/jA8sM5hGgnM14pz/kikvQ1w/eNro/V5yx6Z/PTB9/zhDP3bL5DMfNyfuoyzQ49qjP
         hJWlEiNgpOcsRLUHUoQasulKzAVsUt070OtiB4SYBoUcuNgGXtNwOoiPMPDC74t31Eva
         DGyT71I0pexB3SzVKHdXiErQkexkgjxbPM4Ia5UxZTqZXXeExAruhltP+LUFApzId3ze
         OGbg==
X-Gm-Message-State: AOJu0YzuNyn68G+lMXIbF/1KzLxpDTMjq4Dpm5jwky9ojc85G9AAcHGl
	Vtx0edNprvETCs4333uT+epRrp85UI+FxQ==
X-Google-Smtp-Source: AGHT+IFe103fAPGtBfEQ3Kg5mO1ICteuecCv/oadcOAic11ziW8TPWMoRgnCGVt1dkoOLHwjzG0dHw==
X-Received: by 2002:a05:6512:3b2:b0:509:5d4b:742f with SMTP id v18-20020a05651203b200b005095d4b742fmr80760lfp.20.1701363320429;
        Thu, 30 Nov 2023 08:55:20 -0800 (PST)
Received: from localhost.localdomain ([102.244.155.37])
        by smtp.gmail.com with ESMTPSA id a20-20020a50ff14000000b0054b1360dd03sm711671edu.58.2023.11.30.08.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:55:20 -0800 (PST)
From: Achu Luma <ach.lumap@gmail.com>
To: git@vger.kernel.org
Cc: Achu Luma <ach.lumap@gmail.com>
Subject: [PATCH v2 1/1] t2400: avoid using pipes
Date: Thu, 30 Nov 2023 17:54:29 +0100
Message-ID: <20231130165429.2595-2-ach.lumap@gmail.com>
X-Mailer: git-send-email 2.42.0.windows.2
In-Reply-To: <20231130165429.2595-1-ach.lumap@gmail.com>
References: <20231003174853.1732-1-ach.lumap@gmail.com>
 <20231130165429.2595-1-ach.lumap@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit code of the preceding command in a pipe is disregarded,
so it's advisable to refrain from relying on it. Instead, by
saving the output of a Git command to a file, we gain the
ability to examine the exit codes of both commands separately.

Signed-off-by: achluma <ach.lumap@gmail.com>
---
 t/t2400-worktree-add.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index df4aff7825..7ead05bb98 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -468,7 +468,8 @@ test_expect_success 'put a worktree under rebase' '
 		cd under-rebase &&
 		set_fake_editor &&
 		FAKE_LINES="edit 1" git rebase -i HEAD^ &&
-		git worktree list | grep "under-rebase.*detached HEAD"
+		git worktree list >actual && 
+		grep "under-rebase.*detached HEAD" actual
 	)
 '
 
@@ -509,7 +510,8 @@ test_expect_success 'checkout a branch under bisect' '
 		git bisect start &&
 		git bisect bad &&
 		git bisect good HEAD~2 &&
-		git worktree list | grep "under-bisect.*detached HEAD" &&
+		git worktree list >actual && 
+		grep "under-bisect.*detached HEAD" actual &&
 		test_must_fail git worktree add new-bisect under-bisect &&
 		! test -d new-bisect
 	)
-- 
2.41.0.windows.1

