Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FCB91F406
	for <e@80x24.org>; Tue,  9 Jan 2018 22:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755467AbeAIWQg (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 17:16:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53347 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755157AbeAIWQe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 17:16:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D52EC1636;
        Tue,  9 Jan 2018 17:16:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bkn82PWHYbxGCnbI79ubFlU6vNg=; b=DB2CjO
        D1ALghKS/UpxOjQGxLuNP88KXtdy2+ruQosSmga0bo9seU0znHudg82BOpd+S2It
        qldo49EFYyE649vXxCxDRxNEPO7W0vXwQ1Li1q5EOFOiBhfz/u9VjXNa1ciKhp6+
        nXlziev9BdlTlHnU9/txMh5kdy94k6+Ece204=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g3mV2nWQHciHirI2xNIr2ohLf32SkJLD
        BZ/NhirVOFvxGrcTLtFz28clhQ4BqniPZUy33cUI4bSNzNPNhhvT8IhCQjuKTfjz
        Jziei7HL1bfRhWS6QexfkJZ5gw6uMdY/QJ0B93p8zPCdYN/RXL/3xX+CBCXUNBVJ
        Ib0w1DAsG5k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76C71C1635;
        Tue,  9 Jan 2018 17:16:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA49EC1634;
        Tue,  9 Jan 2018 17:16:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/20] cat-file: make valid_atoms as a function parameter
References: <01020160db0679c9-799a0bc4-b6d1-43e2-ad3b-80be4e4c55e9-000000@eu-west-1.amazonses.com>
        <01020160db067ae8-81d31cf2-0f69-4f36-9de8-27e9716d2f4b-000000@eu-west-1.amazonses.com>
Date:   Tue, 09 Jan 2018 14:16:31 -0800
In-Reply-To: <01020160db067ae8-81d31cf2-0f69-4f36-9de8-27e9716d2f4b-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Tue, 9 Jan 2018 13:05:23 +0000")
Message-ID: <xmqqpo6i3cg0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFBB674A-F58A-11E7-8EA8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> Make valid_atoms as a function parameter,
> there could be another variable further.
> Need that for further reusing of formatting logic in cat-file.c.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored by: Jeff King <peff@peff.net>
> ---
>  ref-filter.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Please be a bit more careful about your title.  This change does not
seem to have anything to do with "cat-file".

I was not sure what you meant by "make X as a function parameter"
after reading the proposed log message twice, but I am guessing that
you are allowing these functions to operate on not just the global
singleton but a different instance of array.  

I also suspect that this step may make the references to the
valid_atom[] array somewhat inconsistent in that the functions that
are touched by this patch would refer to the passed-in array while
the remainder of the existing code still works on the global
singleton.  For example, parse_ref_filter_atom() is called by
verify_ref_format(), but this patch does not make _it_ take the
array as a parameter, and instead uses the global singleton, so
anybody who wants to use verify_ref_format() with different
valid_atom[] are SOL.  I am not saying that this inconsistency will
be a problem, but that the patch (including the proposed log
message) does not explain why it is not---and it should.

Thanks.

> diff --git a/ref-filter.c b/ref-filter.c
> index 1426f0c28bce7..2d6e81fe1ab00 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -396,6 +396,7 @@ struct atom_value {
>   * Used to parse format string and sort specifiers
>   */
>  static int parse_ref_filter_atom(const struct ref_format *format,
> +				 const struct valid_atom *valid_atoms, int n_atoms,
>  				 const char *atom, const char *ep)
>  {
>  	const char *sp;
> @@ -425,13 +426,13 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>  	atom_len = (arg ? arg : ep) - sp;
>  
>  	/* Is the atom a valid one? */
> -	for (i = 0; i < ARRAY_SIZE(valid_atoms); i++) {
> +	for (i = 0; i < n_atoms; i++) {
>  		int len = strlen(valid_atoms[i].name);
>  		if (len == atom_len && !memcmp(valid_atoms[i].name, sp, len))
>  			break;
>  	}
>  
> -	if (ARRAY_SIZE(valid_atoms) <= i)
> +	if (n_atoms <= i)
>  		die(_("unknown field name: %.*s"), (int)(ep-atom), atom);
>  
>  	/* Add it in, including the deref prefix */
> @@ -708,7 +709,8 @@ int verify_ref_format(struct ref_format *format)
>  		if (!ep)
>  			return error(_("malformed format string %s"), sp);
>  		/* sp points at "%(" and ep points at the closing ")" */
> -		at = parse_ref_filter_atom(format, sp + 2, ep);
> +		at = parse_ref_filter_atom(format, valid_atoms,
> +					   ARRAY_SIZE(valid_atoms), sp + 2, ep);
>  		cp = ep + 1;
>  
>  		if (skip_prefix(used_atoms[at].name, "color:", &color))
> @@ -2139,7 +2141,9 @@ void format_ref_array_item(struct ref_array_item *info,
>  		if (cp < sp)
>  			append_literal(cp, sp, &state);
>  		get_ref_atom_value(info,
> -				   parse_ref_filter_atom(format, sp + 2, ep),
> +				   parse_ref_filter_atom(format, valid_atoms,
> +							 ARRAY_SIZE(valid_atoms),
> +							 sp + 2, ep),
>  				   &atomv);
>  		atomv->handler(atomv, &state);
>  	}
> @@ -2187,7 +2191,8 @@ static int parse_sorting_atom(const char *atom)
>  	 */
>  	struct ref_format dummy = REF_FORMAT_INIT;
>  	const char *end = atom + strlen(atom);
> -	return parse_ref_filter_atom(&dummy, atom, end);
> +	return parse_ref_filter_atom(&dummy, valid_atoms,
> +				     ARRAY_SIZE(valid_atoms), atom, end);
>  }
>  
>  /*  If no sorting option is given, use refname to sort as default */
>
> --
> https://github.com/git/git/pull/450
