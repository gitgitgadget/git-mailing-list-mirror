Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F252C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 10:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A8F611AD
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 10:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhIKK0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 06:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhIKK0i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 06:26:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA1CC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 03:25:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b10so2892420ejg.11
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0nXaOJKB4wsD8/mfJdDUIzvUxe4PmF6maBH+Un89EJc=;
        b=XFWnDxUIKqj+DVNt+pUoq7Zy7BOkP23EMEGG9YG+YD6//mkeHQJXXKoI/gSqEWKhzO
         cC4EJCF9HbqVfaC7C80YrcLFsF2sA+MATqecwQFNtkKHn2Sd/kvjkMCQzpFEka2Wu7Ht
         ahgQRWT7HTpLHs/0QVucjAOlh2sRUVE53PhjLOA99EVfjQEnaHs4Q4ksF6hTdcwN8gyr
         ODsTGRFPOqyVJL7Go3yWkz0apWHwoQHNLUd4eCbBNPXQTcsNtXX3enz5Gdu5ocfUGdpN
         mxVkO68yXAglym1td7CyPiaXuzKF0iImle7ULIWx3S5s9aMhkC6DW5yuGrEGgfimqmdZ
         /Zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0nXaOJKB4wsD8/mfJdDUIzvUxe4PmF6maBH+Un89EJc=;
        b=6IAnjDTJqKrAB12RA9RxDDV6OOUiGbgMxF9hH0iMjiwbodfRwYYvZ3w72/qewlbWOf
         rlExXYJik2xxl7DMFWvgT8J2/mGMXw+gsGEGlYpdTEvYtI7KgC33UVQ7n6BTpZZwVIKT
         VNMo3uYxLTIquZTKazWpK0GjVUGfIC94FTYZt8pg+jmUNbcMxVOQN6dz0vHtqB9/AOvM
         yGaxHYzG2MQC7awLruVMoYFXCIEei8Zc0/F6S1ymfCC9Gjj4YhIBPy3XSmW3nSHohgdd
         y1lXd1X2BlEUil6iuRxOwt7BdpY66cJ7XSUyQP3KOJlTAPfDcipfTff03RPIx7agwSGV
         CS+g==
X-Gm-Message-State: AOAM5328a3LQjf2tmSBbwlNKyZ2c4EPlBpYUe1GeSMkVAI7aEvGY+ubi
        l1k9Bae/t8S5MsI1Qh6J9m0=
X-Google-Smtp-Source: ABdhPJyzBdf5s6XSoii6C+FFlzXPxcIMF/bVhmabtr3dr96/C1UqHqd8YN+W7AtF7RZCnXPhQUSlYQ==
X-Received: by 2002:a17:907:7252:: with SMTP id ds18mr2178921ejc.105.1631355923277;
        Sat, 11 Sep 2021 03:25:23 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h10sm719224edf.85.2021.09.11.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 03:25:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 7/8] builtin/repack.c: make largest pack preferred
Date:   Sat, 11 Sep 2021 12:17:37 +0200
References: <cover.1631331139.git.me@ttaylorr.com>
 <a790ee5ac6c03d6832599e77f84c352f577d6287.1631331139.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <a790ee5ac6c03d6832599e77f84c352f577d6287.1631331139.git.me@ttaylorr.com>
Message-ID: <875yv79zot.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Taylor Blau wrote:

> +	if (geometry) {
> +		struct packed_git *largest = get_largest_active_pack(geometry);
> +		if (largest)
> +			strvec_pushf(&cmd.args, "--preferred-pack=%s",
> +				     pack_basename(largest));
> +		else
> +			/*
> +			 * The largest pack was repacked, meaning only one pack
> +			 * exists (and tautologically, it is the largest).
> +			 */
> +			;
> +	}

Probably one of those cases where an assignment within an "if" is the
better of two evils, despite the CodingGuidelines warning against it
(but not forbidding it). The added get_largest_active_pack() could also
learn to punt on a NULL argument, in which case we wouldn't need an
assignment):

	struct packed_git *largest;
	[...]
        /* If ...[...] */
	if (geometry && (largest = get_largest_active_pack(geometry)))
		strvec_push(...);

I punted on re-phrasing the comment, because the current code invites
the reader to start reading this block, then we see that we may do
stuff, and then the comment applies to what we *didn't* do.

> -		usage("read-midx [--show-objects|--checksum] <object-dir>");
> +		usage("read-midx [--show-objects|--checksum|--preferred-pack] <object-dir>");

Just an aside, but I'm surprised to see this use the older
non-parse_options() usage API, which we're generally moving away
from. usage_msg_opt() is generally better.

> +		git config core.multiPackIndex true &&

I remember a similar pattern from another series, does this test pass
without the config being set? I didn't check...
