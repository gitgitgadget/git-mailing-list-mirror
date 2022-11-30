Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979C4C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 09:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiK3JnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 04:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiK3JnV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 04:43:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04401C42E
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 01:43:19 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ha10so40001467ejb.3
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 01:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv1thiTZtop7+mr98Ia6tEihm3tqJ4VuI+QPKkWxdQE=;
        b=CE9LJWhe0n/H277fmyRQBygF5lH/ef8pdQh+YqODKM9wOe+oDnyAAJtK4BSo/89Cla
         ABoYkLI6WH6FOBb+EX3602fK1HsXUdZBGSfz1q39ax/aZqhkTax3SF1MvrvZ1TXoDIzt
         IMlhyrIPlwQkMRDl6yz5ctAMbhYuB8jcw+BNslTVNwR8zyQXl0qi35zbYlPGM8k7o/at
         oyq894OcrI07CfibHtoi4q1OVteTeaMPAJ9+fRlhT6uUpwxG71N7x5j5mhZp2l2ZWTCP
         9q5gmD+z0rp4mrZ4EWqvuXOgqsoH0+N845CgwAn3yUNm8jqD/Fm80nsD6roZUsMjQsGI
         25Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv1thiTZtop7+mr98Ia6tEihm3tqJ4VuI+QPKkWxdQE=;
        b=JhpD/clpaAf/cKPStwCDY99nb4ufO4a1Rqq0CEsqlDinmPvS4TL3TiBT6/UwxfsAXH
         iAS6AhOAp67F0g6yqKq7yxXqOBGY6RuMSRipxNhv8vumAY9GV4ZnuOPVt6/XBz0KaKzU
         QDAds5aRpgrRTmGOSmCtI35jm5gYZHcZC4ipnLX56KU1bA8XhEFHZcAPwMCHQeKqQHse
         W9kKbJ4NPLcEchwu85II1PH1fKO3I6sh31yWd0PaJQrq2cp8+mBhJEvgXYlyyxAq3+C1
         RgAHwQAhclRaldvnNzuoJMC3RK4QYLdo8pAxD0u8fk2X1uhm+jm2rKk5S5tutNH7sXb4
         yMKA==
X-Gm-Message-State: ANoB5pn47SnrHyllbrPX8kBfBWMOmd9XA2zb2DfUJK4NbPBkoVFHkG5v
        vOM4hu4YtTq+XJAiooNNfKg=
X-Google-Smtp-Source: AA0mqf6x27Xw8CId6IxuQAhvLwPtsMbKSjRPvUWwzKfW/d/wHQ1CMw90r6bn+CFDQ5to0tkkuaKc4g==
X-Received: by 2002:a17:906:a1cb:b0:781:fcf6:e73a with SMTP id bx11-20020a170906a1cb00b00781fcf6e73amr50008982ejb.352.1669801398124;
        Wed, 30 Nov 2022 01:43:18 -0800 (PST)
Received: from gmgdl ([109.38.157.167])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0078d9b967962sm439540eja.65.2022.11.30.01.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 01:43:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p0Jca-001xbX-2L;
        Wed, 30 Nov 2022 10:43:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com, me@ttaylorr.com
Subject: Re: [RFC PATCH 5/6] ls-tree: introduce 'match_pattern()' function
Date:   Wed, 30 Nov 2022 10:39:07 +0100
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>
 <20221117113023.65865-6-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221117113023.65865-6-tenglong.tl@alibaba-inc.com>
Message-ID: <221130.86pmd4ixqj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 17 2022, Teng Long wrote:

(I saw this in the latest "seen" push-out)

> From: Teng Long <dyroneteng@gmail.com>
> [...]
> +__attribute__((unused))
> +static int match_pattern(const char *line)
> +{
> +	int ret = 0;
> +	regex_t r;
> +	regmatch_t m[1];

Here we hardcode the size of "m".

(Re-arranged a bit)

> +
> +	ret = regcomp(&r, pattern, 0);
> +	if (ret) {
> +		regerror(ret, &r, errbuf, sizeof(errbuf));
> +		die("failed regcomp() for pattern '%s' (%s)", pattern, errbuf);

Needs _().

> +	}
> +	ret = regexec(&r, line, 1, m, 0);

Here we hardcode that "1" again, but we should use ARRAY_SIZE()
instead. See an existing example at:

	git grep -W regexec.*ARRAY

(Re-arranged from above)

> +	char errbuf[64];

This is a super short errbuf, in other cases we hardcode this to 1024,
which seems reasonable.
