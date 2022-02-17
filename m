Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34346C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 19:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbiBQT1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 14:27:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243389AbiBQT06 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 14:26:58 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D100E72B9
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 11:26:43 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EFF4D3F4149;
        Thu, 17 Feb 2022 14:26:42 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7B3783F4090;
        Thu, 17 Feb 2022 14:26:42 -0500 (EST)
Subject: Re: [PATCH v5 10/30] fsmonitor--daemon: implement 'run' command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <6fe5a2bc79eec132b6455d53196906036d0f4a80.1644612979.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202171744410.348@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6e03d1e0-8765-a474-f69f-b1ce63146b6a@jeffhostetler.com>
Date:   Thu, 17 Feb 2022 14:26:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2202171744410.348@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/17/22 11:46 AM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> +static int try_to_run_foreground_daemon(void)
>> +{
>> +	/*
>> +	 * Technically, we don't need to probe for an existing daemon
>> +	 * process, since we could just call `fsmonitor_run_daemon()`
>> +	 * and let it fail if the pipe/socket is busy.
>> +	 *
>> +	 * However, this method gives us a nicer error message for a
>> +	 * common error case.
>> +	 */
>> +	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
>> +		die("fsmonitor--daemon is already running '%s'",
>> +		    the_repository->worktree);
>> +
>> +	printf(_("running fsmonitor-daemon in '%s'\n"),
>> +	       the_repository->worktree);
>> +	fflush(stdout);
> 
> Do we want to print this to `stderr` instead?


Yes.  I have a patch in part 3 that moves it to stderr
and only emits it if a config setting is present.

fsmonitor--daemon: print start message only if fsmonitor.announceStartup

Wondering if I should squash that in here instead.

Jeff
