Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F13761FEB3
	for <e@80x24.org>; Wed,  4 Jan 2017 01:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762323AbdADBsy (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 20:48:54 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36859 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760371AbdADBst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 20:48:49 -0500
Received: by mail-pg0-f50.google.com with SMTP id f188so220826927pgc.3
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 17:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dfp0TjfojJE/8DtgbHeWF1emROp/o6XSRTy58cClMuk=;
        b=trkNQ/X9Ij2NqU0ulHt9yZBya89VuxFG4xTjpOic2o4FhXH4yKVt+MWBlIUC693fj6
         iWdOgSISfuSrelDamBle/bucQE1LCiu4up4qKCpxf3u0wdcuIV4SUElarCv9kubUhXKP
         t+j4k5HcFUeC0gsLnS+rFpijk1orlqwV0I1KUibGgqhdAqXHpAlbuCFmd2h0GCAQuMTH
         qQFsmC/+olc5ApooQvbUcXIeUOSXlGvseGpnv3NvONlHGDNu+3l5VWp6nVgq8fTSzlDd
         LTR/ez3lGacN06g1p+O8vewp+bjHQnzhmDal9pRcwuaezESdnhUVM2l58sS+qL19Bq0P
         F3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dfp0TjfojJE/8DtgbHeWF1emROp/o6XSRTy58cClMuk=;
        b=Gt4tB4F+yfE/bZd2HvVUfJ1cHfpNUo4gQkpR42ltCQFmK3msG2t2SqYla34y4AGtGq
         u0b88LIaGhVRwjIO8M3ZBWfJO2FOZ9EC+mcPOjqSNuNPO703mA/QWujIxyHmGjIc3QQR
         sdJ8prnlt1BC9mA0mGlhgGlM7ZsKAKR4pI4CoiwvjcHP3A9ctQt/CrfMrnAsy0LfI82p
         9Xleti2oAUk2vIiCU+PQ1g/or0mURDQxpxpyihoTkEnoB71VP9lwZS0IOUVFsEDlq6T6
         b8rJTQ7j/LX9XfEV/X+EIh/J0/qeiwghm9rDnVgH8yCFlIvRJzUdEFh+ENmnADpjKAh9
         yZ/A==
X-Gm-Message-State: AIkVDXIt3kqnD+YpMYQ1tvH6v9+Hnq1ilkJCXnEUJpmGMf5dbJSpIyL2QVH5XQT2t3QUHsqz
X-Received: by 10.99.222.85 with SMTP id y21mr120005071pgi.119.1483494529028;
        Tue, 03 Jan 2017 17:48:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:f014:c1c8:7de6:70a4])
        by smtp.gmail.com with ESMTPSA id j130sm119042658pgc.2.2017.01.03.17.48.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 17:48:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] pathspec: give better message for submodule related pathspec error
Date:   Tue,  3 Jan 2017 17:48:35 -0800
Message-Id: <20170104014835.22377-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.31.g2cc886f
In-Reply-To: <20170104014835.22377-1-sbeller@google.com>
References: <20170104014835.22377-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every once in a while someone complains to the mailing list to have
run into this weird assertion[1]. The usual response from the mailing
list is link to old discussions[2], and acknowledging the problem
stating it is known.

This patch accomplishes two things:

  1. Switch assert() to die("BUG") to give a more readable message.

  2. Take one of the cases where we hit a BUG and turn it into a normal
     "there was something wrong with the input" message.


[1] https://www.google.com/search?q=item-%3Enowildcard_len
[2] http://git.661346.n2.nabble.com/assert-failed-in-submodule-edge-case-td7628687.html
    https://www.spinics.net/lists/git/msg249473.html

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 pathspec.c                       | 24 ++++++++++++++++++++++--
 t/t6134-pathspec-in-submodule.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100755 t/t6134-pathspec-in-submodule.sh

diff --git a/pathspec.c b/pathspec.c
index 22ca74a126..574a0bb158 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -313,8 +313,28 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
 	}
 
 	/* sanity checks, pathspec matchers assume these are sane */
-	assert(item->nowildcard_len <= item->len &&
-	       item->prefix         <= item->len);
+	if (item->nowildcard_len > item->len ||
+	    item->prefix         > item->len) {
+		/* Historically this always was a submodule issue */
+		for (i = 0; i < active_nr; i++) {
+			struct cache_entry *ce = active_cache[i];
+			int len;
+
+			if (!S_ISGITLINK(ce->ce_mode))
+				continue;
+
+			len = ce_namelen(ce);
+			if (item->len < len)
+				len = item->len;
+
+			if (!memcmp(ce->name, item->match, len))
+				die (_("Pathspec '%s' is in submodule '%.*s'"),
+					item->original, ce_namelen(ce), ce->name);
+		}
+		/* The error is a new unknown bug */
+		die ("BUG: item->nowildcard_len > item->len || item->prefix > item->len)");
+	}
+
 	return magic;
 }
 
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
new file mode 100755
index 0000000000..2900d8d06e
--- /dev/null
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+test_description='test case exclude pathspec'
+
+TEST_CREATE_SUBMODULE=yes
+. ./test-lib.sh
+
+test_expect_success 'setup a submodule' '
+	git submodule add ./pretzel.bare sub &&
+	git commit -a -m "add submodule" &&
+	git submodule deinit --all
+'
+
+cat <<EOF >expect
+fatal: Pathspec 'sub/a' is in submodule 'sub'
+EOF
+
+test_expect_success 'error message for path inside submodule' '
+	echo a >sub/a &&
+	test_must_fail git add sub/a 2>actual &&
+	test_cmp expect actual
+'
+
+cat <<EOF >expect
+fatal: Pathspec '.' is in submodule 'sub'
+EOF
+
+test_expect_success 'error message for path inside submodule from within submodule' '
+	test_must_fail git -C sub add . 2>actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.11.0.rc2.31.g2cc886f

