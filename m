Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46982C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 18:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJJSwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 14:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJJSwR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 14:52:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B2D786DD
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:52:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nb11so26786471ejc.5
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L/hNR3umdEUf2FjV313K2ks7N2DKloVOum6Lv0TNEzQ=;
        b=CZo/CZ6DKQBuTTbsiD5VVAn7uMLIpeYUYaB1AxzSccuoBEI5mknu3Ea2e5LYj9HhRj
         0ol01NhBKwY20vbq2gfgv1r5p/64mXffbxH4b6snX+l7K+1Gs+y4/YVbY/ccj+dU1Mxt
         vOA+nrPBpltqks59K2RqtRjDacALx0b6n0TfEd5wqFpm5NfcylMlJBRNJNJSk1pg/UZv
         AaLYpqzuOM9UqHYtAATPgUy9W1x9bqgMw7/1VXHTvyDI026vb+ieAmYrMDBAYZPDyz2R
         vBlkd9ja67mOIaeOyheR8r1Lf98GqogrGArUDrRt7vfo3iToBEtBqFKMTUvJviVOYvpB
         pWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/hNR3umdEUf2FjV313K2ks7N2DKloVOum6Lv0TNEzQ=;
        b=GMnVAHOJltmqgHFRZagD7Hb5N9taIwEVAxLNC+9pt/HFCB8Qp2ciWx4kk3wplnAjmU
         RUy4BQXVhefrF8ag7Gy4Nh/pMQGMNplbirbmpQdog6vwLWOcmcverczZ1UF8P9NlRRL4
         otnosZkmsK9d0GcCNFgzlRfWY88+5WdDuUpJnBA1UpuRGdGojRoOe1XfsetURwCT3mET
         7oNJzny3P+NOMrC+TiGAs6uNy3HEuvV0Euy41vHrD7xO1f2tdeX1yzzTxWgg2HZkD4rE
         o+ZzQldNv8aIpboBnRwR5bXF+BwpD/K+XBisZpnyCCLmcLJMx0Ba7sBnYeg7z8330rQX
         36Jw==
X-Gm-Message-State: ACrzQf3fdbe8We5Hky8kXUxPwe4FG+CjiIfzMVJNLjGZ0OB2YAoqXaxB
        vbv/s3yZ7zs+wVci8opuY/4T20VuNs1zVw==
X-Google-Smtp-Source: AMsMyM4snKzpP12U+MnZo1ybxGbyu88ub5/ViV2v1LQzV7w5BRTJHYAVkXc2oIPtjqQ+vaJs6QttVA==
X-Received: by 2002:a17:907:2bdb:b0:78d:cf5a:210e with SMTP id gv27-20020a1709072bdb00b0078dcf5a210emr1004643ejc.747.1665427933325;
        Mon, 10 Oct 2022 11:52:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g7-20020a170906538700b0078d9cd0d2d6sm3609853ejo.11.2022.10.10.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:52:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ohxsp-003jE2-2P;
        Mon, 10 Oct 2022 20:52:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, orygaw <orygaw@protonmail.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] log: require --grep for --invert-grep and --all-match,
 fix segfault
Date:   Mon, 10 Oct 2022 20:48:25 +0200
References: <o2ijhZAUIi7nPTwQmsJfpvPIEeLbhvn1AP8rhW2hCNbC380Z2ogDHzZigqJsHI6RwphsIZR3OSJSy-wYvyWv5un632tKynHKFLFPLPEDH2g=@protonmail.com>
 <patch-1.1-f4b90799fce-20221010T165711Z-avarab@gmail.com>
 <xmqq7d174m6a.fsf@gitster.g> <xmqq35bv4lns.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqq35bv4lns.fsf@gitster.g>
Message-ID: <221010.86o7ujpl44.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 10 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Neither the "--invert-grep" option added in [1] nor the earlier
>>> "--all-match" option added in [2] were intended to be used
>>> stand-alone.
>>
>> Mostly yes, but with "to be used" -> "to take effect".
>>
>> "[alias] lga =3D log --all-match" would be equivalent to "log"
>> unless the command line starts talking about "--grep", which is
>> quite handy.
>>
>> So the real fix would be not to forbid the standalone passing of the
>> option to the command, but to fix the over-eager freeing of an
>> unallocated resource, introduced more recently, I would suspect.
>
> On the other hand, I do not think "--invert-grep" is useful in the
> same way.  The only usage I can think of is to omit merges by
> looking for substring "^Merge", but then we already have a more
> robust "--no-merges" option for that purpose.
>
> But both uses the same mechanism, I would say treating them the
> same, i.e. silently ignoring these when --grep is not given, would
> be the most sensible.

The rationale for changing it this way is that the documentaion says:
=09
	--all-match::
	        Limit the commits output to ones that match all given `--grep`,
	        instead of ones that match at least one.
	--invert-grep::
	        Limit the commits output to ones with log message that do not
	        match the pattern specified with `--grep=3D<pattern>`.

Especially as we also say:

	--grep-reflog=3D<pattern>::
	        Limit the commits output to ones with reflog entries that
        	match the specified pattern (regular expression) [...]

I.e. pretty much the same wording, but there we'll die if the
corresponding other option is omitted, as the context shows.

Maybe we want to post-hoc say we'd like to support it, in which case
some plasting over the issue (e.g. in the direction of Taylor's fix)
would do it.

