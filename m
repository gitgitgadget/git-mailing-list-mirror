Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E542C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 00:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F0160F25
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 00:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhIOAnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 20:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhIOAnP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 20:43:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF25C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 17:41:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i21so2367698ejd.2
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 17:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=kYuuGVaYZ9TIpX7KbgylIzz1qBmnYccIzc27k3Lu8NQ=;
        b=GkeCvH1MQ1MoUean9mgWbekbpQr5GBg9m56tIW+Wi5nKFH+TYqttevxZflCcbuM6n7
         eISu2RNhgmHmg5VexVxWnQjAZzX83CtviQvs3PFbz0hG+40x3dbZ9qMLh3PdaFgAErLg
         G2ybX2D3dl0SfxlyEtL0cKpTypbj3VGvEAXmWfRoCKwlgX6/qOuG+Ll8pUHJ9gt7p62D
         d6fCNyWe6dVrDhHuAoaICON6zkUtazWEVL43iCJL3YzpjlUjib7jH758mFmzaZ1tF1e3
         ogvwQSNx80P6cD0V5hllr2xQoHfvXNpT9aNg59dqHZ6hTbP+t5CgO8X+nOS3hmm2DQYT
         sD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=kYuuGVaYZ9TIpX7KbgylIzz1qBmnYccIzc27k3Lu8NQ=;
        b=PQw1IE+ePuXST6jiLg8NjiZUhhSuok+Lgs5kD6d3BsZsjUkmsNIsodetCdOpkcdgQF
         SR8erkISEFgVG7XvA58oryy3VH5k19DnI7S7GVCFL+JMn/KnLGx2kbVrY+EKGhLxfWL3
         YW/A0/pmB3Ko47n83pb1XYqM6tidy6dTJn8vpqSS8R8Qu+MV+ueoMKBA524+5ttbuQkB
         0SnSkRJuipPezxJPwDvVNbaS95QDWP263xPxZiD0QTFmi3g6Dv0OlINqZdcCgVQmdTE1
         sJ8zaEsNDUfEczn0FolnBFnWdBWaE1iEy0EAcFDDkoiZTSPvt6GUfPDaM4ykF3kOvJkT
         4eiw==
X-Gm-Message-State: AOAM533ODRQjDBN7TqwIySxXuYw1FKxPOl3BET7U/of99r3vPqUQsZuc
        LwY+4oaFHN69zw+dmp6Lv4g=
X-Google-Smtp-Source: ABdhPJwamw8iw3jI+ifWZu3OGuQbWg2PyjeqYELygATm204nNfKglXNOBruOUPWJWcCbNxAo1v/aTg==
X-Received: by 2002:a17:906:2691:: with SMTP id t17mr21419618ejc.522.1631666516146;
        Tue, 14 Sep 2021 17:41:56 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k6sm6134199edv.77.2021.09.14.17.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 17:41:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 03/11] serve: add "receive" method for v2
 capabilities table
Date:   Wed, 15 Sep 2021 02:31:28 +0200
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE1fGZc1FuuyUNH@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUE1fGZc1FuuyUNH@coredump.intra.peff.net>
Message-ID: <87sfy6mzzg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 14 2021, Jeff King wrote:

> -static int is_valid_capability(const char *key)
> +static int receive_client_capability(const char *key)
>  {
>  	const char *value;
>  	const struct protocol_capability *c =3D get_capability(key, &value);
>=20=20
> -	return c && c->advertise(the_repository, NULL);
> +	if (!c || !c->advertise(the_repository, NULL))
> +		return 0;
> +
> +	if (c->receive)
> +		c->receive(the_repository, value);
> +	return 1;
>  }
>=20=20

I haven't actually run this yet (and need to zZzZ soon), but AFAICT at
the end of this series you leave the existing advertise semantics of
advertise() be (which is fine). I have this unsubmitted patch locally
which you may or may not want to work into this.

I considered splitting up the advertise() method as well, i.e. we could
have a new "is_advertised" boolean callback, and then a
"capability_string" or whatever. "server-option" and "object-info" never
add anything, so they could leave that as NULL.

But it's probably not worth it, just food for thought...

-- >8 -- serve: document that "advertise" is called in two modes

If we're being called with a non-NULL argument we're sending out the
advertisement line, but if it's NULL we're actually in the middle of a
request.

So you can use the check for NULL to emit your own "die" on "return
0", like "wtf, I said I don't support command xyz, why are you calling
it?", as opposed to the default "invalid command '%s'".

Maybe nobody cares, and we can't assume that we're going from an
advertisement to a command for the same request anyway (can
we?). I.e. are we serving multiple clients?

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 serve.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/serve.c b/serve.c
index aa8209f147e..b187ce26911 100644
--- a/serve.c
+++ b/serve.c
@@ -55,6 +55,12 @@ struct protocol_capability {
 	 * Optionally a value can be specified by adding it to 'value'.
 	 * If a value is added to 'value', the server will advertise this
 	 * capability as "<name>=3D<value>" instead of "<name>".
+	 *
+	 * When called with a NULL value we're past the advertisement
+	 * itself, and are checking during a request whether we
+	 * support this command. This can be checked and used used to
+	 * e.g. emit a die("we support this, but don't have it
+	 * enabled!") error.
 	 */
 	int (*advertise)(struct repository *r, struct strbuf *value);
=20
--=20
2.33.0.1013.ge8323766266

