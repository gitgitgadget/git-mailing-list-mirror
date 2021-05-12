Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783A8C43617
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574D36143D
	for <git@archiver.kernel.org>; Wed, 12 May 2021 20:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345943AbhELUhZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 16:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381409AbhELTeK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 15:34:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839EC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 12:33:00 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so11396691otg.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GoluJwMqzNfPKLCAVwlUdGwIldRKWMJkHXwIYlheuvA=;
        b=ZXzbHLCAGBfR8ac4sRr8l6kEPvSmO5CC5Akx8b55nPgDwVjKU3RGEuGT7Vgq1U11Xy
         cfmQcVJfecUBZ8/ORuotnZg7s34igrJ0k/xwng6VBEGr82kOQ7E48Fzuc7bCtKvn2FzN
         QAWmyhstVXuvFbsWFV6amjj6aCRJTVn+jYQSqeC7YcVTkCBGetBISKeZ7vnAytDoWXzL
         tzmbCfmf9bSUtLYzdpSgqkwifDJTL1AyEEOB8igI40tzeVCgiAmicsFYHsuoXsFqTy/0
         dKbVZIXhc/RqpD2jIjEJlkTCOdaf3bEqZ18W/gy0f0aV8A/jxXacAbIhf8WLGKK83S3P
         arjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GoluJwMqzNfPKLCAVwlUdGwIldRKWMJkHXwIYlheuvA=;
        b=cJHDHo/SR0HPDCqDW9Omb+BfDTV/WZV5VG6SMSY1Zf5RTNLYEH+PPDNaPmxDGNS3Qm
         RhTqBTVywb9GngWvovKKPOrCVlmgniHCBWL6RNSowsPcCxmOGV0mGeJTaViRckjq+er4
         LkJMDmrEdfk9w6AQCa3rwbHEBC1D4+mi6MFKwXUWgTPHrxwPtaTvaK6taoJ7ET0xIfVb
         7Pj5tOBHozEXsLpq0oosi1UAGp1ZrHLeImnOxppSmjduEkHftApIl5PioesLd0veM8j1
         +lhTmB+qtKfA/DgZMOAh+w12M0BgBgxcle8JDjjEbEF9AhFjZy1lMgiWMsRDGLZlbe0B
         vjng==
X-Gm-Message-State: AOAM533DpqzRNLFyIkTInqdGrHrOz5/QZXXxknTNB5RXP2tDzGm9nYPi
        176BvsBjKTEKRfGjsN670Os=
X-Google-Smtp-Source: ABdhPJyDUsK/VuL98mYFjInhcHy2ijcplRDJll8X3igW37KoLNQ+qQfg2G50sI1XsrZT2ZhkSXJHfQ==
X-Received: by 2002:a9d:6b8d:: with SMTP id b13mr9420606otq.316.1620847979896;
        Wed, 12 May 2021 12:32:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id c95sm140161otb.80.2021.05.12.12.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 12:32:59 -0700 (PDT)
Date:   Wed, 12 May 2021 14:32:53 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Gregory Anders <greg@gpanders.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <609c2d652d592_71bd120824@natae.notmuch>
In-Reply-To: <YJwZFpxKLTch/N6O@gpanders.com>
References: <20210512033039.4022-1-greg@gpanders.com>
 <609b8a5a65826_6e0fc2084c@natae.notmuch>
 <YJvUMTAVKJqPZF2t@gpanders.com>
 <609c0eaca8d28_71bd120878@natae.notmuch>
 <YJwZFpxKLTch/N6O@gpanders.com>
Subject: Re: [PATCH] git-send-email: add sendmailCommand option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders wrote:
> On Wed, 12 May 2021 12:21 -0500, Felipe Contreras wrote:
> >The sole purpose of software is that it's useful to users. Software 
> >that works today but not tomorrow is bad software.
> >
> >The primary purpose of the testing framework is to ensure that doesn't
> >happen; that git keeps working in the same way today than it did
> >yesterday.
> >
> >That's why it's more important that tests excercise the options people
> >were using yesterday.
> >
> >In addition we also want to be testing new functionality, but that's *in
> >addition*.
> >
> >Maybe at some point in the future more people will be using
> >--sendmail-cmd, but right now that's not the case. Right now we need to
> >be testing the option people are using *today*.
> 
> I agree with this completely. Is this requirement satisfied with the 
> addition of a test that checks the usage of an absolute path with 
> --smtp-server (the behavior that people were using yesterday), while all 
> of the existing tests are still converted to the new option? I have such 
> a test written (along with a few others) in the forthcoming v2 patch:

I still insist the current tests should not be converted. But ultimately
it's Junio's call.

Cheers.

-- 
Felipe Contreras
