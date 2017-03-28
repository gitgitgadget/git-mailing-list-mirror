Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00C3E1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 17:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755460AbdC1RyM (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 13:54:12 -0400
Received: from mx1.riseup.net ([198.252.153.129]:54786 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752624AbdC1RyL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 13:54:11 -0400
Received: from cotinga.riseup.net (unknown [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 5DB221A1927;
        Tue, 28 Mar 2017 17:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1490723643; bh=expdtW61GtUAGysuwEdVO/f1l0K/CPxRTHTzBywMwdo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ackDAbfkHjkU06d/x2wVrKzNnoPC7MPqBVHUKMzrrBwFKqt+6x+ZLOK8/lQu9FRP6
         +RObbw8f8kF8B6M9pGKs3C63o8YnPuS/mO41vioZm8saHPqghdPD9YIxnn8GCorWWO
         oSzFZ6Vk2D/lTteH9XNBsqutHVpfjryQleauXsRY=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: pickfire)
        with ESMTPSA id E8D6D4009F
Date:   Wed, 29 Mar 2017 01:53:56 +0800
From:   Pickfire <pickfire@riseup.net>
To:     jacob.keller@gmail.com
Cc:     git@vger.kernel.org
Subject: Re: Re: Microproject | Add more builtin patterns for
 userdiff
Message-ID: <20170328175356.1GG4n_Oas%pickfire@riseup.net>
References: <20170328104652.XsS8a6ysu%pickfire@riseup.net>
 <CA+P7+xr+vJP=usEhnR2gZdNY+k8035sX9FgFvvrrL5j_xCu=Mg@mail.gmail.com>
In-Reply-To: <CA+P7+xr+vJP=usEhnR2gZdNY+k8035sX9FgFvvrrL5j_xCu=Mg@mail.gmail.com>
Mail-Followup-To: jacob.keller@gmail.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> wrote:

> On Tue, Mar 28, 2017 at 3:46 AM, Pickfire <pickfire@riseup.net> wrote:
> > While I was working buildins shell patterns for user diffs. I noticed that
> > the tests t4034 passes but I can reproduce it manually with:
> >
> >     mkdir cpp/ && cd cpp/ && git init
> >
> >     cat > pre <<EOF
> >     Foo():x(0&&1){}
> >     cout<<"Hello World!\n"<<endl;
> >     1 -1e10 0xabcdef 'x'
> >     [a] a->b a.b
> >     !a ~a a++ a-- a*b a&b
> >     a*b a/b a%b
> >     a+b a-b
> >     a<<b a>>b
> >     a<b a<=b a>b a>=b
> >     a==b a!=b
> >     a&b
> >     a^b
> >     a|b
> >     a&&b
> >     a||b
> >     a?b:z
> >     a=b a+=b a-=b a*=b a/=b a%=b a<<=b a>>=b a&=b a^=b a|=b
> >     a,y
> >     a::b
> >     EOF
> >
> >     cat > post <<EOF
> >     Foo() : x(0&42) { bar(x); }
> >     cout<<"Hello World?\n"<<endl;
> >     (1) (-1e10) (0xabcdef) 'y'
> >     [x] x->y x.y
> >     !x ~x x++ x-- x*y x&y
> >     x*y x/y x%y
> >     x+y x-y
> >     x<<y x>>y
> >     x<y x<=y x>y x>=y
> >     x==y x!=y
> >     x&y
> >     x^y
> >     x|y
> >     x&&y
> >     x||y
> >     x?y:z
> >     x=y x+=y x-=y x*=y x/=y x%=y x<<=y x>>=y x&=y x^=y x|=y
> >     x,y
> >     x::y
> >     EOF
> >
> >     echo '* diff="cpp"' > .gitmodules
> >     git diff --no-index --color-words pre post > output
> >
> > Surprisingly, it shows (which is very different from the expected output):
> >
> 
> The diff test code uses "test_decode_color" function which decodes the
> color commands into human readable text. From the looks of it, you're
> trying to reproduce the test outside the test suite. However, you're
> not decoding the colors using the test library function, so it doesn't
> look right.

Yes, I can't reproduce it outside the test suite. I have added the builtin
and yet the test fails. test_decode_color gets same output as expect but
still it fails, should I send in the patch?
