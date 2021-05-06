Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6614AC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 10:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3067B611AC
	for <git@archiver.kernel.org>; Thu,  6 May 2021 10:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhEFKYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 06:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhEFKYI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 06:24:08 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80A9C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 03:23:09 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso4419180otp.7
        for <git@vger.kernel.org>; Thu, 06 May 2021 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=i2Qq9MmNps4PVjc1OlNzWBMwQuwBawZjE/iJWWGbvM0=;
        b=EGozqbySVsxlkHPM6dsmWHLhZTAqJPNEkSELiwjl9XpVCbMwV5ibelxIQrxOTQSY08
         VPSVfDiUL9xP4cMuC3Zik+0ojWYqJXxk50XVOb0opIIFJtnVFYfOj3pmsy5/H/BsDyWv
         TqWI50JQbMe9t4DmkPk7O/MB5kHLyT3nyS23APKn9deXiaj+aaM8pgIGk89WzpxiADk3
         TUc4soGG9bDyrZvayHkxBxFI1b/CEi8gxFFTTHxeOfGSLgzd86p91i6PPENRVG4y4vkW
         nMFhxdddwwrEDDWS8FZR1iwCjmfxqc4fqVOehU2b9ac5hh7brMZ2/f6Ri2ND4OimLymw
         JI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=i2Qq9MmNps4PVjc1OlNzWBMwQuwBawZjE/iJWWGbvM0=;
        b=MTv55t36hPZQPbOr0mWBoDR6aqq7OxGluPpwUyKcRbk3JR3TG6FOmf16m0j5rB8v1o
         jakwBnqO5DlAzhRsLcjGt1JJi8FDzPUIUIsUngGXKrXMCD7MnPxoMrBIOLCwGwcxswW4
         MrV5xx0Ay9iSF8CFy/YLq2I8kMmYYjiHRknakmFw0EYPKRjwKINsi7VCmT5M0HRfmkyU
         /n+Xiij3qKWL8KiOUsqvsgNZvlMEfFnLJgrVV0VnlL2C/SkZhZtub04JByVA/9zEMc1p
         pDZgcGFLre4y9YHgmDtrUitUiAdRDvOVrmLOEnbFuaD5AGrBX1bMB4WN1aPKIzfllOTz
         +yew==
X-Gm-Message-State: AOAM533NOTdVZJoPGhsNGW/FUtBP4HmewCTWE/smuEP56ZspJrw2QAzU
        JjbDingHNEKOv4khkVywucZkMhnPdvCWuQ==
X-Google-Smtp-Source: ABdhPJzeLYqlFlzPdjibNXAO+HGL+DzMQaqiyutZFkF7q+O/TA0zaQf7thg9stKw9LtJbmSe/yInsw==
X-Received: by 2002:a05:6830:30bc:: with SMTP id g28mr2985374ots.43.1620296589202;
        Thu, 06 May 2021 03:23:09 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id r18sm469344otp.74.2021.05.06.03.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 03:23:08 -0700 (PDT)
Date:   Thu, 06 May 2021 05:23:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Yuri <yuri@rawbw.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <6093c38b7ca62_325720884@natae.notmuch>
In-Reply-To: <f1bf3086-8c89-f0af-c0c7-f427a935771f@rawbw.com>
References: <d8aef355-0718-8b3d-7e9f-614673dd250f@rawbw.com>
 <fff9baee-ac4e-66ea-1dfb-791a8b044527@kdbg.org>
 <e75f000b-e376-45d5-ee5a-2a555076a3d9@rawbw.com>
 <35877543-93b8-00f8-692e-09a06d4679aa@kdbg.org>
 <d4ae27b9-3911-506c-a23c-3ed91bb250d1@rawbw.com>
 <xmqqbl9oz27g.fsf@gitster.g>
 <f1bf3086-8c89-f0af-c0c7-f427a935771f@rawbw.com>
Subject: Re: [feature suggestion] Add 'git stash export', 'git stash import'
 commands to allow to backup stash externally
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri wrote:
> On 5/6/21 1:38 AM, Junio C Hamano wrote:
> > Unlike centralized SCM like SVN and CVS, commits in Git are private
> > until you make them public by pushing, and you do not allow other
> > people to fetch/pull from the repository you actively work in.  If
> > your commits become public immediately after you make them, perhaps
> > there is a room in your workflow for vast improvement.
> 
> Let's say I make commit1, commit2, commit3 and then commit4.
> 
> How can I push only commit1 and commit3, but not commit2 and commit4?

You create a separate branch "for-upstream" based on the parent of
commit 1.

Then you chery-pick commit 1 and commit 3.

You can leave the other branch as-is, and deal with that later, or you
can rebaste that temporary branch on top of "for-upstream".

Or you can rebase first, create a new branch from tmp~2, and then push
it.

> Can I permanently hold some commits from being pushed while pushing
> others?

Yes.

-- 
Felipe Contreras
