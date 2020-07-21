Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDB7C433E0
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F96208E4
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jvEdtQVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgGUAEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:04:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51047 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgGUACw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 20:02:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89B4A7BCB7;
        Mon, 20 Jul 2020 20:02:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HDq+w+N3Vc6zX0TUOsq1PTgQBRA=; b=jvEdtQ
        VG70gC9YiPElSoNjHNDh04Lrr5R1zOnafzuultNY3bF5XjMVopXSUP1I8KZzjiI+
        Qtun5dvFkp9veTcKKlj3ivlqmMUwHFTcLUtRbJFK7AIFNROjSEekLH6kHiJGNSpN
        BmY12mMgomPELdOCXgWn3fI7jt464MqCyOek0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=COGe9OVU/WV1CJsMJxTJbgJNvx+YpG4O
        +J8cVxoId+Vud3jcf5MWV/HXWLIHwreIgDqoK6tF/GG3M+OIP9ifWpww6d9tKZ+Z
        tmpv0M0kgin5luEEkXWfV3MLJTrgTLRXvbUsPlKcVp48Ofe0aE0Rd3YroqtNdfhV
        Q681LVQmWCg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81CEF7BCB6;
        Mon, 20 Jul 2020 20:02:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AD7E7BCB5;
        Mon, 20 Jul 2020 20:02:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Frej Bjon <frej.bjon@nemit.fi>
Subject: Re: [PATCH] remote-curl: make --force-with-lease work with non-ASCII ref names
References: <CAP8P1T+JQUTVDXsJbrWkiZ2AWZmoptFSRdKssANYrNSFa+Egmg@mail.gmail.com>
        <20200720224327.1631947-1-sandals@crustytoothpaste.net>
Date:   Mon, 20 Jul 2020 17:02:46 -0700
In-Reply-To: <20200720224327.1631947-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 20 Jul 2020 22:43:27 +0000")
Message-ID: <xmqqlfjd91ll.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 824CB9BC-CAE5-11EA-8019-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/remote-curl.c b/remote-curl.c
> index 5cbc6e5002..ccf0c27daf 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -121,7 +121,13 @@ static int set_option(const char *name, const char *value)
>  	}
>  	else if (!strcmp(name, "cas")) {
>  		struct strbuf val = STRBUF_INIT;
> -		strbuf_addf(&val, "--" CAS_OPT_NAME "=%s", value);
> +		strbuf_addstr(&val, "--" CAS_OPT_NAME "=");
> +		if (*value == '"') {
> +			if (unquote_c_style(&val, value, NULL))
> +				return -1;
> +		} else {
> +			strbuf_addstr(&val, value);
> +		}

I wonder if

		if (*value != '"')
			strbuf_addstr(&val, value);
		else if (unquote_c_style(&val, value, NULL))
			return -1; /* error */

is easier to read without having to use {braces}, but that's quite
a minor point.

A clean-up opportunity I can see here is to declare that we have
found a good value for CAS_OPT_NAME and inline the string and remove
the C preprocessor macro, but that is obviously an unrelated change
to this fix.

Thanks.
