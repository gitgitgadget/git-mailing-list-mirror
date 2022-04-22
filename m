Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CC7C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiDVWEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiDVWEm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:04:42 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1751EF9A3
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 13:47:12 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8C3A93F47F4;
        Fri, 22 Apr 2022 16:47:11 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0C2EF3F412C;
        Fri, 22 Apr 2022 16:47:10 -0400 (EDT)
Subject: Re: [PATCH v5 23/28] fsmonitor: never set CE_FSMONITOR_VALID on
 submodules
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
 <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
 <5db241f7d2f654d46d4858ce9e9413032705abf3.1650487399.git.gitgitgadget@gmail.com>
 <xmqqv8v3l3w1.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7cbabd84-0c4d-5517-0d5d-3f5725d3105d@jeffhostetler.com>
Date:   Fri, 22 Apr 2022 16:47:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqv8v3l3w1.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/20/22 7:41 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +create_super () {
>> +	super=$1 &&
>> +
>> +	git init "${super}" &&
> 
> It is not wrong per-se, but a simple reference to a shell variable
> without magic interpolation like ${parameter-word} is easier to read
> without {} around the variable name, i.e.
> 
> 	git init "$super"
> 
> an exception of course is when you want to suffix its value with
> alnum, i.e.
> 
> 	for d in "$super" "${super}1" "$super"2
> 	do
> 		...
> 
> and writing it as "${super}1" would probably be easier to see what
> is going on than "$super"2 notation.
> 
>> +	echo x >${super}/file_1 &&
>> +	echo y >${super}/file_2 &&
>> +	echo z >${super}/file_3 &&
> 
> CodingGuidelines still says that these redirection targets with
> variable interpolation must be enclosed in double-quotes, i.e.
> 
> 	echo x >"$super/file_1" &&
> 
>> +	mkdir ${super}/dir_1 &&
> 
> The double quotes around "${super}" we saw on "git init" indicates
> that the helper function wants to be prepared to handle a directory
> path with possibly $IFS whitespace characters in it correctly, so
> let's make sure we are consistently prepared for such a parameter,
> i.e.
> 
> 	mkdir "$super/dir_1" &&
> 
> The same applies to the rest of the script.
> 
> Thanks.
> 

good points.  i'll fixup and resend.
thanks!

jeff
