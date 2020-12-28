Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD65C433E6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 14:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D32208B6
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 14:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506043AbgL1Old (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 09:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506246AbgL1Ol1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 09:41:27 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD42C061798
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 06:40:47 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i6so9297819otr.2
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=fFZk8zRT60MXnHGYiBgHPj77Yd5IpCmUaSJj4WywQS0=;
        b=vWfuDOMQXYVs5/OE6ueI/HBdt8NNdumVazoRV5w+m58rcAWJCoK86V3JXEBftF8dTi
         ueNHzvG3O6lD4LnlA6pM53LLFGIB+N5J8GJe4KC3V0Wg//LoGRhraWpRTnzW012WCgdM
         e3GR/6hrm3kPclXeOt6UG7y4yYv+Zgw/bxtPJAb8aEpcSUL1el0MrAgkgEKRx1pc+T4N
         dGWOOCWA/QIvmwutqpvZPHoitI5fkaPszQ7SrFRQ3+CtXbLK0uRoBuVzw0sAvNCUjGpy
         4rR9y5XDqS65ucJpBJyuaOQ3KbzuaGpyng6xMnU7tF7LXpfGbCmtm1Mje+jBt5o7c0KL
         4TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=fFZk8zRT60MXnHGYiBgHPj77Yd5IpCmUaSJj4WywQS0=;
        b=JwP1mSOmjBEoAAb83azo95WQFsF7ohGHcq/7C5YNiINH07Ok8xZoRh5M257TCAtXr+
         MDeXBgF6hnraUMJ6CXbCIS6jqkPkMgaQj2MJPDe7ThdihE4EzpPvHUFyKqkH24/qqFKO
         YQs5LJto2UcgAM6AZXJgG78pbQNZQKgGZcGmr7hJf3E8dovF/4SEegLRcXhk8YHT9NM0
         keC5HgPbLxRHZbLR6LgGTLlvgwlK7uaG+LIhfx4wNIe8X36/1jzqMxf6Z/IMwo3E941V
         5UnRiJLWdtgLV+ZQmsDESKTTfwA3HM+Y79R/1FYLwx/612UyHA8xsZarN8pq7VqG3HE4
         H+KA==
X-Gm-Message-State: AOAM532ZzNnuHb5Qq1u/2YaUDiBmtOQWw22q8qIRk0hXQD9UI6ObKgot
        kp35J1S6E+hDDWT8OYfaaYg=
X-Google-Smtp-Source: ABdhPJypbD6hPxj27gVKFaUm6U0tXJUY4lF6YqLgJvOmADtLJz0qBGi4yuqEJf6dOpD8r7hv3Vu3xw==
X-Received: by 2002:a05:6830:110b:: with SMTP id w11mr32600647otq.285.1609166447183;
        Mon, 28 Dec 2020 06:40:47 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id m10sm9845578oig.27.2020.12.28.06.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 06:40:46 -0800 (PST)
Date:   Mon, 28 Dec 2020 08:40:45 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <5fe9ee6d58c2c_209d20891@natae.notmuch>
In-Reply-To: <xmqqsg7qjk9q.fsf@gitster.c.googlers.com>
References: <20201227205835.502556-1-seth@eseth.com>
 <20201228004152.522421-1-seth@eseth.com>
 <xmqqsg7qjk9q.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH v7 0/2] mergetool: add automerge configuration
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Also, instead of relaying as-is, you can relay a patch with your
> improvements rolled into the same patch (i.e. not as follow-up
> fixes).  Some (or major) parts of the original patch may still
> remain in the edited result and you'd need to keep original author's
> sign-off as-is [*1*].

Yes, you *can*, but doing so in this case would be against the author's
wishes, and a violation of the Developer Certificate of Origin.

> In this topic's case, 2/2 would be a feature enhancement on top of
> 1/2, so relaying 1/2 as-is would be OK, but in a case where an
> promising patch was sent with sign-off and bugs, then gets abandoned
> by the original author, fixing the bug in the patch you relay in
> place (i.e. not as follow-up patches) may even be necessary to keep
> bisectability.  When you do so, you'd typically do:

If the author doesn't object (which is usually the case), this makes
sense.

But if the author objects, you would be violating clause (d) of the DCO.

Just because the only way to do X is to violate laws, terms, or
agreements doesn't mean that's what you should do. You can simply not do
X.

-- 
Felipe Contreras
