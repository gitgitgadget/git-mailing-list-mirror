Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2CA21FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 21:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754981AbcH2VOd (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 17:14:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58496 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753436AbcH2VOc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 17:14:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 258BE37F47;
        Mon, 29 Aug 2016 17:14:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XYAYCTz5xb9PnElqbwOKqSJrZxo=; b=FYnR03
        PePV0D3J6qJ7iP5EBMyoMw4n1dslb3WN1B3sInOPzbiNfZ+Wk4rqlgZlQT3yZo3U
        ydnA5z1k+o9t5eDDlPFIpWGZkTpc1tHLV/2cvjZ9oaQsiVjI0lMb36fdlxJt4z6X
        pzIaP4vp8A+1mXzvNBJScfrk2WhmyX/f75OiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fjcIP1kab+hijcON9SYeq8ykc3QO9ard
        +mgbrBEHDK/GJM2IdBEwykE4v09zd8c18148EOBvor8n9BvgXk5ioIeShjtTYSfp
        IzxGbeNn2DSQ35xJQeLfrpn4NortCaWPQEduDWLxEgycBJpAGvX0qN09Yi3gc5y+
        ZsGE+fj3gWs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E94237F46;
        Mon, 29 Aug 2016 17:14:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C2EB37F43;
        Mon, 29 Aug 2016 17:14:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 10/14] sequencer: lib'ify read_populate_opts()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <cover.1472219214.git.johannes.schindelin@gmx.de>
        <0fde7522953f71bd07e6aa7a15081dbf069aa6b6.1472219214.git.johannes.schindelin@gmx.de>
        <xmqq37ln9ubo.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 29 Aug 2016 14:14:28 -0700
In-Reply-To: <xmqq37ln9ubo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 29 Aug 2016 13:46:51 -0700")
Message-ID: <xmqqh9a38eh7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9360C3F6-6E2D-11E6-B696-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
>> +		return error(_("Malformed options sheet: %s"),
>> +			git_path_opts_file());
>> +	return 0;
>
> As discussed, perhaps have a comment immediately before calling
> config-from-file that says that the call could die when it is fed a
> syntactically broken file, but we ignore it for now because we will
> be writing the file we have written, or something?

Obviously we will be _READING_ here ;-)
