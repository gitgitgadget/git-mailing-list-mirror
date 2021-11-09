Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F57C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 20:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D4460187
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 20:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbhKIUEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 15:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242871AbhKIUEv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 15:04:51 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1693C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 12:02:04 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id b17so282776qvl.9
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 12:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9ZIiuRCh9QEYDqiuQ0LF254HYw+laPyZVcFTHWl1fc=;
        b=FzQlA6MB3s1jfpk9472RR0tfCOFvuU4ypXw+ZAl6fngte2Pb0dL8IuaL1+WTEygHZN
         T7dLNedxvjpaX/LplQ0TGYKE+9cVa17AhGIsk8n/YpLVOeAsKRLF07yVlHRKkqly4EwM
         IVbT5EmwHL0I8All+QARCc+KzWXdA4vkKl3nq+boP225n1p6mmtEFFgunJUBjo+e7oQH
         YwyGTrXrEsKbuKkgRrx3m3qYdBRgtA8gN2+wuNyiv/wrfy5/sJrwUsbDpcvj20g2aIzq
         6wtHHIJH45CK/lNHkk6x6WJ8pYIl0+YNjhsolGmHGMgkoFxr6uZB37ARAmGUwUAiB8r9
         Fwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9ZIiuRCh9QEYDqiuQ0LF254HYw+laPyZVcFTHWl1fc=;
        b=Pt3KGPCrFhLXxISqSpzz7k6zoDMRZkoJacyoQeuRBX2P2yBg9NgysutPmx1pDjWb7H
         EEILw3GTl5VAM9YdKWjJz/JhZ5uq5CCfcUNiGBN50CLPG+6PFWtX/sNjoH8T1MN4WZ8L
         s7ydUH8hoHvoZ5OCx5J7dz8Ezr34X8Uii9F7bT56/9sGjKDwBETvFgIjXAYlllIRtVFb
         UY/3fERS1OLuyvxmZG+71ZKsrURpRGwUfJ/exC1b1Dg1oKB4DXz+w0NPzuVGEFSPUAzZ
         61kGwvRl+C+B1LV7U+5JrTVz73cKGlaM7FsA5hQNlxuWw590NJgo3xD8YHO5drDxJ2rH
         dzLQ==
X-Gm-Message-State: AOAM530DesVMfAx7+YKWpxxFDh4RHpw1RRvsQZA6dgzgyZn4SW6cVe0O
        g2ZTIMFBgZppAMNrYDtYLqezG/vdXDglxJoc
X-Google-Smtp-Source: ABdhPJxrEW1E5VbGJS+yHe6usUVIC3bt7wPUVkPocSeCs51SoOQTxNqOM+N4vHkRCYpYJ2hbnC88GQ==
X-Received: by 2002:a05:6214:1c86:: with SMTP id ib6mr9833987qvb.26.1636488124164;
        Tue, 09 Nov 2021 12:02:04 -0800 (PST)
Received: from samxps.umontreal.ca (x-132-204-243-123.xtpr.umontreal.ca. [132.204.243.123])
        by smtp.gmail.com with ESMTPSA id l15sm111211qtx.77.2021.11.09.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 12:02:03 -0800 (PST)
From:   Samuel Yvon <samuelyvon9@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
        samuelyvon9@gmail.com
Subject: Re: [PATCH] builtin-commit: re-read file index before launching editor
Date:   Tue,  9 Nov 2021 15:01:23 -0500
Message-Id: <20211109200123.27763-1-samuelyvon9@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <xmqqbl2t2n2p.fsf@gitster.g>
References: <xmqqbl2t2n2p.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> You seem to be quoting the thread over and over, but what you are
> quoting is somewhat different from the concluding part of what I
> said, which was:
>> If I have to guess, I think the reason is because pre-commit
>> automation is expected to be some sort of mechanical change and
>> not part of the actual work that the end-user produced, it would
>> become easier to perform the "final review" of "what have I done
>> so far---does everything make sense?"  if such "extra" changes
>> are excluded.
> So, in short, it is not "undefined", but rather it seems to be a
> designed behaviour that we are seeing.

Apologies if you feel I misquoted you. I am confused by the comment in the
original code w.r.t the location of the cache reset, which (from my
understanding) is contradictory with the quoted conversation and so I
focused on those parts.

Junio C Hamano <gitster@pobox.com> writes:
> I do not personally mind if we change the philosophy but because it
> has been a longstanding designed behaviour, it may need a careful
> transition plan.

Out of curiosity, what would that involve? 
