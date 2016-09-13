Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5883320984
	for <e@80x24.org>; Tue, 13 Sep 2016 23:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932160AbcIMXGP (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 19:06:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57926 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755568AbcIMXGO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 19:06:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 286E43EEDB;
        Tue, 13 Sep 2016 19:06:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QdXVse9jQO10IufHsjLpP5qmPHw=; b=mheLxU
        r24cguiYBL+G4ylC7PKQlt6WEvExjXlqC1NtUE+9/fE6Mw9p7tOyyktwGd8o2rHN
        nU7YtH8JPW/pXDu87GCkn9zqonwa6e2eSrdKlxQ/yQHhu8E0dRVCPRIzKMhxUwHg
        Ra+2PWJ05F5P6nauC/5jqAO8eHOxAqHCVV4Mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NruWsd+fLp8Bc0SvLlZOp+d5BwpWqTBa
        Fba579vMZI9WeMsRohltP87VGnzQRLuoJ6emWGKNLzLVyqZnuw7jCcAQbwetD+w8
        c2nHMIj1VJpzvjp1iq7yIbE7AXGF/vZok4QNCztfsly+vv0vsyy9telzMlBVnlmn
        NiTkjw9L5YY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20EF53EEDA;
        Tue, 13 Sep 2016 19:06:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DF4E3EED8;
        Tue, 13 Sep 2016 19:06:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, chriscool@tuxfamily.org, git@vger.kernel.org
Subject: Re: [RFC/PATCH 16/17] diff: buffer output in emit_line_0
References: <20160913044613.1037-1-sbeller@google.com>
        <20160913044613.1037-17-sbeller@google.com>
Date:   Tue, 13 Sep 2016 16:06:10 -0700
In-Reply-To: <20160913044613.1037-17-sbeller@google.com> (Stefan Beller's
        message of "Mon, 12 Sep 2016 21:46:12 -0700")
Message-ID: <xmqqlgyvtn6l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA4845D2-7A06-11E6-8926-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +struct line_emission {
> +	const char *set;
> +	const char *line;
> +	const char *ws;
> +	const char *reset;
> +	int first;
> +	int len;
> +	int whitespace_check;
> +	unsigned ws_rule;
> +	int has_trailing_carriage_return;
> +	int has_trailing_newline;
> +};

It is somewhat strange to see whitespace things are per-line here.
I'd understand it if it were per-path, though.
