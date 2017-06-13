Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8701FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbdFMVUU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:20:20 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36682 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753934AbdFMVUT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:20:19 -0400
Received: by mail-it0-f67.google.com with SMTP id 185so12949056itv.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OBoOnBR6EQPV84BIGKdvsV0zchwm78BCOkDXwRL60fo=;
        b=RZoI3RlYCq4gIYsUWn1XNCzjgksSmlyiw1f5g9NPvGY+nkkVWHJ6oaY1Nl8n39gv21
         kIP27VPolUOvGGXTMc9FvSAQjycVeNrnXQuxCugbdrbeeBv5rqzcBTSrQw7/W38L2e6M
         af7AaXxKo9E3UCVlYBdy2rdrlHNrgD1XrvL80Jw2CHc5ZXnd2HPQg5Z1X4rcugOdZv3O
         oScd2/eu20Euo41H5nVmGlkbhR8VY53rmLroz9Q97nIUznN7FLh9NnlGd+qB1Dr0IFGV
         1P5Ru+7JNr/2r9AIxnv9/CkWS2On5yYSm2ABnnxZIAS8RHPyr176lvsXgUV08KBORr1H
         t/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OBoOnBR6EQPV84BIGKdvsV0zchwm78BCOkDXwRL60fo=;
        b=YvviNKoAHWO/9rfH/ACApbHbJwUFx5ZZ6c15sQmKuZ81zmnXBjeLWSQgoneQgicdDx
         PVvGN0u0OA3Z+201vWFejjjrRW0RTkh1nBPEkKs9yS+igoRY14Pm7Efgo3NTKNdSNOQw
         TfhrCNoOTrLmP1TR5bmoJdwlB03puU26DMld6Yhsw2O6GuflCYQl+D8fnMxNBGOwFHoQ
         6mRK6R1zD1qbHdGWT6igZlRlwahCMFhhaqb6siuqdOK9Dgjsbo5WtVz3jUwhynU76BUY
         OmaPn5g/HEcv3uIvnX802pf3E/cLLf5CkDzFzRD/maNmvpBv6ei96peM2Cib9/GyBLty
         NmFw==
X-Gm-Message-State: AODbwcCYgrY5kNMcF6Bcj62p3OQ9/N6Ive84IbOTrMpG42vrlxegnMMv
        DsmBqZiw+XOM6g==
X-Received: by 10.36.51.82 with SMTP id k79mr20380890itk.32.1497388818927;
        Tue, 13 Jun 2017 14:20:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id u63sm2425775ita.16.2017.06.13.14.20.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:20:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Michael Giuffrida <michaelpg@chromium.org>, git@vger.kernel.org
Subject: Re: [BUG] add_again() off-by-one error in custom format
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
        <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
        <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
        <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
        <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
Date:   Tue, 13 Jun 2017 14:20:17 -0700
In-Reply-To: <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 13 Jun 2017 22:29:01 +0200")
Message-ID: <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> The difference is about the same as the one between:
>
> 	$ time git log --format="" >/dev/null
>
> 	real    0m0.463s
> 	user    0m0.448s
> 	sys     0m0.012s
>
> and:
>
> 	$ time git log --format="%h" >/dev/null
>
> 	real    0m1.062s
> 	user    0m0.636s
> 	sys     0m0.416s
>
> With caching duplicates are basically free and without it short
> hashes have to be looked up again.  Other placeholders may reduce
> the relative slowdown, depending on how expensive they are.

I think the real question is how likely people use more than one
occurrence of the same thing in their custom format, and how deeply
they care that --format='%h %h' costs more than --format='%h'.  The
cost won't of course be double (because the main traversal costs
without any output), but it would be rather unreasonable to expect
that --format='%h %h %h %h %h' to cost the same as --format='%h';
after all, Git is doing more for them ;-)

So in that sense, I am actually OK if we decide to remove the caching.

> Forgot a third option, probably because it's not a particularly good
> idea: Replacing the caching in pretty.c with a short static cache in
> find_unique_abbrev_r().

Indeed.
