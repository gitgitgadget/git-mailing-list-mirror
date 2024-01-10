Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4293482F9
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Txsk5EKT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5336986cso53386135e9.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 04:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704891258; x=1705496058; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=njE0pBCOI7Y2xdiyYyyoUolKR3lOnpIfm0SuL2OJ9FM=;
        b=Txsk5EKTKHvrqzvsw27oR0YngUhE/0wQ2o7H3EM0MLjadzv8cHbCkxL8hqpCDaqFUo
         RiU6YTiddkK/rUy/q10TLGzRP3s+CeCNUADspBgxjkEy5q7KvlAXPuos6RiaQY0c2/LL
         jQkNIfnQf/s94nDasjwsVcL2VQdqUnjNzK9hwu0XNOTWy9oDBUI+47GFHC7XwRove9ed
         NgbehyZBdtmyuizfdFsS5eHzBwC5G2uPtO9NMt264sQD1vcO4/jDmAFSmo6549OLQAU2
         d4J1559qfsQUbwdW+SHItY1ZGwZYMdxQJpiLZfmbJCKD4AV+bmMae/cN8SxROzt/4zs8
         wwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704891258; x=1705496058;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njE0pBCOI7Y2xdiyYyyoUolKR3lOnpIfm0SuL2OJ9FM=;
        b=oiRuSTG3eHzYU+ES5DQDTBuv+eVeeV+YRuzBOpDw4SlEYmphpKZJo1sQ8oPebXq+j8
         FM/xBExOZG6ZZTG5E98mxwvssSUzUrDTNPSG08ydhY510Q1aP5B/WN+Q+bTkvrc8B4ek
         sSPi2dmnpT+KKyG+Lv/AehXGAogbZeXI7NkxGo7I6Wkvxok/z0t6ym4b85yu23s6gL4B
         wDLfqJ5JJSyi4O46umceVRqJVUnv/qG4PE5+ogX9st7vUhIZTolebGty9jc6vnQd8rTP
         rW7rA02ehgEAV3OuysMMR1jd2S4NShv7TNy+zmHz/MMqe0thq3Om+/s8J3ZDFidrK5zQ
         HmNQ==
X-Gm-Message-State: AOJu0YxgKhhPm4Xwicf15qHXVLhYHVgJU/PHjj9X2ZHwNeOe+iwiKggr
	ngDaFLLZply2ujHX/pZetjYSp8X6OoY=
X-Google-Smtp-Source: AGHT+IG95o2Dw9KCAi5l0aN0IPK4TbVc/YzyEGFObedQebxSxO6kxIBe1i/1/TwVGbFrNzbMBq46iA==
X-Received: by 2002:a05:600c:35cc:b0:40d:fc98:b936 with SMTP id r12-20020a05600c35cc00b0040dfc98b936mr494483wmq.126.1704891258313;
        Wed, 10 Jan 2024 04:54:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4-20020a05600c474400b0040d5ae2906esm2115383wmo.30.2024.01.10.04.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 04:54:18 -0800 (PST)
Message-ID: <pull.1636.git.1704891257544.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 12:54:17 +0000
Subject: [PATCH] t4129: prevent loss of exit code due to the use of pipes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

Piping the output of git commands like git-ls-files to another
command (grep in this case) hides the exit code returned by
these commands. Prevent this by storing the output of git-ls-files
to a temporary file and then "grep-ping" from that file. Replace
grep with test_grep as the latter is more verbose when it fails.

Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    t4129: prevent loss of exit code due to the use of pipes

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1636%2FChand-ra%2Ftest_pipe-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1636/Chand-ra/test_pipe-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1636

 t/t4129-apply-samemode.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index e7a7295f1b6..ffabeafa213 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -41,7 +41,8 @@ test_expect_success FILEMODE 'same mode (index only)' '
 	chmod +x file &&
 	git add file &&
 	git apply --cached patch-0.txt &&
-	git ls-files -s file | grep "^100755"
+	git ls-files -s file > ls-files-output &&
+	test_grep "^100755" ls-files-output
 '
 
 test_expect_success FILEMODE 'mode update (no index)' '
@@ -60,7 +61,8 @@ test_expect_success FILEMODE 'mode update (with index)' '
 test_expect_success FILEMODE 'mode update (index only)' '
 	git reset --hard &&
 	git apply --cached patch-1.txt &&
-	git ls-files -s file | grep "^100755"
+	git ls-files -s file > ls-files-output &&
+	test_grep "^100755" ls-files-output
 '
 
 test_expect_success FILEMODE 'empty mode is rejected' '

base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
-- 
gitgitgadget
