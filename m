Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070E22023D
	for <e@80x24.org>; Wed,  1 Mar 2017 21:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbdCAVev (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 16:34:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51049 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753278AbdCAVeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 16:34:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C84A7656F;
        Wed,  1 Mar 2017 16:34:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8ib3EW7/f2hR2wAjGw5A0RY9RRg=; b=Iav94B
        xwnx7OFw9qO6HE4/sgeyWUpsCgX0wQ2l3PjZmEKc3Ns7dYH5so4l1TTjY/X7Sqj+
        3zvR4tnQtWqufy0qUjc8b6WFa2zCyDFE6hFVxhgJHrwR4RfjEtOcq68l+dAyEZrf
        rQbCmtNQQo4DF2WB6A8h21uqsYa/i8jwdTOrw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QdvP2XIlVg0vxSacUZv9xn40dL2z8lTi
        OeQQYZk/C9aih/LFaDwNHQn2liUBCV2Ci/igjmBRHJr3blvIPRlu0YJP9jRzTwnf
        iNDX9x0K37Q9UWd+9oOhUN6t+3KvjDvDRjGUsgAvSg8f+BUNFTepvw8TtM1/77UW
        kg+Y/txUAP0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7493B7656E;
        Wed,  1 Mar 2017 16:34:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C48A07656D;
        Wed,  1 Mar 2017 16:34:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 15/22] read-cache: touch shared index files when used
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
        <20170227180019.18666-16-chriscool@tuxfamily.org>
Date:   Wed, 01 Mar 2017 13:34:06 -0800
In-Reply-To: <20170227180019.18666-16-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 27 Feb 2017 19:00:12 +0100")
Message-ID: <xmqqinnsfzqp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD11E330-FEC6-11E6-950E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +/*
> + * Signal that the shared index is used by updating its mtime.
> + *
> + * This way, shared index can be removed if they have not been used
> + * for some time.
> + */
> +static void freshen_shared_index(char *base_sha1_hex, int warn)
> +{
> +	const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
> +	if (!check_and_freshen_file(shared_index, 1) && warn)
> +		warning("Could not freshen shared index '%s'", shared_index);

I'll downcase "Could" to match existing convention (no need to
resend only to update this one).
