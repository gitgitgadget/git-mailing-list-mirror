Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058601F404
	for <e@80x24.org>; Tue,  3 Apr 2018 13:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750767AbeDCNr3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 09:47:29 -0400
Received: from siwi.pair.com ([209.68.5.199]:34636 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbeDCNr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 09:47:28 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 753BF3F4043;
        Tue,  3 Apr 2018 09:47:27 -0400 (EDT)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F20743F4046;
        Tue,  3 Apr 2018 09:47:26 -0400 (EDT)
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
To:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <20171221190909.62995-1-git@jeffhostetler.com>
 <20171221190909.62995-2-git@jeffhostetler.com>
 <20171221204356.GA58971@aiede.mtv.corp.google.com>
 <xmqq3742tyho.fsf@gitster.mtv.corp.google.com>
 <20171224143318.GC23648@sigill.intra.peff.net>
 <xmqq1sjgoyph.fsf@gitster.mtv.corp.google.com>
 <20180104192604.GA27528@sigill.intra.peff.net>
 <091D90DC-DAA2-4338-AAFA-01CB75807992@gmail.com>
 <87vad8vbid.fsf@evledraar.gmail.com>
 <d63b54e9-5ec6-f523-d882-756ac38b882b@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <36e3a9c3-f7e2-4100-1bfc-647b809a09d0@jeffhostetler.com>
Date:   Tue, 3 Apr 2018 09:47:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d63b54e9-5ec6-f523-d882-756ac38b882b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/3/2018 7:39 AM, Derrick Stolee wrote:
> On 4/3/2018 6:18 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Tue, Apr 03 2018, Lars Schneider wrote:
>>> What is the state of this series? I can't find it in git/git nor in
>>> git-for-windows/git. I think Stolee mentioned the config in
>>> his Git Merge talk [1] and I was about to test it/roll it out :-)
>> It's in the gvfs branch of git@github.com:Microsoft/git.git, i.e. it's
>> not in Git for Windows, but used in Microsoft's own in-house version
>> used for Windows.git.
> 
> Thanks for adding me to CC. I mentioned it in my talk because that was one thing we shipped internally as a "quick fix" until we could do the right thing.
> 
> If I remember correctly, Jeff abandoned shipping this upstream because it did have the feel of a hack and we wanted to see if users used the config setting or really cared about the output values. We saw fast adoption of the feature and even turned the config setting on automatically in the following version of GVFS.
> 
>> I may be misunderstanding this feature, but my impression was that it
>> was a kludge as a workaround until the commit graph code landed, because
>> once we have that then surely we can just cheaply report the actual (or
>> approximate?) number in the common case, but of course it may still be
>> slow if your commit graph file is out of date.

Right, the only thing in master are the changes to take the new
command line option and to alter the output of status.  We did not
reach consensus on the need for the config setting and/or whether
it should be in "core." or "status." or another namespace and/or
how it should work.

And yes, it was also seen as a hack (just turn it off) until the
client-side commit graph was ready (at least for interactive use).
Because there are callers that don't need the answer (regardless
of whether it is cheap to compute) and so the explicit command line
arg limitation is sufficient for them.


This part is in upstream master:
     commit 4094e47fd2c49fcdbd0152d20ed4d610d72680d7
     Merge: c710d182ea f39a757dd9
     Author: Junio C Hamano <gitster@pobox.com>
     Date:   Thu Mar 8 12:36:24 2018 -0800
     
         Merge branch 'jh/status-no-ahead-behind'


These parts are in the 'gvfs' branch in the git@github.com:Microsoft/git.git repo:

     commit 039f65946968fa654a9c3bca27a4f4e93c1c9381
     Author: Jeff Hostetler <jeffhost@microsoft.com>
     Date:   Wed Jan 10 13:50:24 2018 -0500
     
         status: add warning when a/b calculation takes too long for long/normal format

     commit 0d6756f06d0ad6f1fdc8dba0ead7911e411c9704
     Author: Jeff Hostetler <jeffhost@microsoft.com>
     Date:   Mon Feb 5 09:44:04 2018 -0500
     
         status: ignore status.aheadbehind in porcelain formats

         Teach porcelain V[12] formats to ignore the status.aheadbehind
         config setting. They only respect the --[no-]ahead-behind
         command line argument.  This is for backwards compatibility
         with existing scripts.

     commit 0dd122d6cd43106a5928587d768a7381cfe9e7a3
     Author: Jeff Hostetler <jeffhost@microsoft.com>
     Date:   Tue Jan 9 14:16:07 2018 -0500
     
         status: add status.aheadbehind setting
     
         Add "status.aheadbehind" config setting to change the default
         behavior of ALL git status formats.

Hope this helps,
Jeff


