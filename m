Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A61C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 10:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiLPKNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 05:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiLPKNS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 05:13:18 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13872120A7
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 02:13:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id g1so1471571pfk.2
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 02:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBIftUYjoR57P3oY5e9kNsEh5LzBCGpWivIlpylf9ZE=;
        b=KrnTJV6eXbPNFk1nNQFI8GNF9euSFiBC+/6R4TBStmlbr6AQ5MkkR/X69uEtOIr5rs
         fKwp8oWnYCkhfhaoA92FAbw4t8FSH6BxAGBX+tEI2pMbtlgNRp3nnORTiThKqs1r6wCr
         EaZXAeYBYrvXJaYGpykbyzvzOYfz8v0VGq5LVlggKcOELerEBY8zX9V5jkwYrh6MSzbG
         9fLwv7uaIaueoXcOg1h8/N8n9FiJu8fuljnEPzmnzWDfLRd0GOVEAh5jCKPRwHCtcIbx
         twXMOFIxpRguPj3v8vO2A+TCPucoj1Fg1CTlDII2eEiBKe88STjU+TryYyBhrwDPYlYm
         9Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YBIftUYjoR57P3oY5e9kNsEh5LzBCGpWivIlpylf9ZE=;
        b=utsTVbh0o7Ux/ucOraHgUtSGWfm2Qwd6rMNd8zUcIjtM70Jqz5DnJa2C9ZVqfC1qfu
         AncJnz9DQoU6UGAuNdc9OPd5ePpA69CctT6r8ku5yaj9ifotVHp0cutjntq/jBDXk9X6
         RSqIM0C75b+PeN05DTLwlvrThpfJ373Yjcolu3CGZoiSz0RvObJd1gF6l3Djd7PpQmA3
         RzhrJIrt6RDgCpXsDZYDRxEVNnyjqGDUC8C0q8sxh5Z+qBGOdAAn4T4edg1Fzku9D2xb
         KQbNaUWFY5smbJC8eLSXsiA+PfmBjPkIC/R+LT5iS+bIN1cpTu+x3PiYvHNJb3vxBcX0
         VAPQ==
X-Gm-Message-State: ANoB5pn2KgpyIzum75OcSAIGMfDpSuVhzIEOZrqcTc1D9tqvGk+gHaNl
        HqS+Sxco3Ug197lUtbvbo3ITrI/nAefHhw==
X-Google-Smtp-Source: AA0mqf7xJYs07N1g7EreXBiOAeC3e63SOkc873n/Hq10NrxfjruE88dJfhLJGXp5HnIAmoYhzIXqPw==
X-Received: by 2002:aa7:828e:0:b0:574:6795:ff5e with SMTP id s14-20020aa7828e000000b005746795ff5emr27716005pfm.24.1671185596383;
        Fri, 16 Dec 2022 02:13:16 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x27-20020aa7957b000000b00576670cc170sm1151566pfq.93.2022.12.16.02.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 02:13:15 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH 2/2] Improve check-whitespace output
References: <pull.1444.git.1671179520.gitgitgadget@gmail.com>
        <cdc2b1aae81f8c37b4e71cb3e0e382cf82de2272.1671179520.git.gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 19:13:15 +0900
In-Reply-To: <cdc2b1aae81f8c37b4e71cb3e0e382cf82de2272.1671179520.git.gitgitgadget@gmail.com>
        (Chris. Webster via GitGitGadget's message of "Fri, 16 Dec 2022
        08:32:00 +0000")
Message-ID: <xmqqh6xvmzb8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: "Chris. Webster" <chris@webstech.net>

> Subject: Re: [PATCH 2/2] Improve check-whitespace output

The same comment about specificity of the improvements applies to
this one, too.  Also, I forgot to point out that our usual commit
title takes the form of "<area>: <description>", e.g.

	Subject: [PATCH 2/2] ci: show $X in check.whitespace output

where "show $X" is meant to be a more concrete phrase than "improve"
what the change is about and how it improves the output.

> +          echo "Run these commands to correct the problem:" >>$GITHUB_STEP_SUMMARY
> +          echo "1. \`git rebase --whitespace=fix ${goodparent}\`" >>$GITHUB_STEP_SUMMARY
> +          echo "1. \`git push --force\`" >>$GITHUB_STEP_SUMMARY

It's a bit curious to see two "1." and not "1." followed by "2."
here.  Is this meant to be processed by markdown or something so we
do not have to do the numbering ourselves, or something?

> +          echo " " >>$GITHUB_STEP_SUMMARY
> +          echo "Errors:" >>$GITHUB_STEP_SUMMARY
>            for i in "${problems[@]}"
>            do
>              echo "${i}" >>$GITHUB_STEP_SUMMARY

Thanks.
