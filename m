Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D812D1FAE2
	for <e@80x24.org>; Wed, 17 Jan 2018 19:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeAQTm2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 14:42:28 -0500
Received: from verein.lst.de ([213.95.11.211]:57422 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753412AbeAQTm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 14:42:27 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AB99768C4E; Wed, 17 Jan 2018 20:42:25 +0100 (CET)
Date:   Wed, 17 Jan 2018 20:42:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Christoph Hellwig <hch@lst.de>,
        git@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180117194225.GA30940@lst.de>
References: <20180117184828.31816-1-hch@lst.de> <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com> <20180117193731.GC25862@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180117193731.GC25862@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 11:37:31AM -0800, Matthew Wilcox wrote:
> How about this instead?
> 
> This option is enabled by default and ensures data integrity by calling
> fsync after writing object files.  It is not necessary on filesystems
> which journal data writes, but is still necessary on filesystems which
> do not use journalling (ext2), or that only journal metadata writes
> (OS X's HFS+, or Linux's ext4 with "data=writeback").  Turning this
> option off will increase performance at the possible risk of data loss.

I think this goes entirely into the wrong direction.  The point is
fsync is always the right thing to do.  But on ext3 (and ext3 only)
the right thing is way too painful, and conveniently ext3 happens
to be almost ok without it.  So if anything should get a special
mention it is ext3.
