Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A168C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 14:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbiEXOoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 10:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiEXOoL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 10:44:11 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E56D841
        for <git@vger.kernel.org>; Tue, 24 May 2022 07:44:09 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6F5A43F4814;
        Tue, 24 May 2022 10:44:08 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 107E73F4813;
        Tue, 24 May 2022 10:44:08 -0400 (EDT)
Subject: Re: [PATCH v7 26/30] t/helper/hexdump: add helper to print hexdump of
 stdin
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
 <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
 <6f2e935f148e826609153378751c04807858e76c.1653336765.git.gitgitgadget@gmail.com>
 <xmqqk0acosks.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1fe2e843-20d1-4ea9-7ea2-c05330da17c2@jeffhostetler.com>
Date:   Tue, 24 May 2022 10:44:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0acosks.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/23/22 5:19 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +int cmd__hexdump(int argc, const char **argv)
>> +{
>> +	char buf[1024];
>> +	ssize_t i, len;
>> +
>> +	for (;;) {
>> +		len = xread(0, buf, sizeof(buf));
>> +		if (len < 0)
>> +			die_errno("failure reading stdin");
>> +		if (!len)
>> +			break;
>> +
>> +		for (i = 0; i < len; i++)
>> +			printf("%02x ", (unsigned char)buf[i]);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> It is meant to be consumed by machine, so I do not think we would
> mind too much about a single long line, but given that consumers
> include "grep", it would probably be better to avoid emitting an
> incomplete line, especially since addition of this tool is all about
> portability across platforms.
> 
> An extra putchar('\n'); after the loop would fix it easily.

Yes, I should have added a final LF.  I was more focused
on cleaning up the test cases.

Would you prefer a send a V8 or would you be willing
to push a fixup commit on top?

Jeff
