Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A56B1F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755093AbcHSBd7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:33:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53244 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754638AbcHSBd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:33:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3328F203BD;
        Thu, 18 Aug 2016 22:48:14 +0000 (UTC)
Date:   Thu, 18 Aug 2016 22:48:14 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Ben Wijen <ben@wijen.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/2] mingw: ensure temporary file handles are not
 inherited by child processes
Message-ID: <20160818224814.GA10341@whir>
References: <cover.1471437637.git.johannes.schindelin@gmx.de>
 <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
 <20160818173555.GA29253@starla>
 <xmqqshu14udc.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshu14udc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Our codepaths themselves generally do not care about O_CLOEXEC, so
> giving a racy emulation of it is not worth the effort, making the
> later half of the above an overkill.

OK.

> Perhaps the three lines to
> define O_CLOEXEC to 0 on older UNIX might be sufficient.

I'd be more comfortable keeping the EINVAL check that got
snipped in your reply.  O_CLOEXEC can be defined to non-zero in
new userspace headers, but an older kernel chokes on it with
EINVAL.

I've seen this failure in the past with chroots.
