Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F322DF5D
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 04:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8dUk04l"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e6bf323b0so2181425e9.2
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 20:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705119975; x=1705724775; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqXnT1z08yxRTcrKXxhMr4Qt9c1xQmi0McaM4qGXbTk=;
        b=j8dUk04ldilAPMQk8DjzY8wPjn0HOXFPgS24BFcRph4wiI0oUOO6zUTyeoERizJieE
         B1FJ3bDT8fAbCD/GHkJs1keO54vM5eow69lRMK4NHOhAlSAw2SYKkf2hbuJzkQjOaAZo
         956hSBhxs7A8kB3aNoOitbXUGoJv7EQoIhIfvhcZBke5OLcF7J2b7i6acMm2Lhlbnkvj
         lN+GEW8sO/7JhyA8gwRVAAPC6cefyK0cS7CTYP3mIPjsuGUKJSxOkvNDIFWXSq1hF+4f
         GG5Hd2SytSPBDB839U9yV41rvhSMqXq6U1AU8GWtjfd24vYff6EgTapTxZzh4LowJqow
         3nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705119975; x=1705724775;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqXnT1z08yxRTcrKXxhMr4Qt9c1xQmi0McaM4qGXbTk=;
        b=WDR47R/qTAxJmdgW8CUltScDAKleuWJrn3A5Bov1SEed/Kp1oIHDxzqg6TrXKlvd/y
         QwnTXv6Os/xEYyjawkxIwNOQhoQSvFEOvOG1K1bB3qcqNnvWCgynYD3MSMs7auZg9X+V
         cfoprmzly56uL4VLnSCufDJOV3d7Nlezq7LPQpsPSpJHEqqHcI1CpkuDVfoHKo+6/EC9
         0Yl9jqYvv3R4tgNLMj2po12/hLUFXBdbAUYtIvp0XAhykabwjFHU+v5wGzTqsW/MhzI8
         cOOddOc8C2TeAIf7qyftszEx7OpdfFqk2euNa2Tx/oaTrRIL2wZArKVbn8TXt8o9iQrJ
         9LMg==
X-Gm-Message-State: AOJu0Yy66uoFX5Zpp6P5aSrQaVPy37fTnm3QfAvjvtw8jhltxKoNbmyV
	apgTSYGwZNyLijIrVy7YK6oRFtfYIf8=
X-Google-Smtp-Source: AGHT+IF1mY4Yk9BwPjwS1yXDGUTNULndmvqW1/H+MzfUaBn1hx95DdO9gncdwcHhV+21e3O217xHCg==
X-Received: by 2002:a7b:c8d5:0:b0:40e:4ded:a87 with SMTP id f21-20020a7bc8d5000000b0040e4ded0a87mr1243963wml.94.1705119974804;
        Fri, 12 Jan 2024 20:26:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay12-20020a05600c1e0c00b0040d802a7619sm11983193wmb.38.2024.01.12.20.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 20:26:14 -0800 (PST)
Message-ID: <pull.1637.v2.git.1705119973690.gitgitgadget@gmail.com>
In-Reply-To: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>
References: <pull.1637.git.1705006074626.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jan 2024 04:26:13 +0000
Subject: [PATCH v2] diffcore-delta: avoid ignoring final 'line' of file
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

hash_chars() would hash lines to integers, and store them in a spanhash,
but cut lines at 64 characters.  Thus, whenever it reached 64 characters
or a newline, it would create a new spanhash.  The problem is, the final
part of the file might not end 64 characters after the previous 'line'
and might not end with a newline.  This could, for example, cause an
85-byte file with 12 lines and only the first character in the file
differing to appear merely 23% similar rather than the expected 97%.
Ensure the last line is included, and add a testcase that would have
caught this problem.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    diffcore-delta: avoid ignoring final 'line' of file
    
    Found while experimenting with converting portions of diffcore-delta to
    Rust.
    
    Changes since v1:
    
     * Removed the unnecessary similarity threshold specification
     * Munged the discovered similarity percentage so we are only checking
       that a rename is detected
     * Fixed up filenames

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1637%2Fnewren%2Ffix-diffcore-final-line-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1637/newren/fix-diffcore-final-line-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1637

