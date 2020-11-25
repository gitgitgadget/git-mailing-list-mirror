Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDBCC5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 08:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BC4206F9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 08:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="K9swL1kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgKYIbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:31:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64115 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgKYIbr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 03:31:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E351FEBFB;
        Wed, 25 Nov 2020 03:31:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=quQec5USS/rJ5x+c4fzYuek8P4c=; b=K9swL1
        kzZX8VWlKKsgPy2+Fymj63pn4/cD5vqSwT+1ZNU2xs/+3j6ElSj1mS6KJ37jGH18
        12Urj0d8G9D/TiJyBRP9f2YzidhPPX6W3Hh+5Y8z2r8o52I2k3P2GuSOQeij9obZ
        DUcCVVPLcH54FFsz/ubomQ1xNiL3qgEDjDBqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jmVqeIIHRbHpRTAtXFtT1rq8XZ3JTNk2
        1wdhDgjqOv1ea9A8mEe+LNSv3r3N2ZePRXXAILJgpVkkDYIgvFERHSoIe8FT/JBv
        EXxJN6mv09WdcoVOLjOziOewC48O93UgzThb8EZUDgG0dSPAu2OGf4vrMC5mbYbP
        CdQS3JUVeQc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06D2BFEBFA;
        Wed, 25 Nov 2020 03:31:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A342FEBF1;
        Wed, 25 Nov 2020 03:31:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Cc:     git@vger.kernel.org, levraiphilippeblain@gmail.com
Subject: Re: [PATCH] imap-send: parse default git config
References: <76d2be10-0c42-70f4-101c-ee15e3039821@gmail.com>
        <8a21b031-fbfd-81c2-1f91-eff8c03bafb7@suse.com>
Date:   Wed, 25 Nov 2020 00:31:41 -0800
In-Reply-To: <8a21b031-fbfd-81c2-1f91-eff8c03bafb7@suse.com> (Nicolas
        Morey-Chaisemartin's message of "Wed, 25 Nov 2020 09:05:52 +0100")
Message-ID: <xmqqh7pdg7ma.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5CA15AC-2EF8-11EB-B254-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com> writes:

> git imap-send does not parse the default git config settings and thus ignore
> core.askpass value.
> Fix it by calling git_config(git_default_config)
>
> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> ---
>  imap-send.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/imap-send.c b/imap-send.c
> index 5764dd812ca7..790780b76da2 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1367,6 +1367,7 @@ static void git_imap_config(void)
>  	git_config_get_int("imap.port", &server.port);
>  	git_config_get_string("imap.tunnel", &server.tunnel);
>  	git_config_get_string("imap.authmethod", &server.auth_method);
> +	git_config(git_default_config, NULL);

There are two styles of parsing configuration variables to get
values.  The way imap-send.c works is to grab individual values by
calling git_config_get_*() functions.  The other is to give a
callback function to git_config() to iterate over all configuration
variables and pick the relevant ones.

Once we start doing the latter, the existing git_config_get_*()
calls we see above should also be folded into it to avoid mixing two
styles for code clarity.

IOW, I'd expect

 (1) The call to git_imap_config() near the beginning of cmd_main()
     is changed to a call to git_config(git_imap_config, NULL);

 (2) git_imap_config() function is updated to begin like so:

        static void git_imap_config(const char *var, const char *value, void *cb)
        {
                if (!strcmp("imap.sslverify", var))
                        server.ssl_verify = git_config_bool(var, value);
                else if (!strcmp("imap.preformattedhtml", var))
                        server.ssl_verify = git_config_bool(var, value);
                else if (!strcmp("imap.preformattedhtml", var))
                        server.use_html = git_config_bool(var, value);
		...

     to parse the "imap.*" variables the function currently parses,
     and end like so:

		...
		else
			return git_default_config(var, value, cb);
		return 0;
	}

     to delegate the parsing of other configuration variables that
     ought to be read by default.

Of course you could also unify in the other direction and instead of
running git_config(git_defauilt_config, NULL), pick the exact
variables you care about (did you say askpass???).

