Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B79C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 22:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjBNWZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjBNWZV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 17:25:21 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DA53C0D
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:25:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so183288pjw.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Zb1vceT1NP8QcyylpX/maExNPrZsWAqE4ntVYRzc4k=;
        b=QHOsP38SJAeUIvmikPMyWA7ezm90Cqn5J876jVsQ+eW5vk1hjnmiLfmmPJe4b0HSre
         PNlkYTGXCVC5ixho406vu+atVWlXnXYcLQVnCtBsFNkmJYz68II4SElHPvSYONgEGF0E
         cH97x7BAqYxGxfcxkVcJUrxEVlGhYYXfgckLPpUvfamEPa4Ij4QOmfUdGO+78NIhU/Vg
         Q5FvDrwuOfc5Qoj8xj0Cp3bCarTOXSThNOQaUlgqWbjSQQcRkT99DQmJZ05zQ/03CenC
         zNykEI1DwmO68FhTv20I0NgsXZhdKdA1AVTa+Ll3ML5Yh33ynOOsSpmGqsq+vhpshLjP
         IBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Zb1vceT1NP8QcyylpX/maExNPrZsWAqE4ntVYRzc4k=;
        b=Ncn/AX3n+PSz4FRUXBrYVG+mbNE7ZQN6A5SArV5cpvmxokSQmUF2CYx8OZCp2CpCBR
         ffFNlrZb/bpARpC0W6/DTtQevy4ckFFV/aoVc9zDzstD6D/EEPtfzzGiCcY77U6c5t/w
         b+sUMCYScW+cNiwgqkRYA/Si5HcZmjxLfLmyGR8ekVaBa3lrLURFxAIL/5PjFslXbw4u
         XVRtnr6U+LyunxCbCJakLtDTDnFAn2D9yk1ZuoFvni/3KgJ8VsYAUq7WPuj8adp/pgop
         OvdPH/KBtxR66S5Y67ZaVcPdCqxoVp1xaeRm5R816YgTxre3LKmUPV6D8nZ8PfosjCzO
         L7Mg==
X-Gm-Message-State: AO0yUKXfLiPXaIXA+rzaHtQR0ByLvwQWirBh7XeaWyWgys965Gq+SIwT
        f/f9pK7JKiPJKpfY+KRFGh6emUMjHWA=
X-Google-Smtp-Source: AK7set9+6GWj7TqDZgy5HVPP1aV50dza0IdjvL2lxoiSTgkXFkIILjQ2ZGq4Zf4fwDWkYDfnzm9bxQ==
X-Received: by 2002:a17:90b:4a47:b0:234:19a1:8690 with SMTP id lb7-20020a17090b4a4700b0023419a18690mr398663pjb.26.1676413520061;
        Tue, 14 Feb 2023 14:25:20 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id dw24-20020a17090b095800b00230ab56a1f3sm28010pjb.51.2023.02.14.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:25:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): avoid sscanf()
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
        <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net>
        <xmqqmt5f535i.fsf@gitster.g>
Date:   Tue, 14 Feb 2023 14:25:19 -0800
In-Reply-To: <xmqqmt5f535i.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        14 Feb 2023 13:48:57 -0800")
Message-ID: <xmqq5yc351gw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Am I reading the loop correctly?  I wanted the bogus refname not to
> match the rule, but without peeking back refname[-1], I cannot tell
> the two cases apart at this point.


Heh.

    $ git symbolic-ref BOGO refsXheads/naster
    $ git symbolic-ref --short BOGO
    heads/naster

