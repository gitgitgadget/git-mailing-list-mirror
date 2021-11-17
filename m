Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF7C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA6361B5E
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhKQKEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbhKQKE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:04:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C5AC061764
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:01:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x15so8590211edv.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=hh8aCZaLKQ0ivHAXRaYwYIEO5Y41Fcj9qrHf6IngJW8=;
        b=Ldf9b5FI44J9q2u6q7XqDohgOv0t8rGB37xLJFs/YNDqNxt3v/r/0IgEm+JKEK0hDk
         jAOHaUmOSPi5Y45cGYkR8UgLcKjPDLw+zHvdzaTTOk6e3H7XBx9T7cdW5u4Y6qYGIKzG
         fJrZCj9ooKN12eKsay2SuCaE2fRQHp+d1zL1tXl3bOhvDRd1HK9oHYaupvGdUaQtWvCj
         YmJb3yAiKsZ7e/m7jjM65WxjUj+R6vhQHusx2v9Fw6uWC6qtUN/hTyIhWo6NseeoyraV
         R+Ta0FPRKRkwLWDFbw565oJDKzilqKN49d85CabgwJsCdeMiFbkwqivNEw92tAhdu+ps
         VTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=hh8aCZaLKQ0ivHAXRaYwYIEO5Y41Fcj9qrHf6IngJW8=;
        b=MvoZGyGpgmpDCQDrKRUfQdfdddP0D0bReNClCg9cnWEPMH+VdbQqAlWHoKphPesdap
         Hh7N1w1FnTH0uWHmHDSjVeo3SBchV/7Qz7yrKWJu8F+h6wcAeKDfQVYRh0ckDG+/Ra93
         X2XIKrzQzFgi+exiG6rHU0s7AotrHC1bW03k94SOoxAuAMRlgyVHYDK8hmXcDfiZEpUZ
         hZtuatwpkbpNGbhWq609cpkxUTQAAActtJdEfZ8n/oejAc/WfrINXVwM/HbWvd/rhXqm
         hLCmJAf3bNCTE6ia13e/Rp7syfajb3Tn29AktApI1bVrevKy5K3p7I+5aE1W+ZsFgtPB
         gaWQ==
X-Gm-Message-State: AOAM532SdUiE9H9fs+f8OMMNBjML4jBiYNy9BOFX79c4XfbAy0LdA5wF
        ZkFgJTMXmyqIoJz1xNEwLaU=
X-Google-Smtp-Source: ABdhPJwE8S4OZqZDNbHll1WZxyqLp7APY5rL60x4NVfyuLpuYUbxdeCdpNL2OVtydZlBQHFC3VnjJg==
X-Received: by 2002:aa7:c406:: with SMTP id j6mr20269860edq.76.1637143288749;
        Wed, 17 Nov 2021 02:01:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f7sm10737354edl.33.2021.11.17.02.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:01:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnHkt-0005Ur-FA;
        Wed, 17 Nov 2021 11:01:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 21/23] Makefile: disable GNU make built-in wildcard
 rules
Date:   Wed, 17 Nov 2021 10:47:43 +0100
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-21.23-cb3ae5ce00b-20211116T114334Z-avarab@gmail.com>
 <20211117030030.nru2ntuxk63lhwqx@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211117030030.nru2ntuxk63lhwqx@glandium.org>
Message-ID: <211117.86sfvv6qyw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Mike Hommey wrote:

> On Tue, Nov 16, 2021 at 01:00:21PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> +### Remove GNU make implicit rules
>> +
>> +## This speeds things up since we don't need to look for and stat() a
>> +## "foo.c,v" every time a rule referring to "foo.c" is in play. See
>> +## "make -p -f/dev/null | grep ^%::'".
>> +%:: %,v
>> +%:: RCS/%,v
>> +%:: RCS/%
>> +%:: s.%
>> +%:: SCCS/s.%
>
> `MAKEFLAGS +=3D -r` should have the same effect (and more)

Yeah, I did try that. It's a much bigger hammer though, and throws out
all implicit rules, some of which we may use (I'm not sure). I've
updated the commit message to note this.

In terms of performance it doesn't seem to matter over the above more
narrow change.
