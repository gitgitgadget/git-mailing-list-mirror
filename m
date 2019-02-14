Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350951F453
	for <e@80x24.org>; Thu, 14 Feb 2019 20:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406867AbfBNUre (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 15:47:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62127 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389639AbfBNUrd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 15:47:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C0D4A5BD1E;
        Thu, 14 Feb 2019 15:47:31 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=c2lQ49NIVub48+IJ8Vy9VX+SHoQ=; b=GQUWNx6
        5DP6U/ZN02PDQkN2AKPxnZ71lvQtiqEGgGBbqIgt1GIotAcmVxEfCNGZ4K2/f0v/
        67Prm7q4CNt8sYsXAkKLU5MGTuQPKQunPMDhtfycJWTT/9amUF5bgb0GihomkK/p
        wSxtNmc4b2XAIJpKFLC8zHaG7jOoshl3x7kE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=Bmrc2o3PuO5WY/CtUm0p5gL40LEEZSK9y
        DnA+iU42KvxSZ7EDc/YyZ2KskRDBm6g/mcRuuI+jYsrXJ4eLuU76q6smhTiftzKt
        pSKDkdbfV9F9kRVD2nD94YxiMI6lWZt6vQWrN5pv/V220LQbgMwH2P0ddvHh7M3W
        gG0R1uA7X0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A71F35BD1D;
        Thu, 14 Feb 2019 15:47:31 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5649D5BD1C;
        Thu, 14 Feb 2019 15:47:28 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 14 Feb 2019 15:47:25 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jonathan Nieder <jrnieder@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] t/lib-httpd: pass GIT_TEST_SIDEBAND_ALL through Apache
Message-ID: <20190214204725.GK16125@zaya.teonanacatl.net>
References: <20190214063513.32041-1-tmz@pobox.com>
 <20190214201711.130216-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214201711.130216-1-jonathantanmy@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: BE055B4A-3099-11E9-8C4C-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:
>> 07c3c2aa16 ("tests: define GIT_TEST_SIDEBAND_ALL", 2019-01-16) added
>> GIT_TEST_SIDEBAND_ALL to the apache.conf PassEnv list.  Avoid warnings
>> from Apache when the variable is unset, as we do for GIT_VALGRIND* and
>> GIT_TRACE, from f628825481 ("t/lib-httpd: handle running under
>> --valgrind", 2012-07-24) and 89c57ab3f0 ("t: pass GIT_TRACE through
>> Apache", 2015-03-13), respectively.
>> 
>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>> ---
>> I missed this with rc0, but poking through build logs I noticed a number
>> of 'AH01506: PassEnv variable GIT_TEST_SIDEBAND_ALL was undefined'
>> warnings.
>> 
>> I think exporting this in lib-httpd.sh like we do for GIT_VALGRIND* and
>> GIT_TRACE is the way to go, as opposed to in test-lib.sh, as we do for
>> things like GNUPGHOME.  But I could easily be wrong about that.
> 
> Thanks for looking into this. I think this is the right way to do it
> too.
> 
> Previous discussion here [1] but I don't think any patches came out of
> that.
> 
> [1] https://public-inbox.org/git/20190129232732.GB218214@google.com/

Hah.  Somehow I missed that thread and Jeff's reply barely
24 hours before I sent this.  Hopefully this saves Jonathan
Nieder a few minutes of patch prep & testing.

Thanks,

-- 
Todd
