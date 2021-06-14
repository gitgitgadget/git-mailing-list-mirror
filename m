Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62782C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 20:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDE66128A
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 20:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhFNU0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 16:26:06 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:40490 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbhFNU0C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 16:26:02 -0400
Received: by mail-pf1-f173.google.com with SMTP id q25so11462229pfh.7
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 13:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wYKlhcrZ8plq2xkj8MovHlBfkjkWF5waiws14H23ywk=;
        b=JhSXPhwcj+KF3Vk3W1YL+nZl6/vsVg5PO/DOpZt/BNCLupBMzOKExKpr/3CeSbr3D7
         RZq7mApEjqWv90PPj9mtVdbPMEfFPyrCxgAhSdMyISjVb1hISmPVWyARZTdDeRmaFh5L
         GvWFWHhPNWPrRbvZ2t4mWnRQmFY+pF8cuSVeHLZ675ZrnG7NwXtrBk7LYB3KZ8UJ2z+T
         7PN8OHYVAXFnQM4uGI+Ut+WQ1oDRmgStRFbmx/+7yvNqhwiAdHzWlQ93TLM2TWBPO1/Q
         goUG5bRSWhLLstzmb/HbMqT9LCiGcv2g+rX0NmADG3dPr51h26dXL93brhlDJ7dhhjvN
         I+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wYKlhcrZ8plq2xkj8MovHlBfkjkWF5waiws14H23ywk=;
        b=Xz2l6FoXxvLVkcjcW9hOnBooJJI6Fq3AI7OgRMNu3FxEETXGNxnKoDHBg6k26BW91O
         PkhJzuP7864eSIQ4se6BRPzvMhDixV+CjT9zEp/HPuoY4dmO7lkDOMfVFZ7VuiPEsFdm
         kHehi8jyKXg14hdaTKduZKeinUu7uMhh61f8WT5Wok21/oDJKq9UGY+xOnhBgm1mp3H4
         zcDJMF0mV2qFiwl7rlLPbhYNxC5vOgPTTulbtYnXUw8L8ad7dZ6bsLaiI0drlrBZG0pB
         EBYp3KpO1qIVD4xR5O4FPDHzlFb9vYcUEBnHf4TOKZNcKC84gpp3VAXavHgK8cPnaz1J
         /G/Q==
X-Gm-Message-State: AOAM532mS/E6TBVB5bEq1BpCyXZmpzet26LbMmKUJS/00fMdTjYGA3WZ
        Ppe8fre3ZBQiJ1l34/6zek1VA0hbAgCDvA==
X-Google-Smtp-Source: ABdhPJwTzQBt8OrGRMFkJQQygdXHkfETw1jiaFODr6Sz0aG91OP6+NUa6tlkLIgH886eIiGRU7mOxw==
X-Received: by 2002:a62:1942:0:b029:2e9:debd:d8b1 with SMTP id 63-20020a6219420000b02902e9debdd8b1mr927840pfz.9.1623702178819;
        Mon, 14 Jun 2021 13:22:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:87fc:fefd:1365:fa14])
        by smtp.gmail.com with ESMTPSA id x20sm13265049pfh.112.2021.06.14.13.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 13:22:58 -0700 (PDT)
Date:   Mon, 14 Jun 2021 13:22:52 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 00/30] Minimal restart of "config-based-hooks"
Message-ID: <YMe6nJHxN2yO36wf@google.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 12:32:49PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> I proposed splitting Emily's "hook config" topic[1] into at least a
> topic that retains all current behavior of the codebase, and merely
> refactors existing behavior to new APIs, and then doing behavior
> changes later.
> 
> This is a re-roll of an attempt to do that. See v1's CL [2] for much
> more details.
> 
> I was hoping to get more feedback from Emily in reply to [3] and
> related E-Mails on the v1, but as it's been almost 2 weeks with no
> reply, and both her topic and mine semantically conflict with changes
> since merged to "master" I thought I'd send this re-roll.

Yes, sorry about this. I'm planning on reviewing your series this week.
Thanks for sending the v2.

 - Emily
