Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C191C433FE
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B78060F6E
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhJKEte (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 00:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJKEtd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 00:49:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C11C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 21:47:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g10so61896083edj.1
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 21:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d3Ce6e9oaFMUrNxHsLWuScchVIR8O7qhgxQ6kvcyAiw=;
        b=eLq9udYNFA37HhsunvX4vNjDn680k7rE/EzKjt+iJXMuSIVp2CJ3xKX7kjtQyYQJhj
         +ijUIkj6heorqf9v66jXN/UvtYH/7K1TCzGE9OF8dO7AaWJECWApK/7ExOfWqZ+B5ndh
         H/HcBfa7x0wpGQLN68nuvE2jLOYfYz/yG/2BEZ7mzypS80TCug7CN+Hqv6U+Lk2+vGqA
         zC6Qx43bNZQfv/RlIXQccTChS6E3eROx8v2Qm0MPZG8TC4JO9ngBa7374tNYZ5QwO7tC
         lLTHj2eDTz7nAKE8PumvjWWgVBTjFobPfclQcxVlQ7aAPNMoMTaY0NUMB6sBbJVhczHC
         UI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d3Ce6e9oaFMUrNxHsLWuScchVIR8O7qhgxQ6kvcyAiw=;
        b=qa22T5L1UyPdbaRNZKjge49PC9lha3D7ajevbn+kFfsx4e5YH1lKpLyCIGeVSyeQYo
         FYIgdtjtL5a9xkWwcGs8plsDP9Uh/nwZ5OE9lzFDzeRtnctqAJKVoLVJ3kIn5kP59Blw
         q+DUjJisOKfiq2EzOHs5JV8imQy7L4y6MYNKDtgBsRU4iY7Z3juPInZTtFX0uWLJEp3g
         JKRFym//GSlONFVnqk4aeJfsvuV6x10HbLPGoSEiGyLUv08MwLzlnBzScUPKbNLURTKR
         zCK2za8IOnDi5/SRmpXbYoxBmlZ8weCryO+J4TDTmATRZLzaEIuAtfBT/i5Rfz5319bH
         EYkA==
X-Gm-Message-State: AOAM533KowW2SteEdCA11/1hzGqOb1hjManRUqNmSn4MjK0+m1k5ospl
        ujwHwf5mBbsChsKQ5CcXk6k=
X-Google-Smtp-Source: ABdhPJzl/8+hYMqwN0q8sDDuPw4++LiR46Sm33B5Kzi+dgTMRsBfEP1pv/KvKDPUeYsa9GIpJoIxZQ==
X-Received: by 2002:a50:fc8e:: with SMTP id f14mr38614649edq.87.1633927652894;
        Sun, 10 Oct 2021 21:47:32 -0700 (PDT)
Received: from szeder.dev (94-21-58-27.pool.digikabel.hu. [94.21.58.27])
        by smtp.gmail.com with ESMTPSA id jv12sm2809662ejc.83.2021.10.10.21.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 21:47:32 -0700 (PDT)
Date:   Mon, 11 Oct 2021 06:47:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] http: check CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting
 errors
Message-ID: <20211011044730.GF571180@szeder.dev>
References: <patch-1.1-6e65734cbce-20210924T100532Z-avarab@gmail.com>
 <20211010214209.GE571180@szeder.dev>
 <87o87wl485.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o87wl485.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 03:49:39AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Oct 10 2021, SZEDER Gábor wrote:
> 
> > On Fri, Sep 24, 2021 at 12:08:20PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> Change the error shown when a http.pinnedPubKey doesn't match to point
> >> the http.pinnedPubKey variable 
> >
> > I'm not sure what this means.  Between the repeated
> > 'http.pinnedPubKey' config variable name and the "doesn't match to
> > point the ..." part I can't decipher it.
> 
> It should be "point to the" (but this grammar error is already in
> "next").

So it's supposed to be

  ... a http.pinnedPubKey doesn't point to the http.pinnedPubKey
  variable ...

?  I still have no idea because of the repeated config variable name.


