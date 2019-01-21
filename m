Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FD8A1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 19:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfAUTuU (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 14:50:20 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46487 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfAUTuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 14:50:19 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so12905152qkf.13
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 11:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJriI1jdfpCylSf+joow0A8Mwvgwuqtne3By369NPY8=;
        b=KkzeMnp+xf7RrfkAK7isIVRtoJtfEFi008AjuyREgqiao4Oelq2xs48tXNcYXlPtDQ
         6SADYYDJ2db+HDC6NyznX+ZftCcaP9GC9VzjxClLF+E+foE23JtmIQ7FjCWxj8F/CPTZ
         5JhMNYUC+MVIFF13GoigvNMETMC3e9yJp6wb/mvchqGnsWfpFvpXhUAvVhA/1r8uIiDf
         Vb6OHAJRiqemiF5TPJTKLBzhEnfE2q7X5wgtpVTD0EMISAMJ0GffmueQigg1aXiHnTLX
         5ppWC/Uz6ETUpW6G4KPhYSs9eW+DbOC7fSP7vUi/7BQw4NoSHqUnTog0xxDZCUEayd7o
         mE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJriI1jdfpCylSf+joow0A8Mwvgwuqtne3By369NPY8=;
        b=iQD7kTStpBp3NFBWBM1AtmglhzTmcDecgm/hO4iLUCxMetyxN77C6DLOcp2n/Wh4XQ
         DEr4NWaNrWnq8MSxZ93YrCpjGATTAgyuiSilJhhX/KTtBcysIGYeHTXEmVsBioufEQPl
         pEcVv93bCyw8nFVJfF7nNeXoqbKtBSCymD9GvdWeGZmN/PC4L+ygifUtWGOoSv7ZBA8v
         Jt4BdkONLwi3RSEOqTDD1VJb0F1UDPhEdL5KwW/6/YIyeZwyi0d1tndVvk0vuLb5uhsQ
         inMUp5lMJ8Z1DBZDyWgH07pFGkAYrHXZobMYnk+m/TIC8r6osAthVMqfEboOGxMWopR1
         mpwQ==
X-Gm-Message-State: AJcUukf+fP+4xzeQ9Qec+aCtE60oZZwYeME6sLgEubKcbox3Biaw49HD
        JocLkLp0kCVxvHcGcQJoRaMURbc17Qo=
X-Google-Smtp-Source: ALg8bN5tXr+4jndUtFLVdUt5VW7E2/tufrFRby39wX6+aXoex5npoH8yP6ilqiAcspm/6eBGTGRdug==
X-Received: by 2002:a37:57c5:: with SMTP id l188mr25075466qkb.54.1548100218497;
        Mon, 21 Jan 2019 11:50:18 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id n62sm22760625qkn.43.2019.01.21.11.50.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 11:50:17 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     asottile@umich.edu, benpeart@microsoft.com, gitster@pobox.com,
        pclouds@gmail.com, peartben@gmail.com
Subject: [PATCH v2 0/2] Fix regression in checkout -b
Date:   Mon, 21 Jan 2019 14:50:06 -0500
Message-Id: <20190121195008.8700-1-peartben@gmail.com>
X-Mailer: git-send-email 2.19.1.gvfs.1.16.g9d1374d
In-Reply-To: <20190118185558.17688-1-peartben@gmail.com>
References: <20190118185558.17688-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

The optimized `checkout -b` doesn’t typically create/update the index and
working directory.  Add a new test to detect the case when the call to
`checkout -b` is the first call after doing a `clone --no-checkout` and no
index exists.  In this specific case, well now make the call to
merge_working_tree() which will create the index and update the working
directory.

Also simplify and update the test cases based on the feedback provided by
Szeder and Junio.  A shout out to Johannes who diagnosed, fixed and patched
a bug that was preventing me from running the git test suite in the master
branch.

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/55dd8602f5
Checkout: git fetch https://github.com/benpeart/git initial-checkout-v2 && git checkout 55dd8602f5


### Interdiff (v1..v2):

diff --git a/builtin/checkout.c b/builtin/checkout.c
index af6b5c8336..9c6e94319e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -517,12 +517,6 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
 	if (core_apply_sparse_checkout && !checkout_optimize_new_branch)
 		return 0;
 
-	/*
-	 * We must do the merge if this is the initial checkout
-	 */
-	if (is_cache_unborn())
-		return 0;
-
 	/*
 	 * We must do the merge if we are actually moving to a new commit.
 	 */
@@ -598,6 +592,13 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
 	 * Remaining variables are not checkout options but used to track state
 	 */
 
+	 /*
+	  * Do the merge if this is the initial checkout
+	  *
+	  */
+	if (!file_exists(get_index_file()))
+		return 0;
+
 	return 1;
 }
 
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index c438889b0c..c5014ad9a6 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -200,13 +200,11 @@ test_expect_success 'checkout -B to the current branch works' '
 
 test_expect_success 'checkout -b after clone --no-checkout does a checkout of HEAD' '
 	git init src &&
-	echo hi > src/a &&
-	git -C src add . &&
-	git -C src commit -m "initial commit" &&
+	test_commit -C src a &&
 	rev="$(git -C src rev-parse HEAD)" &&
 	git clone --no-checkout src dest &&
 	git -C dest checkout "$rev" -b branch &&
-	test -f dest/a
+	test_path_is_file dest/a.t
 '
 
 test_done


### Patches

Ben Peart (2):
  checkout: add test to demonstrate regression with checkout -b on
    initial commit
  checkout: fix regression in checkout -b on intitial checkout

 builtin/checkout.c         | 7 +++++++
 t/t2018-checkout-branch.sh | 9 +++++++++
 2 files changed, 16 insertions(+)


base-commit: 77556354bb7ac50450e3b28999e3576969869068
-- 
2.19.1.gvfs.1.16.g9d1374d


