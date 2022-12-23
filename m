Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4CDC4332F
	for <git@archiver.kernel.org>; Fri, 23 Dec 2022 01:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiLWBfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 20:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiLWBe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 20:34:58 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E51D262F
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 17:34:57 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b2so3623042pld.7
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 17:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQPuR7ajWlS36VX+VFPROIXxLDuCmHIigaqZnLHMaxo=;
        b=U1bvsMgh7nMhgw0gYr3+faEsNSLc7ppmRUparkEJjmAfoFOwgHwx7OhcDRfAfb+t4S
         ZX2gYJOgbDgNwSNfo3XmWTNbUiYNJVi3qq9QCiEwkEtB/U2q+JpxlqBDWTJkDPm8wyuS
         dC+Qa8A7xa81rlGgixj86JrEUvTvY9LiRXsHjxaXUxwqHLKoqiVHcpF2D5+21ermnhBe
         kvpd89ZUZ7ykMAliO/XIQpfaEMqIQoVVCHorXklTbYfmv+4yn/ymcoTMevvlaQGEkLBv
         aCTGMwCCN5gUJOIB0jHZ69ZPigwFheG8hPYYJhI/rEywKvz3mRFna2Z5lHtDY9j4No+6
         5Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VQPuR7ajWlS36VX+VFPROIXxLDuCmHIigaqZnLHMaxo=;
        b=r/XnkAt7vmTYfcMSgZtUrSQzet/xVmp3DefzW9/g0UnZ6hCSCTEN690Qui1TbuSs3P
         jYSYxzLMuLNonzCM0dMMzoojZKA/RixcE6SJQWofMDj4KFjBvlX1MRJVnpe9VYsrTX/7
         BlY2rnouqCV6m3WHfqe66ugaILmFEbvDa7N40tJaIW59LlPmNzhVD4UiTV4q2gjbKXM+
         QqrtQlYHiiGjcn/YhGo56DKVsIaSxr4lZXkAP9X+Wop7c0fK67g9PXSAE38a8s5d4tqP
         WAg6e8JXbXaGGsPQEFuZE4I9OmUgcfBVKYp58bw6sib+5BebBjfMzv5XiDkizp7fjCY5
         O/cA==
X-Gm-Message-State: AFqh2koSPlXSBluBCcr99uKyxqKACudoNsvexBWBYLSMcZPQdU9qEa0b
        XpFU0rOcKyLKTcnlAkSFLNg=
X-Google-Smtp-Source: AMrXdXvg4krstOUXJX1GfqwsjdMQW0VbiTl/gOxDtEreC/uddX0VhGUW9K9G6RXI1HEVhXylKyIVbA==
X-Received: by 2002:a17:902:7792:b0:189:d0f7:dfbe with SMTP id o18-20020a170902779200b00189d0f7dfbemr24600700pll.30.1671759296605;
        Thu, 22 Dec 2022 17:34:56 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b001887e30b9ddsm1075686plf.257.2022.12.22.17.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 17:34:56 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] format-patch: support format.mboxrd with --stdout
References: <20221114094114.18986-1-e@80x24.org>
        <221114.86leodlbix.gmgdl@evledraar.gmail.com>
        <20221114205909.GA14736@dcvr> <xmqqv8m9wd7r.fsf@gitster.g>
        <20221222201619.M435985@dcvr>
Date:   Fri, 23 Dec 2022 10:34:55 +0900
In-Reply-To: <20221222201619.M435985@dcvr> (Eric Wong's message of "Thu, 22
        Dec 2022 20:16:19 +0000")
Message-ID: <xmqqedsqrjgg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Subject: [PATCH v2] format-patch: support format.mboxrd with --stdout
>
> mboxrd is a more robust output format when used with --stdout
> and needs more exposure.  Introducing this config knob lets
> users choose the more robust format for all their --stdout
> uses.
>
> Relying on --pretty=mboxrd and including all of pretty-formats.txt
> in the `git format-patch' documentation would likely be
> confusing to users.  Furthermore, this setting is useful across
> multiple invocations.  So introduce `format.mboxrd' as a boolean
> configuration knob that changes the default --pretty=email format
> to --pretty=mboxrd when (and only when) --stdout is in use.

Sounds sensible.
