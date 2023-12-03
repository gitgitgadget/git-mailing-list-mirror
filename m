Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKnpva02"
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1AE106
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 21:57:08 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3332efd75c9so2049705f8f.2
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 21:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701583026; x=1702187826; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlKqH4Ex5Hz0DcVmbkbwp1b+sjR9qljU7Rkjy86OiGo=;
        b=AKnpva02ZHvr94gAA11r8By1cLVndx9Cn8lvZgIGj7YaDkbEwcKEMnZf4IIXlIeE0S
         8AJCp932yjbAmGUn/qm4YXXJEcV3mJqMIPeC/GLPxufUaQmcQtgJ+H4Y/QDC2+3a6dJu
         VHjxdc/QbrOOvjmEFd5nS8jVJEnMzSvhi8c5AIQnYSwTL9KSGLpSIYf2e1PN3SO1TGbl
         4PNFNZL61AztGKPb4w7HDep0qWmE4iAbyYH8SipPnhYzTw/Fni5JDKufOXieW3tXcwi9
         FTzmUtwwJ/eQGfIU2tTP1ROJITqUP64Nl4kd6lyEy12rdoabtAgq6AIuZx+wqMbDzJ/J
         9s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701583026; x=1702187826;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlKqH4Ex5Hz0DcVmbkbwp1b+sjR9qljU7Rkjy86OiGo=;
        b=MyiJD0y/4tVKOVUANgmDQ56WobeVw3T1o7zvffu7Ps0pneSYl6ao+r7fm4Z1C9A6Fv
         wfA+LWUN2veGXetyHUCGgRj6JF9vwzGdD+QdUVnGhL0/O8kItzTkzR0kRke9TOJ7JDCq
         jzklhWD/3CV4fS+uGyVQsjUkge4PcWHqEY2zu1YOQ1QOVMh5U9Uq1Kc1RJh+MagEW/xQ
         ba388yx2ZpP7BTKuuFOU6oHnAXhULrhZOUzXW1CCORIRUpGZhc5PhP+5IssU2qHbgpF5
         VO1przLdf0bY7fNzWpFjmROaMA5mOxmlmyFJyDoCLlSg4Q3tuewkFk6wZSLyC/uTLVBM
         pKyw==
X-Gm-Message-State: AOJu0Yx90axRgpr7PtN2Nmidksh/s1KzsQNuZzX+/QBGPQJVFHjOgnCr
	aV54o0hxzuVwQZIq/5Dbd867mhCLvbg=
X-Google-Smtp-Source: AGHT+IFlSHziKOctle1n477Fqs+7Se7vIWWt7gPVh/hWqEN14CMjau06/4NJgMQebn1+t0XsTgMbpQ==
X-Received: by 2002:adf:b608:0:b0:333:3802:9e07 with SMTP id f8-20020adfb608000000b0033338029e07mr553087wre.136.1701583026030;
        Sat, 02 Dec 2023 21:57:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11-20020adfb60b000000b00333415f1c80sm1123611wre.70.2023.12.02.21.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 21:57:05 -0800 (PST)
Message-ID: <97e20e3b99d8261815450e8a7c137938caaf5a6e.1701583024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>
References: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
	<pull.1349.v3.git.1701583024.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 05:57:01 +0000
Subject: [PATCH v3 1/4] completion: squelch stray errors in sparse-checkout
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

