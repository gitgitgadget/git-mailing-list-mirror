Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E261C433F5
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 12:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbiBTMrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 07:47:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiBTMre (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 07:47:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDFDA183
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 04:47:13 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w3so23917550edu.8
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 04:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HjX5EGIkyGKCZR22zvIJkGy9RzLnB8iwELuULeI98Xk=;
        b=bzv0qgyYMnYQsXg/JJQ8Dtf0S4M5sloMKpxN82RVurdnmHzZ23FnRTHL1qva8WPv26
         g3Mq2YmlgtULAnBUo64z5HfzUzvQsuPSykbtIqZLTWbdVwyZcdIBYsjIh5yt3/90vOh9
         n4z8URtyKLJYOYKeZZAU6yVkdJnMlxi61Wew0HPTi5irQYNJrjjqiGXBHgqkbBn0OToX
         OfdBoFB3YkdhawrKpMMVMqglK9c1OKkFMxivT+QXtp2nafcAaCrGTtEgLlvDajvGne7A
         rVqesHLuk5Jm4aXZ5DeHCB2magkOrt8FUggkLTij1330awI5/YwcrfUKfjShxl+nsgTh
         OvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HjX5EGIkyGKCZR22zvIJkGy9RzLnB8iwELuULeI98Xk=;
        b=x4+yYepNKD8ZtJtt8O5SnLqug2JR3lJ1tNbZhcc8tInWq7q3NcU9UgwxCc6tByYa/w
         5UgSPUe/N0lhTtQeA0L/BVPoGvSBELnG2b7/05oJMD0EKfmStW8b1t+uiLLGyUYjyjDM
         40bRESB9hJNhnAQQY4gy5RpqtmPqB57L2hfyVTxaZJE/+C15xF9C+aTL9PNLBcjt9w3U
         G3O+JDnQI3dR+wCoAU2pAVFAymcb0Lw/5no+tEbXX4PJ5MeUoUqxmQqW5t7Pss+0aAWo
         QQ7d2vhH8WxeiaxseMWZ7CSOWPY1IF4sqDENTO4berdbpGzaLPMWj08srDA+rvEIIkz6
         C9VA==
X-Gm-Message-State: AOAM530AYVTV7lsfyI+I4MclcYzshH+PIyve6y/HLWKtdHjyirmQYqJM
        fW+OdP38703eWdtrbRvc3Js=
X-Google-Smtp-Source: ABdhPJyHEJH4B+34L3O1y9qvrqNUe2SO44MNqRHdJtiJPAfTlPfdNSNwjfaRmlaxQT+rtNm2Lc2mVA==
X-Received: by 2002:a50:f1d1:0:b0:410:84c6:b861 with SMTP id y17-20020a50f1d1000000b0041084c6b861mr16554950edl.132.1645361231800;
        Sun, 20 Feb 2022 04:47:11 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i27sm4112397ejo.214.2022.02.20.04.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 04:47:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nLlcH-005MDu-Cd;
        Sun, 20 Feb 2022 13:47:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH v3 3/3] trace.h: remove never-used TRACE_CONTEXT
Date:   Sun, 20 Feb 2022 13:38:43 +0100
References: <cover-v2-0.2-00000000000-20220128T110330Z-avarab@gmail.com>
 <cover-v3-0.3-00000000000-20220219T103752Z-avarab@gmail.com>
 <patch-v3-3.3-27ea260bbea-20220219T103752Z-avarab@gmail.com>
 <xmqq5yp9wxt1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq5yp9wxt1.fsf@gitster.g>
Message-ID: <220220.86fsodd7sm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 20 2022, Junio C Hamano wrote:

[I forgot to CC Karsten Blees]

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> The definition of "TRACE_CONTEXT" as "__FILE__" added in
>> e05bed960d3 (trace: add 'file:line' to all trace output, 2014-07-12)
>> appeared between v6[1] and v7[2] of the series that added it.
>>
>> It does not appear to have been something anybody asked for, and
>> doesn't seem to have been used by anyone since then to override it to
>> something other than the default __FILE__.
>
> Sorry, but I do not quite follow.  How can we claim nobody used it,
> given that it should be usable with CFLAGS=3D-DTRACE_CONTEXT=3DANYTHING?
>
> On the other hand, I do not see how it is hurting anybody to have
> this indirection today.
>
> Or am I missing something obvious?

I don't know that, but:

 * From the list discussion at the time it seems nobody asked for this,
   it was just something the author "snuck in" between re-rolls.

 * I didn't find any subsequent on-list discussion of people actually
   using this.

Both leads me to believe that this was a neat-at-the-time but never used
for anything outside one-off testing feature.

Perhaps you'd like a v4 without this. It isn't strictly needed, but
where I'm going with this series is improving the usage.c output/passing
of these __{FILE,LINE,FUNCTION}__.

I don't need it now, but if we'd eventually like to unify trace & trace2
we'll need to deal with this part, since those functions won't deal well
with replacing a __FILE__ "just pass whatever data you'd like here".

