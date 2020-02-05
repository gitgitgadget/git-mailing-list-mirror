Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3202C35247
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABEA02085B
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 00:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4sI3Kf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgBEAwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:52:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35637 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgBEAwn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 19:52:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id y73so262793pfg.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 16:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=njpouKVWoU7USFlPeCZF1SWQtIo30yeEmVNUqxEanMA=;
        b=R4sI3Kf2SDdfphQUy6jAzZBq+mByzSMgZp5knRQTNO6qxtrYd9SNp/6I/PAdy/5os9
         gBRfvSqCj3ZZugqwodxjE57u+aLZ30dr7gr0IskPr9OZ4b6W06KxtWCe1v5/lfrlNuFy
         O+PjFc7PCAU6giwJIj2EPAaIW0RkO+lcAWKYz1ZGlualBVs90KjjTTM5HnPPpsWULk+j
         51mvb+somlwCiDTlgJqTXO3naOqzQftD+nVoQjv1A13M34HWC83LQshQmOms/QXv8EMS
         mYhX1B4FcSw09wz+IWKOyujSqpihjkJjuLj1tRLG2svvufSEugMqOcvC9sJMo2YzoGzQ
         j4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=njpouKVWoU7USFlPeCZF1SWQtIo30yeEmVNUqxEanMA=;
        b=lEMMP8BaYHXpS9kbwnGc+rtazyXZpORBzsX/GPNBcZLSmoq5mdQVm+Z129ZWATuWq9
         cWrskt/7sWr1C1gppzvKWPpiDlFu6h86H9PE0nDNTiYUSpRr8FU0TDfbT4mnCO/8NMnD
         wj4niEOojz6xkN4YghlIORpNmc/GDpMhHXkaJFAP3qmDJZATlR1b34fGrMyKXUxLOYhw
         1O5isK4nGnZcmFcJWoUdy42gY2YfzBunsvWgsp99Yu0EsQkPTECq58WHOvirEkKa/zCj
         u9DYm2QtQhbRee8yxBvzUxn2ShsPbL2WzKWQrtDl2qCBNMgapUXDAahe5frvG5ue64A7
         j5qw==
X-Gm-Message-State: APjAAAUSBmz9v7sxQNqtQAHBaGyihJ7H0nGV7HatxMjhI22AmfkcQiUm
        FeKp4CiK3bBS6Uqr9TgdAt4+rw==
X-Google-Smtp-Source: APXvYqz0McoEVP+r7W9JwePDw6Q/sdSx5LrPQhfIyXj1/+oZ7Pz5LCVjov/oPlE2DnTGacseBppuGg==
X-Received: by 2002:a63:1044:: with SMTP id 4mr8216604pgq.412.1580863962693;
        Tue, 04 Feb 2020 16:52:42 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id p24sm24672360pgk.19.2020.02.04.16.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:52:42 -0800 (PST)
Date:   Tue, 4 Feb 2020 16:52:37 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 09/15] bugreport: generate config safelist based on
 docs
Message-ID: <20200205005237.GJ87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-10-emilyshaffer@google.com>
 <CAN0heSo2ujJr_Mi5xPv86NneLoXT3DM3dnRmTACs2VQERBq76Q@mail.gmail.com>
 <20200205003043.GH87163@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205003043.GH87163@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 04:30:43PM -0800, Emily Shaffer wrote:
> Yeah, I think this is a good point. I'll try to figure out how to reword
> the commit message, and take another look at the sample include/exclude
> change I made to see where I can omit entirely.

Eh. I'm going to try and reword the whole commit message. I combined
your scissors patch, plus something from Dscho's scissors patch, plus my
original commit message, and now it's huge and hard to follow.


 - Emily
