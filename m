Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFD12FE13
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cewGAMyG"
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2585F114
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 07:34:45 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-584042a01eeso232069eaf.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697726084; x=1698330884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1ezSbguqg3vY5hYOhLzkGQ3/5r5QJBPRhby1dqQ3eE=;
        b=cewGAMyG+AlTAoOHwOlZ9GVqvxKpovqslvS8WZqSV8eFi//+YRVgc8nb0/xwkuQjbN
         i8Evixc155yWML3aJc44Eur1APjv8zEajZezGW9JNjxLwG9+vRYj67u1Gkdzgen+uVMf
         eBtvzb6T7q/BekVwDFi2ONBR3nIpVgXigAY7+BNCC8mo60472MoUcb4smAwGmhYZucFE
         e2D3tDvr/I4kNIqeSVOhxrooqh1+Dj7ZJLH+MTGrQ4wGcwaz9QUQ9JtECtRyz5Z8YyTn
         4Zvaqu8XTx3nWv9qpkrK2t9ZoloEUhbx+fEKyJzgqwYlydY6SYoqfxF4FleGu7J8HZus
         tfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726084; x=1698330884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1ezSbguqg3vY5hYOhLzkGQ3/5r5QJBPRhby1dqQ3eE=;
        b=Irc1aqQPYTJPy9niLSq1WGV89vLCGegdENBJ5G4GdTx7HEdMR62u8/s2fpV/Hy2sjw
         75aITmkaXFb/Vzde4ngnWoZ7DRLF+o/+g64mvwmRT+zEcKF3WtSyDi7X/eDIUlvjDtOC
         20INH+u6boBbBRdM9uHJxuW6mefvgKL5dFJ4rMdbhs+57QQ/pUspx1XfJaHfXv7QmezB
         eiYBPVrS9QPvMT9imCfbg4SAkSQHJ6jjrPPMKYQxFpF3Q3SQcPQekzR19IPjfam9n7Qe
         bpxOM0gXIDLG6H6WdmJmQEcrfUO4G3NGIoPyAdgpYJUFTZDXsimk045GNiwqIIKRuYrJ
         NTYw==
X-Gm-Message-State: AOJu0YwCD+E4BSruLuMVJkzyMUx1wlsJtkImCmGjd+5lbz1kvPyn4XbY
	fzvYOexe2UkgzGaPEUfygE8M5++VxUn8uQ==
X-Google-Smtp-Source: AGHT+IEd5uU/Sl+1dQCxIPNMZRwCnkytEjVRMoLBWMgd8K0U5bIUIRB+p++a3NBJrm3oeOUBRetGIw==
X-Received: by 2002:a05:6359:100e:b0:13a:6748:9312 with SMTP id ib14-20020a056359100e00b0013a67489312mr2027954rwb.19.1697726084211;
        Thu, 19 Oct 2023 07:34:44 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f11-20020a056a00228b00b0068feb378b89sm5368869pfe.171.2023.10.19.07.34.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2023 07:34:43 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 2/2] fetch: no redundant error message for atomic fetch
Date: Thu, 19 Oct 2023 22:34:33 +0800
Message-Id: <ced46baeb1c18b416b4b4cc947f498bea2910b1b.1697725898.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
References: <38b0b22038399265407f7fc5f126f471dcc6f1a3.1697725898.git.zhiyou.jx@alibaba-inc.com>
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

Instead of displaying the error message unconditionally, the final error
output should follow the pattern in update-ref.c and files-backend.c as
follows:

    if (ref_transaction_abort(transaction, &error))
        error("abort: %s", error.buf);

This will fix the test case "fetch porcelain output (atomic)" in t5574.

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
index 1397101629..3c72fc693f 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -97,7 +97,7 @@ do
 		opt=
 		;;
 	esac
-	test_expect_failure "fetch porcelain output ${opt:+(atomic)}" '
+	test_expect_success "fetch porcelain output ${opt:+(atomic)}" '
 		test_when_finished "rm -rf porcelain" &&
 
 		# Clone and pre-seed the repositories. We fetch references into two
-- 
2.42.0.411.g813d9a9188

