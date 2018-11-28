Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105C31F609
	for <e@80x24.org>; Wed, 28 Nov 2018 11:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbeK1Wch convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 28 Nov 2018 17:32:37 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:46318 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727519AbeK1Wch (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 17:32:37 -0500
Received: from app06-neu.ox.hosteurope.de ([92.51.170.140] helo=null); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1gRy3n-0005jY-EF; Wed, 28 Nov 2018 12:31:15 +0100
Date:   Wed, 28 Nov 2018 12:31:15 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Message-ID: <849207555.1650.1543404675371@ox.hosteurope.de>
In-Reply-To: <87lg5lzd7i.fsf@evledraar.gmail.com>
References: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
 <84cbbfbd213b358d1e2d7cce8b4685b09efac3de.1542833244.git.thomas.braun@virtuell-zuhause.de>
 <87lg5lzd7i.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v1 2/2] log -S: Add test which searches in binary files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev42
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1543404677;3ef8360e;
X-HE-SMSGID: 1gRy3n-0005jY-EF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> hat am 22. November 2018 um 10:14 geschrieben:
> 
> 
> 
> On Wed, Nov 21 2018, Thomas Braun wrote:
> 
> > The -S <regex> option of log looks for differences that changes the
> > number of occurrences of the specified string (i.e. addition/deletion)
> > in a file.
> >
> > Add a test to ensure that we keep looking into binary files with -S
> > as changing that would break backwards compatibility in unexpected ways.
> >
> > Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> > ---
> >  t/t4209-log-pickaxe.sh | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
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
> This should just be part of 1/2 since the behavior is changed there &
> the commit message should describe both cases.

My reasoning was that this is a separate test which does not fit in with the other part.
But I'm happy in folding both into one patch. Done.
