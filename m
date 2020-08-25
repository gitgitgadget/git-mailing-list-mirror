Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538C7C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3188120767
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JomRkJw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbgHYLbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbgHYLaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 07:30:55 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74371C061756
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 04:30:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x25so7114743pff.4
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgunsanhPjvfQJDw4981MBRNATbWvlj8DjXzfTzsxmU=;
        b=JomRkJw/YiCOufFpjmEglTZZwO/aPJD6whyqtI8hKNOjJ2oOytGxzpYfcxfsWPYtY9
         b5+20HfuGEC03puXdemLuIaKOS0k3FqZpyykl2RBbKi/KMLygxN4Uy7vTpK6mnKr2XZB
         dymbBFnZ4oiSBVfIY/BGny4+5xe4sD5NDeZFygHuS0ECyhrWN8aInrDRL6ErgIE2y6nO
         3yaFyngXnSauaYb3Rx4bfJkmT/W0lvtdxzCIHuEp63hEN3y/7WWU1xUef5vMOQhoZq6E
         BcaQjglOJfxp4IsaxHSnQLCeM94dlaYusYQqIHDgHCMW77ivDwA1z0wGi7IMDSbwRxY9
         CusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgunsanhPjvfQJDw4981MBRNATbWvlj8DjXzfTzsxmU=;
        b=lUPajlmC60DY/l2dIYOEeYNp6X3k27uexSAwOfktAmrn2CdZlA6K/6FNLknZAmExBR
         LTLLK+eKyhpJ5FR/bXat1wADF6FWMyGo8nlip09audLSyAQz/wWu0hJDpxvq4GhGKkz1
         5ijEmqfvZsYr9gC5c0VHcGYf1HfcCQkOoXT7PVP9dkv3RhkvY2bsjRKK4bpbufZOKDmT
         Suh1vNxf4Eom0TK/bI0fs4vgOMdW+oHOTpS8UT74dEpVrJvAfrx8miPl8whF7GG+60Wb
         5JHpwe1pRFQxkgoAiaqLTnr5owSMNTRBLcGv9VgQKPnlX50UJZfhODOCiQnIicOPaFAu
         N2gw==
X-Gm-Message-State: AOAM5337fnAQeiaQLBDlb0rAcuglLpRuY/DOPU8AGVQ82SAFXXzvDc36
        AQjl5oFMG+kfwn09oiryQYznW6sq2ph/Lg==
X-Google-Smtp-Source: ABdhPJwD0Wd8XVf+aYeJL90G14nGnm5h7R+V/jY2N4SIMTdfPUX5ZEV6R7ajo5HSQ5Ic1EvoWWQAGg==
X-Received: by 2002:aa7:982e:: with SMTP id q14mr7649021pfl.299.1598355054483;
        Tue, 25 Aug 2020 04:30:54 -0700 (PDT)
Received: from localhost.localdomain ([115.97.133.243])
        by smtp.gmail.com with ESMTPSA id y3sm2821518pjg.8.2020.08.25.04.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 04:30:53 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de,
        peff@peff.net, liu.denton@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 3/3] t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
Date:   Tue, 25 Aug 2020 17:00:20 +0530
Message-Id: <20200825113020.71801-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
References: <20200825113020.71801-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'grep' check in test 4 of t7421 resulted in the failure of t7421 on
Windows due to a different error message

    error: cannot spawn git: No such file or directory

instead of

    fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory

Tighten up the check to compute '{src,dst}_abbrev' by guarding the
'verify_submodule_committish()' call using `p->status !='D'`, so that
the former isn't called in case of non-existent submodule directory,
consequently, there is no such error message on any execution
environment.

Therefore, eliminate the 'grep' check in t7421. Instead, verify the
absence of an error message by doing a 'test_must_be_empty' on the
file containing the error.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c      | 7 ++++---
 t/t7421-submodule-summary-add.sh | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 93d0700891..f1951680f7 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1035,7 +1035,7 @@ static void print_submodule_summary(struct summary_cb *info, char *errmsg,
 static void generate_submodule_summary(struct summary_cb *info,
 				       struct module_cb *p)
 {
-	char *displaypath, *src_abbrev, *dst_abbrev;
+	char *displaypath, *src_abbrev = NULL, *dst_abbrev = NULL;
 	int missing_src = 0, missing_dst = 0;
 	char *errmsg = NULL;
 	int total_commits = -1;
@@ -1061,8 +1061,9 @@ static void generate_submodule_summary(struct summary_cb *info,
 	}
 
 	if (S_ISGITLINK(p->mod_src)) {
-		src_abbrev = verify_submodule_committish(p->sm_path,
-							 oid_to_hex(&p->oid_src));
+		if (p->status != 'D')
+			src_abbrev = verify_submodule_committish(p->sm_path,
+								 oid_to_hex(&p->oid_src));
 		if (!src_abbrev) {
 			missing_src = 1;
 			/*
diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-add.sh
index 59a9b00467..b070f13714 100755
--- a/t/t7421-submodule-summary-add.sh
+++ b/t/t7421-submodule-summary-add.sh
@@ -58,7 +58,7 @@ test_expect_success 'submodule summary output for submodules with changed paths'
 	git commit -m "change submodule path" &&
 	rev=$(git -C sm rev-parse --short HEAD^) &&
 	git submodule summary HEAD^^ -- my-subm >actual 2>err &&
-	grep "fatal:.*my-subm" err &&
+	test_must_be_empty err &&
 	cat >expected <<-EOF &&
 	* my-subm ${rev}...0000000:
 
-- 
2.28.0

