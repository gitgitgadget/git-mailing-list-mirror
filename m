Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A46C1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 07:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfGaHSD (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 03:18:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62936 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfGaHSD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 03:18:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B74E97A09B;
        Wed, 31 Jul 2019 03:18:01 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=ahjHQ4tcdCI2quu0DAmOsZLPpdQ=; b=Xl1YI3Y
        zQSfaRuwlPzeORa7ut8vJEXISUYtRAd7R2ROx9I2w/LTtFBtecibYkG93TGINUX1
        Nuknrhlnx64pAV6TiEFncArzJ4BRdj+jYbcneY4M1fjKGqACPXbFawNmei1PaxZ8
        6onMXYPN0PFbDkaDDR7tJubjy0RM/5wvWN00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=eoxN77u0SceA2roOlgoDgJJoRSJpB3j52
        yiD8i1go25ONgayA00ZJ6HT/p6QtSyN6SDYMY6NEKw7FgkYSgnLnDwxZGNbCdDL7
        0JG0ASdMT77+Roh3p4UQ30MjbN7snqTfhlRHtAWrtqWORLR2MN/FEOiI88+AwYBp
        MiRXbzWgiU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B12B77A09A;
        Wed, 31 Jul 2019 03:18:01 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B6A97A097;
        Wed, 31 Jul 2019 03:17:58 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Wed, 31 Jul 2019 03:17:55 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG]: Testsuite failures on big-endian targets
Message-ID: <20190731071755.GF4545@pobox.com>
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 530A655E-B363-11E9-A56B-8D86F504CC47-09356542!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

John Paul Adrian Glaubitz wrote:
> Recent versions of git are failing the testsuite on big-endian targets
> such as s390x in Debian.
> 
> Build logs are:
> 
>> https://buildd.debian.org/status/fetch.php?pkg=git&arch=s390x&ver=1%3A2.23.0%7Erc0-1&stamp=1564449102&raw=0
>> https://buildd.debian.org/status/fetch.php?pkg=git&arch=s390x&ver=1%3A2.23.0%7Erc0%2Bnext.20190729-1&stamp=1564449397&raw=0
> 
> Unfortunately, I cannot really read from the build logs which test in
> particular is actually failing as I see a lot of lines starting with
> the string "error".

The test I see failing is test 6 in t0016-oidmap.  Grepping
for '^not ok ' is helpful in this case, though it's even
better when the test summary is provided, as it points to
the failing tests by name and number.

The t0016-oidmap failure is discussed in the thread starting
here:

    https://public-inbox.org/git/04b301d54715$3b371a90$b1a54fb0$@nexbridge.com/T/

Peff posted a patch which resolves the test failure here:

    https://public-inbox.org/git/20190731012336.GA13880@sigill.intra.peff.net/

Cheers,

-- 
Todd
