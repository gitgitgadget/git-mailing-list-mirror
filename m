Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA78C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241397AbiBQNzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:55:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiBQNzn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:55:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C4D272DA3
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:27 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d27so9195647wrb.5
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4p5vifrt7kKHK/2sz4H735jR3xX0iBjqdcCbscTpii8=;
        b=LcChwDFs+WYSeFyrY1qLejXmXAH3J5DIAm2qKQe543hi1n61xCDMMj5weV5PZ2atCe
         tMERc+/ahGKnOxKGNk53Xog0tbd7Lcmf6TyyG3HCXuu5eZRIzOfCcwgNGcEuceLZSTL8
         mJF4PBRBt4706YoqN54JI9J8rZ8sSYzaILTIaqA3T0PVk13GrtMOPWFyAeAKYJQCYnrT
         jpSpVbPcKtBtG4SAw0rHVK22dVya9ZDeje9HJr1hVU1iitnXXx+EXIz/SkoBpJB1auGc
         Ei4ilnsxLDB4GsnCWP2Sg0Iecfv8+0kUjySuGbTlrTG/0OvfDrVQz55ILnttoMLlCa7U
         oSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4p5vifrt7kKHK/2sz4H735jR3xX0iBjqdcCbscTpii8=;
        b=gLh1fyVCk8GkpEv8wiS1FtrOKt5W6iuq9wuJpVtvOHc3+e6AcA1eNTvK7TI0YSRYH0
         a70YvPoRunqFmWUc10SUW/TnbJL1gLHyioDMiFgjwvA3T0RxYL+5AxCBU3WaEa3RlPvp
         E3oOfNsAyw5/KbNwLvnlvmPTeGEthb0u+if78/ZPnk1NeODtaPOdyTVRyD3Oq3vJlRty
         CO6O6g9ZMCvzXw720OiX1alDN1BpXxpSgDBprNI+M/61GXANTcC0PyRZGG/8q4lO5Tn6
         a6683SmBrxfAkPb8BuCmJmeyT1Chp/d/o8aOjooXWTe+USi2Hlw/Tg/zLNFCL/zaQ7Ma
         eibw==
X-Gm-Message-State: AOAM5330FBF43gSz7kripzAzVJH92toi0UZRF1hdxt3a3fynMGbLr/YM
        LRlKPMNWYtMr2z7XyI/fXGPgSjCgZmg=
X-Google-Smtp-Source: ABdhPJxNXbO7es5h2NHKQ2TuNzFCXUQCYIC+L9QDh7wLJYhCrqJU1QMfQd7JBZYf+PQ2NnGi+ZwNMg==
X-Received: by 2002:adf:c385:0:b0:1e3:3ac:5b1b with SMTP id p5-20020adfc385000000b001e303ac5b1bmr2522559wrf.545.1645106125821;
        Thu, 17 Feb 2022 05:55:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm1255820wml.40.2022.02.17.05.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 05:55:25 -0800 (PST)
Message-Id: <pull.1185.v2.git.git.1645106124.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 13:55:17 +0000
Subject: [PATCH v2 0/7] reftable: avoid reading and writing empty keys
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this series makes sure that the object record does not have to consider
empty keys (and therefore, a NULL memcpy destination)

while we're at it add some more tests, and fix a naming mistake.

Han-Wen Nienhuys (7):
  Documentation: object_id_len goes up to 31
  reftable: reject 0 object_id_len
  reftable: add a test that verifies that writing empty keys fails
  reftable: avoid writing empty keys at the block layer
  reftable: ensure that obj_id_len is >= 2 on writing
  reftable: add test for length of disambiguating prefix
  reftable: rename writer_stats to reftable_writer_stats

 Documentation/technical/reftable.txt |   2 +-
 reftable/block.c                     |  27 ++++---
 reftable/block_test.c                |   5 ++
 reftable/reader.c                    |   5 ++
 reftable/readwrite_test.c            | 105 ++++++++++++++++++++++++++-
 reftable/reftable-writer.h           |   2 +-
 reftable/writer.c                    |   9 ++-
 7 files changed, 136 insertions(+), 19 deletions(-)


base-commit: 45fe28c951c3e70666ee4ef8379772851a8e4d32
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1185%2Fhanwen%2Fobj-id-len-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1185/hanwen/obj-id-len-v2
Pull-Request: https://github.com/git/git/pull/1185

Range-diff vs v1:

 1:  2d2e1177ff7 = 1:  80d29e8f269 Documentation: object_id_len goes up to 31
 2:  747c9e9a4c8 = 2:  4c1a19fc4ae reftable: reject 0 object_id_len
 3:  4eefedb0d07 = 3:  600b115f8b1 reftable: add a test that verifies that writing empty keys fails
 4:  e4c1cc58265 ! 4:  ba036ee8543 reftable: avoid writing empty keys at the block layer
     @@ reftable/block.c: int block_reader_first_key(struct block_reader *br, struct str
      
       ## reftable/block_test.c ##
      @@ reftable/block_test.c: static void test_block_read_write(void)
     + 	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
       			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
     - 	reftable_record_from_ref(&rec, &ref);
       
     -+	ref.refname = "";
     -+	ref.value_type = REFTABLE_REF_DELETION;
     ++	rec.u.ref.refname = "";
     ++	rec.u.ref.value_type = REFTABLE_REF_DELETION;
      +	n = block_writer_add(&bw, &rec);
      +	EXPECT(n == REFTABLE_API_ERROR);
      +
 5:  3a72aba447c = 5:  2bd3d44ba57 reftable: ensure that obj_id_len is >= 2 on writing
 6:  a5dfa048884 = 6:  82d36ee0e0d reftable: add test for length of disambiguating prefix
 7:  37aa7744c84 ! 7:  c6ffdb3471c reftable: rename writer_stats to reftable_writer_stats
     @@ reftable/readwrite_test.c: static void test_log_write_read(void)
       	n = reftable_writer_close(w);
       	EXPECT(n == 0);
       
     +-	stats = writer_stats(w);
     ++	stats = reftable_writer_stats(w);
     + 	EXPECT(stats->log_stats.blocks > 0);
     + 	reftable_writer_free(w);
     + 	w = NULL;
     +@@ reftable/readwrite_test.c: static void test_log_zlib_corruption(void)
     + 	n = reftable_writer_close(w);
     + 	EXPECT(n == 0);
     + 
      -	stats = writer_stats(w);
      +	stats = reftable_writer_stats(w);
       	EXPECT(stats->log_stats.blocks > 0);

-- 
gitgitgadget
