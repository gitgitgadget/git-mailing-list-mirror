Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB00C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC3F2220F
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 14:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgIQOUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:20:39 -0400
Received: from verein.lst.de ([213.95.11.211]:56515 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgIQOU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 10:20:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA5AD6736F; Thu, 17 Sep 2020 16:09:12 +0200 (CEST)
Date:   Thu, 17 Sep 2020 16:09:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
Message-ID: <20200917140912.GA27653@lst.de>
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200917112830.26606-2-avarab@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 01:28:29PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Change the behavior of core.fsyncObjectFiles to also sync the
> directory entry. I don't have a case where this broke, just going by
> paranoia and the fsync(2) manual page's guarantees about its behavior.

It is not just paranoia, but indeed what is required from the standards
POV.  At least for many Linux file systems your second fsync will be
very cheap (basically a NULL syscall) as the log has alredy been forced
all the way by the first one, but you can't rely on that.

Acked-by: Christoph Hellwig <hch@lst.de>
