Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023B6C6FD1D
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 19:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjC0TuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 15:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjC0Tty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 15:49:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153C84ED1
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 12:49:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w4so9494769plg.9
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679946586;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VT/lVQ4L3EMvdneVxTB8J/4qzpc8jMcrg847tUwnnM=;
        b=jSMM+GNrSZZZM/OGuYaBT9eSdcUPs8q6pYWbmEglcortgffd7yZlolzqSxJ+QZuPB8
         cnTQ6umoKhtrwF2GdUYt61cjxOPbepKAGoa81PejsoKcI3n7nRaGokyAixbanX+VXc4o
         xqE9oeB71Hn92mTU19lEgyOvyu9oNs/86WrXChLEkc6VNxuLgcG31UHb9qUI3ezMQLuK
         36OkdMaRzlB99vGV46spvP5v/7+xEWOtOpi21QgXbP2R2dWRhdIbGi9N9y6zHFlJHkVf
         Wd7zltBlqsvwnJpfS6DxRRYbIPrNdBXhr3xzTkMB/e4nJTiZlknpng/yPOCvNDGhBXvi
         6aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946586;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VT/lVQ4L3EMvdneVxTB8J/4qzpc8jMcrg847tUwnnM=;
        b=yDG7/czlDiu993EIIJHysyACRWtluawNxTWJ+Xzmo/4b6UV1NxgfIi3iV3H8GLbBo8
         65Ole8h9F3h4pyyx5KD+csp6T1btS/+gR/EdSVwt7noyS+GF40XPX3w1tqW0M8vw1L0c
         7igQ02QEPhyAE06GHqxg7b3g1LG2hVL5O0w1mJjAATazuvtchjVGsHPmh1HmTwVDMTPJ
         7JHGF3ClplTHtz/ELR/lkVO2QElGjINf8uxJMQ4ja0Tdw+Gcj8i+9KZijjyVI4B+FEFH
         TejYB6rjgKzdUo1F+eCc1asvGfYL52Q6saoG5XzRnigXvDuGt0tR1wqFTT8P2fAt7E2s
         JwBg==
X-Gm-Message-State: AAQBX9cuDQzaLB1q7RVm87cdnx7d8jBsxSYLxYG+NAYOClSFShSUPWny
        3U9AnAYc8HbYU5DdcYpuK1A=
X-Google-Smtp-Source: AKy350ZiEvqvLcc2iAEPkHwiAnHWeMGN3UoOZKAlClv2x02HAuEyOeU2gBUJX1nM6XqdnVOZ91NiQg==
X-Received: by 2002:a17:902:e14c:b0:19f:2fd5:10dd with SMTP id d12-20020a170902e14c00b0019f2fd510ddmr10421574pla.24.1679946586170;
        Mon, 27 Mar 2023 12:49:46 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902760900b001a1a8e98e93sm19252383pll.287.2023.03.27.12.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 12:49:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v5 0/5] branch: operations on orphan branches
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
        <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
        <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
        <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
        <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Date:   Mon, 27 Mar 2023 12:49:45 -0700
In-Reply-To: <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Mon, 27 Mar 2023 00:19:36 +0200")
Message-ID: <xmqq7cv29dpi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> In this iteration, v5, I've reverted some of those major refactorings,
> mainly the inlining, because it ended up introducing unnecessary
> complexity for minimal benefit in this series.  Maybe those refactorings
> make more sense in future series.

The previous one has been cooking in 'next' already for some time
(even before the feature freeze for 2.40), so we'd usually do not
take such a rewrite and rather go with incremental refinements, but
let's discard it out of 'next' and queue this intereation instead.

We're probably overdue to rewind and rebuild 'next' this round
anyway.

Thanks for an updated version.  Will queue.

