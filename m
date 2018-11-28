Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C1B1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 11:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbeK1Wcs (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 17:32:48 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:46490 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727519AbeK1Wcr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 17:32:47 -0500
Received: from app06-neu.ox.hosteurope.de ([92.51.170.140] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1gRy3y-0005mQ-3a; Wed, 28 Nov 2018 12:31:26 +0100
Date:   Wed, 28 Nov 2018 12:31:26 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Message-ID: <1148695380.1653.1543404686042@ox.hosteurope.de>
In-Reply-To: <20181122162024.GD28192@sigill.intra.peff.net>
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
 <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
 <20181122162024.GD28192@sigill.intra.peff.net>
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev42
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1543404687;770d3593;
X-HE-SMSGID: 1gRy3y-0005mQ-3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jeff King <peff@peff.net> hat am 22. November 2018 um 17:20 geschrieben:
> 
> 
> On Wed, Nov 21, 2018 at 09:52:27PM +0100, Thomas Braun wrote:
> 
> > diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> > index 69fc55ea1e..8c2558b07d 100644
> > --- a/diffcore-pickaxe.c
> > +++ b/diffcore-pickaxe.c
> > @@ -144,6 +144,11 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
> >  		textconv_two = get_textconv(o->repo->index, p->two);
> >  	}
> >  
> > +	if ((o->pickaxe_opts & DIFF_PICKAXE_KIND_G) &&
> > +	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
> > +	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
> > +		return 0;
> 
> If the user passes "-a" to treat binary files as text, we should
> probably skip the binary check. I think we'd need to check
> "o->flags.text" here.

Good point. I missed that flag. Added.

> > diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> > index 844df760f7..42cc8afd8b 100755
> > --- a/t/t4209-log-pickaxe.sh
> > +++ b/t/t4209-log-pickaxe.sh
> > @@ -106,4 +106,26 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
> > [...]
> > +test_expect_success 'log -G ignores binary files' '
> > [...]
> > +test_expect_success 'log -G looks into binary files with textconv filter' '
> 
> And likewise add a test here similar to the textconv one.

Added as well.
