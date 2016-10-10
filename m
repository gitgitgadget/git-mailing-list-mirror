Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F89320989
	for <e@80x24.org>; Mon, 10 Oct 2016 22:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbcJJWsi (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 18:48:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50449 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751743AbcJJWsh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 18:48:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13C22460AD;
        Mon, 10 Oct 2016 18:48:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J0/C66BWR+J2+JwPjvRtq6JdR58=; b=BMQUwW
        X+15u/H+7lMseJnL20cBuMiSEk5fbVp80rjOjZoJ1X/B6Xn/K7v3StolVZFn36xy
        chFaLcLJYsHcbBP/BaytSkJN8HtkokbBpl2rzZUu3nAo+lMyLJNcmslKiKk6aa7i
        4xBY1K2l84VK/WTenglqDJj7OUOIKBnQcJkmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rZT5cul6/NXc8Wa53pH8YIuVlx/g+zAX
        77Het+TiuqxMd5A5Ql9k13HK/EDQsY1BECthY6GDLFFC7Ovzlcei2xIGuPNW1o5w
        KXfo9TJIidWAjRnsno3uUP9vh+PtCnil4i3qkCg+tlumeNxmMO+M1B4sqAvrG+PR
        HTbMIdQtwEA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0559A460AC;
        Mon, 10 Oct 2016 18:48:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D7B1460AA;
        Mon, 10 Oct 2016 18:48:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org, Jens.Lehmann@web.de,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 2/3] serialize collection of refs that contain submodule changes
References: <cover.1475851621.git.hvoigt@hvoigt.net>
        <cover.1475851621.git.hvoigt@hvoigt.net>
        <81bdbf6a1295c17c1b9233c91da6e5eb4583785e.1475851621.git.hvoigt@hvoigt.net>
Date:   Mon, 10 Oct 2016 15:48:33 -0700
In-Reply-To: <81bdbf6a1295c17c1b9233c91da6e5eb4583785e.1475851621.git.hvoigt@hvoigt.net>
        (Heiko Voigt's message of "Fri, 7 Oct 2016 17:06:35 +0200")
Message-ID: <xmqqpon7bz26.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD1966A2-8F3B-11E6-BD04-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> +static int append_hash_to_argv(const unsigned char sha1[20], void *data)
> +{
> +	struct argv_array *argv = (struct argv_array *) data;
> +	argv_array_push(argv, sha1_to_hex(sha1));
> +	return 0;
> +}

Do we have struct object_id readily available in the caller?

    ... goes and looks ...

No, this is part of sha1_array API, so this callback is perfectly
fine.
