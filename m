Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7124744C6C
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fW16copN"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d098b87eeeso18030225ad.0
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702822298; x=1703427098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOOGRqP2lPdr/OeewR/EfY1CqypMbszBWqkBjN1veBE=;
        b=fW16copNG50TxpOBt8y2NSTmyLvBvb1K/8gSbozmAcMHfdk1oQ7HkhKEqPyAXY3UKH
         0xMC3sZro4b+c4N0ioBxqiwp8kj269rYwLhvJoMh23j3xYl+i8APMf6Ege+8khuKfaSq
         Kv0A6Mw0qnwfYVf1UPBtUX3ZLV59dLFxdHrhiwNKMNOfuip1B6j/rsOT0aJ/NZMJgWEO
         XhFXGxLm7xeelK7C3nmRx1ouj2KJjdAF2DRxUUzt6n/yvrPVwGSSi4D/eaDZ4Cz4CywZ
         R1JexLQWy4JEm9ewL8dY1/pj32OLiKGuDgkCsGJD0FSjhFKa5vOJgdBD8lMDO+lLLy9n
         9stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702822298; x=1703427098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOOGRqP2lPdr/OeewR/EfY1CqypMbszBWqkBjN1veBE=;
        b=U16C/iB+NhClZlNY2nfRoGqf1m3cnyizkvaRExWO8jRAYpgg92Wydfl+Ss4yoH7RGV
         n5MLYg66d9J5vtTwtEi7sVBRa7Suwxx9hD2fhkRUG+SvJLqUoepGttNzVYQclPN7KvdM
         zbN60x9lE/s9jEH26w/4rkZ+yAzobnIJavAxkFC3KpU2ZGNnUc3/E52SnDbbO5rCOHZA
         ftIT2QztAE92Q+2cUzof8X3RNWEpGe+SOqJmWE3wEVLvdj1UqjwcGp4pMo4JiP5fR3JB
         WGubNAkC7f0bRo6LzG0jbii75UME8mdEYEIsYzM3l8yV7rqIQOjNeLOJcgEZUfwMmc+t
         hiDw==
X-Gm-Message-State: AOJu0YzBKIr2ed0QfmPvxsJcfTL/LQaTc4bZPBPL8adxBM97/qNNXOhS
	rM8zXXE9f9hRkeSpZV/aPxInYU2I0xg=
X-Google-Smtp-Source: AGHT+IFwLLP8rSuj7BvulV5r6wTHkcBdDbOCiMdVwjf6TFZz6HJ+bEMcxKWtgOXzPqqe9Aerd8+qvQ==
X-Received: by 2002:a17:903:24c:b0:1d0:6638:b9de with SMTP id j12-20020a170903024c00b001d06638b9demr16875296plh.10.1702822298549;
        Sun, 17 Dec 2023 06:11:38 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090a114100b0028b005dadb3sm7672045pje.26.2023.12.17.06.11.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:11:38 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 2/2] fetch: no redundant error message for atomic fetch
Date: Sun, 17 Dec 2023 22:11:34 +0800
Message-Id: <a8a7658fb2e1d5194e78608ea336ce6df94045ce.1702821462.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702821462.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1702556642.git.zhiyou.jx@alibaba-inc.com> <cover.1702821462.git.zhiyou.jx@alibaba-inc.com>
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

Because a failure message is displayed before setting retcode in the
function do_fetch(), calling error() on the err message at the end of
this function may result in redundant or empty error message to be
displayed.

We can remove the redundant error() function, because we know that
the function ref_transaction_abort() never fails. While we can find a
common pattern for calling ref_transaction_abort() by running command
"git grep -A1 ref_transaction_abort", e.g.:

    if (ref_transaction_abort(transaction, &error))
        error("abort: %s", error.buf);

Following this pattern, we can tolerate the return value of the function
ref_transaction_abort() being changed in the future. We also delay the
output of the err message to the end of do_fetch() to reduce redundant
code. With these changes, the test case "fetch porcelain output
(atomic)" in t5574 will also be fixed.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/fetch.c         | 14 +++++++++-----
 t/t5574-fetch-output.sh |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index fd134ba74d..a284b970ef 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1651,7 +1651,7 @@ static int do_fetch(struct transport *transport,
 	if (atomic_fetch) {
 		transaction = ref_transaction_begin(&err);
 		if (!transaction) {
-			retcode = error("%s", err.buf);
+			retcode = -1;
 			goto cleanup;
 		}
 	}
@@ -1711,7 +1711,6 @@ static int do_fetch(struct transport *transport,
 
 		retcode = ref_transaction_commit(transaction, &err);
 		if (retcode) {
-			error("%s", err.buf);
 			ref_transaction_free(transaction);
 			transaction = NULL;
 			goto cleanup;
@@ -1775,9 +1774,14 @@ static int do_fetch(struct transport *transport,
 	}
 
 cleanup:
-	if (retcode && transaction) {
-		ref_transaction_abort(transaction, &err);
-		error("%s", err.buf);
+	if (retcode) {
+		if (err.len) {
+			error("%s", err.buf);
+			strbuf_reset(&err);
+		}
+		if (transaction && ref_transaction_abort(transaction, &err) &&
+		    err.len)
+			error("%s", err.buf);
 	}
 
 	display_state_release(&display_state);
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index b579364c47..1400ef14cd 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -90,7 +90,7 @@ test_expect_success 'setup for fetch porcelain output' '
 
 for opt in "" "--atomic"
 do
-	test_expect_failure "fetch porcelain output ${opt:+(atomic)}" '
+	test_expect_success "fetch porcelain output ${opt:+(atomic)}" '
 		test_when_finished "rm -rf porcelain" &&
 
 		# Clone and pre-seed the repositories. We fetch references into two
-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

