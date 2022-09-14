Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A49ECAAD3
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 09:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiINJTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 05:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiINJSI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 05:18:08 -0400
Received: from outbound8.mail.transip.nl (outbound8.mail.transip.nl [IPv6:2a01:7c8:7c9:ca11:136:144:136:8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4157961B
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 02:08:53 -0700 (PDT)
Received: from submission4.mail.transip.nl (unknown [10.103.8.155])
        by outbound8.mail.transip.nl (Postfix) with ESMTP id 4MSDxj6LsJzY77CV;
        Wed, 14 Sep 2022 11:07:37 +0200 (CEST)
Received: from [192.168.1.198] (5072ADBC.static.ziggozakelijk.nl [80.114.173.188])
        by submission4.mail.transip.nl (Postfix) with ESMTPA id 4MSDxh6CNTznTbV;
        Wed, 14 Sep 2022 11:07:36 +0200 (CEST)
Message-ID: <f13bc5aa-dadd-a895-eeca-79bd77c5363b@fwdekker.com>
Date:   Wed, 14 Sep 2022 11:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
 <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
Content-Language: en-US
From:   "Florine W. Dekker" <florine@fwdekker.com>
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
In-Reply-To: <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission4.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=fwdekker.com; t=1663146457; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version:content-type;
 bh=cTiGOHtomoSdzkwpyVv9MrRQCji6gCAOQNvynTADMS4=;
 b=FhfNexQx46ZfmT/F2DVVaKFYGhqjhGr+3XAZIRJX/NEppsM8vsb1iOeUmOr2MMTAUN2fr9
 fUKXN5dt3TMW32i2PDwoeNqYryPBTG8cs2XqAqnCtu7Q4L5kYMeqDMwDT6yYymFMcQYk3W
 uB74qgTQRfMCTmqPIyBkcBUX3UHPz+MBAkExoecZGuSgGwAc2uogywTOJlIW8Q+oqhirJD
 634XBZ8TcfZwZMfoJnkThm2MPCqMgTboN3UCJyoi5qAzxJfD+uH9YmkO+lfDHxBH0BJkyH
 DSUIHg8yCDyH4c65Ig3l6wORJZfBUYiDTDHS606AAY8YqqZSANDqiGTxU/VUAA==
X-Report-Abuse-To: abuse@transip.nl
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/2022 09:40, René Scharfe wrote:
> Am 13.09.22 um 23:53 schrieb Florine W. Dekker:
>> Now, John can now add the following line to their mailmap config:
>> `John Doe <john.doe@example.com> <\*.doe@example.com>`, which does
>> not reveal their old name.
> That would falsely attribute the work of possible future developers
> ann.doe@example.com and bob.doe@example.com to John as well.

Good point. I assumed such false positives would be unlikely because I 
was considering very-small-scale projects, but I agree that using 
wildcards is not at all feasible for larger projects.

> Supporting hashed entries would allow for a more targeted obfuscation.
> That was discussed a while ago:
> https://lore.kernel.org/git/20210103211849.2691287-1-sandals@crustytoothpaste.net/

That was an interesting read. I agree with Ævar in that thread in that I 
think URL encoding is sufficient. I think it meets Brian's use case of 
never having to see the old name again, and my use case of obfuscating 
it from accidental discovery by friendly collaborators. While a hash 
certainly gives a stronger sense of security, I think it's a false sense 
of security, because, as you note below, recovering old email addresses 
from the tree is not much more trivial than reversing the encoding. And 
either way, a sha256 hash can easily be inverted in a few days(?) using 
a dictionary attack with email addresses from data breaches. As someone 
who has changed her name, I would be content with using a simple URL 
encoding.

>> Someone could always spend more effort to uncover the name using more
>> advanced tools, but the point of this feature is to prevent
>> accidental discovery of the name in cases where completely hiding the
>> name is not feasible.
> Extracting old email addresses from a repository is easy by comparing
> authors' email addresses without and with mailmap applied, no advanced
> tools required.  Here's mine from Git's own repo:
>
>     $ git log --format='%ae %aE' |
>       awk '$1 != $2 && !a[$0] {a[$0] = 1; print}' |
>       grep -F l.s.r@web.de
>     rene.scharfe@lsrfire.ath.cx l.s.r@web.de
>
> The same can be done with names (%an/%aN).

You're absolutely right. With "advanced tools" I was referring to 
anything more advanced than a plain `git log` ;-)

- Florine


