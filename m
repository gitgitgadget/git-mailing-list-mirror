Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA36C433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241886AbhLXRmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhLXRmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:42:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4359BC061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:42:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z29so35621733edl.7
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DXrmqq7yf0JjMv5AWL1WBvCr21OQVJKrcppHRC3qlp4=;
        b=AUgvD00xWTABO4o1pfUp0IjvxmPU/OiuTAqnezKM9M9n7gbCoYmpkuXcT7Wr3ZT6yU
         Krw58GOgFCupIZfzTMM22AImCL2ZhRWfJAJBSP+y8qoHaybz/5XUBmFwEj6hNotz6BzD
         Wh/fNiUiMFFBA/P/uB8lCdAuRahOE6cZgjmbDNTtp74dLi6Dlqeg0VSlzt+Vu9pHClkB
         ZGSE+uRN6m9mdqyilnK7EmUPDMePwAMn3cBw5bYsAEAhVLLW5ALqDOcapqcSeXhrjgXM
         bp4UTkKYDeSmzRWUu8xIljQfqbDzbeHwA/UDUMmbG96W1j1IEn8aWblvfvsmMdPED3ux
         tdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DXrmqq7yf0JjMv5AWL1WBvCr21OQVJKrcppHRC3qlp4=;
        b=6qEGQxtI+drVFFf2VEqurfTab0MpKD1EoWbie9nYL3wSrB1oX00LmxK/6rgsTjP+nc
         +scLb0nvizdvb+AN6+cBsq+Iq3xCjBScJlX3UqVjnUB3D/zirRoPgK6ESKPJA3xkg5Ys
         QDzX0Er2UkzRg+mQvYtdEA7nKlE6/6NHf/JyWL4pjxv9a6Q3IV/6dOdOWlt4OZFYkcxO
         FG11TqdGS+co8CExrWyy6f8QyMN+HYSPgy4yO3BZIIxpmixiEwfgVPJqcIJUJpR/hSxv
         g4bPhc7IEdnWBURDcoXrSpoCLZdZRzXsCBf3cr+wWgzmBYPOov/DQt0aqdr6mVgvtvGf
         /BJg==
X-Gm-Message-State: AOAM531EWAoAnOvB9yr+qHapfqfqILsF/ALJDFaY8hF4Po7QqnE3KElH
        zl5+a3rHgnkNEZq4xkldzTs=
X-Google-Smtp-Source: ABdhPJy1Q691ntui9aq/b2g+2cq6Bgwb1R3yYlW5W/zwmno0kCUbMXkR23wZ83FyOcU9Ua1c7g6oQw==
X-Received: by 2002:a17:907:a42c:: with SMTP id sg44mr5888518ejc.513.1640367731755;
        Fri, 24 Dec 2021 09:42:11 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id u21sm3279976eds.8.2021.12.24.09.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:42:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n0oa2-0003nW-Fn;
        Fri, 24 Dec 2021 18:42:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 8/8] Makefiles: add and use wildcard "mkdir -p" template
Date:   Fri, 24 Dec 2021 18:41:30 +0100
References: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
 <patch-8.8-aca560ca410-20211217T012902Z-avarab@gmail.com>
 <CAPig+cQt47U9E8kUFiTBecEPcTaLhRCi5X_T=nPqZM-HJR=n0g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CAPig+cQt47U9E8kUFiTBecEPcTaLhRCi5X_T=nPqZM-HJR=n0g@mail.gmail.com>
Message-ID: <211224.867dbthpcd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 17 2021, Eric Sunshine wrote:

> On Thu, Dec 16, 2021 at 11:40 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> [...]
>> But as it turns out we can use this neat trick of only doing a "mkdir
>> -p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
>> of a performance test similar to thatnoted downthread of [1] in [2]
>> shows that this is faster, in addition to being less verbose and more
>> reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):
>
> s/thatnoted/that noted/
>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>> diff --git a/shared.mak b/shared.mak
>> @@ -90,3 +92,18 @@ ifndef V
>> +## Is racy, but in a good way; we might redundantly (and safely)
>> +## "mkdir -p" when running in parallel, but won't need to exhaustively
>> +## individual rules for "a" -> "prefix" -> "dir" -> "file" if given a
>> +## "a/prefix/dir/file". This can instead be inserted at the start of
>> +## the "a/prefix/dir/file" rule.
>
> Is there a word missing between "exhaustively" and "individual"?

Thanks. I addressed both of these in the v2, for which I accidentally
broke the threading by omitting In-Reply-To (sorry!):
https://lore.kernel.org/git/cover-v2-0.8-00000000000-20211224T173558Z-avara=
b@gmail.com/
