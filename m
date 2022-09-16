Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50D9ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 17:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIPR66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 13:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIPR65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 13:58:57 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB8AA6ADE
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 10:58:55 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EE8DBCA1238;
        Fri, 16 Sep 2022 13:58:54 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1008:b046:9928:d9b3:686c:9bea:ee52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3E83ACC833D;
        Fri, 16 Sep 2022 13:58:54 -0400 (EDT)
Subject: Re: [PATCH v6 0/6] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
To:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
References: <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
 <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ac9c12cf-866d-565f-fbf8-58dbfdd92ef1@jeffhostetler.com>
Date:   Fri, 16 Sep 2022 13:58:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/13/22 4:27 PM, Eric DeCosta via GitGitGadget wrote:
> Follow-on to the work done to allow Windows to work against network-mounted
> repos for macOS.
> 
> Have macOS take advantage of the same configuration option,
> 'fsmonitor.allowRemote' that was introduced for Windows. Setting this option
> to true will override the default behavior (erroring-out) when a
> network-mounted repo is detected by fsmonitor.
> 
> The added wrinkle being that the Unix domain socket (UDS) file used for IPC
> cannot be created in a network location; instead $HOME is used if the
> default location is on the network. The user may, optionally, set the
> 'fsmonitor.socketDir' configuration option to a valid, local directory if
> $HOME itself is on the network or is simply not the desired location for the
> UDS file.
> 
> An additional issue is that for mount points in the root directory, FSEvents
> does not report a path that matches the worktree directory due to the
> introduction of 'synthetic firmlinks'. fsmonitor must map the FSEvents paths
> to the worktree directory by interrogating the root filesystem for synthetic
> firmlinks and using that information to translate the path.
> 
> v6 differs from v5:
> 
>   * incorporates earlier, Windows-specific changes that have not made it back
>     yet to the master branch
>   * incorporates code review feedback
>   * adds documentation for 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'
> 
> v5 differs significantly from earlier versions:
> 
>   * redesign of handling 'fsmonitor.allowRemote' and 'fsmonitor.socketDir'
>     such that these options are no longer added to the settings data
>     structure but are rather read from config at point of use
>   * refactoring of code for handling platform-specific file system checks via
>     a common interface to avoid platform #ifdef in IPC code and be in-model
>     with other platform-specific fsmonitor code
>   * dealing with 'synthetic firmlinks' on macOS
> 

I've looked at v5 and v6 and I like the direction this is heading,
so I'll mark this LGTM.  (I'm still traveling back from Git Merge,
so I haven't had time to test it out, but I think we should proceed
with it.)

Thanks for you patience and attention to detail on this!
Jeff

