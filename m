Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7027DC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiFFRto (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiFFRtm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:49:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C8053B72
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:49:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so30397446ejq.6
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=mL1VDW6EqbIkjoSzi11wEk9aAj1+isdnb2YiXJfSbug=;
        b=ONqnlqALfMFH6yuALMdSnBKtKBR8+MhFhNdobpZktVflUumc3dU5qRA5BqQ9s4JEdi
         S60zf9a9T5HsDfBzArOPbzrW7VlT3FmhOG9BZdrWxmGfwrxRWEf7fdo/LDHw1GKWlh9p
         9jYh/vJis6E36v3hjponEklpzE2paRDtr0lgKuOzhnhtU1bQsJRMMskbZ9sDBr7OLoVB
         wqEatxx5TDnudfiOfdC0YSod8h/ppG/RmXvSKxTwuxEjPVjz6/S++NQTKlM+1j3Ibu3F
         0Aw4h6Hnawhz+QuufKO1LGeRLoic8o/0Qf6Hp8VFNQ3g17Pi1PPwvOLS9Br1WmAx1U2t
         K/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=mL1VDW6EqbIkjoSzi11wEk9aAj1+isdnb2YiXJfSbug=;
        b=o4LInxAUP5QTD0i3bRsgupUSKJwYz3FpKwwdNmlcqbIg2thGUbcFcrmu7AgqL79u0v
         1p5ZUIO9y0nhsoDWHe4WpXhpeDzzzTDfkVfTAZv1DBLcSiHP+s4HRXqJO7hHmnP3cmwU
         x87M6pKDqV72huRWfLDEbQeQduhFCPg62bt2cJ8/cHRzAU/sRYSTh50xnlAEKFY0kJdw
         EGiMeP7IeAVODwG94DBBJhKfvVX3nm9EI0nlVqk/tY3TIye9+pg6+JPpfGN9UlfApYzj
         eZIzvtnIbKVhYjb9OfHHZTDqdnInjv/4Yw38aJlHHqLDdcoZdW9fVbUNqiX7DTy9yeQG
         Ie9Q==
X-Gm-Message-State: AOAM533cVaRybthXBGlc/lDqIIAHi0aEuQeISPmsg1nGH8rD1KE2SUW5
        4aU0fO48EtVnZKyAwQmH9cgKxqntldg=
X-Google-Smtp-Source: ABdhPJzRTDvdnOaA9B451wlgHqQa+FfiNWaVrWCGD/RBBI98Pv/qFwXCB1CEC7IvT5C43JGxYv0zfA==
X-Received: by 2002:a17:906:99c5:b0:6ff:4c8f:6376 with SMTP id s5-20020a17090699c500b006ff4c8f6376mr22858376ejn.328.1654537779706;
        Mon, 06 Jun 2022 10:49:39 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e18-20020a1709062d5200b006f3ef214da6sm6634286eji.12.2022.06.06.10.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 10:49:38 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyGrA-002Ift-Vh;
        Mon, 06 Jun 2022 19:49:36 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 03/15] reftable: don't memset() a NULL from failed
 malloc()
Date:   Mon, 06 Jun 2022 19:46:44 +0200
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
        <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
        <693ed3c3-535e-9eae-9fd7-ca612ebf6943@web.de>
        <220604.86pmjpw8h0.gmgdl@evledraar.gmail.com>
        <1de74bf7-0e75-8ae3-6ea7-62939b540061@web.de>
        <220604.868rqcwfnw.gmgdl@evledraar.gmail.com>
        <xmqq7d5tag3s.fsf@gitster.g>
        <220606.864k0xwuyl.gmgdl@evledraar.gmail.com>
        <xmqqh74x8z66.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqh74x8z66.fsf@gitster.g>
Message-ID: <220606.86v8tdvg0f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 06 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Yes, but I think in this case most of these are either 100% legitimate
>> issues, or things where we'd like to e.g. add a BUG() assertion anyway,
>> e.g. in the diff parsing case.
>
> Where does that "BUG() assertion anyway" comes from?  What are we
> protecting against?
>
> I do not think such a BUG() added only for placating -fanalyzer
> falls into "legitimate" category at all.

No, but e.g. in 09/15[1] we *would* have a segfault or NULL dereference if
that function was fed input that it wasn't expecting, which is output
from another git command (or the same output created in-core).

In that case we can reason about it being impossible in the current
state, but annotating that with the equivalent of a BUG("unreachable")
seems prudent, i.e. it helps human readers to understand the code,
whatever -fanalyzer says.

Ditto the pack-related code in [2], where it's noting an aspect I'd
noted in an earlier code review (before I'd ever used
-fanalyzer). I.e. the combination of certain flags could land us in a
NULL dereference, even if we can carefully reason that we won't combine
the two having the code be less easily misunderstood seems better.

1. https://lore.kernel.org/git/RFC-patch-09.15-de0f7722608-20220603T183608Z=
-avarab@gmail.com/
2. https://lore.kernel.org/git/RFC-patch-13.15-63eeb66185a-20220603T183608Z=
-avarab@gmail.com/
