Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F56C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 08:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243174AbhLVIG5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 03:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhLVIG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 03:06:57 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46F9C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 00:06:56 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o6so5389873edc.4
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 00:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=amKEWAI7zlgcSJv0xPtUGCcEg1L0QkhOKQ7iB/5UxbQ=;
        b=Cx3OyhljuPRLgL7/iTJ145S3HSXZsjlQzi/AqaefmY2il+GhmcGHEO4CJaIW1uYOvH
         h0/eomXwWCftR1HFAwEoEPHC+UbL9y1NjYGKLyQldqkMycX1n6WGqEjrwiYNO1t1A1uY
         jX8iTBFxPtO1DEAI1s6VVaFzJIg2oxhC4O/mBIZUqRYyrzbLc4y5Jl7be/IQSC4FOCEB
         smUh3LrpQBhcUpKvL22ZlQfiUBXdehu2sYZxzGqG6QvDhwgnD5L4at3KffXUsw+XXEu/
         Rhpi3DNCyxU+XxGoz9JJN9G/KGMmBHSfBZ7tKBoCtRPSPzFx27frSUyN8vfpfdyGNBX4
         Is/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=amKEWAI7zlgcSJv0xPtUGCcEg1L0QkhOKQ7iB/5UxbQ=;
        b=H6M3k3URg+w2Lx1M3Xd7ADvYthK6No7+fjhNT7V5oS4BdKCGd7jMWfxuo+nMsEMt5p
         r3vrkKBwVD4opLDTCbNdNoTUEJ2WYm91pISf3F+LOp31Cozdhcl3FG8InuGoEbIjogw/
         olY4CB7OIVEaUVp4Yf1+Amrv+ZdKpzcAB/Z0YP3N6tt8r63wHPuM0Hvy7Lu0RaADUaX+
         AqyovoRlWqdl9+1gVO1LCbP76X8wSuR5Ba3eMnicgo+zTUPQp8pnrI1INxOLW875hhQv
         F85Zc+/n60Cpq1SU5UEhIhEHIYX9YlZMMqLLd7rTEL4iSvv2f5gVlZOM8Bts7V9fO034
         ruJA==
X-Gm-Message-State: AOAM532cnWqhzdnwdnJ5/Q4apsYbKTyU7AkOfArLQmVEc3ObnwgCJlp5
        Nr2XaZjBMk1aOEhzAr6lYz9AFURmerGtIg==
X-Google-Smtp-Source: ABdhPJy2xbmrfjSqwSjniQ0Ef/VB3tbpbOmtaDL1sDlMp5cTJUkZZjmzcXjImbYgRXwj8UC50/4BbQ==
X-Received: by 2002:a17:906:5d01:: with SMTP id g1mr1539884ejt.219.1640160415341;
        Wed, 22 Dec 2021 00:06:55 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r3sm429685ejr.79.2021.12.22.00.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 00:06:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzweD-0017XD-5K;
        Wed, 22 Dec 2021 09:06:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] fetch-pack: parameterize message containing 'ready'
 keyword
Date:   Wed, 22 Dec 2021 09:06:30 +0100
References: <20211222075805.19027-1-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211222075805.19027-1-bagasdotme@gmail.com>
Message-ID: <211222.86a6gtoyg2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 22 2021, Bagas Sanjaya wrote:

> The protocol keyword 'ready' isn't meant for translation. Pass it as
> parameter instead of spell it in die() message (and potentially confuse
> translators).
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v3 [1]:
>    - Comment style fix (suggested by Junio)
>
>  [1]: https://lore.kernel.org/git/xmqqwnl0gkks.fsf@gitster.g/T/#u
>
>  fetch-pack.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 34987a2c30..51385cb3c9 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1415,9 +1415,17 @@ static int process_ack(struct fetch_negotiator *negotiator,
>  	 * otherwise.
>  	 */
>  	if (*received_ready && reader->status != PACKET_READ_DELIM)
> -		die(_("expected packfile to be sent after 'ready'"));
> +		/*
> +		 * TRANSLATORS: The parameter will be 'ready', a protocol
> +		 * keyword.
> +		 */
> +		die(_("expected packfile to be sent after '%s'"), "ready");
>  	if (!*received_ready && reader->status != PACKET_READ_FLUSH)
> -		die(_("expected no other sections to be sent after no 'ready'"));
> +		/*
> +		 * TRANSLATORS: The parameter will be 'ready', a protocol
> +		 * keyword.
> +		 */
> +		die(_("expected no other sections to be sent after '%s'"), "ready");
>  
>  	return 0;
>  }
>
> base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962

This version (and earlier ones, really) looks good to me. Thanks!
