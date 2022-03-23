Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928DFC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbiCWOdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiCWOdu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:33:50 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184CB7A9B3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:32:20 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3B3303F414D;
        Wed, 23 Mar 2022 10:32:19 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id EC0023F414B;
        Wed, 23 Mar 2022 10:32:18 -0400 (EDT)
Subject: Re: [PATCH v7 16/29] compat/fsmonitor/fsm-listen-darwin: add MacOS
 header files for FSEvent
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
 <14b775e9d8b1a4672f8175a546eb70e2790c1b23.1647972010.git.gitgitgadget@gmail.com>
 <220322.86ils5q1um.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <cc9ff6b9-9574-8170-f7de-b3f0e3815edd@jeffhostetler.com>
Date:   Wed, 23 Mar 2022 10:32:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220322.86ils5q1um.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/22 2:19 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 22 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
[...]
>> +++ b/compat/fsmonitor/fsm-darwin-gcc.h
>> @@ -0,0 +1,92 @@
>> +#ifndef FSM_DARWIN_GCC_H
>> +#define FSM_DARWIN_GCC_H
>> +
>> +#ifndef __clang__
> 
> This was surprising, until I remembered that clang tries really hard to
> pretend to be other compilers. I wonder if we should steal the macro
> check from compat/compiler.h into something more generic & use it here,
> probably best as a follow-up...
> 
>> [...]

yeah, V5 had this as an ifdef __GNUC__, I changed it in V6 because
we were always using the hack local declarations rather than the
official header files in clang builds.  (Technically, it doesn't
really matter, since the net result is the same, but it felt
cleaner (er, less mysterious).)

As for extracting a better macro from compat/compiler.h for more
general use, maybe, but that's not something I want to think about
right now.  Doing a quick "git grep __GNUC__" turns up a lot of dark
magic.  There are only a couple of references to __clang__, so it
might be that a good comment somewhere (say in compat/compiler.h)
would be sufficient.

Jeff
