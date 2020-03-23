Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A677C43331
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C392073C
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 20:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="AG3RxMyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgCWURD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:17:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36404 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWURD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 16:17:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id j29so901477pgl.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hQNeL7cFA5w3oPJX4dECXwLVHnI24MGadUIUOb2oHrM=;
        b=AG3RxMySlfyfhkGVltGPxXG/D4PFYxtsAu35byr2Qvk2agLqVPwqDQz9vbWXlgGVRP
         rHHUcYVZCVhZcldYUIZgqZCJVFk7zZPJotyj1Rk13SSA2G2OcHgJ+DwOLBdoOwjo1UWV
         OcvUkuoz/T6ixEsdG9pxVog8jb6EClV+54LtK6ovNGKizPApA7YEh1ZmhEgJYoVh/JwG
         G8iSYHUxAnpJKTDrQbSOzjTZ3XaD1oL9qhdxbi5YHz3uxcdmjHB4BkMBeuf+muY2v2YU
         j4koeuPYQE5YFVjSGhg9XkRJ4RK8oBkNep3q4jp+xOFueOZBcgASMryzrHV/g5DNxJvl
         Aslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQNeL7cFA5w3oPJX4dECXwLVHnI24MGadUIUOb2oHrM=;
        b=kQG6K/7592q54e8TkyJr6EbkpGuMmFomn/qduoFbmQUn9SAY2IepytP71Zr5EqrYtF
         onvz5jjomOxRMulzyiAbHxBkfPMZIF29sjpV0ZVBVx3lVtwhm7AaJyIK4zTrvjCdcutK
         Ysu3tD/PcdinzSkMv8tGzFcJfyhR11miotQ2iZOkW8D/++3BSojK91vWh8iUFvmxSS2s
         owooOi2i+TnhP0Y91TwXjRqNIKg6mMorxekyjG+ldcLf+XsVhlNOj5xIfnmLORj6IUry
         EHs+I7vuhRuEqVyJAMlpXzIIgdAP9uYaw3KUzhgXH05SXeVaj39yEjJqB9wORH1qGP9F
         kDhg==
X-Gm-Message-State: ANhLgQ2kJ18r+dkFrh3b4Kmgm5ZEgVn1pSR9UFuF1/9P6Iz+S7+NGG+y
        sa72sunwZfmU4sJhBXBCS68WOA==
X-Google-Smtp-Source: ADFU+vulKxu0yG0XI4GroIfyL3LG6aN2SKvS6iJon+hevfoDVy83evqnIyNIz2poz8cWVf5gPPqY0Q==
X-Received: by 2002:a62:fb06:: with SMTP id x6mr25543760pfm.149.1584994621663;
        Mon, 23 Mar 2020 13:17:01 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id cq12sm407696pjb.7.2020.03.23.13.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 13:17:01 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:17:00 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2020, #07; Sun, 22)
Message-ID: <20200323201700.GA98968@syl.local>
References: <xmqqh7yf7u6q.fsf@gitster.c.googlers.com>
 <20200323191602.GC93624@syl.local>
 <xmqq4kue6fha.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kue6fha.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 23, 2020 at 12:25:21PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I noticed that this has been cooking in 'next' for a few weeks now. Is
> > there anything you're looking for specifically before graduating this to
> > master?
>
> Yeah, I saw some mention about "--input=none does not mean there is
> no input" confusion in a separate discussion in the past few days
> [*1*], which may make us reconsider the proposed UI by this series,
> and it is a good time to do so when we rewind/rebuild 'next' after
> a release (i.e. "now").

Makes sense. I hadn't responded to that thread yet because I thought
that it had already been discussed, but on second glance '--input=none'
really isn't as clear as it could be.

I posted [2], which I think should move things forward.

> [Reference]
>
> *1* https://lore.kernel.org/git/20200322110424.GC2224@szeder.dev/

Thanks,
Taylor

[2]: https://lore.kernel.org/git/e0f42a2f3c0162a5d43bb2bce0f69264b59f92e9.1584994172.git.me@ttaylorr.com/
