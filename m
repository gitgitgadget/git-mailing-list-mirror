Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E93A211B3
	for <e@80x24.org>; Fri, 14 Dec 2018 18:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbeLNSp6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 13:45:58 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:39882 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730123AbeLNSp6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Dec 2018 13:45:58 -0500
Received: from app13-neu.ox.hosteurope.de ([92.51.170.147]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1gXsTC-0002SP-8V; Fri, 14 Dec 2018 19:45:54 +0100
Date:   Fri, 14 Dec 2018 19:45:54 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        avarab@gmail.com
Message-ID: <1758521848.95160.1544813154194@ox.hosteurope.de>
In-Reply-To: <xmqq5zwgny9d.fsf@gitster-ct.c.googlers.com>
References: <1535679074.141165.1542834055343@ox.hosteurope.de>
 <c4eac0b0ff0812e5aa8b081e603fc8bdd042ddeb.1543403143.git.thomas.braun@virtuell-zuhause.de>
 <xmqqa7lsnyu5.fsf@gitster-ct.c.googlers.com>
 <xmqq5zwgny9d.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH v2] log -G: Ignore binary files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1544813157;2e6dee6b;
X-HE-SMSGID: 1gXsTC-0002SP-8V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> hat am 29. November 2018 um 08:22 geschrieben:
> 
> 
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +test_expect_success 'log -G ignores binary files' '
> >> +	git checkout --orphan orphan1 &&
> >> +	printf "a\0a" >data.bin &&
> >> +	git add data.bin &&
> >> +	git commit -m "message" &&
> >> +	git log -Ga >result &&
> >> +	test_must_be_empty result
> >> +'
> >
> > As this is the first mention of data.bin, this is adding a new file
> > data.bin that has two 'a' but is a binary file.  And that is the
> > only commit in the history leading to orphan1.
> >
> > The fact that "log -Ga" won't find any means it missed the creation
> > event, because the blob is binary.  Good.
> 
> By the way, this root commit records another file whose path is
> "file" and has "Picked<LF>" in it.  If the file had 'a' in it, it
> would have been included in "git log" output, but that is too subtle
> a point to be noticed by the readers who are only reading this patch
> without seeing what has been done to the index before this test
> piece.
> 
> If you are going to restructure these tests to create a three-commit
> history in a single expect_success that is inspected with various
> "log -Ga" invocations in subsequent tests, it is worth removing that
> other file (or rather, starting with "read-tree --empty" immediately
> after checking out the orphan branch, to clarify to the readers that
> there is nothing but what you add in the set-up step in the index)
> to make the test more robust.

Thanks for the explanation. First I though that "checkout --orphan"
already takes care of everything but "read-tree --empty" is the way to go.

Done.
