Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48E9C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D9C20720
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 19:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SwhWiUkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGGTcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:32:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59484 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGTcy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 15:32:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F1D16F7F4;
        Tue,  7 Jul 2020 15:32:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U3on/a/YY0Febx6rOwBIpzlONU4=; b=SwhWiU
        kbN3hFBlJq7wGRp4lH+TGMriUNJJHWQxjuSbJTHwxInVoi7TPvKrKQ0HL//qtqtJ
        Nwj3inlzEAQplGlnmqfc+prIfL2fF0+9be85LEdLExSHWLDkyEDakaj372+jAW0c
        8m8G5YcoJUFEYFBHcQGJyStSgvB/wODBvgEWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rHMmmvYJ+HcYnKkRAMSBJMHu/rjlzDqa
        uXv2mJxHxV7JOkm1+/cZvRee+UgWe2BpmZbXWv/2kDfGopPSrFHbUAqFWY+ClINB
        JcTCr7unYZf9E8KhEXRqzOBMvbXVddmL5fyFFF6u77jTAKjKqwc/oUaFCPrrhQgM
        fr2/PTr0s/Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 755FE6F7F3;
        Tue,  7 Jul 2020 15:32:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 031426F7F2;
        Tue,  7 Jul 2020 15:32:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 3/4] t6300: test refs pointing to tree and blob
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200707174049.21714-4-chriscool@tuxfamily.org>
Date:   Tue, 07 Jul 2020 12:32:49 -0700
In-Reply-To: <20200707174049.21714-4-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 7 Jul 2020 19:40:48 +0200")
Message-ID: <xmqqo8or3yu6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4BF7316-C088-11EA-A128-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Adding tests for refs pointing to tree and blob shows that
> we care about testing both positive ("see, my shiny new toy
> does work") and negative ("and it won't do nonsensical
> things when given an input it is not designed to work with")
> cases.

Nice.

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t6300-for-each-ref.sh | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index da59fadc5d..371e45e5ad 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -650,6 +650,28 @@ test_atom refs/tags/signed-long contents "subject line
>  body contents
>  $sig"
>  
> +test_expect_success 'set up refs pointing to tree and blob' '
> +	git update-ref refs/mytrees/first refs/heads/master^{tree} &&
> +	git ls-tree refs/mytrees/first one >one_info &&
> +	test $(cut -d" " -f2 one_info) = "blob" &&
> +	blob_hash=$(cut "-d	" -f1 one_info | cut -d" " -f3) &&
> +	git update-ref refs/myblobs/first "$blob_hash"

Wouldn't it be sufficient to say

	git update-ref refs/myblobs/first refs/heads/master:one

instead of the last 4 lines in this set-up?

> +'
> +
> +test_atom refs/mytrees/first subject ""
> +test_atom refs/mytrees/first contents:subject ""
> +test_atom refs/mytrees/first body ""
> +test_atom refs/mytrees/first contents:body ""
> +test_atom refs/mytrees/first contents:signature ""
> +test_atom refs/mytrees/first contents ""
> +
> +test_atom refs/myblobs/first subject ""
> +test_atom refs/myblobs/first contents:subject ""
> +test_atom refs/myblobs/first body ""
> +test_atom refs/myblobs/first contents:body ""
> +test_atom refs/myblobs/first contents:signature ""
> +test_atom refs/myblobs/first contents ""

All makes sense.  We require "git for-each-ref" that asks for these
atoms in the format to silently exit successfully when the object at
the tip of a ref is of these types, so all these test_atom should
succeed.

Nicely written.

>  test_expect_success 'set up multiple-sort tags' '
>  	for when in 100000 200000
>  	do
