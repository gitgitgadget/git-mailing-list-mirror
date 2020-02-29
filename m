Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E5C3F2CD
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DB824699
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 15:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhE6/rMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgB2PjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 10:39:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38435 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgB2PjA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 10:39:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id u9so676571wml.3
        for <git@vger.kernel.org>; Sat, 29 Feb 2020 07:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KCvuD5ELgtiWpskH3S/8W/odtOueVUa/r8DAnQJgjcY=;
        b=ZhE6/rMVrldMatABGozaEi8dc1Ly1V6UupsAEG72Y4pFTFtdPjaYRg/Y+M6wVUNDvJ
         GOZwKWxki4wgFlFQiwjqxrQsqNACByIZd9FzSSHB9D9bgWscGu40W6Il7mUyNDDKntHH
         Hzg1wyJuFDsp3cg/J2o028NLYY4mCzL0OOSKDVFjtl/D3rHG6wldxlwfIQFFjBNpaV9O
         FvVU/ysDv5nL10SrZ5MoDxSsX3jOqsOx9qdwfmtk3f1Fb9VITPBXiRLyNN9hMjQgu9S3
         ZkdUcwr/bSQhwfdCYXIMJjkbd1DaHNGa7L+lAwybaPESxb4Uni06Z2ESvLcvEGeb8ZsO
         XWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KCvuD5ELgtiWpskH3S/8W/odtOueVUa/r8DAnQJgjcY=;
        b=EjsIAeMvOtzygBWIitqvKenZbdQsK99HA1FB6h9tmJGWY1clKxoVEBmXE4KTFyLHEG
         BHmzm2ctTADbOaV8W/3bbDsyF/THDcShC0WuEfQn+9gtbu6L90p1nhpSCcFvXEeSHWcd
         fsDe0ayj7D0XdohkqbqIgSTg5XOJx/trWFYOXjD7mNcuCLK6io4CXXZnCyPHIzWim9mK
         NaEg4//AlRHN363M5Ack4TBMFKUOX0PVGnrvDAn8RC/1Cv1iqICMCYAiKjVpdCM2YitT
         qFmIPZhn7UFssZzu/xE9OVoGUCBxsiefmXJXK2b9lw7oubYxSC53TMqqBtcTVHt41jJx
         oGCw==
X-Gm-Message-State: APjAAAU39Vbi4YPlUqPgLi+IhqOiO5Te0JF7gvucjL2mBGxVjnuLx3ZI
        9ffeQPJPxefzolsv/dCWNWA=
X-Google-Smtp-Source: APXvYqy6REjsYdW5sjgKend50Q6pDOA8cWneHi1w5d2ej/HY2v+wJ+ZNXZN+BqNdoS73tDxMscYoaw==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr10281121wmi.21.1582990739014;
        Sat, 29 Feb 2020 07:38:59 -0800 (PST)
Received: from doriath (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id j5sm18008717wrw.24.2020.02.29.07.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 07:38:58 -0800 (PST)
Date:   Sat, 29 Feb 2020 16:38:55 +0100
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH 1/1] midx.c: fix an integer overflow
Message-ID: <20200229153855.o2s2lv4qiltej4ej@doriath>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Sat, 29 Feb 2020 15:31:57 +0100
References: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
 <20200228185525.GB1408759@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200228185525.GB1408759@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Jeff King, Fri 28 Feb 2020 at 13:55:25 (-0500) :
> Makes sense. Such a midx shouldn't be generated in the first place, but
> we should handle it robustly if we do see one.

This midx was actually written by `git multi-pack-index write`, when there
is no pack files in the store.

>   for (i = 1; i < m->num_objects; i++) {
>           ...
> 	  nth_midxed_object_oid(&oid1, m, i - 1);
> 	  nth_midxed_object_oid(&oid2, m, i);
> 	  ...
>   }

We could, but this mean that we have to shift all values of i by one in the
body. My patch has a smaller diff :)

> Though I almost wonder if we should be catching "m->num_objects == 0"
> early and declaring the midx to be bogus

This is probably the best solution. Should I also catch m->num_objects == 1?
Having a midx with only one pack does not make much sense either.

> (it's not _technically_ wrong, but I'd have to suspect a bug in anything
> that generated a 0-object midx file).

So mid.c:926 calls write_midx_header unconditionally. 
	written = write_midx_header(f, num_chunks, packs.nr - dropped_packs);
Maybe we could check that packs.nr - dropped_packds is > 0 first.

So I can reroll.
- I'll add a warning to verify if there is no pack in the midx. What about
  when there is one pack?
- Should I update write_midx_internal to not write anything if there is no
  pack?  What about if there is only one pack?
- Should I add tests?

-- 
Damien
