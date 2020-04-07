Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CC6C2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A0120768
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYRuTO1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDGSfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:35:48 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37318 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGSfs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:35:48 -0400
Received: by mail-pj1-f68.google.com with SMTP id k3so123197pjj.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 11:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9ySLR+zW2nq5X3moFoECB9MOoJxPNGaoZ1D6ds3DYr0=;
        b=NYRuTO1YK4xfr0Uq1JsFxJCAxqWQd+1qY/ebQJX9V1FhirjqqBhuBUtdfGXpIDEqok
         LWhaDl1l22ZRbLLGxL4mpCoze4kvsIy/nRb6KIpgqKRWm+SAChgqB6apiRFabxrEIvSi
         OQZuOj1Z7jo5x2seJfZKrnRpBNJxQXetAGX1v9+YTEkJ9k6ixnGBLqiqCCBQe3p+AwM7
         8taNcLKOxZ8NqZNZdqVFaOKu1IRby5wIvQ9v5/bkboBLykG69cUiF9zMJI8CSlujrc43
         e4VOORC6nMMY1wuXLpm5d2i5ttf3CFMmm4uMU0NCfOKFXH5aGwoNh+giu9B2niQOUA2D
         r37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9ySLR+zW2nq5X3moFoECB9MOoJxPNGaoZ1D6ds3DYr0=;
        b=i3mTWBid84b4CYQWvD/oBUXaouwkCOWjHDPPqzVDPPJE0geeyzqSbXlNvsoQUcC2G7
         my1Q5dECypPiCj0u3Uwh16fXJUy4Ty3/C/bHzCswI+gh+LAXYMrYHLSg89o4cMFpIpPC
         HgzF7M3UA9yOPxdkakYFq0i2bJzOgnAWp4t3YucAZRSmxVoyanxxwNlvhbUKKbxSl0uV
         Dya0VIA0t+xgZkwaYj92RMgq71adNVxUsX+nNd85jYCHkv0QgypFpDI7w7EBzwL8HeNa
         OzaE82aR8FPjLqbtkegc92qDuAuAqgYtBn1yVAQgIQ/4x4duoyp2EpWve7abWdvCOLrO
         Kpvw==
X-Gm-Message-State: AGi0Puap8GPDbp2QJyizTYU5VLOttDmgFMBwMSswOQKrlh0H+g3TjCd4
        aS353qctiXJr5IMd+4H7C9MXZg==
X-Google-Smtp-Source: APiQypIeF9Dd+z2yW8EUmIR1u6ZShJAp/t4HGi7Ln5W0HZfOiPXCNPrkRs4EJ3RpCD9ABp4TIu5aQw==
X-Received: by 2002:a17:902:a404:: with SMTP id p4mr3711378plq.167.1586284546837;
        Tue, 07 Apr 2020 11:35:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id d84sm14534981pfd.197.2020.04.07.11.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:35:46 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:35:41 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v12 5/5] bugreport: add compiler info
Message-ID: <20200407183541.GA137962@google.com>
References: <20200406224526.256074-1-emilyshaffer@google.com>
 <20200406224526.256074-6-emilyshaffer@google.com>
 <20200406234738.GA2568@danh.dev>
 <xmqqpncjtjsh.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpncjtjsh.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 07, 2020 at 08:09:02AM -0700, Junio C Hamano wrote:
> Danh Doan <congdanhqx@gmail.com> writes:
> 
> > On 2020-04-06 15:45:26-0700, Emily Shaffer <emilyshaffer@google.com> wrote:
> >> Helped-by: Danh Doan <congdanhqx@gmail.com>
> >
> > If you ever send another version of this series, my Git identity is:
> >
> > Đoàn Trần Công Danh <congdanhqx@gmail.com>
> >
> > Thanks,
> 
> Thanks.
> 
Thanks Danh - I copied it from the email header, my apologies. Junio,
since you replied as well does that mean you updated your copy and I
don't need to re-send? (I haven't read the other comments yet, but your
comment on the cover letter makes me think you don't want a v13.)

 - Emily
