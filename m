Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088EBC433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 19:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359206AbiAaTUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 14:20:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51988 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbiAaTUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 14:20:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F9E3F80BC;
        Mon, 31 Jan 2022 14:20:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jPmskAwJuwIsYhUBxKzuPppwE0558jfMUqbkGb
        kuhQI=; b=feuj6TzglCWJ+YtMGJGFVBRqhWiiYuIutAVA0fdwH8h4GyWIACC/uR
        l83Gzx/sANV04N32xsM1Wwq6Ud2PFJx3QZOa6ypLr67BC9AQNbXF3Y+rxhyOOy1p
        qCs1hBfTVVTlvIh7FFWA8+YqwtRL0Cy7y7qtFaGKAY6PcOcaqVWGg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15E13F80BB;
        Mon, 31 Jan 2022 14:20:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6D59FF80B9;
        Mon, 31 Jan 2022 14:20:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] fetch --prune: exit with error if pruning fails
References: <20220127153714.1190894-1-t.gummerer@gmail.com>
        <20220131133047.1885074-1-t.gummerer@gmail.com>
Date:   Mon, 31 Jan 2022 11:20:50 -0800
In-Reply-To: <20220131133047.1885074-1-t.gummerer@gmail.com> (Thomas
        Gummerer's message of "Mon, 31 Jan 2022 13:30:47 +0000")
Message-ID: <xmqqh79jiuel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E725DECE-82CA-11EC-B3B1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 5f06b21f8e..648f0694f2 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1609,12 +1609,14 @@ static int do_fetch(struct transport *transport,
>  		 * don't care whether --tags was specified.
>  		 */
>  		if (rs->nr) {
> -			prune_refs(rs, ref_map, transport->url);
> +			retcode = prune_refs(rs, ref_map, transport->url);
>  		} else {
> -			prune_refs(&transport->remote->fetch,
> -				   ref_map,
> -				   transport->url);
> +			retcode = prune_refs(&transport->remote->fetch,
> +					     ref_map,
> +					     transport->url);
>  		}
> +		if (retcode != 0)
> +			retcode = 1;
>  	}

Looks trivially correct, even though a few style things look a bit
irritating to my eyes ;-).

Thanks, will queue.
