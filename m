Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF19FC636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 18:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBESNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 13:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBESND (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 13:13:03 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5C359C
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 10:13:02 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o13so9658988pjg.2
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7e0kXpyiviNJD0ih35DqrBOM6vGwMa8L7BqKzLHBv8=;
        b=IFT/NN3j89H/kuzymxGtr3syWln5b1bqtGTdot5qkXfvzffqUBsXwPxmMjmpybhbpw
         xq5DXr+bWq9kgfb5r7a49qBYexsjS+rG48xjArHgx53HiGCjKmOtd/haoQ/AnWAaH+af
         C1YNvi2vHU26DCAj4shvXcWXEvfzAuBEsls0JHsweE6qvLuzJc3WaYkpFk0n4kbuA10D
         028BJCrTY3TO2gl9SWa5en1JJufvCqjeh35VARJbdFr9pIbjkAfoq+KdgPAr2VQvV4KA
         j6zxGc/dLrZujrELOQMoMKkMUGl1y7eVK1Zd7woXR9s/fST1vOwwEpYXOoW3UgpOwZwF
         Deew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7e0kXpyiviNJD0ih35DqrBOM6vGwMa8L7BqKzLHBv8=;
        b=RJ3cWcMgE0GuRxgIMtZ+KqKmFJStHTDIIDWCUp+7W36D5z0Fv2jtFMdMZUCpyC2dKC
         hp2YvUjAQ3V0pcjzwckoQAfVF44MSWc15GCmYrzB0zrgpeYHxtGamynV+ypD9wV2V0nf
         cadapKTUP0s7Akbutaqor5dti2tpPjPdcb2iD2TrcReFkTLcFYjEDz/3qIQ+dXEgitH0
         zUpnZg1pqJIuEBCjXO8BCSnD2j+Icce992GRh6+M+wLJuufUlZmpaYEgogNRyDv7SNRi
         ThitXckyQJSgmkjldHLklP76AsuOZDlCgKSF2NRMNbLtiq97zqzGgaEoqkzFmydpo4jz
         gG0g==
X-Gm-Message-State: AO0yUKWkshsgsno8lkWi8BvzEenYQK8pVpkYSkSyBZUYErT3ErnmMCQz
        Jg0AJGdomRUAAsKU17LKMshZjFtEY4MrcFT2
X-Google-Smtp-Source: AK7set8vy9Qbt38Du/hyS13qT2gHV2PIEVqSStGNlcwdPbDtTziFm8jC6+35Ff3Eu3DCsYw6veR1DQ==
X-Received: by 2002:a17:902:c611:b0:198:e584:5823 with SMTP id r17-20020a170902c61100b00198e5845823mr6568679plr.34.1675620782226;
        Sun, 05 Feb 2023 10:13:02 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.146.128])
        by smtp.gmail.com with ESMTPSA id v22-20020a1709028d9600b00198fd66f4b7sm2152833plo.253.2023.02.05.10.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 10:13:01 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     gitster@pobox.com
Cc:     five231003@gmail.com, git@vger.kernel.org, newren@gmail.com
Subject: Re: [GSoC][PATCH] merge: use reverse_commit_list() for list reversal
Date:   Sun,  5 Feb 2023 23:42:57 +0530
Message-Id: <20230205181257.159652-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqmt5uo9ea.fsf@gitster.g>
References: <xmqqmt5uo9ea.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 4 Feb 2023 at 00:37, Junio C Hamano <gitster@pobox.com> wrote:

> One possible action item for us may be to rename or give comment to
> highlight the in-place destructive nature of the function to make it
> easier for developers to use (or avoid misusing) it.

There is a comment describing what the function does in commit.h but
it doesn't  _explicitly_ warn about this destructive behavior (although,
with a little thinking, developers can infer that the function can cause
this behavior after reading the comment). So, maybe we should go with the
comment being a bit more descriptive?

Thanks
