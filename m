Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131A5202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 04:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750763AbdJBEvO (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 00:51:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58529 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750737AbdJBEvN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 00:51:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D7EF94346;
        Mon,  2 Oct 2017 00:51:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tgdQP7hmk+YOd2yDyt/vGSmez2A=; b=R0k9h5
        l+RGpwbTK8dIq8tPLdamVE7kuaUvZ0hkHSU040rkyo+xO2YggUuObyttJ4Y9pB5G
        V45Vt/e1bd747cEMJ8K9Y7b/ktfCN2/m7PgwOEfZDy/VbHBNhnzxwNVp+dz4szF/
        wM352cnEU87XrBxJP0QU0G1a/DUbyY5U9v4bk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FQdmz+CdSj2Fk+eEP0LILD6+v7FpNj3X
        1lFSdsRs9Jus08EwnOiKOECF7oJYy219ErXWz+HhuVUaLxKAZLoKhfgPSyojgzUE
        0nDVY5lNspAbbQVmZJURf06DsO5zTeCnKPzf0BRxO4w1TxSqLgrCFvGydsa+Zmdr
        f+HAYuUakqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 154C694344;
        Mon,  2 Oct 2017 00:51:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CF1894343;
        Mon,  2 Oct 2017 00:51:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v5 6/6] ref-filter.c: parse trailers arguments with %(contents) atom
References: <20171002003116.GA69902@D-10-157-251-166.dhcp4.washington.edu>
        <20171002003304.77514-1-me@ttaylorr.com>
        <20171002003304.77514-6-me@ttaylorr.com>
Date:   Mon, 02 Oct 2017 13:51:11 +0900
In-Reply-To: <20171002003304.77514-6-me@ttaylorr.com> (Taylor Blau's message
        of "Sun, 1 Oct 2017 17:33:04 -0700")
Message-ID: <xmqqk20ep2yo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 509D19D6-A72D-11E7-B21F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> @@ -212,9 +212,10 @@ static void contents_atom_parser(const struct ref_format *format, struct used_at
>  		atom->u.contents.option = C_SIG;
>  	else if (!strcmp(arg, "subject"))
>  		atom->u.contents.option = C_SUB;
> -	else if (!strcmp(arg, "trailers"))
> -		atom->u.contents.option = C_TRAILERS;
> -	else if (skip_prefix(arg, "lines=", &arg)) {
> +	else if (skip_prefix(arg, "trailers", &arg)) {
> +		skip_prefix(arg, ":", &arg);
> +		trailers_atom_parser(atom, *arg ? NULL : arg);

A parameter for the call is missing.  I think you want 'format'
there.
