Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72BB81F597
	for <e@80x24.org>; Tue, 24 Jul 2018 17:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbeGXSK4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 14:10:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32921 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbeGXSKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 14:10:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so4883761wrp.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XnSu/fFF8DU3SrUwYuoF7nNpKVtLu9VJDt7CRXXk0Nw=;
        b=sFHoZSqHbPHrumOTa/MOGsG0w2xQ+ca01aH5Iy2AeoPf8Ee8QJZfmuS7ykYMrJakXW
         UY0PvliSe0o8rk5O9vuySqNrWuHP/Uo5YQ1nzI06XXCP+f4i1ktKQAjfaShVCqcXKo98
         J7tJ5Lkm7ALhnQaVB6qd72QK9d6/A48I5c01PgtOL8wlYLJ8G1vl3PTLpCbPvmhkFhkE
         /qCv0r23vWF3w2v2UrVBDceVWvlz3PETpoPpJVCnNXjPkF8isxey/4x1frl/mQPwemA6
         XPq/SiRRbP5HPXbIRVcKncZfqSG4N4KG2AGI6ITWtp0L6N6D5LrZpkIuhe1Za4LaHQ92
         WLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XnSu/fFF8DU3SrUwYuoF7nNpKVtLu9VJDt7CRXXk0Nw=;
        b=lKRZ3Wdbubum/f5E03oJ8uZ0lVpmDSDCPKZMAJlJj8jpX4AVx3EAF7oQ80xIEVtd38
         TmfnViVgyeZWB71nX3EsgzO7a2oWoJABUROB1af8Qta361fD7pXM6jr0AOly5b+Kqcoh
         +9stLOAoWVihuBfWrc53oxoDDSEA8A72XoHzyQiOf+LXWYOSdOiuM1CRXr0jkTP62Vxb
         4oy5kikeGxHQfPzpNOzCu7h76lp2gtvkJ+sLSrkFjyGZjBupejlhvSK3vA6gZz7gyTJA
         gtQTEZDPpQnlSYMy7/rYw2fLJWfYgTw/kuZkTvC8Fm7aodf7z7caZUxiZ44Ob3zI0WQp
         2a1A==
X-Gm-Message-State: AOUpUlHydpyIJ0pOJwAxLi8N09OPtBoztDaLaGuDENJAE4y1vV9cOLON
        PnLU1YXKvcUHAqBrbvV4dLO9Eo5F
X-Google-Smtp-Source: AAOMgpdUu2767WVEc6Kp3B0EJMgf2x8kQseTfvvYzbarZoK2rjKCltQGXVMuSGE5EIFBL26czR3pGQ==
X-Received: by 2002:adf:8385:: with SMTP id 5-v6mr12274883wre.13.1532451808864;
        Tue, 24 Jul 2018 10:03:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w204-v6sm3895741wmw.5.2018.07.24.10.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 10:03:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
        <20180722054836.28935-4-chriscool@tuxfamily.org>
Date:   Tue, 24 Jul 2018 10:03:27 -0700
In-Reply-To: <20180722054836.28935-4-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 22 Jul 2018 07:48:34 +0200")
Message-ID: <xmqqk1pkzhuo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +Islands are configured via the `pack.island` option, which can be
> +specified multiple times. Each value is a left-anchored regular
> +expressions matching refnames. For example:
> +
> +-------------------------------------------
> +[pack]
> +island = refs/heads/
> +island = refs/tags/
> +-------------------------------------------
> +
> +puts heads and tags into an island (whose name is the empty string; see
> +below for more on naming). Any refs which do not match those regular
> +expressions (e.g., `refs/pull/123`) is not in any island. Any object
> +which is reachable only from `refs/pull/` (but not heads or tags) is
> +therefore not a candidate to be used as a base for `refs/heads/`.
> +
> +Refs are grouped into islands based on their "names", and two regexes
> +that produce the same name are considered to be in the same island. The
> +names are computed from the regexes by concatenating any capture groups
> +from the regex (and if there are none, then the name is the empty
> +string, as in the above example). This allows you to create arbitrary
> +numbers of islands. For example, imagine you store the refs for each
> +fork in `refs/virtual/ID`, where `ID` is a numeric identifier. You might
> +then configure:
> +
> +-------------------------------------------
> +[pack]
> +island = refs/virtual/([0-9]+)/heads/
> +island = refs/virtual/([0-9]+)/tags/
> +island = refs/virtual/([0-9]+)/(pull)/
> +-------------------------------------------

It becomes clear only from this example that what the feature calls
(and documented in patch 2/5) "regexp" is not BRE but ERE.  Update
2/5 so that it is clear to readers of "git config --help" who looks
for "pack.island" in the output.

> +That puts the heads and tags for each fork in their own island (named
> +"1234" or similar), and the pull refs for each go into their own
> +"1234-pull".

"by concatenating any capture groups" made me imagine that the last
one would be "1234pull" without dash.  The actual rule should be
mentioned in that paragraph (i.e.  "concatenating any capture groups
from the regex, with a '-' dash in between" or something like that).

> +Note that we pick a single island for each regex to go into, using "last
> +one wins" ordering (which allows repo-specific config to take precedence
> +over user-wide config, and so forth).
