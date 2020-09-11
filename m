Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D20C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609B5208E4
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdamSeVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgIKSZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgIKSZc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 14:25:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2229C0613ED
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:25:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so12409101wrm.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q92HCblGSsqn+nVZla7ay220xSGLmsSz9h8d+nzPjZY=;
        b=CdamSeVxHG+r/nIFDrFGaP4ISWIRMrWuwFEVoMZVsmJmokP/NkNlk6mxGj/zWH2Krs
         mJDbe25hxAwKApLioQnQG4SmAybSB4jO30aPRMUWgIpfKCv1xJsFz+MIfIp0+iSZMDCX
         Ptl7e/3hki4Y8G6F/tZt6sJeYnygUVBkrnx3UlZeaJviL5zH0bjlUU+zuM8bF7vp+6/O
         OIG7tWYZmnNkxCEu2khJy4vml7MQRVYcmJNWAf1kQmVRQ8KuxD+53rYsdICfTzPBeftK
         wZaQ+rR/UJAki94xoZFTpnviSGIMUXYxPA7vYULnIfNzAorKh5Vm3PyR7m5ROzEsPZhP
         pTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q92HCblGSsqn+nVZla7ay220xSGLmsSz9h8d+nzPjZY=;
        b=mnsrmmciMmOih3fKJ2Rv0T0+qEdrvFrc/3sTgTAgyqf+ag7iW4JegtSNR6Xvbs/cSe
         aLgxDsfMuY8lyUe7CR9HpTImmZvEOJrGMsakquoKLjMIApA06yK1YZulHFi5hs4GBb84
         HrmkiJsRLFQ829Y5gz3E6PhdoBHWnaj/eFiQFdGaK5MLj9OR4DL335lULC1WasLujLPn
         sPxZhRCLuerXZ0Z6l9tBHyFfWIB7VfwGfmArB0W4N3VUzdwtFgBD8L4rA4O4rwke0ktT
         67bffs4Hg5l0xKHT/CkYyN8FjqPTc96XujJYrMVELtzxFNZ09s9//YXdmhPRCyd7DY7/
         Ccbw==
X-Gm-Message-State: AOAM530tFnM1MS1Ns80qQpj8qner567kQvbfHWfweonLubZar2iaKADT
        8P+0q48OVO6JAfd6T7S4h58H2zfargQ=
X-Google-Smtp-Source: ABdhPJwUwZVHUtBRvrPPcb9L2KjuZMUDmAegdgJ+C/fjZvtCUeFoD/7vPVaWRDFr06vECjbWhDZoRA==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr3193864wru.137.1599848730402;
        Fri, 11 Sep 2020 11:25:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a74sm5909943wme.11.2020.09.11.11.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 11:25:30 -0700 (PDT)
Message-Id: <0dff8cd66930130ffd5f0d7d068ad3ed47cd1c81.1599848727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.727.git.1599848727.gitgitgadget@gmail.com>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
From:   "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 18:25:26 +0000
Subject: [PATCH 3/4] clone: validate --origin option before use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>, Sean Barag <sean@barag.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Barag <sean@barag.org>

Providing a bad origin name to `git clone` currently reports an
'invalid refspec' error instead of a more explicit message explaining
that the `--origin` option was malformed.  Per Junio, it's been this way
since 8434c2f1 (Build in clone, 2008-04-27).  This patch reintroduces
validation for the provided `--origin` option, but notably _doesn't_
include a multi-level check (e.g. "foo/bar") that was present in the
original `git-clone.sh`.  It seems `git remote` allows multi-level
remote names, so applying that same validation in `git clone` seems
reasonable.

Signed-off-by: Sean Barag <sean@barag.org>
Thanks-to: Junio C Hamano <gitster@pobox.com>
---
 builtin/clone.c          | 7 +++++++
 t/t5606-clone-options.sh | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index bf095815f0..1cd62d0001 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -967,6 +967,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *ref;
 	struct strbuf key = STRBUF_INIT;
 	struct strbuf default_refspec = STRBUF_INIT;
+	struct strbuf resolved_refspec = STRBUF_INIT;
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	const char *src_ref_prefix = "refs/heads/";
@@ -1011,6 +1012,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (!option_origin)
 		option_origin = "origin";
 
+	strbuf_addf(&resolved_refspec, "refs/heads/test:refs/remotes/%s/test", option_origin);
+	if (!valid_fetch_refspec(resolved_refspec.buf))
+		/* TRANSLATORS: %s will be the user-provided --origin / -o option */
+		die(_("'%s' is not a valid origin name"), option_origin);
+	strbuf_release(&resolved_refspec);
+
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index d20a78f84b..c865f96def 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -19,6 +19,14 @@ test_expect_success 'clone -o' '
 
 '
 
+test_expect_success 'rejects invalid -o/--origin' '
+
+	test_expect_code 128 git clone -o "bad...name" parent clone-bad-name 2>err &&
+	test_debug "cat err" &&
+	test_i18ngrep "'\''bad...name'\'' is not a valid origin name" err
+
+'
+
 test_expect_success 'disallows --bare with --origin' '
 
 	test_expect_code 128 git clone -o foo --bare parent clone-bare-o 2>err &&
-- 
gitgitgadget

