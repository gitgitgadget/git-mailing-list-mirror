Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1719C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 03:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743CE20733
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 03:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o7hWRm1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgC3Dcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 23:32:52 -0400
Received: from mail-qv1-f74.google.com ([209.85.219.74]:53217 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgC3Dcw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 23:32:52 -0400
Received: by mail-qv1-f74.google.com with SMTP id f4so5983874qvu.19
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 20:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X5VkJaKO+gbds3G1D1ahZnzwoy68rKUqWTQls5D55oE=;
        b=o7hWRm1/z95psZlGPmy07XJZCKkrG4wirnRbiFqOdLysBpLyy4iHU81i0uHwe3KzLv
         9e3uguJvPkKVPLHHQ3kaUlOsTLnr5bDXsg45yaLDDBjd8G3QXiRgc+WorjsdbWptZ16b
         rMqKaVB0kviaxgOViH0HyaXfyBYr/Rc8pJAYMO83gLGS5pg9ixqmwAkHlx5hV9lwUzzD
         SB6Dp22wxw1WW6VNc4TquzhV5wKlrKjM0mRSG7uZqxzkh4488rsXSqPkgEDgU0RBs+C4
         z1ukOXblL8RgNR7TkM2EXNOjkngal2o9IMjb1Jyh4WYvuAXsup7NIVgbr02EJDa656h7
         0teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X5VkJaKO+gbds3G1D1ahZnzwoy68rKUqWTQls5D55oE=;
        b=sEUbzEIXURPo+I4blKes9vEcxtPeZr+9T3xYSt2rkKXsDgFD589t+s3LwqngvznCrF
         xdwBgH8CwSMYTeBKRRrznzc9Mq1bNgI9faUboMNppEhB+Pwb34SBe5v1w7lsqKy2W4uq
         lMIyMtSwb5QKB2RarF44Q/AdFleKgt8I9BG3xCGeG2qpjZuI7ArDWZkPQ2x9SkGcu5Zb
         8+abzSH0AcL0jOqyY8dYQywd807DV5NvTH9G2ZDG6vWe0/rukDS7H7WhzOAHnB3X+HZW
         i8mMYz3YpvO+oPHtHsHFQzDr6JF44Y07jFGvCUyTqxUIIzhTTRaCZvTS7fD+tWF2QanH
         S0aA==
X-Gm-Message-State: ANhLgQ2Z9Bq3UdLYZ6pydUkD2YpqHnEwtkncCjF6fBoPJhpB1cll9uZy
        RuLFPUfeonMBid5wesnHqWE5FH3Z7J5n0z0B/zej
X-Google-Smtp-Source: ADFU+vspoKgzbvdshlzBqWdnz3wNAlps2F0XYjso5TLlAluZ2prSGxXwK168AxmJS1wRVUVQUX6yh6s63Y8O3eXPEhBr
X-Received: by 2002:a0c:b617:: with SMTP id f23mr9811916qve.134.1585539170893;
 Sun, 29 Mar 2020 20:32:50 -0700 (PDT)
Date:   Sun, 29 Mar 2020 20:32:47 -0700
In-Reply-To: <xmqqeetbawlx.fsf@gitster.c.googlers.com>
Message-Id: <20200330033247.27880-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqeetbawlx.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: Re: [PATCH] connected: always use partial clone optimization
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, emilyshaffer@google.com,
        steadmon@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sounds good.  Jonathan?  I've squashed Josh'es Reviewed-by, but I
> will refrain from merging it to 'next' just yet to see if you too
> like the proposed code structure.

I think that this is a local enough concern that going either way won't
paint us into a corner, so if what's in
jt/connectivity-check-optim-in-partial-clone is OK, I prefer using that
to reduce churn.
