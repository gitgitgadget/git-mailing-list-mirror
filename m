Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D1CC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C229464DE0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBPOHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhBPOHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:07:41 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86C9C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 06:06:59 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id v19so4678715qvl.7
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 06:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nr8oa296kMdbAikR21DS6K0l0keHv4ZuXUsPrJB4vss=;
        b=c0IQnh4YRa5X0Nlty5aDvlZS/u8W57xQuW44vmcG63BQ12+st89VUwBTH/xqonM/8N
         U1XbqCdU7T/IAHqGLUViwgV/Rqw+vj8fIpxOK0itKBowtl1N0adb+cmIMGkcusRuBn5F
         uW+IBJLytrKKLtNPN8Y3r3oz4AOL7cHVAgYcBX/UbDRElkXCW6Sjk3iP9Q0otX+BuvD6
         8Mq5M5TbTbrB+ru325gtExiqtS602EX2hbpqSjFd39Ph+4ebyv9R7UINt9qP2lJgh4xu
         u0UlnnlgB7k5EjrPZUUE0xoksaRwsF2rjOEB5TRXpRQptUIaI8Zliscpj4q5fOk3i20j
         H7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nr8oa296kMdbAikR21DS6K0l0keHv4ZuXUsPrJB4vss=;
        b=Fh4by6G7uMv6T4FgsY9toHolHkdCpGkABhmfmTGZPCa1ANvU2h8d56tIu6T9kGnQLP
         LNciOpWYHrxjF3vVdQMakqz5BIf2x72Icv/8qrIWQYjVp3vD51R623iV1MBagk+SLmLi
         ul9dfoTQQq71Su9dGeHL/8L3ozgXnRxssxT2GsyIdzRvE4zovo+zcejFrb9ssFSJeHoO
         Cs0UOEOyN3lAOc1G+/iQC2jTStkWRu25PwXLnyjWG6BT5JU/K3UtA8cgYDM+aha7ucT4
         MQSWw35oUT6baSC5jK3IYj7SDBav1ra5Z19cfreTrtC3r/t4vmebaVzztagX0sLGn/ea
         SsbQ==
X-Gm-Message-State: AOAM530yCvlYuGOb+quTjjZhMx9v2Cf+TjAlb7FEAnvsEQPl+IjwzCwm
        7LOiHmpTsFMHRUN5yXU8NBJdAHNJwG44oA==
X-Google-Smtp-Source: ABdhPJxmH5P5kgHxz3TuV9iRv/WCRquBpEErvsPaEJ/vKl+hJVcEx/mXDFL/bSHEnoK72GjVYS90Ew==
X-Received: by 2002:a0c:a905:: with SMTP id y5mr19981151qva.55.1613484418635;
        Tue, 16 Feb 2021 06:06:58 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id x62sm14303049qkd.1.2021.02.16.06.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 06:06:58 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v3 0/2] checkout-index: some cleanups to --temp and --prefix outputs
Date:   Tue, 16 Feb 2021 11:06:50 -0300
Message-Id: <cover.1613483833.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613411136.git.matheus.bernardino@usp.br>
References: <cover.1613411136.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change since v2:
Make the test added by patch 1 more robust by not depending on the
absence of 0-length blobs in the test repository.

Matheus Tavares (2):
  write_entry(): fix misuses of `path` in error messages
  checkout-index: omit entries with no tempname from --temp output

 builtin/checkout-index.c        | 35 ++++++++++++++++++++++-----------
 entry.c                         |  8 ++++----
 t/t2006-checkout-index-basic.sh | 23 ++++++++++++++++++++++
 3 files changed, 51 insertions(+), 15 deletions(-)

Range-diff against v2:
1:  bdda5f99d0 ! 1:  41c166d380 write_entry(): fix misuses of `path` in error messages
    @@ t/t2006-checkout-index-basic.sh: test_expect_success 'checkout-index reports err
      
     +test_expect_success 'checkout-index --temp correctly reports error on missing blobs' '
     +	test_when_finished git reset --hard &&
    -+	missing_blob=$(git hash-object --stdin </dev/null) &&
    ++	missing_blob=$(echo "no such blob here" | git hash-object --stdin) &&
     +	cat >objs <<-EOF &&
     +	100644 $missing_blob	file
     +	120000 $missing_blob	symlink
2:  6ece1947c1 = 2:  8dec184326 checkout-index: omit entries with no tempname from --temp output
-- 
2.29.2

