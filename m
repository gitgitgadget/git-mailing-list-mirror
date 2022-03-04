Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD145C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiCDSwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbiCDSwH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:52:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1F41D67CC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:51:18 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id i11so15725766lfu.3
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xy9kzSWtQZDYtlGBlXmIYEmfxpLyEgIcJFHxSFlb/w0=;
        b=Zn+VYIABHuVEDbetjEsqbm4b+ASLxnfoZunOFRm6pTyvW7pmxrfbssNtSZ9vZkicDv
         RjnT2gfO3z3caf7c2jmghlRNDjv/NoyHKIvjW0umShxmAizu59BZHZ8ylhImEOPj760V
         /Dw9vcTt9N4aj9R1PJztpUARu7RckhiBAPe8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xy9kzSWtQZDYtlGBlXmIYEmfxpLyEgIcJFHxSFlb/w0=;
        b=6nfn4I0Iop7xAaZaqJT9neEAt22e0wTjHv9U7nk0SmcifJjF5BFbP5TKkyv6EEhEpV
         7QvFSb/2n/+w1oUj25Ofo731I1WrpQBMqh76xh2ZbvgBd9t5siveqreXjDVKG5bMNWp8
         020BasfNMXB9wTFuBtLXlWipHCVLRsz7C6AkclXjZIw7MXDmn5+ZvW4y2PxUdgCXJ+TZ
         eF3m74bSIFb1yBytmKmoRzjRXwVjK2VRCUei1FzOSh5xuTNgO5FjOo9nU4EECzJdXunE
         H8yA87yrpUtPDgCmirsNQFTY/eDs9rOZ/VOQOyE5Vo3WylBIyMhifZgLJfbO8y40ZrAQ
         MOfQ==
X-Gm-Message-State: AOAM533Z4E87wkrIYoDoG7mg9txFGwPy969cVSTZuwqqd7/VZOWzjo0K
        7BqaTPyyVu9Y2K4Vid8xCmB1l7a2i9HWb22b
X-Google-Smtp-Source: ABdhPJw6Sdy4iNawAgC+Uveag2W7VJBC//hTO1v7X0uQBB1lbF/F9Lo7EjbGuNpkTU0sCvqm/cujFA==
X-Received: by 2002:a05:6512:104f:b0:447:f9b6:9217 with SMTP id c15-20020a056512104f00b00447f9b69217mr65973lfb.575.1646419874959;
        Fri, 04 Mar 2022 10:51:14 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c16-20020a056512105000b004433ce86133sm1194544lfb.51.2022.03.04.10.51.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 10:51:13 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id g39so15674444lfv.10
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:51:13 -0800 (PST)
X-Received: by 2002:a05:6512:3042:b0:437:96f5:e68a with SMTP id
 b2-20020a056512304200b0043796f5e68amr69986lfb.449.1646419873326; Fri, 04 Mar
 2022 10:51:13 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wi2HkQ648sYe3BusCEh5tBYjJbQ9c5T-DrykfEdgRbi=g@mail.gmail.com>
 <xmqqlexq8zqo.fsf@gitster.g> <CAHk-=wjQP8PwYZMYUhKu3s9wMhE2yDqdAO_OKagqXuvPrHRyAQ@mail.gmail.com>
 <xmqq1qzi4bpk.fsf@gitster.g> <220304.86r17ifahr.gmgdl@evledraar.gmail.com>
In-Reply-To: <220304.86r17ifahr.gmgdl@evledraar.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Mar 2022 10:50:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whaqdakNBwVZ-AZ0Ei2WLA+=3oqofhKfdQ618dWrYySfQ@mail.gmail.com>
Message-ID: <CAHk-=whaqdakNBwVZ-AZ0Ei2WLA+=3oqofhKfdQ618dWrYySfQ@mail.gmail.com>
Subject: Re: Silly 'git am' UI issue
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 3, 2022 at 11:22 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> A more general solution would be some continuation of this, i.e. we can
> use the "defval" in "struct option" as a pointer to a validation
> function for any arguments.

I wasn't familiar enough with the option parsing code to do this, but
yes, I think your approach is nicer and makes it easier to add
checking to the other passthrough cases

So Ack from me on that approach instead.

I do suspect that you'll notice when trying to code up a proper patch
that it's probably complicated by the fact that the "validation"
function wants a different argument (in this case a 'struct
apply_state') than the "passthrough" function does (it wants that
"struct strvec").

Again, I'm not familiar with the argument parsing code, it all
post-dates my work, so what do I know..

                Linus
