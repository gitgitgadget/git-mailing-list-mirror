Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1527B1F404
	for <e@80x24.org>; Sun,  8 Apr 2018 23:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeDHXSt (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 19:18:49 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:52223 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752320AbeDHXSs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 19:18:48 -0400
Received: by mail-wm0-f48.google.com with SMTP id u189so14503047wmd.1
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=ALVzn90nud06tMRnui63KGuYGVU2PgUahpZ+6VnT1os=;
        b=lu56O7Gi1rjisfC8sajfaH10aC6P6vp2PmpqnGZqwY1q63r2pj5bwy0LARz1ZqFewZ
         kpTPEZNguXlu5Qljw1MbnORwNTHqdCt0mx+QlQcu/MJNH/JsbDlTex4KCwtvdQQWTrjg
         TeZmOSLvQ7eBHryr4oX7r9coeqcpQ9vZuxP9mb+vnsmXLjIXtDgcli/pbzBYneXLhZ4n
         zBCQ2ebWjC65Okuf4bwijvgoSQ2/QKTrSkLMojfgq1eP2sYDX9p9maCMfVc/E+F5mpbs
         AgXiruEU52YgLFyui76Wm802jaBfKNgO7TSmP6IClLCzcEFDpYfbuOkDl5M4Hv6pfzjW
         CDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=ALVzn90nud06tMRnui63KGuYGVU2PgUahpZ+6VnT1os=;
        b=U3ysNbZP5ucIpM9+Tt1MnPakO9q6ZzpZektyCTIZdUao7DJQJqRA8wl7bs46XKrlHZ
         mLi5mdlSuPNdXMjnOs4XV+Qouo7axy6oiROckYlNZf26krLzGzQMrj/NIDMvE41dp3Vt
         RteUPAXMrQVj/IKxiGZELLPq4VwGX/R5l97QfvHW2oQUmdVsEjOIJWT3PrTgvTBhMipj
         l6leO44+tuedybY47T/Q/y+sHCyDCa8/sHjuVBkFL8jCgNXvS61SCSVR7M0v997BUZ2k
         aXdytGubtxrKrVpIDsL6rPU6hHSTvtRlc1fP7CkQ9cXS6F4gBOL5iuResBfpDDVy60/Z
         OvvA==
X-Gm-Message-State: ALQs6tAZ/0JglVn4wwdBFUu6Qw9bpgG8xhsDSQx3PgvfiQKW0pAR1/Bs
        JYHBYdYdmioUjly/x9Xvvh5x62H/
X-Google-Smtp-Source: AIpwx49Safv2DtdEsZeXSnc7CITlBzoMY33RVpL5KYYN8pFsfXkaoCCGxc6WE18eghwb9tDMk1iv6w==
X-Received: by 10.28.192.7 with SMTP id q7mr18227611wmf.44.1523229527263;
        Sun, 08 Apr 2018 16:18:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z9sm24253748wrz.4.2018.04.08.16.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 16:18:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller\@google.com" <sbeller@google.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 0/4] Lazy-load trees when reading commit-graph
References: <20180403120057.173849-1-dstolee@microsoft.com>
        <20180406190919.167092-1-dstolee@microsoft.com>
        <20180406192146.GC921@sigill.intra.peff.net>
Date:   Mon, 09 Apr 2018 08:18:46 +0900
Message-ID: <xmqqr2np70dl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If I were doing it myself, I probably would have folded patches 1 and 3
> together. They are touching all the same spots, and it would be an error
> for any case converted in patch 1 to not get converted in patch 3. I'm
> assuming you caught them all due to Coccinelle, though IMHO it is
> somewhat overkill here. By folding them together the compiler could tell
> you which spots you missed.

Yeah, that approach would probably be a more sensible way to assure
the safety/correctness of the result to readers better.

>
> And going forward, I doubt it is going to be a common error for people
> to use maybe_tree directly. Between the name and the warning comment,
> you'd have to really try to shoot yourself in the foot with it. The
> primary concern was catching people using the existing "tree" name,
> whose semantics changed.

Yup.
