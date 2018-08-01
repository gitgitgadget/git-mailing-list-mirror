Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 320D31F597
	for <e@80x24.org>; Wed,  1 Aug 2018 22:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeHBALC (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 20:11:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53600 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeHBALC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 20:11:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so299371wmh.3
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yaOmnjJOe+6XYNf5UTjBCU6/D4juVY4cnCTdlpax9QM=;
        b=KIlsfU8C74RZKaBaw9c7js0e+bcIuHqUuuAq47+BbgPI+g9zIRAPhjVDCKJUUSR0+v
         7SXyCKqinyIoSCBmttK4B/F1i2VdPcQLkHCWC+I+4HcOWxjGAP+XTTF4Oc+r/HadZWL+
         GbgNbjcfJ3iWBVFh5Y5kT0lKOp8k34boymmgBZyhL5FuWxKIvlFpl0XToPKHtwmDGCxc
         btovOs6BU0TviX9FD0taZtnpjLhe+8T3pQu76ME7CncpmL6Tc5sPnhrkWUvp/yVi+bJ1
         KY/0lbklsgQzzHQO/TKzYp1SerOWLDujyhukGFS3BuJ7TB7lUWkeholKRREy6LiXMzwr
         /8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yaOmnjJOe+6XYNf5UTjBCU6/D4juVY4cnCTdlpax9QM=;
        b=NBwnEqUoWWMixFPVaO/bpUfhMbjVjfsSup72KiUQw+3CbjIiud6LWxV24ypM+fkJ03
         QcIsSWFxd3v5mRl7KBm7rz6ciglZqkgc45k/Y5nHYHdKlEv5bETsTNNSd5Cmmpr1gLrQ
         syfp8KKT2Ld8COD/cTQ+A3hLTjMQ4kUyJQ4OBBFa50OlaxfCnzKlArn5AM4g+SPlJqiA
         T5DqCZxCDKCJb3l0otyhRojQweYIe9kVqu+WQl7j92kp60SxGlPb7oky7YEElTvVZ+XD
         9jrXcHsVAtNIyk6yXiwzrv8V92NZN79y4E+r4Ik70cBNQ7pdsbwZH4bLTpmTAikk39Gq
         sLmQ==
X-Gm-Message-State: AOUpUlEMclIvRcKPekGyjj2AGYvWUQ7YRdS+0zTngCjCgtQoOuHJPpIR
        y4nVHb1fKIC+SlrPJCpyG5KBw8eU
X-Google-Smtp-Source: AAOMgpdbDp6zIpDkRqTnlew62+pCJGavqPuWGPLDXYfbj/WqQWOGrqwmVeJf0CwWNCLCdgxsi+sHxA==
X-Received: by 2002:a1c:2208:: with SMTP id i8-v6mr185319wmi.105.1533162182680;
        Wed, 01 Aug 2018 15:23:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u1-v6sm157452wrm.53.2018.08.01.15.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 15:23:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH] fetch-pack: unify ref in and out param
References: <20180729121900.GA16770@sigill.intra.peff.net>
        <20180801201320.201133-1-jonathantanmy@google.com>
        <20180801213826.GA66237@google.com>
Date:   Wed, 01 Aug 2018 15:23:01 -0700
In-Reply-To: <20180801213826.GA66237@google.com> (Brandon Williams's message
        of "Wed, 1 Aug 2018 14:38:26 -0700")
Message-ID: <xmqqk1p9681m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> ..., I expect we may need to do a bit more work on the whole
> fetching stack to get what we'd want in that case (because we would want
> to avoid this issue again).

Amen.  Thanks all.
