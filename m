Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FB8C433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6557F20739
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qyoea3yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGPMRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgGPMRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 08:17:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFCEC061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 05:17:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g13so4639688qtv.8
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P8aGrK35KNAcaNJml9saGGazwGRpVMKrm0YVpL+rHt4=;
        b=Qyoea3ycGCGHC8IVSqKH1HwOdtPuxAb7XD9jYyafxyX8LHX/Xv+JIneA1bjtX6031+
         qRhFzm86pU2MCM0Wd5j9IzRCqjvwihhvv1iN4KcHBtB1o/4vsajR2NJ7MRtaY2s9ZXqi
         eUivePCTYk1W5ODL2VwyTOzXVpV85RSjPXVzyLN6LUUKpnFdDbo2dfkHcezIpKKIJXJp
         r80+CSXdOJZmYBorrA3OIfjOPqb6HZE9o8HCBOLmNcuXElUJv7P3bODglYHT2PNMrGnh
         2aCVh8zZ0LFrfmAfyR3PGH5R5hSgZP6cvHctZbIT+KPeUoOyuyEl08XSMSeZtodccRRd
         nqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P8aGrK35KNAcaNJml9saGGazwGRpVMKrm0YVpL+rHt4=;
        b=fIpg9t+0ZBvQrqT8eEBVBRpufRPdYikHiLLa9+iehRd6FCPZ98bEVLLUOkCTN++usv
         DZ1ITZb1h44h8royqA6346aGupSSpl6zjwzvcD+lFx0qbHn+dmQRrWAVY7frtdnSgz2l
         Jb29+QVEZUUAr7w2BxHZxO5uYHpEaRp9Zww3yehkywQ9dXzXfSen2285xU8Mq0Y2tt04
         XpcIL3nM1CtNDVVTnx41RULCHH4h1XM88RymfdrggYJDaVgFERWFsvhvT1pUEYqx24ch
         9jn+tlTQ/ikBwx/l2tdZ5e9KQpy2lhSSIW6cAHeICn0cs8ZEesFrX/MJ9ailspzMI8hu
         0gSQ==
X-Gm-Message-State: AOAM532VnQq3rH0ZQ2u36OpSgjcccHxgycY39/9hC8kS8gxx9UAcBF1/
        8t5vVyUVLrcIjjmQ0dVabnc=
X-Google-Smtp-Source: ABdhPJwAw2ObzR0hcq+lFmfMGztjf9HtBnPuhRHauIgz6D0NHq1+T21kT1wYq3ddt2vm7iKdow9F/Q==
X-Received: by 2002:ac8:3ff9:: with SMTP id v54mr4814732qtk.352.1594901825146;
        Thu, 16 Jul 2020 05:17:05 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id p29sm7704484qtu.15.2020.07.16.05.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 05:17:04 -0700 (PDT)
Subject: Re: [PATCH 0/2] extensions.* fixes for 2.28 (Re: [PATCH] setup: warn
 about un-enabled extensions)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
 <nycvar.QRO.7.76.6.2007161011270.54@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e32f27f4-6469-fe68-8263-bd10a101d380@gmail.com>
Date:   Thu, 16 Jul 2020 08:17:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2007161011270.54@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/2020 4:13 AM, Johannes Schindelin wrote:
> Hi Jonathan,
> 
> On Wed, 15 Jul 2020, Jonathan Nieder wrote:
> 
>> Junio C Hamano wrote:
>>
>>> Here is my quick attempt to see how far we can go with the
>>> "different endgame" approach, to be applied on top of those two
>>> patches.
>>
>> Here are patches implementing the minimal fix that I'd recommend.
>> These apply against "master" without requiring any other patches
>> as prerequisites.  Thoughts?
> 
> IIUC all of the existing `extensions.*` predate the reverted strict check,
> right? And the idea is that future `extensions.*` will only work when
> `repositoryFormatVersion` is larger than 1, right?
> 
> I would have been fine with Junio's patch on top of Stolee's, and I am
> equally fine with this patch series. My main aim is not so much
> future-proofing, though, as it is to avoid regressions in existing setups.

I'm fine either way.  I think that Jonathan's patch comes from a
more informed place than my patches, so his are probably safer.

The situation that caught my interest is covered by this test
that was part of my patches:

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 7cd45fc1394..6c0b82c3930 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -68,6 +68,18 @@ test_expect_success 'git sparse-checkout init' '
        check_files repo a
 '
 
+test_expect_success 'git sparse-checkout works if repository format is wrong' '
+       test_when_finished git -C repo config core.repositoryFormatVersion 1 &&
+       git -C repo config --unset core.repositoryFormatVersion &&
+       git -C repo sparse-checkout init &&
+       git -C repo config core.repositoryFormatVersion >actual &&
+       echo 1 >expect &&
+       git -C repo config core.repositoryFormatVersion 0 &&
+       git -C repo sparse-checkout init &&
+       git -C repo config core.repositoryFormatVersion >actual &&
+       test_cmp expect actual
+'
+
 test_expect_success 'git sparse-checkout list after init' '
        git -C repo sparse-checkout list >actual &&
        cat >expect <<-\EOF &&

and this test passes with Jonathan's series. I think this kind
of behavior is covered by his change to the 'converting to partial
clone fails with noop extension' test in t0410-partial-clone.sh,
so a duplicate test in t1091-sparse-checkout-builtin.sh may be
overkill.

Thanks, all.

-Stolee
