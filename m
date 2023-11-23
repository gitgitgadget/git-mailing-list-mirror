Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7JtCEMc"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC61B10CB
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:44:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4083f61322fso8386415e9.1
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 09:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700761452; x=1701366252; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gk91LFUa4fhLzX3tW1H9Cp25C+W2Wc+wvRl7tqLimVQ=;
        b=I7JtCEMcpPeBAs7Jt1oDYTWRJ3LJBq+4XwAdiPYWVGJ5NOi2dn3uO+ChcZzeoUJMrO
         bRB56lfBgLYJTJofjZFBESj3bE9Fyn8HDMlRpvqicAeWZBY0Ji5T0Cjne8otISqimZd1
         EnSs3r2ETBHXhdwgtCZAEGmJAK8hmmWqLDqu480yleUa+mpEGoBQ++vENcyFNuVm+LS6
         W+BLTfC+qFOrMY2SXNPeuz0cWl2u6Pu+NNTrn0ZBPvNJ6aTsyBxowM09Iv3WWJZGaf6O
         jM58toLOEwFN74uEqaQgBVuiN/LGcYAakbnv7cYEdNVRN3Ujb5xEI8cZCLsLhku+oI4m
         LFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700761452; x=1701366252;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gk91LFUa4fhLzX3tW1H9Cp25C+W2Wc+wvRl7tqLimVQ=;
        b=DUATdEMzxlRuFFkebzZALl7EqbUK7htgABAhdh5U/o/1/jyyvnExa6VYGp2Hh1CYdI
         Nd0PFtMnJqX3h0mRddCEHMaNutjJD7xDZUM+U5jDDnBguTSZl1ii+DDWEsBh211hQbJi
         iF6k94olSY94K52CdPj4wZ7od/ayCKN8NulSSa7XDCG8o1RgtExlFgGQMgXUASBiCD5j
         y9eTIRsH6aTxTL5CYfrEu0kqX9cGD0PZos/5EVTcEvUy2rn5rWY+MoMkDQ58AKK8TicV
         PI1F4K1uPkOX7xw3NIajWlLlY9zRPCDXsJ2sMdDvfm0YGi9oU4uyG1JuuoKJmetEzbC7
         849g==
X-Gm-Message-State: AOJu0YxFgIRQVK3wBSZAOmHhcb2ChRPSacFDY8oFyyzB2d8Zfshf/W7D
	30foGJ8r19fKLS1/Rj2pSbButEdgRmk=
X-Google-Smtp-Source: AGHT+IF8L2IMV1iTuLU5tCWS9jYx1JkLw54r9empUxHFn2/65h/uhPfCumeXelDgVzNdFvfctH7kTQ==
X-Received: by 2002:adf:f88c:0:b0:32f:e1a2:525d with SMTP id u12-20020adff88c000000b0032fe1a2525dmr117069wrp.57.1700761451747;
        Thu, 23 Nov 2023 09:44:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dm16-20020a0560000bd000b0032d09f7a713sm2258101wrb.18.2023.11.23.09.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 09:44:10 -0800 (PST)
Message-ID: <e8cc5c54e60c3729e133fc68dea4ec8686fdbc63.1700761448.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 23 Nov 2023 17:44:07 +0000
Subject: [PATCH 3/4] completion: avoid misleading completions in cone mode
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
index 42e9e0cba8f..136faeca1e9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3020,6 +3020,26 @@ __gitcomp_directories ()
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

