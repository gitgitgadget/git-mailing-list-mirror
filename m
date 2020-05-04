Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B214C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 07:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E376D21775
	for <git@archiver.kernel.org>; Mon,  4 May 2020 07:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnxQ648N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgEDHpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 03:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725921AbgEDHpX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 03:45:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E6DC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 00:45:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x6so1781425plv.8
        for <git@vger.kernel.org>; Mon, 04 May 2020 00:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=suVJsrQj6spsMC41gPziBU8w2uSUgRulrI0HBge0vUU=;
        b=rnxQ648NQR3286jmWCfW7nXpRz4QA0gbkWKyWm6TpMabqsLEynCTgLclvt7jVE+q/e
         vfYN+YN8MEsi+xqskbRRwCw1hH7xIZdDMHS39h6/yIUTtfSpAyoM1pgZshKYUtM0qjfJ
         x1Wr/TcLQpT9jF0FlxQjOI9Ac6O5XCBH7dJeCaVo35pt/izfX/yczlVcfT5sd6/1cUOy
         M457Hz12fKXeqZZO4rYIHmnalBTItCewEbiVwlJ22qdOtUN3qZH7newQ/1VfF2nWUQAX
         yEAue26DF9VDnAd+vTrd0uyoYn8b8l7B/40Q892e32C0FNaLKi/ZBYO4kr7IgkVPMR3C
         DsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=suVJsrQj6spsMC41gPziBU8w2uSUgRulrI0HBge0vUU=;
        b=ApOlSVkkjERBDpYAOJyG1ACnkWyQpTZ9cgvtCb9YyxuzqsxE168MBNunTmCs1Sfp42
         lCJdbBCKbjIkFKsLLcg9Dg3EQmf3/olRp7e08YLgEXZm3dDTRzPz4PV5hzfL2udL+tyk
         EDW6KK3MJIOO7rYM5AyYO5GwrfyAVLR3hDD6HyOlZu4JCg9UjTxTHeMti7wtw81oZtwe
         RrGC50Xf1PcYHGoAb9ywIDkP3L+ehCF7bIQ4d5nEsZ9y7aWaRZN6GcNp4aYHGumwalWU
         no8HEUUBeKEkjDBxYN2UA328bukhfGhb/0K0lgCEjpELAQK6b5BhmRh0MTpyzvOOyvJ5
         94IA==
X-Gm-Message-State: AGi0PuaXHzMl/7YRGnArzetaFL6ax+SJbfI4D4JN6AXv1FYHeZFvAyBU
        0Qvt8kG16BtjW6PqOA/NLFc=
X-Google-Smtp-Source: APiQypKaH/1yCZM7jvIOzFsHSWyZXdErpGQ0XPioMM6zgxLHDJ93fDQGelZ35qDDMHblKCZ975Wb/A==
X-Received: by 2002:a17:90a:8b:: with SMTP id a11mr15592183pja.163.1588578322914;
        Mon, 04 May 2020 00:45:22 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id m6sm6089362pjo.5.2020.05.04.00.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 00:45:22 -0700 (PDT)
Date:   Mon, 4 May 2020 00:45:20 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [RFC PATCH] credential: minor documentation fixes
Message-ID: <20200504074520.GB86805@Carlos-MBP>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200503065826.GB1829906@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200503065826.GB1829906@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 03, 2020 at 02:58:26AM -0400, Jeff King wrote:
> On Sat, May 02, 2020 at 11:34:23PM -0700, Carlo Marcelo Arenas Belón wrote:
> 
> > the order of parameters used in credential_match was inconsistent
> > between credential.c and credential.h as well, so update both to
> > match the current implementation.
> 
> Yes, looks like this has been wrong since the beginning in 118250728e
> (credential: apply helper config, 2011-12-10). I checked the callers to
> make sure none of them had gotten it backwards, but they all look right
> (and just the declaration is wrong).

thanks for checking, will include this (and your typo fix) in the
submission; should I add your "Reviewed-by" then?

was also curious about the other documentation updates mentioned[1] by
Jonathan, and that I was hoping this patch will be included with.

some things that I think might need clarification (or maybe even code changes
after agreed on) are :

* the meaning of "exactly" for matching protocol and hostname in the URL
  since 06 are both case insensitive per RFC3986 and we have been
  ambiguous on that, leading to some helpers assuming case or encoding.
* the rules for how helper matching are expected to be ordered, specially
  considering the recent adding of wildcard matching and the revival of
  partial matching, and the fact that the order is relevant for both
  discovery of credentials and which helpers are used.
* the use of hostname as a key, since the addition of cert:// that has none
  and uses path instead (had emailed the author privately for clarification,
  but hadn't heard yet) and the effect that has on which fields are expected
  and which values are valid.
* the role of overrides (ex: the documented example of passing URL and later
  updating it seems useful, eventhough I am not aware if being used)
* clarification on which fields can be updated by the helper; currently I
  don't think we allow overrides for protocol and host and assume all others
  but the documentation doesn't clarify, and that might be a problem for
  cert:// where file is more relevant.

Carlo

[1] https://lore.kernel.org/git/20200428055514.GB201501@google.com/
