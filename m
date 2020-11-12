Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEBDC2D0A3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E628A21D40
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbnHx1bv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgKLOFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgKLOFr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 09:05:47 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527EAC0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:05:47 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q3so6281862edr.12
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=mPaynHgnkFeHUuepb5NOO4qSZYiM1UEY4QgnLSEWGAI=;
        b=pbnHx1bvdG90TiWRshgY+IN2/0Ywi4oELSP3VAkOi8rXZFRTWWuxG4r9BOtjR7AuBM
         Xo67WF8iF4fWuZeiD/2VOku3rYmnhTaGKW/MBAZqK1x64u8i3MSwBRsD6usNUzYWG0FK
         HcT2nL76Uhj+y2ZJ+rORNfwc0JROLtaFoBjXoKZnH0XhQItaqz2Ao6OoObLGX5rscdrG
         X+uUgbb84FwUeGVFw1NOMeUFL9R+FxnLZj4NVTiStT9pSEqmoUK+9AuxOP5kid+1woNZ
         q7b+0o/bmEXe2TDFMyfb7WAIpZSI4/Xwu+q6RgDBcoZaZg0rFJuAErcg4KV1VAsoYd+b
         /dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=mPaynHgnkFeHUuepb5NOO4qSZYiM1UEY4QgnLSEWGAI=;
        b=qcsmxbWLFW4r0FZ1qTEZF2Ba7yACJeg6cn+uM1DbPnSElnuKKyU67AHiq0s8A2f2h1
         DFS4HyLj8E6nq75CxdZijyFWZ/21ckfGmn/YY2FOxvQn39Zp3NgCF4XyjupDv9LLcN0W
         dq8K291hMNv2yslK31URfI4XPNOpgAU47eU2LtuemT2ISArex8Hn5+Rn/gmSBr8BIEL5
         CsXrNM+sqETJXqpBOsnK88K2Fzwz5d1Aok2K76ljEgr5zB8y46C8wjp2baTNJxQ00U2A
         /hi3n75vmeJSneERCvC5tcUEau33rML5Pyc78xO6LFkUyouu9xqBWoCxXszrypmroZ50
         elRw==
X-Gm-Message-State: AOAM531yoiJVSSYayQJeOMk4XxVwSQvHXvbdz7TKZ1SijYYyWnfYVPXb
        ACy797ER9FLWowrQ2FNlHUQ=
X-Google-Smtp-Source: ABdhPJyYf9xYZs9LhOqygXrvNogEYeivSPuwqdIVAA1q4kywGa4KmafyvOlHgDO0ZJXvShU7nDWdnw==
X-Received: by 2002:a50:9319:: with SMTP id m25mr5283848eda.297.1605189945971;
        Thu, 12 Nov 2020 06:05:45 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id p1sm2414871edx.4.2020.11.12.06.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 06:05:45 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 01/11] docs: new capability to advertise trace2 SIDs
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com> <d04028c3c7574e3ca0f9c1b3d711192ca756158d.1604355792.git.steadmon@google.com> <xmqq5z6mqg60.fsf@gitster.c.googlers.com> <634cf106-7bc2-e8fa-5745-5e2d26b50e14@jeffhostetler.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <634cf106-7bc2-e8fa-5745-5e2d26b50e14@jeffhostetler.com>
Date:   Thu, 12 Nov 2020 15:05:44 +0100
Message-ID: <87d00ihdqf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 05 2020, Jeff Hostetler wrote:

> However, the opportunity to introduce a prefix as I suggested earlier
> does offer the opportunity to introduce funky chars that would not
> have any protection, so you may want to c-quote the string when
> inserting it into the wire protocol.
>
>     $ GIT_TRACE2_EVENT=1 GIT_TRACE2_PARENT_SID=hello git version
>     {"event":"version","sid":"hello/20201030T154143.660608Z-H86606a97- 
> P00001d30",...}
>     ...
>
> (Allowing the user to insert a prefix like that has been useful for
> tracking control/experiment testing, so I wouldn't want to disable
> it.)

AFAICT the way it's documented now is the "is the session-id[...]"
paragraph in api-trace2.txt.

I'd like to see us document the implementation a bit better and
explicitly support the "hack" of setting GIT_TRACE2_PARENT_SID=hello.

I.e. maybe I've missed something but we just say "session-id is
prepended with the session-id of the parent" but don't mention that we
separate them with slashes, so you can split on that to get the depth &
individual ID's.

My reading of the updated doc patch in v3 is that not allowing
"non-printable or whitespace" allows you to e.g. have slashes in those
custom session IDs, which would be quite inconvenient since it would
break that property.

And we should explicitly support the GIT_TRACE2_PARENT_SID=* setting
from an external process, and make the SID definition loose enough to
allow for SIDs that don't look like Git's in that chain. I.e. a useful
property (and one I've seen in the wild) is to have some external
programt that already has SIDs/UUID run IDs spawn git, setting
GIT_TRACE2_PARENT_SID=<that program's SID> makes things convenient for
the purposes of logging.n
