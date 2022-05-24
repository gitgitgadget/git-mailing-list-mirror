Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18BAC433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 15:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbiEXPHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 11:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbiEXPHt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 11:07:49 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32A13D4B4
        for <git@vger.kernel.org>; Tue, 24 May 2022 08:07:48 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 17B3B3F480F;
        Tue, 24 May 2022 11:07:48 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A74C43F4806;
        Tue, 24 May 2022 11:07:47 -0400 (EDT)
Subject: Re: [PATCH v7 00/30] Builtin FSMonitor Part 3
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten B??gershausen <tboegi@web.de>, rsbecker@nexbridge.com,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
 <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2205241357410.352@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <dc1bd9f6-f83f-5cb1-9b0c-68d28a4cc216@jeffhostetler.com>
Date:   Tue, 24 May 2022 11:07:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2205241357410.352@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/24/22 8:00 AM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> On Mon, 23 May 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>>   1:  8b7c5f4e23 !  1:  26144c5865 fsm-listen-win32: handle shortnames
>>        [...]
>>      @@ compat/fsmonitor/fsm-listen-win32.c: static int normalize_path_in_utf8(FILE_NOTI
>>       +{
>>       +  wchar_t buf_in[MAX_PATH + 1];
>>       +  wchar_t buf_out[MAX_PATH + 1];
>>      -+  wchar_t *last_slash = NULL;
>>      -+  wchar_t *last_bslash = NULL;
>>       +  wchar_t *last;
>>      ++  wchar_t *p;
>>       +
>>       +  /* build L"<wt-root-path>/.git" */
>>      -+  wcscpy(buf_in, watch->wpath_longname);
>>      -+  wcscpy(buf_in + watch->wpath_longname_len, L".git");
>>      ++  swprintf(buf_in, ARRAY_SIZE(buf_in) - 1, L"%s.git",
>>      ++           watch->wpath_longname);
>>       +
>>      -+  if (!GetShortPathNameW(buf_in, buf_out, MAX_PATH))
>>      ++  if (!GetShortPathNameW(buf_in, buf_out, ARRAY_SIZE(buf_out)))
> 
> Nice touch using `ARRAY_SIZE()` here!

Thanks.  And hopefully it will make the GFW downstream MAX_LONG_PATH
fixups easier too.

> 
> The changes look good to me, from my side this is good to go.
> 
> Thank you so much!
> Dscho
> 

Thanks for all your reviews.
Jeff
