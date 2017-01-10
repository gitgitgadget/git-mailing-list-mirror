Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00FA820756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbdAJUvj (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:51:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64104 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751155AbdAJUvi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:51:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AB165E71B;
        Tue, 10 Jan 2017 15:51:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QFebFOvoIrWnC+SfI1reXiiEao0=; b=MsOm9e
        zlJ5TzDsGUV0eQrHFXM+spAcHXD2myuhVUsdEvXUsOVXu6W8e3psqVDFdNNQGulW
        tSmCEUoiiemjW7jrpPPw38VkUMbDIkj/rs0fQ2S3jzvmCdDa9RbfIC1LLNzxgcZ7
        GngKZx1ql1buPtSGWYnHR5y1ctroqpt9ZglXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wkf3do/ZljxjK7EntCHE/liyBG7DuAYO
        TEau4yZPkDX3naUZiZKfLd4eCNqMAckmFpciSRbTZGteHgsodvtY1mDpnlVMQy3b
        dQ2j3BJqlPBrhAyExNm4kvSUq0O8bnXHoemIe1ouV7VbH6OQ4ZZILKc/KPw8xHSn
        DQHpaYvAlLg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 137DE5E719;
        Tue, 10 Jan 2017 15:51:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FEA45E718;
        Tue, 10 Jan 2017 15:51:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH v10 00/20] port branch.c to use ref-filter's printing options
References: <20170110084953.15890-1-Karthik.188@gmail.com>
Date:   Tue, 10 Jan 2017 12:51:35 -0800
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com> (Karthik Nayak's
        message of "Tue, 10 Jan 2017 14:19:33 +0530")
Message-ID: <xmqqbmver63s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93B1DD42-D776-11E6-9AC1-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> index 81db67d74..08be8462c 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -95,13 +95,17 @@ refname::
>  	The name of the ref (the part after $GIT_DIR/).
>  	For a non-ambiguous short name of the ref append `:short`.
>  	The option core.warnAmbiguousRefs is used to select the strict
> +	abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
> +	slash-separated path components from the front of the refname
> +	(e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
> +	`%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).

I hiccupped while reading this, as the (e.g.) example talks about rstrip
that is not mentioned in the main text that is enhanced by the
example.

	If `lstrip=<N>` (`rstrip=<N>`) is appended, strips `<N>`
	slash-separated path components from the front (tail) of the
	refname (e.g. `%(refname:lstrip=2)` ...

perhaps?

> +	if `<N>` is a negative number, then only `<N>` path components
> +	are left behind.

Begin the sentence with cap?  I'd rephrase it a bit while at it if I
were doing this:

	If `<N>` is a negative number, strip as many path components
	as necessary from the specified end to leave `-<N>` path
	components.

Other than the above, looks very good to me.

Thanks.
