Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C98EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjF0QYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjF0QYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:24:22 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9B4358E
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687883053; x=1688487853; i=l.s.r@web.de;
 bh=g1SgrQxgRiytuW7PmE2J6onWdqOKMWIjj7tLwcvdvJM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=J58mdABCpvGalgc5gDZrXjtqqIsLFWZ/q1NTUeo9GlJnxjEhJoNPVYJgjL++5Bhj1iAVFg4
 1NrdmGYszNIQrxRYGV2a21QSEeiWcfS1GKAIvz9ZUc+vCVzIvQW/JEzuyDTu5ZJY48R9VV1W/
 QXOeoLAL2VqjiQlH11tYgZtT65mSk8+DBQnaXaG/w7483sENdNyuYSZm6DNsk6i1lypajt3Lt
 I3AdaBva2XulnOxd1HPYZZ6m+WkLmpAbtWzm7dRllJAB0E0PvKgIDrVuMpqfiMAVFf/PJHhpK
 G9qc2T2T5g2kEmQjuhnilmRCihEyz7tVxB6x6ViPrJzWezHUX9hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.106]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSBQ-1qaqpm40Ag-00WyKm; Tue, 27
 Jun 2023 18:24:13 +0200
Message-ID: <68593128-21e8-a728-719c-632fccf740d6@web.de>
Date:   Tue, 27 Jun 2023 18:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 3/5] replace strbuf_expand_dict_cb() with
 strbuf_expand_step()
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <5ce9513b-d463-6f62-db4e-f9f60a7c3e9f@web.de>
 <20230627082902.GI1226768@coredump.intra.peff.net>
 <20230627083526.GA1273865@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230627083526.GA1273865@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YVjlco+ROkOUdyT+GmjGmc1RYlSFV3Ni0CL2Fgo3Tmom2zyQfrw
 0io6lwjUe4RCLqBl5u3MNzncBV6zVyNjzvsXy1om4YtHgraGK8WfDOF8fCO8BzWDk208TgE
 yGA8YP5tCMh8piu2D4wsqjut0jlU1ph1acWJKXIaCh4NEEMdaa3UaK1+dL1axw6mHIVJtao
 q5Wkn1QNhr4Y1+fHFtF9A==
UI-OutboundReport: notjunk:1;M01:P0:hG+kAntcs1o=;/O9uizirJUlI4rr0xXgGrtrRJm6
 6LLmJ+Au3DIfn4OE5f3Kk3zkHi/R5LeB+VMQI2bj46nkvDJJ6eRGVIMlwhNhnZal4pHrn+Cng
 vacCgqK1C33Sed3Rre0H82Y7eKIbRPxbHCFR12ARvaUYN4cvMPgNoeIXcgNwuWZSfk+nlsYn3
 KtXtzZwV4LxH4fX8VRckJlA2Bek6TSOJVlln1ltVd4zcK07GxNkEYI5NJJ9PWyX49S5lO8MMQ
 iLo1U5hH7h8acxvAuD3ipjzRJygNFhWSa4O4mzr5eT5WctNUXf2vMAV0ExBp7Dc03X7gVI4C1
 nQlwDzrhYg5mkBg7MA+mi2QlGzXzm8KYQPT8kKVKuzL1LAXp+mkRfbHU8dJ8ZFpZM2Vxq860T
 QOA1bPOvgAWS/LcLdwTzG3T+cIhBZ4x+M6KIiAL4TY5IAOupkMN0E75L4PLPiSWLR3g89d3v+
 cGJfWCdQJlX2Ds+1RbpBBF/+OGJCPrnq9Sct0b42zJjvCwM0QVbL6GDADtpEnCq0qsI95EvbK
 vUuXIKtBCU1gwFsPZtbYl3oRL6OmaVITLBg6FRydwfp5LcLP+tcpF4mupWHcXBqt+qq7L1kiM
 18CCkyYHRNDkjEaB73oBfJ+Ppkffz8OR5ovQxz33+oaAMJ92TvFCLZSA4+9ZnLVHfqsGeXqp4
 TgKcGY0mMZ6XNHuD+T3+jhy6xh/lNWPxl0rrnyF5jWD4pzH9WbdzFGNGKyff1Vei6MpdO52SE
 L4opr12ei5GUe5rP17xoD5XnNfiIK9yvyWYLZvjQiQMiR4vKwEz7oikOtB/kVVwp30duz7AWA
 vtGb2SqeX6BXmHL4ptd/5vc5/3X5jGeUKywmrfm0sLoPtW2OjOcsOFC9P2fVmFSIO2bOVuBjc
 8Xq95bQ4djYr7nBAHW1B8KK4q9i2n8NIFwxzzqbrFj3US0MKCQfCTpehPCDtABNKhBxRPArzP
 tTSFbesnG+FJQdUzcbEfmyQ2LDE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.06.23 um 10:35 schrieb Jeff King:
> On Tue, Jun 27, 2023 at 04:29:02AM -0400, Jeff King wrote:
>
>> Your comment above does make me wonder if strbuf_expand_step() should b=
e
>> quietly handling "%%" itself. But I guess strbuf_expand() doesn't, and
>> your branch.c quote-literal example probably would not want that
>> behavior.
>
> Er, nope, strbuf_expand() does handle "%%" itself. It really feels like
> we'd want strbuf_expand_step() to do so, too, then. Even if we had two
> variants (a "raw" one which doesn't handle "%%" so that branch.c could
> use it, and then another that wrapped it to handle "%%").

strbuf_expand() handles %% and unrecognized placeholders.

We could do that, or move the %% handling to strbuf_expand_literal or
something else.  E.g. initially I had a strbuf_expand_default that
handled %% and unrecognized placeholders.

I think it's a good idea to first get used to the loop paradigm by
eschewing the sugary automatic handling and having everything spelled
out explicitly.  It's just one more branch.  Then we can come up with
a better factoring after a while.

Ren=C3=A9
