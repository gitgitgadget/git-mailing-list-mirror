Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C080C352BE
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A052075E
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 16:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEc+6ekP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391583AbgDNQ1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391533AbgDNQ04 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 12:26:56 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44FBC061A0F
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 09:26:56 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di6so97880qvb.10
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=14t/o5r1yMuhaB5ReRN4U2glQbggcee5/EJbnkQGlX0=;
        b=QEc+6ekPnXThZlGiTdKvW8N7gyDHPFMMRp+fNlax4wTa9babKnXkQnD55u1U3Fzlck
         LooN+PXExDMpl/R2Atrm1zq+4Au0VVoX1lpUpPb3GuOhnhCv+rm05L9AtYJgCPg1DG9V
         HVwP93gkS6hgEPl5M7YskpWhszyzsAre8ZgWrAI4WA6ZEFTrkC7FBHdTDr0logzFEo1Z
         /r8ergcGvsa/Or+87Fgb4SyFAXYHaw4ykRBAfz5i6qdL5ZhyA6ObudeGCaOWZBuHF9tW
         iKE7dgfW+schJ7+6y1VaD/gZDsPNQOHkvgjK6Mf6Xw1vYiGbVkkrsllwb3xxvwgc1OhO
         VlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=14t/o5r1yMuhaB5ReRN4U2glQbggcee5/EJbnkQGlX0=;
        b=hRYI3wHryBdKZc2AD2DGgdK69C4pWQ/tVYXWLBQ0XgFrSC+kqDbcpKPrHD2jMiptEJ
         aEKE4OBAQCmBqZtVOfQMQ0od3CeJR6DOAdEJAm+ABJYZsDvYnY6TiNbu50Yuow6R3oMz
         FzBRBsC6+BGfWpiOuq9joyS2IMrTtQEOhAqflT4KR0yjhsQK3nfziJu1xqi0wO1zacQ1
         6bm+rvtH+zSvT30g5NnaA3pEhuHc3uYPv8KsYv8E8pnHnxr0XoJMbXZJ9yYQD9ez2nW7
         4TPWHkJlkcCUVHTLI62NSAkY7lqgqIdSQ2ydKoerBT7XuJZIlZ1vVG74cl478Tu60Wcx
         zptw==
X-Gm-Message-State: AGi0PuaVmqr9zSqGTNnhf3hpA9n/+kC3Qa3OjnCzOT3rN84VvWPUggU0
        lB3hDJalANvl0sMt6Q67X8E=
X-Google-Smtp-Source: APiQypIdmmK0O/0O7h3ur7Dr+7AXLaKgR9Lx98d8qfVUSsIOsSF11d4FdqkXTfw4oI5kndMAGmv8VA==
X-Received: by 2002:a05:6214:8d3:: with SMTP id da19mr789629qvb.49.1586881615751;
        Tue, 14 Apr 2020 09:26:55 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f14sm10808005qtp.55.2020.04.14.09.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 09:26:55 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] clone: document partial clone section
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
 <pull.745.v2.git.git.1586791560.gitgitgadget@gmail.com>
 <xmqqd08batub.fsf@gitster.c.googlers.com>
 <e77309ef-68a4-0ebd-0d82-051b07838fd5@gmail.com>
 <xmqqimi29gqy.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3e3ef5ff-a808-efa0-ee32-9d24981efa0c@gmail.com>
Date:   Tue, 14 Apr 2020 12:26:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <xmqqimi29gqy.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2020 12:25 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> ... Then when I force-pushed my branch his GGG PR
>> "grew" with the old commits.
> 
> Ah, so we only need to review [3/3], treating it as a single patch
> series?

Correct. Thanks.

-Stolee
