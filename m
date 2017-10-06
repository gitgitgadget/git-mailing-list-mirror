Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334C31FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 05:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdJFFKK (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 01:10:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53192 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750781AbdJFFKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 01:10:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9F2C9C00D;
        Fri,  6 Oct 2017 01:10:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2nlJPB0cpX13jJNElsZmAY5/Sdk=; b=NSEjRx
        aXR7xlVTH4XCsFnfqm6Mp9iO8UrHGsaogcjUqLqGM4ial+LLBGOAp0gkcFMEkZsg
        eaSctNd6rFRydoRsGfvey8x1PtDM5styvNw9GCiKtMSQpLhW5C0li5BOSm2ifb7/
        ipXtkD5mYG59NbcQV/1yFn7sImXiFtyqkoCPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dbc7T/WpWRW+pP1/+ubCggv383HTSBhb
        1E+GHu8RTeLxXPXVl9+CBSHkDNERuefehf0Bpg5ktrOuD+Ee8DCJF6ImjR/O+wP7
        f664JbjVYwR5BDsmCRM00TzHiFA4U8wefCMegrBGdcsp6JGGWwWJtiMzJulRiIWe
        n6JRYWY/0SU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B02129C00B;
        Fri,  6 Oct 2017 01:10:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 27BAD9C008;
        Fri,  6 Oct 2017 01:10:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, J Wyman <jwyman@microsoft.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote ref name
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
        <cover.1507205895.git.johannes.schindelin@gmx.de>
        <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de>
Date:   Fri, 06 Oct 2017 14:10:07 +0900
In-Reply-To: <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 5 Oct 2017 14:19:15 +0200
        (CEST)")
Message-ID: <xmqqvajsx3o0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F20DE10-AA54-11E7-8806-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote ref name

No verb?  s/optionally/report/ perhaps?

> diff --git a/ref-filter.c b/ref-filter.c
> index 4819707d032..b4b2c9b2190 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -77,7 +77,7 @@ static struct used_atom {
>  		struct align align;
>  		struct {
>  			enum {
> -				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME
> +				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME, RR_REMOTE_REF
>  			} option;
>  			struct refname_atom refname;
>  			unsigned int nobracket : 1, push : 1, push_remote : 1;
> @@ -164,6 +164,9 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
>  		else if (!strcmp(s, "remotename")) {
>  			atom->u.remote_ref.option = RR_REMOTE_NAME;
>  			atom->u.remote_ref.push_remote = 1;
> +		} else if (!strcmp(s, "remoteref")) {
> +			atom->u.remote_ref.option = RR_REMOTE_REF;
> +			atom->u.remote_ref.push_remote = 1;
>  		} else {
>  			atom->u.remote_ref.option = RR_REF;
>  			refname_atom_parser_internal(&atom->u.remote_ref.refname,
> @@ -1262,6 +1265,14 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>  			*s = xstrdup(remote);
>  		else
>  			*s = "";
> +	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
> +		int explicit, for_push = starts_with(atom->name, "push");

Hmph, the previous step got rid of starts_with() rather nicely by
introducing atom->u.remote_ref.push bit; can't we do the same in
this step?

Other than that, looks nicer.

Thanks.
