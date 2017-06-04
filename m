Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D80209FD
	for <e@80x24.org>; Sun,  4 Jun 2017 00:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdFDAAb (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 20:00:31 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33604 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFDAAa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 20:00:30 -0400
Received: by mail-pg0-f53.google.com with SMTP id f185so6182732pgc.0
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 17:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uOHWt8P30KO0wV7boICOL0B0eo9DJOVCy1ruHDxhh2Q=;
        b=Cs7e/eF3ESztauGdsB5+10hNMbOiKH4KuDUynNif3/k2DygyaLExJOb8ydUZdAfpal
         SbGdSVl2sIjvzPXZ2s2yCS8k1JPHICXZqTnOoOl0b1m7tjnmWCzocbwWAtJJ+q3H3CHf
         lhugZBK1NuQQ7d69ZilRclk4Jane33Tl50j5xz1vET3FlwcNFj08niwM4QnlpXnp4UAz
         DS8kMUXC7rUE2IPnePDAV4bSjDB7Z8m3YzZ/2LAM3KxT3g/xU9deBqt/0J4n8GPL4G+l
         6R5y5DEWZ3HSPaB7Irdkw//Yxbf8IT4vO8IatSMAUiaf2RMXnOtqHWMBUDqbEVU3o34V
         j52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uOHWt8P30KO0wV7boICOL0B0eo9DJOVCy1ruHDxhh2Q=;
        b=jH4UeCmwB6yc8hBC4qW/Gjlt/62zMjMIahwDxNl4du4S5vxKUPDudZvUHV6DgfhBs/
         nksebmnHv8VLiKk2vfej+JbcguPa1PJOJi5XokhqWeL9E2NvzdNvVzIeQkMPd628Ze75
         iYh4p8Ia9Cqb2BxzU+iNWzkxO7sEWWcHSeOAMqfOdB9qDRO/1BF/DKefmeg/GH5VXDsg
         gVxHCM/JKUskvY3r35HGhOxe2lPK80yLA7rL6Wy/pBbUvYJfs5oXtP+7+NaJrOdxD2Bh
         VD9qvBiiVy24NCsa0LJTsyBsiaOmppwNYNCOum6HhEicK6Q8twWuzE+YYRg+APYL6tK5
         BVEg==
X-Gm-Message-State: AODbwcDvJ4rErS/SjjDgo8PIepcdEGiiBVgfDExTYCWUZKL9TK0lIFgY
        FA+0ntka7jXLng==
X-Received: by 10.84.133.65 with SMTP id 59mr7336498plf.230.1496534429972;
        Sat, 03 Jun 2017 17:00:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:e94b:f1cf:5772:ec43])
        by smtp.gmail.com with ESMTPSA id k86sm46997235pfk.125.2017.06.03.17.00.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 03 Jun 2017 17:00:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
References: <20170602103330.25663-1-avarab@gmail.com>
        <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
        <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com>
        <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
Date:   Sun, 04 Jun 2017 09:00:28 +0900
In-Reply-To: <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 3 Jun
 2017 18:24:14
        +0200")
Message-ID: <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> My feeling exactly.  Diagnosing and failing upfront saying "well you
>> made a copy but it is not suitable for testing" sounds more sensible
>> at lesat to me.
>
> This change makes the repo suitable for testing when it wasn't before.

Perhaps "not suitable" was a bit too vague.

The copy you made is not in a consistent state that is good for
testing.  This change may declare that it is now in a consistent
state, but removal of a single *.lock file does not make it so.  We
do not know what other transient inconsistency the resulting copy
has; it is inherent to git-unaware copy---that is why we discouraged
and removed rsync transport after all.

> Yes, there are cases where there are other issues than index.lock
> preventing testing the repo, but I don't see why there shouldn't be a
> partial solution that solves a very common case in lieu of a perfect
> solution.

As long as the partial solution makes sure that the case it
addressed was the only breakage, I'd be happy to see that it leaves
other kinds of inconsistencies "too rare to bother fixing".  I however
feel dirty if the punting is "we won't even bother diagnosing and
assume that *.lock is the only thing we care about".

Perhaps run "fsck" and "status" immediately after copying to make
sure they succeed, or something like that?
