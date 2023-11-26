Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIGs+puS"
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958D7111
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 23:51:32 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3316c6e299eso2172436f8f.1
        for <git@vger.kernel.org>; Sat, 25 Nov 2023 23:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700985090; x=1701589890; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyzT933Lv+I2eJ6KcLdgufUGswSUXXJts+i+4YrqxEk=;
        b=EIGs+puSHfbBoYoub2e0NLwXDe7al355eyx8FqGTnfHBa+qVop8pvVJo5ut5S4suzi
         kB0pnjOl3HJ1V0OmZeQa7ttgxPOgs25Vaz6iHXWU4/5uUgy0Bg4mu31F8bUBo4owzSTa
         4Uz6VAKIkMy3zlIr6Eb4ln5ph2WJfcBtLb/ND0naBTpbHDKzQyfwZADoQEwqcg49zGIH
         ceTlOz4UAfzjsdqOM6fMOy+Gg9IMb2oV0Cuisw4c3H3JHag50VfzpR0vatYKk5o+/PPT
         2PsuV2T5BnlfIX04PJJKK2Vb5CgzP4UuRwVa/v2u3ukZbyJuRGk5ViFJfH4yRI1/NTRP
         ytLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700985090; x=1701589890;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyzT933Lv+I2eJ6KcLdgufUGswSUXXJts+i+4YrqxEk=;
        b=kuDJPa2tu3XXjwETPCNqrM7YXc44Mco6AZFCDEBjh+MoZMOT4HwvrfywzVhRbvNt9W
         vD44KizuVXduGcemR6GIz4RcawIdhxAuECOokOX53LW2Tbh87P7gSBGARBnKmi9vhqLk
         ujgq4rQfSub18VmUTad+HEN2mrcYvCS1xp/bPkkEv50DAEqJgTGnYVgR68wSs7UHskFs
         AMNRmxRLAWrYBfeXAcwst0Zb9vzAKq92qPqrR60stPBX83MHOKmQdbSwt1WkUJRwf1Ln
         M9XnUncUXRS30loxXh67i5jzZQdBKj6Ry/7lXEXhesqBJ/iK3ffC9OGg7y6QkhveUdA+
         boBg==
X-Gm-Message-State: AOJu0YyFUkUL5BlT3nIVz8XOXFI6Gu/6tc46t8g1tflCnPavD0HsPSVU
	T285DMCpQk1x1k1TDCjyWSTW6n8nDlI=
X-Google-Smtp-Source: AGHT+IGRsniUWVP+Gu6QYJ/0V7pyijV0cSq7EcS1ZPpGTMKQ51NchG+EjD3/awkjSgbk67Inh5iYfg==
X-Received: by 2002:adf:fc52:0:b0:332:c9ba:f29c with SMTP id e18-20020adffc52000000b00332c9baf29cmr6112656wrs.58.1700985090380;
        Sat, 25 Nov 2023 23:51:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16-20020adffc50000000b00332cb561c8dsm8580894wrs.112.2023.11.25.23.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 23:51:30 -0800 (PST)
Message-ID: <1cbbcd9097c96b7646fb0c756c3964413f2a021f.1700985086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
	<pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Nov 2023 07:51:25 +0000
Subject: [PATCH v2 3/4] completion: avoid misleading completions in cone mode
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

