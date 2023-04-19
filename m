Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9082AC6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 15:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjDSPak (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 11:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjDSPai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 11:30:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF411716
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:30:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b73203e0aso48594b3a.1
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681918236; x=1684510236;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48Z4pJ0+Fecypxq8NzkSkDZScL48/3dDzTQQew7UZwI=;
        b=WLfsKYUvLVZtb/AtRWPRq5IYIwedtAV2BxsnDf4/vZEU8eqLFbHqIvcmFKMeAhwEAM
         r6axdgqE4qh6jJq5TJuUklbP9RmCsuQR6m81l6ddBirfLH4e1VGx5jodcNX8iDZYLvYX
         4JApir9YGPJ9IZH3rVzdwZAXm4I/rx9whgm2Ry23SJDAikSbLqUUJ4ilUnN22XSmlncl
         A77z3JokoJDPR+2SZXz/ZJQ9ZSB2CjAZhjIKZGLstQBu+JCiEHolhG/TiXiwRVrBaYcB
         rpCUo9TmEd2meyDLmMJQzvq980U1w7x8bU5VgmZYaxwSb9Vaxx9lv9giIPwRwF3AaT9N
         VM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681918236; x=1684510236;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=48Z4pJ0+Fecypxq8NzkSkDZScL48/3dDzTQQew7UZwI=;
        b=IkLoSPcWMpGmr7ZOCkG0pQfWpAY9wMb7xcEjsajz3+75nfw1hkIPHJelEEUOWEp9kp
         k1dfrWO8D9KZhD7nvMj/f7M/VtFD1bYUVeJDiDOkAgxZq9CWJ4Paji1+3TgP1b/anw//
         KQDJ2te3rWelHrY8I2iMwlyYWldm9T/ZA6gdSJUEeEKeZHXu4u6h0yKvySUErLXKjPCU
         pNKmDw6TIPE0ICIe+wUsHAsxaVESWNHkJJA0UxI1vIJ05JxdkL/sCIi6TCs+mpU1zUZJ
         lk2BI0vJAlGpfKktJkmh+rN/E79Rsb7SFZVUG3a2R8hmaaZKKzayCye6JtWVOwpXmx31
         sQIg==
X-Gm-Message-State: AAQBX9dsdbSwHQnA+8ijIe1NL1oR6VBXWChfslhA2l0tq0jrCnyyMi18
        hcDtU5ar4HOhn5H4Im+pGBw=
X-Google-Smtp-Source: AKy350ZgesV1HtgqHl6geFdXg+5XnCHTBRpNdbzCUN0AUT7SQD97cRaj6O1LYOY0nJ+E3Y1oQGIWcQ==
X-Received: by 2002:a17:902:f7d6:b0:19e:2fb0:a5d9 with SMTP id h22-20020a170902f7d600b0019e2fb0a5d9mr2404245plw.32.1681918235982;
        Wed, 19 Apr 2023 08:30:35 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id t18-20020a17090ad51200b002471e13fcbfsm1520131pju.35.2023.04.19.08.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 08:30:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rolf Eike Beer <eb@emlix.com>, git@vger.kernel.org,
        Jaydeep P Das <jaydeepjd.8914@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] gpg-interface: set trust level of missing key to
 "undefined"
References: <5926995.lOV4Wx5bFT@devpool47.emlix.com>
        <20230418064846.GA1414@coredump.intra.peff.net>
        <xmqqy1mpduq3.fsf@gitster.g>
        <20230419012957.GA503941@coredump.intra.peff.net>
Date:   Wed, 19 Apr 2023 08:30:35 -0700
In-Reply-To: <20230419012957.GA503941@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 18 Apr 2023 21:29:57 -0400")
Message-ID: <xmqqy1mnanz8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's the patch that I came up with, though it does not distinguish
> between "we did not see any trust level" and "gpg told us the trust
> level was undefined". I think that's OK. That level is still below
> TRUST_NEVER. But if we really want to distinguish we can introduce a new
> value for the enum.

Good.

In my zeroth draft, I added to the enum a new TRUST_FAILED = -1 to
be used for the initialization assignment and get stringified in the
gpg_trust_level_to_str() function, which gave us the distinction and
made sure the enum is signed.  But in the end, I decided it was not
worth risking upsetting the end-user scripts that assumed the
current set of levels with a new "level" that is not known to them.

Initializing to undefined like this patch is with much less damage
to the codebase, and existing end-user scripts are probably prepared
to react to "undefined" already and treat it as even less trustworthy
than the "never" ones.

Will queue.  Thanks.

