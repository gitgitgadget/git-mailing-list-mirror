Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8wpdNgp"
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5844510D
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 23:51:30 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332e58d4219so1689709f8f.0
        for <git@vger.kernel.org>; Sat, 25 Nov 2023 23:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700985088; x=1701589888; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pS03YAChelK3yTZmwzMX7JJJjo8RQMbIcri5tSEED6Y=;
        b=G8wpdNgp2sv1e8Kou+jexDahZEAtZwQJticY+UtSC2I5mbA4TYl7pL66j8z0hZ7TW5
         z+GDjZo3OPuodsDBCPS8UcysW6IWSEx8LsAyGlseynvNogOembBgnDc4kw9LfMAlmXJG
         kh9tO37semm6xvY5HiMFJOz3zwMEJzexjeavr3wt+70KvHgMLCdKQCbJB6X9bJUFLs2+
         UREik3ptXDEJAmSWVHfpFawNKdU/QyBmG61k0FmnpWSQaLin+mp+aX7cRIjlerwNVJZa
         4E4QKLxIkUbojAHNE7IojJDyPu/P225Hw801514VGq0vnc8bm0DaBj0ve524/uW0VvrH
         kIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700985088; x=1701589888;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pS03YAChelK3yTZmwzMX7JJJjo8RQMbIcri5tSEED6Y=;
        b=Az9pVpXwLI4I5HaIVUi+mN3EwMlpvCTNYyRBiFC1u/HmsZIjJr/Q+Uw0BmdNR++SE5
         +3uk4T+ee/RNVQKySVp8DIIycoKDQl2iK3vp2ybpvP/vK6qmI4Kw+1csRdwof2Nh8NqV
         IdQ26QN712L4DGomLRbBlzeCdKHTPVb05fTCL4SDpItxSNrPRXaC/KeN1sNGu8cT+fa5
         M2AdM/CYh3MrPQydyQZe8x7KbfzXa0EcYJeS5KZPPI+utA7vixjlsXd3e9igMEr4g7Mv
         HgPop56xbCkw6CToTzp783uDkJ/Wq6IKA8lkONEryOZebHD48NJ617/UdmHdkZwgOl8I
         mlzw==
X-Gm-Message-State: AOJu0YwfQQTrt3tYNKtuGRzhbygDdCw86J9CXRWq+Xfa8gv+Ir9FR05q
	YQvMZvjJbwTuXRMcquiu/H/J0W6/kgM=
X-Google-Smtp-Source: AGHT+IFO9AXSTov0Vmh/7yph48f5CCeZLvWSk5A5XtCwq3wmNFqIslNBfpxOWghm17HblSJ2PuAolA==
X-Received: by 2002:adf:ed4f:0:b0:332:fe7e:2a30 with SMTP id u15-20020adfed4f000000b00332fe7e2a30mr300570wro.14.1700985087818;
        Sat, 25 Nov 2023 23:51:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d674a000000b00332eef1ca7asm3917965wrw.80.2023.11.25.23.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 23:51:27 -0800 (PST)
Message-ID: <pull.1349.v2.git.1700985086.gitgitgadget@gmail.com>
In-Reply-To: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
References: <pull.1349.git.1700761448.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Nov 2023 07:51:22 +0000
Subject: [PATCH v2 0/4] Sparse checkout completion fixes
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
    Elijah Newren <newren@gmail.com>

This fixes a few issues with tab completion for the sparse-checkout command,
specifically with the "add" and "set" subcommands.

As noted in v1, the 4th patch implements a somewhat suboptimal solution that
at least improves the situation, while also documenting with a code comment
a much more involved alternative solution that we could consider in the
future.

Changes since v1:

 * Use __git wrapper function to squelch errors, as suggested by SZEDER
   Gábor
 * note that we could use the index or HEAD for the more involved solution
   in patch 4.

[1] https://lore.kernel.org/git/xmqqv8yjz5us.fsf@gitster.g/

Elijah Newren (4):
  completion: squelch stray errors in sparse-checkout completion
  completion: fix logic for determining whether cone mode is active
  completion: avoid misleading completions in cone mode
  completion: avoid user confusion in non-cone mode

 contrib/completion/git-completion.bash | 96 +++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 3 deletions(-)


base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1349%2Fnewren%2Fsparse-checkout-completion-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1349/newren/sparse-checkout-completion-fixes-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1349

Range-diff vs v1:

 1:  591c7b8d73b ! 1:  97e20e3b99d completion: squelch stray errors in sparse-checkout completion
     @@ Commit message
              fatal: ../: '../' is outside repository at '/home/newren/floss/git'
      
          is written to stderr, which munges the users view of their own command.
     -    Squelch such messages.
     +    Squelch such messages by using the __git() wrapper, designed for this
     +    purpose; see commit e15098a314 (completion: consolidate silencing errors
     +    from git commands, 2017-02-03) for more on the wrapper.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ contrib/completion/git-completion.bash: __gitcomp_directories ()
       			_found=1
       		fi
      -	done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir)
     -+	done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir 2>/dev/null)
     ++	done < <(__git ls-tree -z -d --name-only HEAD $_tmp_dir)
       
       	if [[ $_found == 0 ]] && [[ "$cur" =~ /$ ]]; then
       		# No possible further completions any deeper, so assume we're at
 2:  a15fb054579 = 2:  212ba35ed46 completion: fix logic for determining whether cone mode is active
 3:  e8cc5c54e60 = 3:  1cbbcd9097c completion: avoid misleading completions in cone mode
 4:  fe8669a3f4f ! 4:  604f21dc827 completion: avoid user confusion in non-cone mode
     @@ contrib/completion/git-completion.bash: _git_sparse_checkout ()
      +			# completion function which:
      +			#
      +			#     1. Provides completions based on
     -+			#        files/directories that exist in HEAD, not
     -+			#        just those currently present in the working
     -+			#        tree.  Bash's default file and directory
     -+			#        completion is totally useless for "git
     -+			#        sparse-checkout add" because of this.  It is
     -+			#        likewise problematic for "git
     -+			#        sparse-checkout set" except in those subset
     -+			#        of cases when trying to narrow scope to a
     -+			#        strict subset of what you already have
     -+			#        checked out.
     ++			#        files/directories that exist in HEAD (or in
     ++			#        the index since sparse-index isn't possible
     ++			#        in non-cone mode), not just those currently
     ++			#        present in the working tree.  Bash's
     ++			#        default file and directory completion is
     ++			#        totally useless for "git sparse-checkout
     ++			#        add" because of this.  It is likewise
     ++			#        problematic for "git sparse-checkout set"
     ++			#        except in those subset of cases when trying
     ++			#        to narrow scope to a strict subset of what
     ++			#        you already have checked out.
      +			#
      +			#     2. Always provides file/directory completions
      +			#        with a prepended leading '/', so that

-- 
gitgitgadget
