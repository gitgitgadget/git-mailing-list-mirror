Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14941F516
	for <e@80x24.org>; Tue, 26 Jun 2018 19:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932187AbeFZThY (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 15:37:24 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:37913 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753155AbeFZThY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 15:37:24 -0400
Received: by mail-lf0-f52.google.com with SMTP id a4-v6so7602859lff.5
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4l0RWY8GDdKGPi4RYXYHmV258ctrxu/s6d7hwViHG2o=;
        b=WKBv3e/TiXdcNWydR9pRRvP3BN/1pkiaZlVhFlEj3XlJneUgoyvl6pLWLxJL/hX7wt
         8U0ml8RXxh6dBSoTPD3zOoUtHZ1AGXnhnnKeiG/Igjz1teyyMuMaVgLB2iL8ZffsyAg3
         OE8fsLVIhrCpQEQ0iLuoboHzaBIEA7uPqybZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4l0RWY8GDdKGPi4RYXYHmV258ctrxu/s6d7hwViHG2o=;
        b=Qikypa67EgH6mLB9JNvW5PETZsaOBQTIk5Sds1cBbvxNK5uYvzlCYT8+udgb/qtoAv
         do3z1fcXl3NjdLtoeBUZStIrqnckNZsXdsIpg/Skqzl0yJjz5xAoeOjZHXi0QT8Vsabt
         ZlC5LLCxexU9iDKSwyuvI5frsVCvUjmHcw5f/f0dWECWH5voubaPQ4Xt6DBB6132aypE
         nMszkV3JRRT1e+Wha7VBC47OeiWKzWeWzlYBfHS/uHGm1+BognTiZAydtEBtuSiGyC45
         ux6SnqO5KuJGdprlSS8craRJ/4LUKYAr7aHrL72Bjz3aUJp+G2aiZGG7GvnjTI/m9zxb
         5rtQ==
X-Gm-Message-State: APt69E22awbrw9AbLmgYVTLJL6xZnfZ4Ul40vRv1x84m9Z90vuolce++
        OmRr6Qa1xgSA/YbYfN8DsLmi0VNJn6Xl9asFjpMYgw==
X-Google-Smtp-Source: AAOMgpcZ5ZIZE2Wv6gW47DXVnq+yIdH1fNo+GGG/votO3N+ZBJfRuSJfFIaaUalxHMsWz+yuvw56xlrOvvwCTpF/Xd4=
X-Received: by 2002:a19:ed0c:: with SMTP id y12-v6mr2246341lfy.91.1530041842626;
 Tue, 26 Jun 2018 12:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAP71WjzHffLRCDbjvF7qpexjXDMFcJkaPpEn=AtbSMCJd6QkBQ@mail.gmail.com>
 <xmqq1sctl676.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1sctl676.fsf@gitster-ct.c.googlers.com>
From:   Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date:   Tue, 26 Jun 2018 21:37:10 +0200
Message-ID: <CAP71Wjxxx=mNFUAOn331vjqqf77mkBgU_hE+SKoTuszx6MMjvg@mail.gmail.com>
Subject: Re: git rerere and diff3
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 9:05 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nicolas Dechesne <nicolas.dechesne@linaro.org> writes:
>
> > i have noticed that merge.conflictstyle has an impact on the rerere
> > resolution. looking briefly at the source code, it seems that git
> > tries to discard the common ancestor diff3 bits, but what I am seeing
> > is that if i do the following then it fails:
> >
> > 1. from a clean rr-cache state, with merge.conflictsytle=diff3, git
> > merge <branch with conflict>, resolve the conflicts, then commit
> > 2. undo the previous merge, remove merge.conflictstyle=diff3 (disable
> > diff3) and merge the *same* branch, then rerere won't fix the
> > conflicts
>
> It is possible that the conflict left when making the same merge are
> actually different when using these two conflict styles.  IOW, if
> the merge produces
>
>         <<<
>         side A
>         |||
>         common
>         ===
>         side B
>         >>>
>
> when diff3 style is chosen, but if the same merge results in
>
>         <<<
>         side A'
>         ===
>         side B'
>         >>>
>
> where side A' is not identical to side A (or B' and B are not
> identical), then we will fail to find the previously recorded
> resolution.

well, you're rigth.. that's what's happening...

=== with conflictstyle=merge
diff --cc arch/arm64/configs/defconfig
index 3cfa8ca26738,d53a1b00ad82..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -356,7 -334,7 +357,11 @@@ CONFIG_GPIO_PCA953X=
  CONFIG_GPIO_PCA953X_IRQ=y
  CONFIG_GPIO_MAX77620=y
  CONFIG_POWER_AVS=y
++<<<<<<< HEAD
 +CONFIG_ROCKCHIP_IODOMAIN=y
++=======
+ CONFIG_QCOM_CPR=y
++>>>>>>> tracking-qcomlt-8016-dvfs
  CONFIG_POWER_RESET_MSM=y
  CONFIG_POWER_RESET_XGENE=y
  CONFIG_POWER_RESET_SYSCON=y

=== with conflictstyle=diff3
diff --cc arch/arm64/configs/defconfig
index 3cfa8ca26738,d53a1b00ad82..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -355,8 -333,8 +356,14 @@@ CONFIG_GPIO_XGENE_SB=
  CONFIG_GPIO_PCA953X=y
  CONFIG_GPIO_PCA953X_IRQ=y
  CONFIG_GPIO_MAX77620=y
++<<<<<<< HEAD
 +CONFIG_POWER_AVS=y
 +CONFIG_ROCKCHIP_IODOMAIN=y
++||||||| merged common ancestors
++=======
+ CONFIG_POWER_AVS=y
+ CONFIG_QCOM_CPR=y
++>>>>>>> tracking-qcomlt-8016-dvfs
  CONFIG_POWER_RESET_MSM=y
  CONFIG_POWER_RESET_XGENE=y
  CONFIG_POWER_RESET_SYSCON=y

that explains it.. it was simpler than what I thought..

thanks!