> -- >8 --
> Subject: gpg-interface: set trust level of missing key to "undefined"
>
> In check_signature(), we initialize the trust_level field to "-1", with
> the idea that if gpg does not return a trust level at all (if there is
> no signature, or if the signature is made by an unknown key), we'll
> use that value. But this has two problems:
>
>   1. Since the field is an enum, it's up to the compiler to decide what
>      underlying storage to use, and it only has to fit the values we've
>      declared. So we may not be able to store "-1" at all. And indeed,
>      on my system (linux with gcc), the resulting enum is an unsigned
>      32-bit value, and -1 becomes 4294967295.
>
>      The difference may seem academic (and you even get "-1" if you pass
>      it to printf("%d")), but it means that code like this:
>
>        status |= sigc->trust_level < configured_min_trust_level;
>
>      does not necessarily behave as expected. This turns out not to be a
>      bug in practice, though, because we keep the "-1" only when gpg did
>      not report a signature from a known key, in which case the line
>      above:
>
>        status |= sigc->result != 'G';
>
>      would always set status to non-zero anyway. So only a 'G' signature
>      with no parsed trust level would cause a problem, which doesn't
>      seem likely to trigger (outside of unexpected gpg behavior).
>
>   2. When using the "%GT" format placeholder, we pass the value to
>      gpg_trust_level_to_str(), which complains that the value is out of
>      range with a BUG(). This behavior was introduced by 803978da49
>      (gpg-interface: add function for converting trust level to string,
>      2022-07-11). Before that, we just did a switch() on the enum, and
>      anything that wasn't matched would end up as the empty string.
>
>      Curiously, solving this by naively doing:
>
>        if (level < 0)
>                return "";
>
>      in that function isn't sufficient. Because of (1) above, the
>      compiler can (and does in my case) actually remove that conditional
>      as dead code!
>
> We can solve both by representing this state as an enum value. We could
> do this by adding a new "unknown" value. But this really seems to match
> the existing "undefined" level well. GPG describes this as "Not enough
> information for calculation".
>
> We have tests in t7510 that trigger this case (verifying a signature
> from a key that we don't have, and then checking various %G
> placeholders), but they didn't notice the BUG() because we didn't look
> at %GT for that case! Let's make sure we check all %G placeholders for
> each case in the formatting tests.
>
> The interesting ones here are "show unknown signature with custom
> format" and "show lack of signature with custom format", both of which
> would BUG() before, and now turn %GT into "undefined". Prior to
> 803978da49 they would have turned it into the empty string, but I think
> saying "undefined" consistently is a reasonable outcome, and probably
> makes life easier for anyone parsing the output (and any such parser had
> to be ready to see "undefined" already).
>
> The other modified tests produce the same output before and after this
> patch, but now we're consistently checking both %G? and %GT in all of
> them.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Reported-by: Rolf Eike Beer <eb@emlix.com>
> ---
>  gpg-interface.c          |  2 +-
>  t/t7510-signed-commit.sh | 21 ++++++++++++++-------
>  2 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index aceeb08336..f3ac5acdd9 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -650,7 +650,7 @@ int check_signature(struct signature_check *sigc,
>  	gpg_interface_lazy_init();
>  
>  	sigc->result = 'N';
> -	sigc->trust_level = -1;
> +	sigc->trust_level = TRUST_UNDEFINED;
>  
>  	fmt = get_format_by_sig(signature);
>  	if (!fmt)
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 48f86cb367..ccbc416402 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -221,84 +221,91 @@ test_expect_success GPG 'amending already signed commit' '
>  test_expect_success GPG 'show good signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	G
> +	ultimate
>  	13B6F51ECDDE430D
>  	C O Mitter <committer@example.com>
>  	73D758744BE721698EC54E8713B6F51ECDDE430D
>  	73D758744BE721698EC54E8713B6F51ECDDE430D
>  	EOF
> -	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
> +	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success GPG 'show bad signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	B
> +	undefined
>  	13B6F51ECDDE430D
>  	C O Mitter <committer@example.com>
>  
>  
>  	EOF
> -	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat forged1.commit) >actual &&
> +	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" $(cat forged1.commit) >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success GPG 'show untrusted signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	U
> +	undefined
>  	65A0EEA02E30CAD7
>  	Eris Discordia <discord@example.net>
>  	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
>  	D4BE22311AD3131E5EDA29A461092E85B7227189
>  	EOF
> -	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
> +	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success GPG 'show untrusted signature with undefined trust level' '
>  	cat >expect <<-\EOF &&
> +	U
>  	undefined
>  	65A0EEA02E30CAD7
>  	Eris Discordia <discord@example.net>
>  	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
>  	D4BE22311AD3131E5EDA29A461092E85B7227189
>  	EOF
> -	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
> +	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success GPG 'show untrusted signature with ultimate trust level' '
>  	cat >expect <<-\EOF &&
> +	G
>  	ultimate
>  	13B6F51ECDDE430D
>  	C O Mitter <committer@example.com>
>  	73D758744BE721698EC54E8713B6F51ECDDE430D
>  	73D758744BE721698EC54E8713B6F51ECDDE430D
>  	EOF
> -	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
> +	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success GPG 'show unknown signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	E
> +	undefined
>  	65A0EEA02E30CAD7
>  
>  
>  
>  	EOF
> -	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
> +	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
>  	test_cmp expect actual
>  '
>  
>  test_expect_success GPG 'show lack of signature with custom format' '
>  	cat >expect <<-\EOF &&
>  	N
> +	undefined
>  
>  
>  
>  
>  	EOF
> -	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" seventh-unsigned >actual &&
> +	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" seventh-unsigned >actual &&
>  	test_cmp expect actual
>  '
