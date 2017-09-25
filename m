Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66DE2202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 14:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934954AbdIYOka (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 10:40:30 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:57662 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933355AbdIYOk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 10:40:29 -0400
Received: from [192.197.121.178] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dwUYd-0003mu-KC
        for git@vger.kernel.org; Mon, 25 Sep 2017 10:40:28 -0400
Date:   Mon, 25 Sep 2017 10:40:21 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170925144021.vhbd3wb3uqejs5wq@hopa.kiewit.dartmouth.edu>
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
 <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
 <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
 <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 192.197.121.178
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: -s theirs use-case(s) Was: BUG: merge -s theirs  is not in effect
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 25 Sep 2017, Junio C Hamano wrote:
>    It is a different matter to resurrect the age old discussion that
>    happend in the summer of 2008 if '-s theirs' should or should not
>    exist.  In short, the previous discussion can be summarised to
>    "we don't want '-s theirs' as it encourages the wrong workflow".

>    https://public-inbox.org/git/alpine.DEB.1.00.0807290123300.2725@eeepc-johanness/
>    https://public-inbox.org/git/7vtzen7bul.fsf@gitster.siamese.dyndns.org/
>    https://public-inbox.org/git/20080720192130.6117@nanako3.lavabit.com/

>    It is OK for people to come with new perspective and bring new
>    ideas to the table.  We learned from experience while using Git
>    for longer and are wiser than what we were back then, and might
>    be able to make a better decision ;-)

FWIW

1. As a workaround for absence of -m theirs I using mtheirs git alias:
(I believe provided to me awhile back here on the list):

    mtheirs = !sh -c 'git merge -s ours --no-commit $1 && git read-tree -m -u $1' -

and it worked fine for my usecases

2. I think that if there is a reason for -s ours to exist, so there for -s theirs
since it is just the directionality of merges which changes between the two

3. My most frequently used use-case for -m theirs strategy is repositories such as 

http://datasets.datalad.org/openfmri/ds000001/.git

where we construct "datalad dataset" by crawling the web resource(s), and
workflow consists of 3 branches:

incoming             -- content from the web "as is"
incoming-processed   -- content from the web "processed" (fully automatically),
                        e.g. tarballs extracted etc
master               -- the "final" result, delivered to public

incoming-processed   is formed  by  -s theirs --no-commit  incoming, then all
content needed to be extracted/processed (since last such merge point) is
processed and commit is done.  Such "merge" allows us to establish a point of
previous "processing state" so we could react appropriately whenever anything
in "incoming" branch changes (so that there is a new commit).

  And then incoming-processed is merged (regular recursive) into the
master branch, which might have further "manual" tune ups.

PS thanks for CCing replies

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
