Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F65EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 18:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbjGNS4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjGNS4h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 14:56:37 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED31930F8
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 11:56:36 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-403aa9d4991so5285741cf.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689360996; x=1689965796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UWt1zQiP4Bg/FqGTkgW4mffJ9DPJYfBkd3QmTD2skE=;
        b=YWm+XG3136lCdyl/Jq2/8TgOCTEkIPLwWe1IWrb6wDGUnwS5CcLsCoRFiTAv0mabSV
         aWxLgXbChWkuRqpMI9qQqdWbn4CspGyZnlLcPpOSB5UaptNegtWa8pWbZd2+UEikH1fC
         9O7oldJSmMi+Q2EipwnIew3z8r8ZYmRYzlRETNa/AX5lU0w2yoHMC1VpHW+F+Ul+QKjx
         g7n4vzgVxfca3U8DLW32n5tZyOBaUnKDbHHn5TO0SWgIrds3sGbuC39Ev4ETzodQJIPY
         +2qiT432JBu9enzU1mpxsxtGgoq/vTguFUP7rvvf8LrTzQHHpvTtuoq8Vr+fxruTTzSt
         LrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360996; x=1689965796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UWt1zQiP4Bg/FqGTkgW4mffJ9DPJYfBkd3QmTD2skE=;
        b=PdACPrusGQr+VWYwhl3hSUE0qQF67GsgGPMuk4+p+6L2Meb8onxP2APitVEH4uBZ+8
         m2bOzW0Ls6NK06Y2vrOb4N0sOE3dzY3Ua7+juiJIqsuzz1do2OoZBD8FHoyV7EnIThyE
         2jEt/n4OkSqnwnVUe/zQinIlfbXvNUm7JiPJqgWBKbXoXSxSK+cfzknxb42HwG2dTJHB
         yT05NATXvWU87DwADl69erBkQa3oV5/r1y4X5feXIxpCtSzelAidmmYCWVHZFWvsz03n
         fwdPrLuTq90TLoCTP/5BuvtQTs63Rk1gGdkBe8hRN11UFt+E1iMG0zycXLJq0pmaPIk9
         2UXA==
X-Gm-Message-State: ABy/qLaOANHVEPJ8WZfJJGWiYBrrP/svi6aDwHrmtNmAwzbxlypqcuv1
        R7ufptgx16Z0le9Ao0eggZSMZLdyUUI=
X-Google-Smtp-Source: APBJJlE4cpHFSw7Rqnp32EJ4uw+a1INi6SIAnbJ7Q4uozMHAl3bZZB2bBLLutRB2h7XBmCtzbRalXQ==
X-Received: by 2002:a05:622a:1a99:b0:3fd:eb2f:8627 with SMTP id s25-20020a05622a1a9900b003fdeb2f8627mr6579451qtc.6.1689360995905;
        Fri, 14 Jul 2023 11:56:35 -0700 (PDT)
Received: from [192.168.1.13] (ool-182e6d73.dyn.optonline.net. [24.46.109.115])
        by smtp.gmail.com with ESMTPSA id q11-20020ac8450b000000b003f7fd3ce69fsm4159459qtn.59.2023.07.14.11.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2023 11:56:35 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     =?utf-8?q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "D. Ben Knoble" <ben.knoble+github@gmail.com>
Subject: Re: [PATCH] t4002: fix "diff can read from stdin" syntax
Date:   Fri, 14 Jul 2023 14:56:34 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <CEC94FDD-E5F1-48C0-8FBF-05682EBEB035@gmail.com>
In-Reply-To: <279beaea-d332-0d88-3cd0-b935ef6bc5eb@web.de>
References: <pull.1545.git.git.1689341410476.gitgitgadget@gmail.com>
 <279beaea-d332-0d88-3cd0-b935ef6bc5eb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 14 Jul 2023, at 10:44, René Scharfe wrote:

> Am 14.07.23 um 15:30 schrieb D. Ben Knoble via GitGitGadget:
>> diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
>> index d524d4057dc..7afc883ec37 100755
>> --- a/t/t4002-diff-basic.sh
>> +++ b/t/t4002-diff-basic.sh
>> @@ -403,7 +403,7 @@ test_expect_success 'diff-tree -r B A == diff-tree -r -R A B' '
>>  	git diff-tree -r -R $tree_A $tree_B >.test-b &&
>>  	cmp -s .test-a .test-b'
>>
>> -test_expect_success'diff can read from stdin' '
>> +test_expect_success 'diff can read from stdin' '
>>  	test_must_fail git diff --no-index -- MN - < NN |
>>  		grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
>>  	test_must_fail git diff --no-index -- MN NN |
>>
>
> Good find!  Introduced by 9cfcbcc095 (t4002-diff-basic: modernize test
> format, 2023-05-18).  Perhaps an automatic formatter would have avoided
> it?  E.g. some sed(1) scripting, or shfmt (https://github.com/mvdan/sh)?
> (Just discovered shfmt, never used it.)

Thanks for finding this and fixing!

>
> René
