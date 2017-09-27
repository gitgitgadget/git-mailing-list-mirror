Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A9C20A26
	for <e@80x24.org>; Wed, 27 Sep 2017 20:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbdI0UVl (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 16:21:41 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:50588 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdI0UVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 16:21:40 -0400
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dxIpu-0001TN-C6
        for git@vger.kernel.org; Wed, 27 Sep 2017 16:21:39 -0400
Date:   Wed, 27 Sep 2017 16:21:32 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170927202132.e4gqbozkczctci5z@hopa.kiewit.dartmouth.edu>
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
 <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
 <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
 <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
 <20170925144021.vhbd3wb3uqejs5wq@hopa.kiewit.dartmouth.edu>
 <xmqqzi9iazrp.fsf@gitster.mtv.corp.google.com>
 <20170926133232.3yjasune6um4qw45@hopa.kiewit.dartmouth.edu>
 <xmqqzi9h80jp.fsf@gitster.mtv.corp.google.com>
 <20170927051915.tsxw2zycnjx4dyo4@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170927051915.tsxw2zycnjx4dyo4@hopa.kiewit.dartmouth.edu>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: -s theirs use-case(s) Was: BUG: merge -s theirs  is not in effect
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, 27 Sep 2017, Yaroslav Halchenko wrote:
> > And at that point, use of "-s ours" is no longer a workaround for
> > lack of "-s theirs".  It is a proper part of the desired semantics,
> > i.e. from the point of view of the surviving canonical history line,
> > you want to preserve what it did, nullifying what the other line of
> > history did.

> > So I still do not think the above scenario justifies "-s theirs".

> ok, when you describe it like this (in my case I rarely cared about the
> side of the merge), then indeed I might better do the entire dance with
> git reset --hard theirstate; git merge -s ours HEAD@{1}
> and live happily with the left side being the one always correct and
> hide "my" mistakes ;)  will keep it in mind

ha -- was about to use it, which reminded me about this use case!

NB pardon me for not so wonderful ascii-diagrams as yours but hopefully
still helps

              x-o-o-o-x-o-o    debian
             /        /
             x-------x-----    releases -- should just linearly sweep through releases I care about
            /       /
           R1      R2          various release branches/tags
           A       B           which have differing commits
          /       /
      ---o---o----o----o        masteg

For packaging some packages for Debian, with my git-rotten-soul, I am trying to
keep my debian packaging  (in a branch "debian") on top of upstream
releases.  But the problem comes whenever upstream releases from "release
branches", which are never merged into master and might have different and
conflicting changes.  

So, it becomes impossible to maintain a linearly progressing "debian"
branch without adding a middle-man between upstream releases (in release
branches), and debian branch (should progress linearly forward) -- "releases"
branch.  See e.g.  http://github.com/neurodebian/pandas and its releases
branch.

so I use -s theirs for "linearizing" the branched up development history

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
