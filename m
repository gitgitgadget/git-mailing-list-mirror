Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F19020281
	for <e@80x24.org>; Tue, 26 Sep 2017 13:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936013AbdIZNco (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 09:32:44 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:43484 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934627AbdIZNcm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 09:32:42 -0400
Received: from hopa.wireless.dartmouth.edu ([10.31.185.85] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dwpyY-0001Nx-Js
        for git@vger.kernel.org; Tue, 26 Sep 2017 09:32:40 -0400
Date:   Tue, 26 Sep 2017 09:32:32 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170926133232.3yjasune6um4qw45@hopa.kiewit.dartmouth.edu>
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
 <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
 <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
 <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
 <20170925144021.vhbd3wb3uqejs5wq@hopa.kiewit.dartmouth.edu>
 <xmqqzi9iazrp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzi9iazrp.fsf@gitster.mtv.corp.google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 10.31.185.85
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: -s theirs use-case(s) Was: BUG: merge -s theirs  is not in effect
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, 26 Sep 2017, Junio C Hamano wrote:

> Yaroslav Halchenko <yoh@onerussian.com> writes:

> > 1. As a workaround for absence of -m theirs I using mtheirs git alias:
> > (I believe provided to me awhile back here on the list):

> >     mtheirs = !sh -c 'git merge -s ours --no-commit $1 && git read-tree -m -u $1' -

> > and it worked fine for my usecases

> > 2. I think that if there is a reason for -s ours to exist, so there for -s theirs
> > since it is just the directionality of merges which changes between the two

> Just on this point.  They are not exactly symmetric.

> Imagine there are some undesirable changes you want to vanquish from
> the world, but they have already built on useful changes on top of
> the undesirable changes.  A hypothetical history might look like
> this:

>                  B---C
>                 /
>            X---X---A
>           /
>       ---o---o         your mainline

> where 'X' denotes those unwanted changes.

> >...<

> The symmetiric case where _you_ have wrong changes do not need "-s
> theirs".  These mistakes X are yours, so are the changes depend on
> them:

>                  B---C
>                 /
>            X---X---A
>           /
>       ---o---o         their mainline

> and you can just rebase A, B and C on top of their mainline while
> getting rid of Xs yourself before publishing.

and that is where the gotcha comes -- what if "my" changes were already
published?  then I would like to avoid the rebase, and would -s theirs
to choose "their" solution in favor of mine and be able to push so
others could still "fast-forward" to the new state.

So -- as to me it remains 'symmetric' ;)

> There may be valid workflows that benefit from "-s theirs", and I
> would not be surprised at all if we found more of them in the past 9
> years since we had the "why -s theirs does not exist" discussion in
> 2008.  But "because -s ours can be used in reverse to emulate" is
> not a valid excuse to add "-s theirs".  It can be used a rationale
> against adding it (e.g. "-s theirs generally is discouraged because
> it forsters a bad workflow, but in a very rare case where it might
> be useful, you can always check out their branch and merge yours
> using '-s ours' to emulate it, so we do not lose any functionality
> even if we did not add it"), though.

sure, git is flexible, so workarounds could always be found, but often
many options are just a matter of convenience.  And here -s theirs would
be one of them besides my other use case where it is a somewhat "by
design" workflow, and -s theirs is use to take their exact state I would
improve upon (before committing the "merge")

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
