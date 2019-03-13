Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DBA120248
	for <e@80x24.org>; Wed, 13 Mar 2019 11:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfCMLsM (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 07:48:12 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:40958 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfCMLsM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Mar 2019 07:48:12 -0400
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1h42Mg-0003O4-8F; Wed, 13 Mar 2019 12:48:06 +0100
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test
 on Fedora 29
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
 <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
 <20190311033755.GB7087@sigill.intra.peff.net>
 <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
 <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
 <20190311182328.GB16865@sigill.intra.peff.net>
 <xmqqa7i0h7r6.fsf@gitster-ct.c.googlers.com>
 <20190312105159.GB2023@sigill.intra.peff.net>
Message-ID: <7435b80b-6bd7-cab9-c646-5c81b639f117@virtuell-zuhause.de>
Date:   Wed, 13 Mar 2019 12:47:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190312105159.GB2023@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1552477690;ce766631;
X-HE-SMSGID: 1h42Mg-0003O4-8F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.03.2019 um 11:51 schrieb Jeff King:
> On Tue, Mar 12, 2019 at 04:27:57PM +0900, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>>> The problem to me is not that the steps that a developer has to do, but
>>> rather that we are dependent on the upstream project to make a simple
>>> fix (which they may not agree to do, or may take a long time to do).
>>
>> Yeah.  In practice, I think the recommended way to work for a
>> depending project like us is to keep a fork in a separate repository
>> we control of the submodule project, and allow our fork to be
>> slightly ahead of the upstream while feeding our change to them.
> 
> Reading Thomas's email again, that might actually have been what he was
> recommending. If so, sorry for the confusion. And I agree that's a valid
> solution.

Yes that is what I tried to explain. Looks like it was lost in translation.

> That said, I do wonder at some point if there's a huge value in using a
> submodule at that point. I think there is if the dependent project is
> large (and if it's optional, and some people might not need it). But in
> this case, it is not a big deal to just carry the sha1dc code in-tree.

A big win with submodules is that you have separate histories and can,
quite easily, update to newer versions without manual copying.

One grievance with submodules is the URL switching if you need to go
with a forked repo for some time and then back to the original.
Is it possible to have multiple remotes for a submodule?

Something like:

[submodule "libfoo"]
	path = include/foo
	url1 = git://foo.com/upstream/lib.git
	url2 = git://foo.com/myFork/lib.git

With that the error prone git submodule sync step is not required anymore.

submodule.alternateLocation looks like it is going into the right direction.
