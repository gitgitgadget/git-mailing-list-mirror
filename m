Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1097C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919DC206DD
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 06:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+vuPRp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgJBGHL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 02:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgJBGHL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 02:07:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3C2C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 23:07:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p187so655233ybg.14
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 23:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UoysABHX/Qi/pEvnGAr21nvfUltVktMZEE0Z8q/K8zQ=;
        b=F+vuPRp9sfbEKX4CNpHwlO0AmZSVFbJVXUZcJe7P2MKyF2T9Cl655qXuemDVIfKT8a
         wlMdjus2EFF9DUHglLeeZq4BTEKO+30xM4VTFh/dKiFdt1v0gDTBbm3CaesgDt90z4eB
         hhJg0GKB8ncDdaAoUYjrY08YYwyn6KHsi2XSCxngDJbb8gvlE7BznnbMXBHN9Ui1mZrK
         AmUcITylQfBY62Sh52qfxgdkl/aY5T0jAHmZIZr7WZl7ODjloRAsKwWYbMtdVCRLpEcT
         YAg85S2LqXHIpTB4MhTe66EGNvAyupIQEUUzcs0oYzw9GwfdelpeLfdkUvUTNIlqoTE5
         Y7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UoysABHX/Qi/pEvnGAr21nvfUltVktMZEE0Z8q/K8zQ=;
        b=RMViZwgKFTrQ+tT4WP3bPkkRTnkiGLrXQg2/p8P+xMq26ZwSJq1IdXZg5EBBtjROp9
         /34iAes0eGRylcYjCHAvGw+7j+TiZCz1VdJTzm8AHPr7xKTb9I9QdaUI/SOmmNmlrykr
         Z1zJxUL/KqIzfcvUTQNZwZr4o4woo3EZMwHB9PVk0u3lPXlqdkOvpSa1A/SaV6kWGtJ1
         MbUYHhL4ekKv9mvxFaVeRtC0z+vOHfPVeimHVC4TROJrNzmKrB2pTusv05hX5ij65PeD
         6IIIbSS3kcZKA63QNGVst37msn5kfSh9Q2McylfyaYnymgaHO81vQhJ8Rdo5dSy7D/kj
         Kyxg==
X-Gm-Message-State: AOAM531tddJzS+66Pa+7upNbu++L7Ohogp0U41Vig9Ow6LjvJKewmmxb
        4kaEyBd+j9lKFG3jOZlSaqYyY8M9RE0E
X-Google-Smtp-Source: ABdhPJyEQynEzo4RxK74cNu0KuXlVvWdRkff1wi0URw3D3AClTRAntO+ZDK13PfFbwG3vW3W3JyQYEzghccS
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a25:515:: with SMTP id 21mr809738ybf.114.1601618830261;
 Thu, 01 Oct 2020 23:07:10 -0700 (PDT)
Date:   Fri,  2 Oct 2020 06:07:09 +0000
In-Reply-To: <xmqqblhmer5b.fsf@gitster.c.googlers.com>
Message-Id: <20201002060709.4076630-1-shengfa@google.com>
Mime-Version: 1.0
References: <xmqqblhmer5b.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
From:   Shengfa Lin <shengfa@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> new file mode 100755
>>> index 0000000000..41ed9c27da
>>
>> Let's not waste a test number for just a single test or two.  Can't
>> we roll this into 
>
> ... an existing test for "git commit"?

Will move into an existing test for "git commit".

