Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B005C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 22:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4EF208FE
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 22:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fkR/PMyG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKSWYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 17:24:41 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64440 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgKSWYl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 17:24:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 967FF116A61;
        Thu, 19 Nov 2020 17:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8oOXKb+8RgHfz6/UZaO8g1uk0e8=; b=fkR/PM
        yGnbaUPdI+J6rXvlFqgY7GayZecS5hmbbvl0KUadokQ5vHM7P5JrlX1wvoM6H5Jl
        H6yexin5FmY3ry5Iv5sGMz4+eXFVJXsUCP6/rQAj4QLB2+CHjXPrS2UrRGSSqAZe
        ILAk24zxpWZz/VeDKXQuD1MyB5ahBdmvG2P38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cf1rLveddSAI2Gq3PkpD6xD/sXMfiCJU
        Gqg83+Yn/RECZMt6trg+6mbOu+tBx7vZDOLN+FX43dxLZBHcXlBlOnLN/1ojcp7N
        IeB2aPgiv8lFuvX1rDIq6vn0vzI2vrS0+C3canhUavGwKnXn+56uQW7BYo01SfMM
        CuXO2Jutc7E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8EEC4116A60;
        Thu, 19 Nov 2020 17:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F6AA116A59;
        Thu, 19 Nov 2020 17:24:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/7] t1300: test "set all" mode with value_regex
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 14:24:33 -0800
In-Reply-To: <2da2131114eb47e70ccaf8fb9c51bf7fb5b173b0.1605801143.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 Nov 2020
        15:52:17 +0000")
Message-ID: <xmqqo8jtvvby.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01138E26-2AB6-11EB-AF41-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success 'set all config with value_regex' '
> +	q_to_tab >initial <<-\EOF &&
> +	[abc]
> +	Qkey = one
> +	EOF
> +
> +	cp initial .git/config &&

Not a new problem with this patch, but does the above pattern
introduce potential problems?  I am wondering if overwriting the
config file with a little piece that has only the stuff the test is
interested in, while wiping the parts that may be essential for
repository integrity (e.g. "extensions.objectFormat"), is OK in the
long run (brian cc'ed for his sha256 work).  There also are
autodetected crlf settings etc. that are in the .git/config when a
test repository is created, and we probably would want to keep them
intact.
