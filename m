Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64498C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4014E60EB8
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 18:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhJVSU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhJVSU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 14:20:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726F8C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:18:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z20so5392720edc.13
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=CM5WYWZT1H4AZVY8CKP27Bw8TGZgPQWOeWP26tan82k=;
        b=a4w6vj5YMqhPeyqryz/6e+r3//xClyrxwagyrMOlCQ2uTDGrrZGMWW4xOOjcj2A2Vc
         MN1coUnoRkJ0y2FcbmiLQ9hicQv6ZbNM8wnKX/iTs+U4yycthhUH2ErR9y5/xZfmA7tv
         H/8ySxD+u/PLkJEroiXtHc7U2s9RqoN2r9vPA/jF/Dpp7RQkv7n/BlQHhTQDSPNiLrdQ
         4JYLur3/8R/og/kC8ercxZ1TGp3Dro5lU3u/6iEEpjgFD6TSfjMXxttKA/4FvlQLGsT3
         Gbq4uzjm1hGzlwjUYu2TSF5ecKO0fmym2ipDYRtu3Bdrmhfud3xFq9m7cCpsSdS3KcOv
         NNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=CM5WYWZT1H4AZVY8CKP27Bw8TGZgPQWOeWP26tan82k=;
        b=jvzB6SBhzW3TJOkxiVX0PXIhYN3pr77SR6AvBpjJ1t4Mw17SnTfQrMzkvPvo81fTOo
         50+hl8pfwBP5vsAFMnxG0dysG3NHdXyKgk1b1w+CJGGBatGpMkfhem61DFQfE3edekgl
         w69SSoHm+yTh0Q6w7crJtNDt+obURwMfccF5CW0BvXT+d0HKks6MCTvi5htRduMD/pbO
         T9oKpI3eZVjraaEBQq+OsKTn1RbhMTfnpdeqZlWBmnteDMKUM5nEYr49CuyS9KMcRzLa
         YEkZDIExCFSVmekuqtk2BrcMTGI1vJ9sz1UJSI6IUJEgKndGY/58LBKWXeLMqNUG2NBp
         sUcQ==
X-Gm-Message-State: AOAM530Jznp27kc5IHRDaDdokhK67/Qy4+vPNGw3Wc1zcFwz6BcCQonX
        b4KymjFUfeAFbHW4pz2vt4g=
X-Google-Smtp-Source: ABdhPJxvRHnXjlMqNgf/gkeuRZTZOzeHnfAw782y8n+BlMMenuWFkFkTAnRG+cXyXyhOqf9p2JixEg==
X-Received: by 2002:a05:6402:50d4:: with SMTP id h20mr2063255edb.112.1634926687866;
        Fri, 22 Oct 2021 11:18:07 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x3sm2914901edd.67.2021.10.22.11.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 11:18:06 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdz7F-001J7Z-RE;
        Fri, 22 Oct 2021 20:18:05 +0200
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
Subject: Re: [PATCH 6/6] ssh signing: fmt-merge-msg/check_signature with tag
 date
Date:   Fri, 22 Oct 2021 20:12:11 +0200
References: <20211022150949.1754477-1-fs@gigacodes.de>
 <20211022150949.1754477-7-fs@gigacodes.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211022150949.1754477-7-fs@gigacodes.de>
Message-ID: <211022.86a6j0kjoi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 22 2021, Fabian Stelzer wrote:

>  			buf = payload.buf;
>  			len = payload.len;
> -			if (check_signature(payload.buf, payload.len, 0, NULL,
> +
> +			if (parse_signed_buffer_metadata(payload.buf, "tagger",
> +							 &payload_timestamp,
> +							 &payload_signer))
> +				strbuf_addstr(&sig,
> +					_("failed to parse timestamp and signer info from payload"));
> +
> +			if (check_signature(payload.buf, payload.len,
> +					    payload_timestamp, &payload_signer,
>  					    sig.buf, sig.len, &sigc) &&
>  			    !sigc.output)
>  				strbuf_addstr(&sig, "gpg verification failed.\n");

I haven't tested this, but your addition to &sig here lacks a \n,
compared to the &sig seen right above here in the diff context.

Isn't one or the other either missing a \n, or shouldn't have one?
*Looks ath the surrounding code*, yeah if I'm not wrong it's the \n in
the new code here that's missing.

The whole business of seemingly mixing error messages and a signature
payload in the same variable seems a bit odd, but maybe I'm misreading
it. In any case it seems to pre-date this series...
