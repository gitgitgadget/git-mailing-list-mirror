Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4048DC4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 09:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiKQJy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 04:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiKQJxT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 04:53:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACD05ADC0
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 01:53:15 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gv23so3771104ejb.3
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 01:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fUQ0AO6nBrpkagDYNxciWTqeHrj4HJLUs5uKYCaBSB8=;
        b=YarZRW1SPZN7mIc0p9B06DYJ2eIAkwk4M7JVdRRjeoK+GU2En4x7nxhgBsD+MtQ4kw
         qXMKi3rYL6DiJVMgShRawXEDYYwBT5P8mtTldelWuhrlJQHT3u0tczWzQwfhnfUg2lnR
         zk1Kg/pSCeOh1Rd1HuEzZl3qfFgAuXOJBvE2n0XR+GP9qlEmFoeILvyU1ywQH/IyVgZG
         w3jpPh0p7E42hZ7CfF4xTvVXwnBOcSgiztEG5eXoe1VN13MLdLbt7rwBC7JqyzbKsqLc
         uqzASjALDGRL9ZApVxmeoA2lm9GPh9AJy8vN2S1XV2UwlMrwQSwXYBCxoDWBk/ZOxSAE
         m3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUQ0AO6nBrpkagDYNxciWTqeHrj4HJLUs5uKYCaBSB8=;
        b=QLFeXOffIIuiXuXcMyEeUIMUFNFnsNZPmy9KOlHj5ExHR5NbD+5s0jev2OHVLSA7Sa
         XXymfWn6y9OEOd4E6HksT/x1wJr4OfmsqZNJXHXNQC2C1YC+0haV4vCeRLn01vNBivSw
         HjmpsiqxUCQKGLFfEcAfKCn9yStb09m2zaGAUfpaWSC5CSzOQEVDgKVkaaSC+pkr6t6h
         JAb++Jwc7XXtluxjxtG4XimJBRIRHxpI75f6dcIqP6l0PZUcmTQXh5yVWsrnMJx4As9p
         ZnYyiOEJ0VITdVVKjzyTt2j8RsN7hAN4hbYGgkD6u+FTKC/gio9kgPn5AVICg4Yah+Ht
         OgSw==
X-Gm-Message-State: ANoB5plgMcUQROX/GLUfnfieGxgaOg+oo+PGKQBdCsFLcI8CIfrrP2z3
        9ydmeeidoN6MA3U27jnSsUbNyIoFQdI=
X-Google-Smtp-Source: AA0mqf7bZsiZRxe7nBLHmwHM2ULYIo7GWNQHATFhfXLeqt67F9B4qWKmme5BwHmZ9RnsrwTnFLtGdg==
X-Received: by 2002:a17:906:f106:b0:7b2:9a6b:9ac6 with SMTP id gv6-20020a170906f10600b007b29a6b9ac6mr1468938ejb.215.1668678793783;
        Thu, 17 Nov 2022 01:53:13 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b007ab2d744801sm132072ejd.190.2022.11.17.01.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 01:53:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovba4-004hvY-2w;
        Thu, 17 Nov 2022 10:53:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] notes: avoid empty line in template
Date:   Thu, 17 Nov 2022 10:48:48 +0100
References: <347ee7ad6fea7cf96bb1e51772802102082b58cc.1668614158.git.git@grubix.eu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <347ee7ad6fea7cf96bb1e51772802102082b58cc.1668614158.git.git@grubix.eu>
Message-ID: <221117.86wn7tj4af.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 16 2022, Michael J Gruber wrote:

> When `git notes` prepares the template it adds an empty newline between
> the comment header and the content:
>
>>
>> #
>> # Write/edit the notes for the following object:
>>
>> # commit 0f3c55d4c2b7864bffb2d92278eff08d0b2e083f
>> # etc
>
> This is wrong structurally because that newline is part of the comment,
> too, and thus should be commented. Also, it throws off some positioning
> strategies of editors and plugins, and it differs from how we do commit
> templates.
>
> Change this to follow the standard set by `git commit`:

I don't mind the consistency here, but what does "wrong structurally"
mean? Doesn't the usual removing of duplicate newlines make this amount
to the same?

>> #
>> # Write/edit the notes for the following object:
>> #
>> # commit 0f3c55d4c2b7864bffb2d92278eff08d0b2e083f
>>
>
> Tests pass unchanged after this code change.

Because it did change something and we've got bad test coverage, or just
because it's really a stylistic change?

I don't mind it being a stylistic change, but the proposed commit
doesn't really make that clear, and leaves one wondering about potential
missing test coverage etc.

> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  builtin/notes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index be51f69225..80d9dfd25c 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -181,7 +181,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
>  		strbuf_addch(&buf, '\n');
>  		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
>  		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
> -		strbuf_addch(&buf, '\n');
> +		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
>  		write_or_die(fd, buf.buf, buf.len);

Nothing new as the pre-image shows, but I wondered why not just add a
"#\n", before I remembered core.commentChar, so this is correct.
