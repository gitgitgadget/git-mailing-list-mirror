Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E827C27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 19:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbjAYTCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 14:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbjAYTCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 14:02:36 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEE9442FF
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 11:02:35 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BD514CA126D;
        Wed, 25 Jan 2023 14:02:34 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 83691CC83B1;
        Wed, 25 Jan 2023 14:02:34 -0500 (EST)
Message-ID: <7fa84280-db1d-8618-571a-ce0ac7a26135@jeffhostetler.com>
Date:   Wed, 25 Jan 2023 14:02:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [CI]: Is t7527 known to be flakey?
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        edecosta@mathworks.com, git@vger.kernel.org
References: <xmqqtu0lzzn2.fsf@gitster.g> <20230121102355.GA2155@szeder.dev>
 <f7449e73-7f50-67ea-2be4-2037f98a69f3@jeffhostetler.com>
 <20230123181216.GB2155@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <20230123181216.GB2155@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/23/23 1:12 PM, SZEDER Gábor wrote:
> On Mon, Jan 23, 2023 at 11:56:53AM -0500, Jeff Hostetler wrote:
>> Was this on Linux or MacOS ?
> 
> On an average-ish Linux (an Ubuntu LTS variant).  So the issue is not
> specific to musl.
> 

OK, thanks.  I wasn't worried about "musl", but rather whether
you were running the stress test on a Linux or Mac.

Since they have different backends (inotify vs FSEvent) and all
the code that touches the filesystem is different, it would best
to start on the correct OS when trying to repro it.


Can you tell from your stess test whether the fsmonitor-daemon
is crashing?  (It might be subtle since the daemon is auto-started
if necessary, so it might be crashing and silently getting restarted
by the next command.)

I ask because a SIGPIPE in the client would make me think that the
server suddenly closed the connection unexpectedly, like if it had
SIGSEGV'd or something.

I won't have time to spin up a Linux VM until next week, so I
won't be able to investigate this for a bit.

Jeff
