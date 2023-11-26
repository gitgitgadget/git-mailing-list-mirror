Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qui1Sb5O"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC39F110
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 23:51:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083f613275so25073395e9.2
        for <git@vger.kernel.org>; Sat, 25 Nov 2023 23:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700985088; x=1701589888; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlKqH4Ex5Hz0DcVmbkbwp1b+sjR9qljU7Rkjy86OiGo=;
        b=Qui1Sb5OeYWKy3eJ7Yacx5keoJm1EjsenvilD5PmUCU8eC1RFBRQJbpZdhuqGkZ5k4
         +vwDJ6TYczeYJXuxlJpSYGgNWwRYH8DfRDs1yxcY+6zOxPjidE4snZBOg9LnTBQ8YL/4
         7fpYI26aruKxlKtT58XKy5JLIpxZPQAFIBMprGQkeHp0afWzzS+RQJL9sRL+wsTPhzJc
         KE6MZP2XbQ4SGG1y4kbZBBZJm7ddyKLaG/VQUPKd+CYr2HOS5HiYlDhOgZgsVOWBvpSb
         yz6YBWWAWTQN76clbKPj2bWY7/fUmezQShjCAh1w/mrILPUlzXcrBl5aF2GJqAnsiDu1
         tsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700985088; x=1701589888;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlKqH4Ex5Hz0DcVmbkbwp1b+sjR9qljU7Rkjy86OiGo=;
        b=mpnPE+hNi0idPIb9DUcTvwTPA3vP2a5E4T5QFCOSb4hG/EkUO6bbW45nf3dxi3rM8j
         xTr8o0PwWRyEiv4jsf4a9rYgwBRwUeDOwLw9e7eyM2DQBM0G+3Vlq99bCMmMw1zdPqY2
         NlzKC4ktdW6O4cJf2acCTwx4ERQ0cDYrK/u4ChTKeQ+5C/LGnO2LSG2sXVsLcYl8gnAn
         sjA5FnmQSvLXrxGM0Z5KY0snOFePPIKpLutbBZhx3QpBeyBtGeHHeAkT2KMUSmmcCRdF
         3MixWB4HZfgPD02Ratpt+MGJehrCyI4hgGrwBHtRYcLbMZvUv4O0T8diUYVi2b2IvRvD
         IAoA==
X-Gm-Message-State: AOJu0YxPPDjZxg1uNhX+QM2l26nzOnS/9rCr895lERon3OnEWKWaYJ3y
	gCSNVi2y9GkcxaM9lmY5KkmfUeVuASs=
X-Google-Smtp-Source: AGHT+IFEHjuD4T0Mq+cQRA4L4+IoEq/kaMxxDB3CsHkyMDNqcBdAOwRWu6CRvH3G7Bnf3Rc3hDDg3w==
X-Received: by 2002:a05:600c:1987:b0:409:1841:3f42 with SMTP id t7-20020a05600c198700b0040918413f42mr6075979wmq.13.1700985088266;
        Sat, 25 Nov 2023 23:51:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b0040b3d33ab55sm5527653wmn.47.2023.11.25.23.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 23:51:28 -0800 (PST)
Message-ID: <97e20e3b99d8261815450e8a7c137938caaf5a6e.1700985086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
	<pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Nov 2023 07:51:23 +0000
Subject: [PATCH v2 1/4] completion: squelch stray errors in sparse-checkout
 completion
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
Cc: Elijah Newren <newren@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

If, in the root of a project, one types

    git sparse-checkout set --cone ../<TAB>

then an error message of the form

    fatal: ../: '../' is outside repository at '/home/newren/floss/git'

is written to stderr, which munges the users view of their own command.
Squelch such messages by using the __git() wrapper, designed for this
purpose; see commit e15098a314 (completion: consolidate silencing errors
from git commands, 2017-02-03) for more on the wrapper.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 13a39ebd2e7..b8661701718 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3084,7 +3084,7 @@ __gitcomp_directories ()
 			COMPREPLY+=("$c/")
 			_found=1
 		fi
-	done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir)
+	done < <(__git ls-tree -z -d --name-only HEAD $_tmp_dir)
 
 	if [[ $_found == 0 ]] && [[ "$cur" =~ /$ ]]; then
 		# No possible further completions any deeper, so assume we're at
-- 
gitgitgadget

