Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E20C432C3
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D912068F
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="05EwJ4hB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfKWTzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Nov 2019 14:55:03 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:34757 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfKWTzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Nov 2019 14:55:03 -0500
Received: by mail-il1-f180.google.com with SMTP id p6so10589689ilp.1
        for <git@vger.kernel.org>; Sat, 23 Nov 2019 11:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=v5mWB/Suwh/gh6vxm2tlbjV/Fgy4KkiYQrO0wVORn70=;
        b=05EwJ4hBn/rS/9BF3XzcuVeI3nE15DSGVgybkX4LdZVjF4EmeXmCHp/wTfGds1qHvk
         2oUloip7ZzsXM0p1keXpEYZtIdhciGXCWWmyfD4bnKB0TPBHwfEDHoBLPLC7qbblcQJ2
         fyKbnxk4GRmd7p30GLTD17V914sSqZvfoCtBppt//Zml/DfeSwNFA6MG8LBu6qrPSkCg
         vnE5YpBexld2F74syxCQ/VBKGay3ONjLfltAdvlj/vF+Z/EsIh8EAbcgyDZRxO5ce2c5
         6f7eONofqqdB/IvNEDOs7d4aOClMuKM2tgHjkeWwzFAlnQR40LbKIsAkzOkSnMMym9Sg
         7X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v5mWB/Suwh/gh6vxm2tlbjV/Fgy4KkiYQrO0wVORn70=;
        b=LLCn1/h3vH7+rxW3td2LSclqzrwOeom/UljS7FwsI92WQHX1YDMo9387HwZFX5neR5
         6wPN5XDKDnGKhj56nhjfHXqIBE9HklDemxumWSu7kj4qLJOhYb1rNzvweGqILNhAmij9
         Vy0TQCp8qkIim1OeNzJ1lwJCM+KwRjFYy/yjZmqXZ/P1Rg3fLl1ZERjxbTfA+Sj2OMQ3
         kBV9gl9C4r7EiQ5Zg1y21057CvIARw8EcUTBE41lkfcEZyEt1p/m2Ex+VeCWySAA6ORJ
         oDYem7Z5GqMzt71MT9D2hwLdpSJOIqvXn/MqN92d9aUcF2KOakkTC/vnnD+3N0iIDOuF
         SEOw==
X-Gm-Message-State: APjAAAX1l4WQ6DNJqgH5ryfr5RxMhzVXSeklgEmIsQnn4UQjRwoX8Pg7
        5V7IeaDSal4ZxCOGSCUmh85u7FMg1HJZavCnlmGjPx5p0Y0=
X-Google-Smtp-Source: APXvYqywPYd4QlJCk2OMNC6jKBgG2qfHCYKM2viuMlfg7i4KQYJPW7hhCEPlhhN3M+KZ2BP8PuJUJC1hosg3FwY0b/8=
X-Received: by 2002:a92:8ccc:: with SMTP id s73mr24155118ill.86.1574538900956;
 Sat, 23 Nov 2019 11:55:00 -0800 (PST)
MIME-Version: 1.0
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 23 Nov 2019 16:54:49 -0300
Message-ID: <CAHd-oW4gXSEsO7H0f-85vhWheUQ8CtGw5Jh7QP=h_inBpFTJDA@mail.gmail.com>
Subject: Questions on delta base cache fetching
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, everyone

A few questions popped into my head regarding unpacking functions that
fetch from the delta base cache. Their behavior on the cached entries
sometimes seemed a little counterintuitive for me, so I hoped you
could help me better understand.

1. If cache_or_unpack_entry() finds the desired object in cache, it
just retrieves and returns the entry, not updating its position in the
LRU list. Shouldn't it do so (possibly by removing and re-inserting
the entry)? Or maybe shouldn't the retrieval function itself do the
update?

2. While resolving a delta chain, unpack_entry() checks if the base is
in cache and removes it if so. At first, this seemed a little odd to
me, but the entry is re-inserted at phase 3. FWIU, this is done to
update the entry's position in the LRU list, is that right?

However, if the function is called to unpack a base object which is
already in cache, it will just remove the cache entry and don't
re-insert it (as it won't go through phase 3). Calling the
cache_or_unpack_entry() "wrapper", thought, will, in this case, return
the cache entry without removing it (nor calling unpack_entry()). To
avoid removing recently used entries from the cache, shouldn't
external callers, perhaps, always call the wrapper instead of
unpack_entry()?

Thanks,
Matheus
