Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505A8C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2664160F9B
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351653AbhI3OGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351731AbhI3OGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:06:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA33C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:04:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dj4so23233657edb.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=HLgRG72VdjoUVCwzEnkB+bL0zey094ykLahB+nw2qkk=;
        b=qJZpXXgmFxKozgPyRaeCK3aFu7Hm0de3eF8K7Wmrf/UCrm4xeAaoef+npOja2Jj48d
         jY8rY7bCi+mfI3yZiooePoFloIe3QlG7Om7IU3fhjOnhhIJNn02nvR/FJN1He5ZGeK5E
         ov/MmDw/0TrEbBlLQRN10AnSs6zxfUFGHBAVVRqqry+YeSXynivSn9czp4Lt5X8rTxLs
         VKlT+9wvCEkjjcRQcUNtggp/Taeir2BAoSp+40yXsAUEZq0UAEKv/XUvnun/eX5M6phR
         HTTXHPFEZG6ucGLlOijR0MUpj44t9UpAB4uwXjuITFACHgVjoEtpzjixWXpei1PCycKD
         E7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=HLgRG72VdjoUVCwzEnkB+bL0zey094ykLahB+nw2qkk=;
        b=H4uyMtCTLFOedjYm2sft+TGo/PTyxbJi8/WzDwOhAIXGdDSDa77QLUutMuJCDsyA8S
         dvhOzglZ9qNy2EAl2PzlRZoXGQN9kh5WKJu6Y6ue8t33xvrMbmpzeS9odjaLVLQBmpOI
         s17CJ/ExwcBNiJIShxVxtmBupcYwkrK7uVVs/yUuf0LRlq93sSmj9hh8DfivODgPEDPG
         btnYlWuDFdoe3akovMtf1hNCDBaYZr/zo3kqNK0PoHuCkJwId6FjurZhu7eNMaHXYIPw
         ESmK1ZHSkoTwBlfjHwpgBGQLz27sMWSLeE0iYe7478InBWwxE4KHhD63dLLOVGXIWC8j
         5nEA==
X-Gm-Message-State: AOAM530pyAIbseCYcSO3toD3odNc8h0ssnaWb38pelFKR8qBDs11Xvrg
        7ZCveXnM93hT5pE3m/Em22UnKkSNzy4O7BaE
X-Google-Smtp-Source: ABdhPJxB/ikY/dMLcfjnw/S5W584fMg5s5FrVJZ2+69ytoq08FWPmQPeiukQQNIElHc8xyLgpiB1Bw==
X-Received: by 2002:aa7:d850:: with SMTP id f16mr7243730eds.127.1633010608076;
        Thu, 30 Sep 2021 07:03:28 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id pj17sm1420416ejb.66.2021.09.30.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:03:27 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: not receive pack file with large object
Date:   Thu, 30 Sep 2021 15:42:29 +0200
References: <20210930121058.5771-1-chiyutianyi@gmail.com>
 <20210930132004.16075-1-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210930132004.16075-1-chiyutianyi@gmail.com>
Message-ID: <87pmsqtb2p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> In addition to using 'receive.maxInputSize' to limit the overall size
> of the received packfile, a new config variable
> 'receive.maxInputObjectSize' is added to limit the push of a single
> object larger than this threshold.

Maybe an unfair knee-jerk reaction: I think we should really be pushing
this sort of thing into pre-receive hooks and/or the proc-receive hook,
i.e. see 15d3af5e22e (receive-pack: add new proc-receive hook,
2020-08-27).

The latter pre-dates c08db5a2d0d (receive-pack: allow a maximum input
size to be specified, 2016-08-24), which may or may not be relevant
here.

Anyway, I think there may be dragons here that you haven't
considered. Is the "size" here the absolute size on disk, or the delta
size (I'm offhand not familiar enough with unpack-objects.c to
know). Does this have the same semantics no matter the
transfer.unpackLimit?

Either way, if it's the absolute size you may have a 100MB object that's
a fantastic delta candidate, so it may only add a few bytes to your
repo, or it's /dev/urandom output and really is adding 100MB.

If we're relying on deltas there's no guarantee that what the client is
sending is delta-ing against something we can delta against, although
admittedly this is also an issue with receive.maxInputSize.

Anyway, all of this is stuff that people "in the wild" don't consider
already, so maybe I'm being too much of a curmudgeon here :)

At an ex-job I re-wrote some "big push" blocking hook that had had N
iterations of other implementations getting it subtly wrong. I.e. if you
define "size" the wrong way you end up blocking things like the revert
that reverts "master" to yesterday's commit.

That's somehing that takes git almost no size at all to store, but which
depending on the stupidity of the hook that's on the other end may be
blocked as a "big push".

So I think if we're going to expand on the existing
"receive.maxInputSize" we should really be considering the edge cases
carefully.

But even then I'm somewhat skeptical of the benefit of doing this in
git's own guts v.s. a hook, or expanding the hook infrastructure to
accommodate it, we have "receive.maxInputSize", now maybe
"receive.maxInputObjectSize", then after that perhaps
"receive.maxInputBinaryObjectSize",
"receive.maxInputObjectSizeGlob=*.mp3" etc.

I'm not saying our hook infrastructure is good enough for this right
now, but surely anything that would be wanted as a check in this area
could be done by something that "git cat-file --batch"-style feeds OIDs
to a new hook over stdin from "index-pack" and "unpack-objects"? With
that hook aware of the temporary staged objects in the incoming-* area
of the store?. I.e. if the performance aspect of not waiting until
"pre-receive" time is a concern...
