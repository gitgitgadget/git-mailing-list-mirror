Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F991F954
	for <e@80x24.org>; Thu, 23 Aug 2018 11:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbeHWPRv (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 11:17:51 -0400
Received: from ao2.it ([92.243.12.208]:57216 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbeHWPRu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 11:17:50 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fso4W-0001Ju-3l; Thu, 23 Aug 2018 13:46:40 +0200
Date:   Thu, 23 Aug 2018 13:48:24 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/7] submodule: support reading .gitmodules even when
 it's not checked out
Message-Id: <20180823134824.db90021628baef8c6706fa38@ao2.it>
In-Reply-To: <xmqqd0ua773e.fsf@gitster-ct.c.googlers.com>
References: <20180814110525.17801-1-ao2@ao2.it>
        <20180814110525.17801-8-ao2@ao2.it>
        <xmqqmutoznwe.fsf@gitster-ct.c.googlers.com>
        <20180820233755.dc7b6a6927faccc37b25075f@ao2.it>
        <20180822135152.1d40cd05d0b0cadb5eefb31f@ao2.it>
        <xmqqd0ua773e.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 22 Aug 2018 08:29:25 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ao2@ao2.it> writes:
> 
[...]
> >> > > +		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
> >> > > +			config_source.blob = GITMODULES_HEAD;
> >> > 
> >> Would using ":.gitmodules" instead of "HEAD:.gitmodules" be enough?
> 
> Yeah, either "instead of", or "in addition" (i.e. "try the index
> version in addition, before falling further back to the HEAD
> version"), would be more consistent with the remainder of the system
> (or, at least where the remainder of the system wants to go).
>

OK, I now tested with both "rm .gitmodules" and "git rm .gitmodules"
and I see why one would want to try _both_ ":.gitmodules" and
"HEAD:.gitmodules".

I'll go with "in addition" then, adding tests for both the scenarios.

> >> If so, what name should I use instead of GITMODULES_HEAD?
> >> GITMODULES_BLOB is already taken for something different, maybe
> >> GITMODULES_REF or GITMODULES_OBJECT?
> 
> I do not know why you want to refrain from spelling them out as
> "HEAD:.gitmodules" and ":.gitmodules"; at least to me the extra
> layer of names do not look like they are making the code easier
> to understand that much.
> 

This is in the spirit of commit 4c0eeafe47 (cache.h: add
GITMODULES_FILE macro, 2017-08-02), IIRC this was done mainly to get
help from the preprocessor to spot typos: I caught myself writing
".gitmdoules" several times; GITMDOULES_FILE would not compile.

If this makes sense I'll use GITMODULES_INDEX and GITMODULES_HEAD.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
