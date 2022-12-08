Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C470C4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 05:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLHFuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 00:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLHFuy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 00:50:54 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2945A16
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 21:50:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id k7so545055pll.6
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 21:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i03eVpHn7YNP5EgheT+F111CkVjU+v32pYABqat5OfU=;
        b=Bn5cZ91/swgcTlYLJU3ZWeslP0Pe4V25Mkj5FxhvMbGsLLtkl/8PaUbH1oywmjTY+3
         DyMJrDMYlEiYYNqbOIpETP39qHbaUCMVQ7jqhNOvTtuXRHkn4wImvF2ETMDiJVzWh++f
         QGYdLXheDjIYK15tlO3eUDxh6oxwFS8zeZRhuOYXEynW0JBwwZrKHj6kdIQRdH5guGmg
         GFylnzwiCT2w0KqoxIop6kG/TsqQNvZl/DqNVYke1k+vkOj1x33VhDv7YlMNGDDX/h1o
         MBcBJCTjIsuvcL/B4Aa4CDE3df6tiJ21GmqlInBj//PtDN1sSHFO6SF72Pb51AfeaOLH
         flEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i03eVpHn7YNP5EgheT+F111CkVjU+v32pYABqat5OfU=;
        b=pOe+gzn/wdLT/an8ngMUSR3hiprERbayRpzs9rE3DR2Ed1Y4zF9TED8dhO1NBpgQ4B
         y97db4SaJ8cONBUv7jkWGA54Bwnk+Xyy8psA/+JobupKWmgrRhPorRBWLJHqjXxYy098
         wvX37R7yOtmWv8xxFtdkaTk0zkClqVfIB4yrIbEk1MOTEysD9/XKqnFAzzdH6gRaU29x
         2VIp6A4GcUC2NyAn/Oo0Kd0sqZWr/4k8ECf+9gZQjS15fk7wj5RS24GumAHzpj3m8bf5
         KICStYLOcCDYZTE/fPi2d2BYSnKo5UmaVPXOZMlLM0H6T//uxhat9e0Onaw87EROFFQ+
         2rgg==
X-Gm-Message-State: ANoB5pn4/hkXFt1Jt76KiNVBVgKGfoOtOLF6ejORYsATL22hrAB4cybf
        Wm5ZzHn+udl5w57sA1lyoHw08/gzk+ShqQ==
X-Google-Smtp-Source: AA0mqf5FvNfp6Bo2Q6YKTBT/mKPFuP315DRmGJvm3aYf/Y96hxvzhMSwGF3KKYu4lxQ14JrJX10few==
X-Received: by 2002:a17:90a:7347:b0:213:b6c8:2295 with SMTP id j7-20020a17090a734700b00213b6c82295mr1609826pjs.22.1670478653149;
        Wed, 07 Dec 2022 21:50:53 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id o15-20020a17090a9f8f00b0021870b2c7absm2042746pjp.42.2022.12.07.21.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 21:50:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Oscar Dominguez <dominguez.celada@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] Avoid using deprecated features in Git's GitHub
 workflows
References: <pull.1440.git.1670423680.gitgitgadget@gmail.com>
        <Y5EWUNbR1X+GrrNs@nand.local> <xmqqv8mm4vgu.fsf@gitster.g>
Date:   Thu, 08 Dec 2022 14:50:52 +0900
In-Reply-To: <xmqqv8mm4vgu.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        08 Dec 2022 08:58:41 +0900")
Message-ID: <xmqqh6y64f5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> On Wed, Dec 07, 2022 at 02:34:36PM +0000, Johannes Schindelin via GitGitGadget wrote:
>>> Johannes Schindelin (4):
>>>   ci: use a newer `github-script` version
>>>   ci: avoid deprecated `set-output` workflow command
>>>   ci: avoid using deprecated {up,down}load-artifacts Action
>>>   ci(l10n): avoid using the deprecated `set-output` workflow command
>>
>> These all look reasonable to me, minus the first one which is already
>> on 'master' as-is (unless I am missing something, but see my reply to
>> that email).
>
> I think we already have set-output ones figured out and queued in
> 'seen', and the third one alone cleanly applies without any others
> (and replaces my botched attempt ;-), so we are in good shape, I
> think.

So, with "checkout@v3" by Oscar a few days ago, "set-output to
$GITHUB_OUTPUT" by Ævar yesterday, and the "upload/download
artifact@v3" in this series, all queued near the tip of 'next', all
the deprecation warnings we have been seeing are now gone, cf.

  https://github.com/git/git/actions/runs/3644168470

Unfortunately, a new one says that ubuntu-22.04 will soon be used
when ubuntu-latest is called for X-<.

In any case, thank you, everybody, for cleaning up the CI workers.

