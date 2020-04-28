Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E38C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530442176D
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 16:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i6fet6E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgD1QDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:03:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52426 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgD1QDm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 12:03:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E284BF3D1;
        Tue, 28 Apr 2020 12:03:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YeRSHd+1BW7+tZ2qMOXFNuKwXiY=; b=i6fet6
        E3TebjVzvLLrXSZ89rYcQ1b06Mys08jtuOhaRrYhdtikX3AvLoJPAqEejfHhGCrz
        fjHUo4fviaSeosH2Bfq2wjXKIoxiRfK/qh20jiRMZ2T0riJiOEuWHCaybWU8UtTH
        69tBovZa5DOfsXix9dz5xnhLAww3WVUNL4JrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=egNemPBXmFpc8GorgpUjx+qzn5iMZ03u
        0J2zGwuFHc4hggI8nEPtigJgjF1SmVU80zEFQnMPR2kGrk6M1YSLgDW+vGhjnG6A
        LPJLe/F4OYropS2VpgHPsPBPSU724yWkB4UgoGHnwvhHNZZF16eAAeHO/xczWxBH
        XuFSXt6/Z48=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25BE1BF3D0;
        Tue, 28 Apr 2020 12:03:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 53A30BF3CF;
        Tue, 28 Apr 2020 12:03:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, git@vger.kernel.org, dirk@ed4u.de,
        sunshine@sunshineco.com, Stefan Tauner <stefan.tauner@gmx.at>
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments from store
References: <20200427084235.60798-1-carenas@gmail.com>
        <20200427125915.88667-1-carenas@gmail.com>
        <xmqqftco94wx.fsf@gitster.c.googlers.com>
        <20200427191858.GB1728884@coredump.intra.peff.net>
        <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
        <20200428052510.GA201501@google.com>
Date:   Tue, 28 Apr 2020 09:03:36 -0700
In-Reply-To: <20200428052510.GA201501@google.com> (Jonathan Nieder's message
        of "Mon, 27 Apr 2020 22:25:10 -0700")
Message-ID: <xmqqsggn4mxz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D273649E-8969-11EA-A021-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I wonder if in addition to the above documentation change we may want
> something guaranteed to catch all cases where people would have
> experienced a regression, like
>
> diff --git i/credential-store.c w/credential-store.c
> index c010497cb21..294e7716815 100644
> --- i/credential-store.c
> +++ w/credential-store.c
> @@ -24,8 +24,8 @@ static int parse_credential_file(const char *fn,
>  	}
>  
>  	while (strbuf_getline_lf(&line, fh) != EOF) {
> -		credential_from_url(&entry, line.buf);
> -		if (entry.username && entry.password &&
> +		if (!credential_from_url_gently(&entry, line.buf, 1) &&
> +		    entry.username && entry.password &&
>  		    credential_match(c, &entry)) {
>  			found_credential = 1;
>  			if (match_cb) {

Hmph, so the idea is, instead of ignoring the potential error
detected by credential_from_url() and using credential when it is
available, we loudly attempt to parse and give warning on malformed
entries when we discard a line?

I think that is an excellent idea.

It would be nicer if we can somehow add where we found the offending
line, e.g.

    /home/me/.gitcredential:396: url has no scheme: ://u:p@host/path

Do we feel it a bit disturbing that u:p is shown in the error
message, without redacting, by the way?