Range-diff vs v1:

 1:  f62b22a54c3 ! 1:  e0223bbfeb5 diffcore-delta: avoid ignoring final 'line' of file
     @@ t/t4001-diff-rename.sh: test_expect_success 'basename similarity vs best similar
       '
       
      +test_expect_success 'last line matters too' '
     -+	test_write_lines a 0 1 2 3 4 5 6 7 8 9 >nonewline &&
     -+	printf "git ignores final up to 63 characters if not newline terminated" >>nonewline &&
     -+	git add nonewline &&
     ++	{
     ++		test_write_lines a 0 1 2 3 4 5 6 7 8 9 &&
     ++		printf "git ignores final up to 63 characters if not newline terminated"
     ++	} >no-final-lf &&
     ++	git add no-final-lf &&
      +	git commit -m "original version of file with no final newline" &&
      +
      +	# Change ONLY the first character of the whole file
     -+	test_write_lines b 0 1 2 3 4 5 6 7 8 9 >nonewline &&
     -+	printf "git ignores final up to 63 characters if not newline terminated" >>nonewline &&
     -+	git add nonewline &&
     -+	git mv nonewline still-no-newline &&
     -+	git commit -a -m "rename nonewline -> still-no-newline" &&
     -+	git diff-tree -r -M01 --name-status HEAD^ HEAD >actual &&
     ++	{
     ++		test_write_lines b 0 1 2 3 4 5 6 7 8 9 &&
     ++		printf "git ignores final up to 63 characters if not newline terminated"
     ++	} >no-final-lf &&
     ++	git add no-final-lf &&
     ++	git mv no-final-lf still-absent-final-lf &&
     ++	git commit -a -m "rename no-final-lf -> still-absent-final-lf" &&
     ++	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
     ++	sed -e "s/^R[0-9]*	/R	/" actual >actual.munged &&
      +	cat >expected <<-\EOF &&
     -+	R097	nonewline	still-no-newline
     ++	R	no-final-lf	still-absent-final-lf
      +	EOF
     -+	test_cmp expected actual
     ++	test_cmp expected actual.munged
      +'
      +
       test_done


 diffcore-delta.c       |  4 ++++
 t/t4001-diff-rename.sh | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index c30b56e983b..7136c3dd203 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -159,6 +159,10 @@ static struct spanhash_top *hash_chars(struct repository *r,
 		n = 0;
 		accum1 = accum2 = 0;
 	}
+	if (n > 0) {
+		hashval = (accum1 + accum2 * 0x61) % HASHBASE;
+		hash = add_spanhash(hash, hashval, n);
+	}
 	QSORT(hash->data, (size_t)1ul << hash->alloc_log2, spanhash_cmp);
 	return hash;
 }
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
index 85be1367de6..49c042a38ae 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -286,4 +286,28 @@ test_expect_success 'basename similarity vs best similarity' '
 	test_cmp expected actual
 '
 
+test_expect_success 'last line matters too' '
+	{
+		test_write_lines a 0 1 2 3 4 5 6 7 8 9 &&
+		printf "git ignores final up to 63 characters if not newline terminated"
+	} >no-final-lf &&
+	git add no-final-lf &&
+	git commit -m "original version of file with no final newline" &&
+
+	# Change ONLY the first character of the whole file
+	{
+		test_write_lines b 0 1 2 3 4 5 6 7 8 9 &&
+		printf "git ignores final up to 63 characters if not newline terminated"
+	} >no-final-lf &&
+	git add no-final-lf &&
+	git mv no-final-lf still-absent-final-lf &&
+	git commit -a -m "rename no-final-lf -> still-absent-final-lf" &&
+	git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
+	sed -e "s/^R[0-9]*	/R	/" actual >actual.munged &&
+	cat >expected <<-\EOF &&
+	R	no-final-lf	still-absent-final-lf
+	EOF
+	test_cmp expected actual.munged
+'
+
 test_done

base-commit: 055bb6e9969085777b7fab83e3fee0017654f134
-- 
gitgitgadget
