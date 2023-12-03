Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llfk56Ls"
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23100119
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 21:57:10 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3333127685bso1809120f8f.0
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 21:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701583028; x=1702187828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyzT933Lv+I2eJ6KcLdgufUGswSUXXJts+i+4YrqxEk=;
        b=llfk56LszCUH5/sP6RGMooo+CCyRelVnk5VvqH7e6Uetq2lVCz7pp4r8OnnifCkcE9
         udiads3HS4pc4g2cgOWxtsZaQGVPKGBodS9ui8SntOPjuERQNQyxaPEcVDV4JQ7cSKr8
         c7Sv5vz7zlFOaQ5jH0oq1v/W1e+zvjcCYwzX1pA1BHlJT+FFDXPVtkNLKCQMcz0Db50N
         MSG8hR09kuhAbL2tEKBg8kLx27fVb5I8gJYqfyMnHLEkbIAu1oKnfBsEdkhJ4af0mRjx
         p62mRPU3S9Ws03OVRIouwBIkKHX3QmdmyoRVInTW85eo89N2IsTGxViJj+4NNZfmVvdY
         7DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701583028; x=1702187828;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyzT933Lv+I2eJ6KcLdgufUGswSUXXJts+i+4YrqxEk=;
        b=iDfmitVU5G2dGnghDXWiwa0Th3pPh8uab1QrBg1sHblJDPfTF3XbmRbKdCHmFZFUVd
         DtfyJ04l/U1k/i8PlL+CkW8mILN4ZDVF62HBgi8pWOBKTgPyMAFvi6cRVWiLMboiJCTK
         dPbfFuIKL3AKXDjkcqV4LrQNVWzr7+rcsXXEbn6ZThcnPYy10N8AOGv3v3QwxC+5pDUo
         2Cb8Mx3VGj3Gswx1614bOavb/HmnPd/pr4QHAMHUtYhlqfn1dAD/WaqDaDF6TR87P84q
         l8MPnLjn701fgcZVPsx1MWPpatwmbpnN27SZaIgxKta7de+cyDC/AsqQ0aMkO6O6cnm8
         AQgQ==
X-Gm-Message-State: AOJu0Yz6v21LvnMFnf14WAIBMJeSovOdVvz8Gp3ra2+T0ToHS8hnIxcQ
	dOgPvBWgNdiWCAgRjADHuetw1GIPbJo=
X-Google-Smtp-Source: AGHT+IE3ioZLP1+M9OxYsCi/ceH+R98Dr7NrbAtOpK/VKwhMsYKKziLYLNuSnxqYKwdV/rJHTvzpIg==
X-Received: by 2002:adf:f402:0:b0:333:2fd2:3bcb with SMTP id g2-20020adff402000000b003332fd23bcbmr1626754wro.132.1701583027668;
        Sat, 02 Dec 2023 21:57:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16-20020a5d6550000000b0033340c12012sm1414633wrv.3.2023.12.02.21.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 21:57:07 -0800 (PST)
Message-ID: <1cbbcd9097c96b7646fb0c756c3964413f2a021f.1701583024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>
References: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
	<pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 05:57:03 +0000
Subject: [PATCH v3 3/4] completion: avoid misleading completions in cone mode
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

The "set" and "add" subcommands of "sparse-checkout", when in cone mode,
should only complete on directories.  For bash_completion in general,
when no completions are returned for any subcommands, it will often fall
back to standard completion of files and directories as a substitute.
That is not helpful here.  Since we have already looked for all valid
completions, if none are found then falling back to standard bash file
and directory completion is at best actively misleading.  In fact, there
are three different ways it can be actively misleading.  Add a long
comment in the code about how that fallback behavior can deceive, and
disable the fallback by returning a fake result as the sole completion.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-completion.bash | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7aa66c19ede..c614e5d4f07 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3090,6 +3090,26 @@ __gitcomp_directories ()
 		# No possible further completions any deeper, so assume we're at
 		# a leaf directory and just consider it complete
 		__gitcomp_direct_append "$cur "
+	elif [[ $_found == 0 ]]; then
+		# No possible completions found.  Avoid falling back to
+		# bash's default file and directory completion, because all
+		# valid completions have already been searched and the
+		# fallbacks can do nothing but mislead.  In fact, they can
+		# mislead in three different ways:
+		#    1) Fallback file completion makes no sense when asking
+		#       for directory completions, as this function does.
+		#    2) Fallback directory completion is bad because
+		#       e.g. "/pro" is invalid and should NOT complete to
+		#       "/proc".
+		#    3) Fallback file/directory completion only completes
+		#       on paths that exist in the current working tree,
+		#       i.e. which are *already* part of their
+		#       sparse-checkout.  Thus, normal file and directory
+		#       completion is always useless for "git
+		#       sparse-checkout add" and is also probelmatic for
+		#       "git sparse-checkout set" unless using it to
+		#       strictly narrow the checkout.
+		COMPREPLY=( "" )
 	fi
 }
 
-- 
gitgitgadget

