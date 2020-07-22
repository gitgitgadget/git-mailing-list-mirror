Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBAAC433E0
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 20:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3995207BB
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 20:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StnmTVu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732842AbgGVURT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732735AbgGVURT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 16:17:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D15C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 13:17:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k13so2055875lfo.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LCpFS9twzXag/uyihkjTigvQ+mbz7g4/A7HH3LDeJEQ=;
        b=StnmTVu7T91b+Ib9/YVXdIFRciOw3cc1CBHYWJ9w+gb7H/lNr0k5qam3M4zWfdOAJ0
         isFqa01Uscthf5+Auc5YbT8U4LtlFyRa9KuggaUBMqE5ssH8Pv1HaazBEAOCs3RTg9IJ
         B/P6ApZGhlYkNDIc203AtMnTyRhjBzwMDbcHJ65pTuOJ6Fa8/A1gGJVDow35CEOjwMYc
         uWbz1VcMJoSRhPQuteYJV3sf+W/gerWgt+i9w9SFYIb9mF2OKZ5zjACFMeZ1A9d4QHdn
         eD61z1wJte9dF/GLRLvNMCHJsWSq07ICiJxTE4nRNt4eOLRx3z3UuLs0EIcdzP6n93XB
         qZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=LCpFS9twzXag/uyihkjTigvQ+mbz7g4/A7HH3LDeJEQ=;
        b=B/waJRoZ4AWzsdFH9kQdJ5qSBe1gTDEzVg2rVOleCWjOgiLCs1/eUWTxXJsiJ00Sf2
         oyTvN3UUj68VKUvXlIhFPfG6WRSz/ovoaBldKCuklSiLXk7gzLC9FLjcHl7Z2ko1nBTY
         3lGECxpDtfOZE+Piu5RIiKSnrJbfMVNzxNFAfQWVuyyIkQAyBDCr2sbtlIyxdDq4Oykl
         fiPHSmEe41/cjcaoWMTCwJtvqjXnfWvjd0dj6hGITASEBIbClNKbvnisfbqKHny4U5Kd
         8+yhfYoHU8mmaVFxOPOuZDxqMNTbNTYm0TahzpqA1gatmEojasncJTPrKf3WFcaWWbxH
         Z9cQ==
X-Gm-Message-State: AOAM5314tA1BLG7EF2REL5jI8qOPraY6YiS8JoFYtQifzQJOy9RdlH8U
        tAsOO6Uo6fE7cZ2FZ8PgsRRrkx37
X-Google-Smtp-Source: ABdhPJxtZ8Jn1DQi47MPBicNpvNnGKs+/RGJE1AP/urlmawPCs2pGzPnDa6d+s7TDvEOJWGCTraJSA==
X-Received: by 2002:a19:431c:: with SMTP id q28mr487015lfa.211.1595449037031;
        Wed, 22 Jul 2020 13:17:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u9sm765693ljk.44.2020.07.22.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 13:17:16 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
Date:   Wed, 22 Jul 2020 23:17:15 +0300
In-Reply-To: <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org> (Johannes Sixt's
        message of "Wed, 22 Jul 2020 07:50:08 +0200")
Message-ID: <874kpzmhis.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 22.07.20 um 01:29 schrieb B. Stebler:
>> I have been looking for a tool to display merge conflicts, that instead
>> of showing the two versions of the conflicting section, would show the
>> diff for that section in both conflicting commits.
>
> Perhaps you want to configure `merge.conflictStyle=diff3`?

Is there 'git merge' command-line option for that? I failed to find one.

Thanks,
-- Sergey
