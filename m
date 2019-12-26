Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F722C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 18:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FD620828
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 18:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLZS7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:59:32 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45564 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfLZS7c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 13:59:32 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 326D61F463;
        Thu, 26 Dec 2019 18:59:32 +0000 (UTC)
Date:   Thu, 26 Dec 2019 18:59:32 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] packfile: replace lseek+read with pread
Message-ID: <20191226185932.GA19165@dcvr>
References: <20191226104220.27325-1-e@80x24.org>
 <20191226104220.27325-3-e@80x24.org>
 <xmqqzhffkku2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhffkku2.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> >
> > Furthermore, readers of the packfile will be using mmap
> > (or pread to emulate mmap), anyways, so the file description
> > offset does not matter in this case.
> 
> s/description/descriptor/ probably.

No, I meant "description" :)  The offset is shared in case of dup{,2,3}
syscalls, which only creates a new descriptor, not a new description.
Both the Linux and POSIX lseek(2) manpages say "description".
