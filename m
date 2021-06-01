Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEC4C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 22:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFD2613C1
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 22:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbhFAWf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 18:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhFAWf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 18:35:26 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8F1C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 15:33:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f11so199448lfq.4
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fkMJOhfIVixbZP5Qs6WbbAWz8DLPcxAFpz48eHrMfeQ=;
        b=EqPxO1O0pvtAcwAHAzuJgXUG51g6rZOVv8MOlDNxxrI1QbI7EtrU001IiFDAnJZxbi
         NFRr7g/nXxPGm49L56hoybFTTfRpWNg8EjkaOSqaKpbCGsn9DivPbLvVwdN2fQMUnZTy
         a6CG1fE2lRgP8zKVENMWpk8SvNXpDVfhlZtbkLN9r0rTygsdpb5TvhvUcp7U/6xHAtNA
         phkUNZnRryRlDrQkMwfx0I3RmmMTYXpjM1kYFgSFwfgKOjy5f7++AJvQ2ynVYjGtqZv2
         1TgYqBpAe4PXNJBN4/UZE7CqoQ7F5eoMJNmeo3/aGkT2lElNPbbnM8oMS2mbb5SYan/R
         YQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=fkMJOhfIVixbZP5Qs6WbbAWz8DLPcxAFpz48eHrMfeQ=;
        b=NpeO0lcagiuKMzhF8KAA7GE4i6cYSrRZQFuxIC72ktxuUpO6da9Q0WFj3+b2rfoE1I
         5F837J92Y8rDAkZG5wJju5XlY66fQM9eg92kjNyqLLJk6/HUXcz7K0us4ywIBMQOhiKJ
         z0AG+V+K3j98sMcJYw65zrUNoSv9qfm6LR2EZgMcU96Lm8ynoOtJLzL2HSyj8TBaRXb+
         cEfuzvIhqm7LdnoXzZpf1FsfIaIWqdyQIvDy97Mv7YFhp69EsqppSGbTf7ba2RY2E0iI
         tU57wwRkWaAgQ02y4cJymLx3SLWaPzFM+z75OvouD97cp1r0OtaXT4b+U7JSrSBtC1b3
         kF3g==
X-Gm-Message-State: AOAM531XHkoNXIO248dDq2/wU8GuAmnC9jvdKROWdhiWloc2W9PsrA2l
        2LpQ/dM23M2Wn1ClndRgeYzS/jh2nrw=
X-Google-Smtp-Source: ABdhPJzN6H67ePEmqLm5eQO6yoOVlupPLcDUmRpFlWvIbr7FBA3TklvUUgpULaIgIcd4UmJIxVbDlQ==
X-Received: by 2002:a19:f611:: with SMTP id x17mr20541405lfe.313.1622586822305;
        Tue, 01 Jun 2021 15:33:42 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id p1sm1805660lfr.78.2021.06.01.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 15:33:41 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
Date:   Wed, 02 Jun 2021 01:33:40 +0300
In-Reply-To: <60b5d281552d6_e359f20828@natae.notmuch> (Felipe Contreras's
        message of "Tue, 01 Jun 2021 01:24:01 -0500")
Message-ID: <87wnrd6wqj.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Hello,
>

[...]

> These are the configurations I've chosen:
>
>   [merge]
>     conflictstyle = diff3
>   [sendemail]
>     smtpserver = /usr/bin/msmtp
>

[pull]
	rebase = merges
[push]
	default = simple
[rerere]
	enabled = true
	autoupdate = true
[diff]
	algorithm = patience
[merge]
        conflictStyle = diff3

-- Sergey Organov
