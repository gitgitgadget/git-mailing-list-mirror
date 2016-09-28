Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E382B1F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 19:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbcI1T7d (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 15:59:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52380 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753963AbcI1T7b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 15:59:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4FF741511;
        Wed, 28 Sep 2016 15:59:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HPZk45hjt1zRAKGdCmBVRMJ8ius=; b=r0gGsM
        e6HtbUEuonJlZMBS7J2qAHmYz+uYL6+XRM0b6QAlVAl7fy7VcbilBY8U6A92qyeP
        36MjMoxRwGFjESInxqKBQMRxA2tQhuKqlEojt5zKo/dNzoeaMxcdIWeAvrpy4m+z
        qw7owGTUK70BW5O9SCsDepoUm4BHZCgVECyPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=B4UcdfC1fqADrvRW2mPjhV3nsYYZwd4p
        37ucBIqmA+5sKJGcDHbmtsnDP1PDI+i21zwZd0JXbX3RXkFtYefIbwDBw5MmKs6m
        iCGJzHQyzsMHT92VOlEE/kIRNLqf1y8zJkNthl++vfzSFwNMpeueaGwa+Od6OX6t
        A8H1+a/dMUU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A89441510;
        Wed, 28 Sep 2016 15:59:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21D014150F;
        Wed, 28 Sep 2016 15:59:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org, Alex <agrambot@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2] gpg-interface: use more status letters
References: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
        <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
Date:   Wed, 28 Sep 2016 12:59:27 -0700
In-Reply-To: <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Wed, 28 Sep 2016 16:24:13 +0200")
Message-ID: <xmqqshsjiyn4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10AA83CA-85B6-11E6-A4A1-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> - Use GNUPGHOME="$HOME/gnupg-home-not-used" just like in other tests (lib).

If you are not using /dev/null, I expected you to do

	. ./test-lib.sh
	GNUPGHOME_saved=$GNPGHOME
        . "$TEST_DIRECTORY/lib-gpg.sh"

and then use

	GNUPGHOME="$GNUPGHOME_saved" git log -1 ...

in the test.

Otherwise, you are not futureproofing your use and only adding to
maintenance burden.  The gnupg-home-not-used hack may turn out to be
a problematic and test-lib.sh may update to point to somewhere else,
which will leave your copy still pointing at the old problematic
place).

> - Do not parse for signer UID in the ERRSIG case (and test that we do not).

Good.

> - Retreat "rather" addition from the doc: good/valid are terms that we use
>   differently from gpg anyways.

OK.

> +  "X" for a good expired signature, or good signature made by an expired key,

As an attempt to clarify that we cover both EXPSIG and EXPKEYSIG
cases, I think this is good enough.  I may have phrased the former
slightly differently, though: "a good signature that has expired".

I have no strong opinion if we want to stress that we cover both
cases, though, which is I think what Ramsay's comment was about.

Thanks.
