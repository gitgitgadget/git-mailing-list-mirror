Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pj0KwJPX"
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB370118
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 04:33:21 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28aea039fb4so429920a91.1
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 04:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702557201; x=1703162001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSQ23ZL5fxsbD8hQx0hhLk5imHtQooiO5IgxlsT2p2Q=;
        b=Pj0KwJPXrbG8z8D5VvGCpCHrk6FD5ozhaFQM6sa/xSpEabx+Ocmc3ccMwfOUZp9p06
         nhiQRwIqLMZ56XaSNRLtwgm6uInj5uCf28DI8ujCfe+L4GoCE8MROqqfzItJrO3+XM7H
         J0pBsULZQEZTnH6g8SGfJUnuG4IhqFuH5zA1kRUhnbIRrhLLAMBijN5a9xrtQCuozMGj
         Q73d+/T795OPd116Ee0TH5xrfdaQ/3oq5vpjCYA2hbfab1XO/AZ/mEzFAjvLSAt2c9UA
         j8OA11c90XjDeZgotZWdF8fN0rQRmo1NLs4BhseIrAEcM1R0pTmRpOQ254R830EWMadM
         QgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557201; x=1703162001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSQ23ZL5fxsbD8hQx0hhLk5imHtQooiO5IgxlsT2p2Q=;
        b=hdkF+sh9i4vuZNfga3yhMSHKOvrXCJoDtOFfvYM52LheRftHhdz4KPhVezc6jxsFse
         XTWonyVZHqRD6zLTUcBlm/C30/mdIqJ6sS4S4K3TNd8iA4zidSMN8F7fDQcdkQuI/Ewf
         rTj6UkvmMjZHRuj/RypcyoUhO45P6HOk4rtXw55++VZuN4I+yhEkAw0fxolcNHa94VwG
         HbbUaSfA9RPCvQ6P05QI7CufNktvk4SY4LRbJKoS2croir98mWuRytnEsmG4yZhQLCsG
         wrsIxcmpwuQO9JqVmfBme6GmVGNaCILb9O97RJRrgbm0/sG8gWebjLAH/F5ZlnFLqHuM
         Yx1A==
X-Gm-Message-State: AOJu0Yybon2xRzmtDDHBwtZl5a/qEIggj9CKWywF9wrQYuqglf9Riult
	/nzVEHkDllo/mvNgfEPMMc/nz3qA2d8=
X-Google-Smtp-Source: AGHT+IHfqZrlbHYAfmZ4GI9r7B80cBNYlB/yA4YOsJju/BdRzQREXyXsFKBYibCKxBX/pujH6Z//rw==
X-Received: by 2002:a17:90b:33cb:b0:286:7529:3598 with SMTP id lk11-20020a17090b33cb00b0028675293598mr12122585pjb.13.1702557200950;
        Thu, 14 Dec 2023 04:33:20 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a734800b0028ae9cb6ce0sm3112368pjs.6.2023.12.14.04.33.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:33:20 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 2/2] fetch: no redundant error message for atomic fetch
Date: Thu, 14 Dec 2023 20:33:12 +0800
Message-Id: <6fb83a00000563a79f3948f9087c634ae507b9f5.1702556642.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com> <cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

If an error occurs during an atomic fetch, a redundant error message
will appear at the end of do_fetch(). It was introduced in b3a804663c
(fetch: make `--atomic` flag cover backfilling of tags, 2022-02-17).

In function do_fetch(), a failure message is already shown before the
retcode is set, so we should not call additional error() at the end of
this function.

We can remove the redundant error() function, because we know that
the function ref_transaction_abort() never fails. While we can find a
common pattern for calling ref_transaction_abort() by running command
"git grep -A1 ref_transaction_abort", e.g.:

    if (ref_transaction_abort(transaction, &error))
        error("abort: %s", error.buf);

We can fix this issue follow this pattern, and the test case "fetch
porcelain output (atomic)" in t5574 will also be fixed. If in the future
we decide that we don't need to check the return value of the function
ref_transaction_abort(), this change can be fixed along with it.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/fetch.c         | 4 +---
 t/t5574-fetch-output.sh | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fd134ba74d..01a573cf8d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1775,10 +1775,8 @@ static int do_fetch(struct transport *transport,
 	}
 
 cleanup:
-	if (retcode && transaction) {
-		ref_transaction_abort(transaction, &err);
+	if (retcode && transaction && ref_transaction_abort(transaction, &err))
 		error("%s", err.buf);
-	}
 
 	display_state_release(&display_state);
 	close_fetch_head(&fetch_head);
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index bc747efefc..8d01e36b3d 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -98,7 +98,7 @@ do
 		opt=
 		;;
 	esac
-	test_expect_failure "fetch porcelain output ${opt:+(atomic)}" '
+	test_expect_success "fetch porcelain output ${opt:+(atomic)}" '
 		test_when_finished "rm -rf porcelain" &&
 
 		# Clone and pre-seed the repositories. We fetch references into two
-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

