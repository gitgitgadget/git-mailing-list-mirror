Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D021F406
	for <e@80x24.org>; Tue,  9 Jan 2018 23:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932286AbeAIXcI (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 18:32:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64874 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbeAIXcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 18:32:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AEBEDC2807;
        Tue,  9 Jan 2018 18:32:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=os9Q6dfgbANpnw32HPu4aT0ijzE=; b=haqWbG
        sH5a0N2/W0GyVUmkVI0axOBDT4cTCrjiYORKqKh856sLaC/GHWzXdow/s69UywH6
        /sexCFERIVLzcwX2mwWikiiLNLoLcf9aJ5JDNK3KkeQtyqKX57uaXlKfrSiUZbjZ
        QBd1sJvQlxSeEr8UTilvgOhNeOGZeTA0L+fnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=urfMigFp1y2czevmN/0CpHAcP9CaZXP1
        FCrUopiPT/eqB1MgDHGd2FQsk67sIfLkJZEfdcFXYTrDwM6sEDV5BLF/hKobhE7c
        NP/uVuXLluf9A9vBAv4wqJafjRu/HtMeqr5aayl1MkFRMKANbYRuCJU18MxZHCiG
        jHyEbdqIbZU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A651DC2806;
        Tue,  9 Jan 2018 18:32:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 23DA3C2804;
        Tue,  9 Jan 2018 18:32:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/20] cat-file: reuse parse_ref_filter_atom
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
        <01020160db067b4f-60d6012f-7cb8-4ba2-891f-1d1ed5bb5786-000000@eu-west-1.amazonses.com>
Date:   Tue, 09 Jan 2018 15:32:05 -0800
In-Reply-To: <01020160db067b4f-60d6012f-7cb8-4ba2-891f-1d1ed5bb5786-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Tue, 9 Jan 2018 13:05:23 +0000")
Message-ID: <xmqqh8ru38y2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E5AFD62-F595-11E7-86AF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> +static int is_atom(const char *atom, const char *s, int slen)
> +{
> +...
> +}
> +
> +static void expand_atom_into_fields(const char *atom, int len,
> +				    struct expand_data *data)
> +{
> +...
> +}
> ...
> -static int is_atom(const char *atom, const char *s, int slen)
> -{
> -...
> -}
> -
> -static void expand_atom_into_fields(const char *atom, int len,
> -				    struct expand_data *data)
> -{
> -...
> -}
> -
>  /*
>   * Make sure the format string is well formed, and parse out
>   * the used atoms.

There is no need to move these in this step if the previous step
planned ahead well, and that is something you can correct by
pretending to be perfect with "rebase -i" ;-) That also will help
reduce reviewers' load.

> @@ -726,6 +741,7 @@ int verify_ref_format(struct ref_format *format)
>  {
>  	const char *cp, *sp;
>  
> +	cat_file_info = format->cat_file_data;
>  	format->need_color_reset_at_eol = 0;
>  	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
>  		const char *color, *ep = strchr(sp, ')');
> @@ -736,9 +752,10 @@ int verify_ref_format(struct ref_format *format)
>  		/* sp points at "%(" and ep points at the closing ")" */
>  
>  		if (format->cat_file_data)
> -			expand_atom_into_fields(sp + 2, ep - sp - 2,
> -						format->cat_file_data);
> -		else
> +		{
> +			at = parse_ref_filter_atom(format, valid_cat_file_atoms,
> +						   ARRAY_SIZE(valid_cat_file_atoms), sp + 2, ep);
> +		} else
>  		{
>  			at = parse_ref_filter_atom(format, valid_atoms,
>  						   ARRAY_SIZE(valid_atoms), sp + 2, ep);

if/else with bodies that are compound statements are formatted like
so:

	if (condition) {
		do this;
	} else {
		do that;
		do that, too;
	}

