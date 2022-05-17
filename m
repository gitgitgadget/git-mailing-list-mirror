Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480D2C433F5
	for <git@archiver.kernel.org>; Tue, 17 May 2022 21:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346321AbiEQVOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 17:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239228AbiEQVON (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 17:14:13 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FEB527CA
        for <git@vger.kernel.org>; Tue, 17 May 2022 14:14:12 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E21083F4104;
        Tue, 17 May 2022 17:14:11 -0400 (EDT)
Received: from REPLICASERVER01.azshci.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 88B553F4131;
        Tue, 17 May 2022 17:14:11 -0400 (EDT)
Subject: Re: [PATCH v6 26/28] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten B??gershausen <tboegi@web.de>, rsbecker@nexbridge.com,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
 <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
 <8278f32c4d894d4930b9f1f70f3aa01679e2011e.1650662994.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2205121711300.352@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <adaffdd2-9294-0ddb-5eac-d8b90ae13f20@jeffhostetler.com>
Date:   Tue, 17 May 2022 17:14:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2205121711300.352@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/12/22 11:26 AM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
[...]
>> +#
>> +test_lazy_prereq UNICODE_NFC_PRESERVED '
>> +	mkdir c_${utf8_nfc} &&
>> +	ls | od -t x1 | grep "63 *5f *c3 *a9"
> 
> As far as I can see, this would be the first usage of `od` in the test
> suite. I'd actually like to reduce our dependency on Unix-y tools, not
> increase it.
> 
> One thing we could do would be to imitate t4030, and introduce a shell
> function that calls Perl, something like:
> 
> 	bin2hex () {
> 		perl -e '
> 			$/ = undef;
> 			$_ = <>;
> 			s/./sprintf("%02x ", ord($&))/ge;
> 			print $_
> 		'
> 	}
> 
> But it is a thorn in my side for quite a few years already that we
> _require_ Perl, even in NO_PERL builds.
> 
> So maybe a much better idea would be to introduce a small helper in
> `t/helper/` that converts binary data on stdin to hex on stdout? Something
> like this:
> 

Yeah, lets add the hexdump helper.

Thanks
Jeff
