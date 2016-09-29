Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2BF4207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 18:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934635AbcI2SNz (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 14:13:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63685 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934707AbcI2SNt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 14:13:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A7AF41365;
        Thu, 29 Sep 2016 14:13:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mmUXRa2VvMrdO59dBOEaq/VIT+I=; b=TMAxEB
        Zxly8QePUDPdJwYFkl/IQwguYzSI3WMK0w2/ZOEDGtTvMLGD6BeaON2nv97FRpaj
        qDJrgx0hWV0kbnAAXL7hgCDmDfTnpM8uX/8A0NIU4fwHSnnjCDqoBK2IYMEWixAw
        RUGZA8AEoREDS1p2b7dx9U+wNR3+gyZk+cOfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Of0XUg1tID5nMWmGOzCBWTJSb2YPlgSV
        szduwIQZBBYFJ7HmXzrgzjv7Y73lA2ncb4pkQjjxnvtUJ585+Bm9Yr2t+Q5AAbaN
        GjW/ch9P0fbTqa+pwLtasTDp14ty6WFhkDsQLTyIzBplyTtLH6S3SUXnEgnaAJwn
        Fh7ccTn37JA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2314741362;
        Thu, 29 Sep 2016 14:13:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9880341360;
        Thu, 29 Sep 2016 14:13:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] t13xx: do not assume system config is empty
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-3-gitster@pobox.com>
        <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 11:13:45 -0700
In-Reply-To: <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 05:01:09 -0400")
Message-ID: <xmqqintefuau.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 773E1B32-8670-11E6-8F50-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think anytime you would use GIT_CONFIG_NOSYSTEM over --local, it is an
> indication that the test is trying to check how multiple sources
> interact. And the right thing to do for them is to set GIT_ETC_GITCONFIG
> to some known quantity. We just couldn't do that before, so we skipped
> it.  IOW, something like the patch below (on top of yours).

OK, that way we can make sure that "multiple sources" operations do
look at the system-wide stuff.

> Note that the
> commands that are doing a "--get" and not a "--list" don't actually seem
> to need either (because they are getting the values out of the local
> file anyway), so we could drop the setting of GIT_ETC_GITCONFIG from
> them entirely.

"either" meaning "we do not need to add --local and we do not need
GIT_CONFIG_NOSYSTEM"?

