Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA8ECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 15:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbiIFPZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbiIFPYt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 11:24:49 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611E7BD4DC
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 07:36:23 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 29AA1CA1259;
        Tue,  6 Sep 2022 10:27:25 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1015:b110:85b0:ed17:3499:a7f5:58a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C201CCC831D;
        Tue,  6 Sep 2022 10:27:24 -0400 (EDT)
Subject: Re: [PATCH v4 1/4] fsmonitor: add two new config options, allowRemote
 and socketDir
To:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <836a791e6b7fd4490674254ce03105a8ca2175cb.1661962145.git.gitgitgadget@gmail.com>
 <791b3386-501b-d69d-3f4e-1401aa0c4865@jeffhostetler.com>
 <BYAPR05MB5573AACF524A1319B8F1119CD97A9@BYAPR05MB5573.namprd05.prod.outlook.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <664ece2e-b149-8058-5937-b726810a59da@jeffhostetler.com>
Date:   Tue, 6 Sep 2022 10:27:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR05MB5573AACF524A1319B8F1119CD97A9@BYAPR05MB5573.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/2/22 12:54 PM, Eric DeCosta wrote:
> 
> 
>> -----Original Message-----
>> From: Jeff Hostetler <git@jeffhostetler.com>
>> Sent: Thursday, September 1, 2022 5:22 PM
>> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>;
>> git@vger.kernel.org
>> Cc: Eric DeCosta <edecosta@mathworks.com>
>> Subject: Re: [PATCH v4 1/4] fsmonitor: add two new config options,
>> allowRemote and socketDir
>>
>>
>>
>> On 8/31/22 12:09 PM, Eric DeCosta via GitGitGadget wrote:
>>> From: Eric DeCosta <edecosta@mathworks.com>
>>>
>>> Introduce two new configuration options
[...]
>> 5. In fsm-settings-darwin.c:fsm_os__incompatible()
>>      complain if the socket path is remote (when is-ipc is set).
>>
>>      This probably ought to be a new _REASON_ type for non-local
>>      UDS.  And this is independent of whether the actual worktree
>>      is remote or whether remote worktrees are allowed.
> 
> I thought that was what FSMONITOR_REASON_NOSOCKETS was for?

Yeah, I was probably juggling too many things in my
head when I was making that list.  And I'm sure it'll
fall our when you see what the code looks like.  The
_NOSOCKETS case should basically be just the places where
you test the path of the socket-dir (if it is always outside
of the .git dir).  None of the tests on the actual workdir
inspection should hit it anymore, right?

And we can save for a later day whether or not to test
for NTFS and FAT32 (local or remote) in the Darwin code
based on whether or not the kernel sends FSEvents for
them.

Jeff

