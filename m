Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F405E1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 11:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeK1Wcd (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 17:32:33 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:46048 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727585AbeK1Wcd (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 17:32:33 -0500
Received: from app06-neu.ox.hosteurope.de ([92.51.170.140] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1gRy3i-0005ei-TO; Wed, 28 Nov 2018 12:31:10 +0100
Date:   Wed, 28 Nov 2018 12:31:10 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Message-ID: <2133674367.1646.1543404670839@ox.hosteurope.de>
In-Reply-To: <xmqqzhu1520k.fsf@gitster-ct.c.googlers.com>
References: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
 <84cbbfbd213b358d1e2d7cce8b4685b09efac3de.1542833244.git.thomas.braun@virtuell-zuhause.de>
 <xmqqzhu1520k.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH v1 2/2] log -S: Add test which searches in binary files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev42
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1543404673;81cdf37e;
X-HE-SMSGID: 1gRy3i-0005ei-TO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> hat am 22. November 2018 um 02:34 geschrieben:
> 
> 
> Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:
> 
> > The -S <regex> option of log looks for differences that changes the
> > number of occurrences of the specified string (i.e. addition/deletion)
> > in a file.
> 
> s/-S <regex>/-S<block of text>/ and
> s/the specified string/the specified block of text/ would make it
> more in line with how Documentation/gitdiffcore.txt explains it.
> The original discussion from early 2017 also explains with a pointer
> why the primary mode of -S is not <regex> but is <block of text>.

Thanks for the pointer. I've updated the commit message.
 
> > diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> > index 42cc8afd8b..d430f6f2f9 100755
> > --- a/t/t4209-log-pickaxe.sh
> > +++ b/t/t4209-log-pickaxe.sh
> > @@ -128,4 +128,15 @@ test_expect_success 'log -G looks into binary files with textconv filter' '
> >  	test_cmp actual expected
> >  '
> >  
> > +test_expect_success 'log -S looks into binary files' '
> > +	rm -rf .git &&
> > +	git init &&
> 
> Same comment as the one for 1/2 applies here.

Fixed as well.

> > +	printf "a\0b" >data.bin &&
> > +	git add data.bin &&
> > +	git commit -m "message" &&
> > +	git log -S a >actual &&
> > +	git log >expected &&
> > +	test_cmp actual expected
> > +'
> > +
> >  test_done
> 
> Other than these, I think both patches look sensible.  Thanks for
> resurrecting the old topic and reigniting it.
>
