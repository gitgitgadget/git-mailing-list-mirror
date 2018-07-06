Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2E501F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933685AbeGFTvX (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:51:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36186 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932776AbeGFTvW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:51:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id s14-v6so15440642wmc.1
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tA+QzZPuwuJq/opw2rrhA8CzjHd2tJo6XjKaj0JGJ9Q=;
        b=Xwpp9VufbJfNiyzc0p2lkjbmESZS5qtEYve1hUhoICRO2h0yY1G8rONPUEiJCpLJow
         +zmSgWlzUT4enlvejr/CC+VM44sQN3JE8X3xQw1634mUZWNy0Ns9G2ZaheFA8dp3q1jf
         5fnJIMlyH9kdt6/sl7amFbM/wwmzFhQplYsKEQmLIIx8N5/C2lYCBklGOmBHY1/Nm6KC
         zRsgA2qBbmhkhiNJlr6yaNYe/dWzPS22X/SCiB8LCuo0gecediJbomcDKAP18HSEn/zD
         g610cPNtZmoODkpk7t7/T1wMqF/Ld7B0PzmAj80I/sz6LUWBMj9bYbcG+i8qbOsAvs3M
         9wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tA+QzZPuwuJq/opw2rrhA8CzjHd2tJo6XjKaj0JGJ9Q=;
        b=NmNtIJ6yG1Nj9F7/fDyig/rwZ88t9TGxrqiQ4Q4kj//5+fPKIeiWvtjyYUkTykWhoz
         h8/vXa7+MuqUQFo29dc43HBQ7m5kXoxsuPpzLtIOlcQ8NAC+WKR4giEzAAB7+R0t3tlg
         A3BiUgUAr36b9YIfu4vAGUwiGkvA2RHD7kbrWgRhOPaScLKWlXrTX80wiQI6/87Ks53r
         GkRnawOpmqa7dF+QPP3jeMSblS021mDhv8+RqKvosqhplj8ZYw00rWrtUPi10lJnzfMS
         Etv9LW5KVM56ceeqlAhTy3P5L/qj+Y7FRY0bseWf033DCWsvgiEESc+51Ce2JQIHIdhQ
         /eZA==
X-Gm-Message-State: APt69E3eyBTgXo7Ct4qUzJDMItKAsKVBVNnonBmdJtMFq/ET/qvPpkBa
        BOcWjaSR/IoQ7VkcB4B0mA8=
X-Google-Smtp-Source: AAOMgpftX8EI+e6AWxURB2bQK8ndBxPq5HejpN54E0MucFwbT0Z7NZHH4RWvbnEfzdv4gpvUVJxqmg==
X-Received: by 2002:a1c:c91a:: with SMTP id f26-v6mr3566789wmb.140.1530906681488;
        Fri, 06 Jul 2018 12:51:21 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f190-v6sm17423999wmd.0.2018.07.06.12.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 12:51:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/8] builtin/receive-pack: use check_signature from gpg-interface
References: <cover.1530616446.git.henning.schild@siemens.com>
        <cover.1530616446.git.henning.schild@siemens.com>
        <f9e371c8dd2a17ddb5fd5989a7fdad1c0d1bb6e7.1530616446.git.henning.schild@siemens.com>
Date:   Fri, 06 Jul 2018 12:51:20 -0700
In-Reply-To: <f9e371c8dd2a17ddb5fd5989a7fdad1c0d1bb6e7.1530616446.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 3 Jul 2018 14:38:13 +0200")
Message-ID: <xmqqsh4wjg7b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> The combination of verify_signed_buffer followed by parse_gpg_output is
> available as check_signature. Use that instead of implementing it again.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---

Makes sense.  

When d05b9618 ("receive-pack: GPG-validate push certificates",
2014-08-14) implemented the check, there wasn't check_signature()
available.  The commit probably should have done what a4cc18f2
("verify-tag: share code with verify-commit", 2015-06-21) later did
to introduce the check_signature() function by factoring it out of
commit.c::check_commit_signature() as a preparatory step.

Will queue.  Thanks.

>  builtin/receive-pack.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 68d36e0a5..9f0583deb 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -629,8 +629,6 @@ static void prepare_push_cert_sha1(struct child_process *proc)
>  		return;
>  
>  	if (!already_done) {
> -		struct strbuf gpg_output = STRBUF_INIT;
> -		struct strbuf gpg_status = STRBUF_INIT;
>  		int bogs /* beginning_of_gpg_sig */;
>  
>  		already_done = 1;
> @@ -639,22 +637,11 @@ static void prepare_push_cert_sha1(struct child_process *proc)
>  			oidclr(&push_cert_oid);
>  
>  		memset(&sigcheck, '\0', sizeof(sigcheck));
> -		sigcheck.result = 'N';
>  
>  		bogs = parse_signature(push_cert.buf, push_cert.len);
> -		if (verify_signed_buffer(push_cert.buf, bogs,
> -					 push_cert.buf + bogs, push_cert.len - bogs,
> -					 &gpg_output, &gpg_status) < 0) {
> -			; /* error running gpg */
> -		} else {
> -			sigcheck.payload = push_cert.buf;
> -			sigcheck.gpg_output = gpg_output.buf;
> -			sigcheck.gpg_status = gpg_status.buf;
> -			parse_gpg_output(&sigcheck);
> -		}
> +		check_signature(push_cert.buf, bogs, push_cert.buf + bogs,
> +				push_cert.len - bogs, &sigcheck);
>  
> -		strbuf_release(&gpg_output);
> -		strbuf_release(&gpg_status);
>  		nonce_status = check_nonce(push_cert.buf, bogs);
>  	}
>  	if (!is_null_oid(&push_cert_oid)) {
