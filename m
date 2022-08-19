Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05891C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352378AbiHSVTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352273AbiHSVTb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:19:31 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0914BFBA69
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660943954;
        bh=ereiWN510+Q66eqt5UP9GJZx1KDlhQ0f+sKY9U8vqI8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TBnV/hlQVQvZYukMKmxUk8WBcDkC/QUdZGwOTkX+ciAeOsjnLUl01qttsZRNOfBNB
         ah4+z5AFoErA26VnoaCOulmCDwO/MoTRGHghDafbjaAl4ICKTquzov5C6EvNURTSKY
         9yEf6cCE5W0gYOnQldRw/GTU8dmSi/QC5qmVd3Gw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.35] ([79.203.27.48]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mtgyp-1nU0dh1x7v-00uphI; Fri, 19
 Aug 2022 23:19:14 +0200
Message-ID: <3e102aa4-ff44-0b7b-8164-f79bb00a8d3b@web.de>
Date:   Fri, 19 Aug 2022 23:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 0/6] fix pipe_command() deadlock
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <b3310324-7969-f9fb-a2e0-46e881d37786@web.de>
 <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
 <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
 <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
 <YvTCIVN2VBir7WEP@coredump.intra.peff.net>
 <976ac297-28ec-0a38-c4e1-eb7b94d0eb8c@web.de>
 <YvVIYyA8Js0WDAMc@coredump.intra.peff.net>
 <c7c6524c-4f02-10f6-1a58-738cef5aecf2@web.de>
 <Yvx/FNlTx+DCiCOj@coredump.intra.peff.net>
 <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TWFbjZHGWpkhv4rZWctHtyB5gt7Akps1BtJR+jVCxYgdTlEy4Xk
 3DCC4hGWfU2ymO6J/d9+mUr+FeQdv//ywyF6/dmTFZPYbAz+8pQcHKimoXK81/XeY/ZKusk
 xXVndVVvRC2BZsRNqrQpfBVrRZOIVn4/AZdSCXbDxz+T32OKi+nqLxNqYIpW6XrtohSSE5A
 SFDG0QxiagQIzJolF+vqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XQibpa7T0XI=:5yYnc5fY9s8WipYG+NWd0J
 eigAvJA7gO8Jxu/SlID37PqyAHoPqlJQBrAnLFwIEKInlLKNUL4Jt/dOz1ZjaXIVZAyqhVHIC
 c8w2OEkO9cls38Xb6Lwoe3AS3xfHv+DdVdnXrBB0uXVnxI8qLG//GO93SzTl4htik1yWO4+nl
 6s81PbnjgU6SNVQHhC1cMnknutPKXM+f4Lo2JUud2vVQOLODftNaQPyKBYJ8TZPTSHqI7P88r
 huRxiS3upUALsSxlSzStXZDMxow4sPA6PKJJ37l5LfUSyxc5H3IO+qRnd1T63h12lzcMbfaZf
 Rt7vR1omtrdSvlZOuku62FXalUKRqj6IwkTLiAPt/IZAG9cEHn2XZeBEpY8PJtEw2DQVWU81B
 /B5H7pRKtkhjdCNlRk6UKy//Z0yIGO351CnpRPsuv7A5J4sTc2kS8+pqrLXzF+4QLqm7U4mYU
 E9Sskj4jm6U0X83BzLeJyKxKVlL246q93hhzBvsCv26ODwm9ng3fwBAKnLMcbc09cAY/GfV4t
 O6RDViXv1M3K8Ii3hSoy7T4biS8/HxmC+cp0A9qyvQXLKUqdSqfPH58Ta9AkkhP7j/paObV3u
 67Aqi44z2XhOwWc4t5de8chJa4kvqeqeKltvZd8TTtXc/yHTda79MfhOFv4Mev2SwhunHVeT5
 LIeIVs0ypH2CBvnxVjEZYP2N5XvPWBVObFFLP5g14xR20kqNo1zEDTQpMODXklFLqX4sRbdWX
 94Fp2es8sSIela4TlQDj/Qa1ijnKcm8MOpx2yBlXJ6/VvJ6FPuUI2gzGcfTAxfpvzSCOp6oLE
 mMxkbPkqP4rcJRluRvomTzFLun/mTLvNTFuazr3ki+QoIAHL395M7ntw1oYrskdxDsCbsWs1A
 hSalNiAXTyO/zzcZN49KJJ8n1TBn++cMnBXnbLrR7hXqTVsbspK0YRzcL23xjM4b3In2buuRR
 eLCeBdJR1qX40Fu96o4RzC5Akpb6U3ZaPsPChMmeCJ65OdkOXgM954G5VSL8yNcYMV73pWE5L
 X73aXBrJpVm529DcJuddeFulu53e/dLxwPEl/3rVF4MmB6JQJ+rJZu1DHlxaFHZfRmwA4Flw5
 hJ0SOU5Ttzqa1MyL2uQOfr+fcqpiEqah0dC
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.08.2022 um 08:04 schrieb Jeff King:
> On Wed, Aug 17, 2022 at 01:39:32AM -0400, Jeff King wrote:
>
>> I wouldn't be opposed to that, in the sense that it's supposed to be a
>> black box to the caller, and it's relatively small in size. But I think
>> we're pretty close to having something usable without that, so I'd like
>> to pursue a smaller fix in the interim.
>
> So here's what I came up with. Most of the changes are done as
> preparatory steps, so I believe the final commit should just work out of
> the box for you, as well as on Windows CI (which I just kicked off).

Indeed: This series passes the test suite for me on Windows 11.

Ren=C3=A9
