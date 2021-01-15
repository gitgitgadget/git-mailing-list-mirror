Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1D1C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6433923AC8
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbhAOCpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbhAOCpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 21:45:16 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE141C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:44:35 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id z11so10454592qkj.7
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nRZCzYAz7jiT4jesIFH9SjEQz0ZpSsLI6LR5ptAnjbY=;
        b=dsasBHNv826KoR0WvoLI+fr5vfOvnOwD3EsDTUKJjGK8b0Pn932wYZWR3s/jrD9Z+X
         vLEmLUBRRQ/h3mk6gg0oTLJERtLZq1D8dTVSNqqmCUbMvIcScD1V/nQy0Wl6/FXUeknW
         0bxAEZv7b9Wvn4ibeokddmM/Azmev5M/IFgo0thXc0yZPF9aqCP73Op3BctVJeDMw6Hp
         850vtvHrkl9QUb9QbUIHLLxXkn5ODg9+N62icYMEM52g/HDjKpXHEbD3JMYPrxPrTIMI
         DGqOQRMcaqCMRwvfOu03Ba4x38zb0h+U+PNxxWp22RZplIjLQRETDQplqPJI9Mwg8MBs
         jyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nRZCzYAz7jiT4jesIFH9SjEQz0ZpSsLI6LR5ptAnjbY=;
        b=qOVjArm6Ue9yX7uL1ZkTEizCJW2AylMSrLdabbUEzFpqncNNcl/UDpTRfIBYhvgFRn
         NYjaRyxXZ4faanh7pytqCAcASJiElp7Gp1efL+/cuLgxgebkai/6dXny9tP63JBlpPt9
         SAEoAEO7gwRsU8YRDcQ/NkOuK2SeXJDnNyy3ATxfi24naF1HA8+3VGm/a2ZoMhWN+twf
         fobi58v760iHMas5ocuD66EC/E4UANO4F6LNPkZZTwkMNeN45HuTZlYAq7Lr6oeRGUE+
         M9ijV/Jg4IT96UYezl7+b4s4p9pw5KREfEQvR6uDLaV+zJQUF2R61kjpBxQPp09xMvsa
         OzSw==
X-Gm-Message-State: AOAM531T/GxmwCUFUb210uZJuVphJu0gokYLG76hRdKB/laCBUjzsh/Z
        fAko/U2q/c5vymnIr0UAx9wGng==
X-Google-Smtp-Source: ABdhPJzjMV9kXnlfkspAYaSu3MKY/7L7uhsKP3Ggxqs/AziIyZm/flzTKqkrmd7oGyNnDGWG8xcyBQ==
X-Received: by 2002:a37:554:: with SMTP id 81mr10102866qkf.419.1610678675052;
        Thu, 14 Jan 2021 18:44:35 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d2a9:3030:291b:4b4])
        by smtp.gmail.com with ESMTPSA id m41sm4132385qtc.28.2021.01.14.18.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 18:44:34 -0800 (PST)
Date:   Thu, 14 Jan 2021 21:44:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
Message-ID: <YAEBkLihh1cb2NJB@nand.local>
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <YADOf41CcaRuToD7@google.com>
 <xmqqsg73ufxr.fsf@gitster.c.googlers.com>
 <YAD80TFOn0EX24wb@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAD80TFOn0EX24wb@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 09:24:17PM -0500, Taylor Blau wrote:
> I'm not Stolee, but isn't this what 'git config --fixed-value' is for?

My apologies: Emily suggested this in her original patch and I
completely read past it. I do think that this is better than repeating
pwd >expect, git config >actual, test_cmp expect actual over and over,
but credit where it's due.

Thanks,
Taylor
