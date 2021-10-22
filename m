Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4417FC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 17:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFA56108B
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 17:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbhJVRmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 13:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhJVRmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 13:42:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AFEC061766
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 10:40:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g10so4362942edj.1
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=PXs9lak0itPu3WzW1qmoQ83xfEIKeuNFivwdUf9PEsU=;
        b=AzR7CIwkktb8nko7PYaCNbtjSg3Xg2brbTAXNfSe1H+nLsXI1QgDEX7QO1loV4JhDY
         49fzm0HXiRDEk0fj1rkIPbOyTf7ROaco3HIXipBQyUPMDYHBR5gss4vNiiKRA5WOYpkO
         1XNkma6RsRLE8ZA4RfdEBldsYoaIZPBoBSkpKrbnaB21lTsk34udxvwy3YqE3zY7GY9d
         DZuAFiuq+UdpZDj4QVU8fZeMmIRg+JxlLgxRDXnrhzY5++zmn8tEw9DSW8L8ZRgo37Ju
         srsg1FwX4YHq8GHOyafXgAfrfA/ovsgDcCcPIFcK9LUKFZiL6pg7FWCWNkkkFiAuqCSC
         41qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=PXs9lak0itPu3WzW1qmoQ83xfEIKeuNFivwdUf9PEsU=;
        b=h5KWkP1XsyI2phtfT9pFiAtxyjPdFzRNinoC2fPvqti0tQ30b8ONu9z22zbZtcA5ah
         2Klmu9ylikK3+awAxl+XdCosK7YMP6CJcMB4ZhuawzN4NgHMa4uCLFEx9SOSFgNcsSko
         0h9SQK4u3/8AwG6GFHBJvETgcF1nMc7Yz0V464pFvrCGv9MY+C0oA8+KU8/AZLyipQtn
         mfC1d90IK5StcyweBjZkYjUw7rNnQy3C3gSitlI5qObrpK7n2jOSP/ngw9nerKgAhv9e
         j0ISETPfzVq15ci6EsgC42vHOO7kVBeJfDylQMO2OqhHDUUHG3XRcrU7VWd6t3iV85D7
         8lfA==
X-Gm-Message-State: AOAM530lL5EynEh5QxuUsNEfDHfH3QUTK5GT6o6VLqqlCBlFu87bbQD0
        /BRQ4cA5SFO1Te57EiBY6h4=
X-Google-Smtp-Source: ABdhPJyrPa6nzIpzkSxUmjpCOtqcHi7Gqw4CWiKJdAXWxn15BsJi0I8D3NyhPeFVoiaGrO17ijolBw==
X-Received: by 2002:a17:906:7ac9:: with SMTP id k9mr1113859ejo.411.1634924426866;
        Fri, 22 Oct 2021 10:40:26 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c19sm5253941ede.16.2021.10.22.10.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:40:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdyWm-001IP5-RR;
        Fri, 22 Oct 2021 19:40:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Gwyneth Morgan <gwymor@tilde.club>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 3/6] ssh signing: verify-commit/check_signature with
 commit date
Date:   Fri, 22 Oct 2021 19:37:03 +0200
References: <20211022150949.1754477-1-fs@gigacodes.de>
 <20211022150949.1754477-4-fs@gigacodes.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211022150949.1754477-4-fs@gigacodes.de>
Message-ID: <211022.86ee8dj6uv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Fabian Stelzer wrote:

[Just nits]

> +	if (payload_timestamp) {
> +		strbuf_addf(&verify_time, "-Overify-time=%s",
> +			    show_date(payload_timestamp, 0, &verify_date_mode));
> +	}

No braces needed.

> @@ -482,6 +495,7 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
>  		error(_("ssh-keygen -Y find-principals/verify is needed for ssh signature verification (available in openssh version 8.2p1+)"));
>  		goto out;
>  	}
> +
>  	if (ret || !ssh_principals_out.len) {
>  		/*
>  		 * We did not find a matching principal in the allowedSigners

Stray whitespace change.

> +int parse_signed_buffer_metadata(const char *payload, const char *signer_header,
> +				 timestamp_t *payload_timestamp,
> +				 struct strbuf *payload_signer)
> +{
> +	const char *ident_line = NULL;
> +	size_t ident_len;
> +	struct ident_split ident;
> +
> +	ident_line = find_commit_header(payload, signer_header, &ident_len);
> +	if (ident_line && ident_len) {
> +		if (!split_ident_line(&ident, ident_line, ident_len)) {
> +			if (payload_timestamp && ident.date_begin &&
> +			    ident.date_end)
> +				*payload_timestamp = parse_timestamp(
> +					ident.date_begin, NULL, 10);
> +			if (payload_signer)
> +				strbuf_add(payload_signer, ident.mail_begin,
> +					(ident.mail_end - ident.mail_begin));
> +
> +			return 0;
> +		}
> +	}
> +
> +	return 1;
> +}

This would be more readable with less nesting, i.e. instead of:

    if (x) {
        if (y) {
            [...]

Doing:

    if (!x)
        return 1;
    if (!y)
        return 1;

I.e. only if you get zero from split_ident_line() do you return 0.

