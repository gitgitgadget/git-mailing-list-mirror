Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97421C2D0C2
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FC620409
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 18:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W88rzK3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfL3Stv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:49:51 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:40127 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfL3Stv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 13:49:51 -0500
Received: by mail-pl1-f176.google.com with SMTP id s21so12217227plr.7
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 10:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xB72vkMpsYhNH1y3QPU20ZpPXHgrww7YH/dcc6e/xRM=;
        b=W88rzK3jmIjgmnY6jr37xUFXGQzjdw2Zqcgfea0KIvsXYXC7XxVYcnI2wYhPc7/eJU
         xu72g5nlQrX8l37UHOQDPvQWrUeeSysY0jZKUse4WeSz+ps9bwrw+nxYMqYmbQ0hzXnt
         YMWgaiPHHEGnLuJBIcL8lGMRcaphOu+7N398MpDOLmYM6+BXBKlUHoCZrtFRbJYHKvE3
         YZdznDdOJBhjk5l2n/EOmSreG/hPsgkTHq7guqTlJlzy0WoC4Y7zZUHDHgyNm+banILb
         2qcIspjlcqbJWlm9/Jt2cbPtyO8CMA/a1yxQm/R8C8nKJ6KEspx/ckzBGvus/ksMxlMW
         BfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xB72vkMpsYhNH1y3QPU20ZpPXHgrww7YH/dcc6e/xRM=;
        b=OIU1/TdfuhCIpo/ORsdiYy2nEL/NT8XonLg9DjTUWqsUBmDv4D5v/pYoUoPWj56dYE
         IRB3zuyzwzUQ4zqJbrlz98Cj1/zuP1uxfMM4gLnslp8c4slZ3+qafSTyChpkIjXLJITn
         bcDVhxVmG89OvB7WzQJdFY541cjEpfBabB0l4ggdTmA8vGSF6w+Py67Ac5iq0S0omzoh
         hOrui3dm9RXanSBBQBBzoWXePxjBlYzQDlDUTcW8a3aMzVuCoxN1v/1wq8UOwBCGOAtI
         4nCbr18LQD8GWHXhtOhvT5+zUJ0OqtzIdzO1VBlicb0Oi+UGAZ8bPt8L6K3gqQOCf+eu
         d1rw==
X-Gm-Message-State: APjAAAVrHq/OEDizHEV1+it6vcCcXLa0uDfi41vNWbgc2dvpGm6ioOhf
        7RhLWk24G9ITaOM0ok+2Pxn3q/ix
X-Google-Smtp-Source: APXvYqxCFAHs/ZfI9yv9z6uHWyQnReyeewHEXlSVxxCMbINh9rps+Ps5De825zA3P25IT2wo4xOSPQ==
X-Received: by 2002:a17:902:fe0d:: with SMTP id g13mr70097556plj.277.1577731790599;
        Mon, 30 Dec 2019 10:49:50 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 136sm47688730pgg.74.2019.12.30.10.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:49:49 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:49:48 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: ERANGE strikes again on my Windows build; RFH
Message-ID: <20191230184948.GC57251@google.com>
References: <6eb02a73-9dcb-f1fc-f015-80e71e9910d6@kdbg.org>
 <20191230180653.GA57251@google.com>
 <54522fee-0796-df46-a3cf-4331537ecf59@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54522fee-0796-df46-a3cf-4331537ecf59@kdbg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 30.12.19 um 19:06 schrieb Jonathan Nieder:

>>                                                                    when
>> errno is meaningful for a function for a given return value, the usual
>> convention is
>>
>>  (1) it *always* sets errno for errors, not conditionally
>
> You seem to understand that errno isn't set somewhere where it should be
> set.

On the contrary: this caller is using errno as an error *indicator*
instead of a way of *distinguishing* between errors (or to put it
another way, this caller is treating `errno == 0` as a meaningful
condition).  This means the calling code is buggy.

[...]
>> Do you have more details about the case where read_object is expected
>> to produce errno == 0?  I'm wondering whether we forgot to set 'errno
>> = ENOENT' explicitly somewhere.
>
> I don't think that forgetting to set ENOENT is the problem.
>
> It happens reproducibly in test 5 of t0410-partial-clone:

Thanks, will try it out.
