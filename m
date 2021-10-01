Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52911C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E92613A0
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 02:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhJACcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 22:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhJACcT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 22:32:19 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEBAC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:30:36 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id b82so17429836ybg.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 19:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PBiF2pJ8gwVXQdqcxPkwef5qIYoPULfgfBSl/zzB8SM=;
        b=k4M65Cl3F2yzDThjixS8eb+9WPG3zxJMnHTYio94BZCO2F5Bu2XGSf53wrKbliIp4F
         YLMG71Ax2k5aZ+Q52S+gileoSs+f4R6FuHz0QmzAGYiItZvrCSSGhaS9UiejLUOs9bzS
         hcprbf4z0nqWbwpm+/9RZiiuhlkIIyJVZ/AJQx2sCMczFhITkuJ7zIBVfacvuA7baRiM
         cMlP9jd6fta0UjIuxtzWgeopJZgOwiuUDoQ5kfwOjSY5OwaVtjlBymKCUFZde7MNDF6N
         vBBWxmW83jBCNnyd03dLorG2q7L07GJo3KuXJIiNhQD4X1dY2ecnycUZ/iCaP1S+xL8w
         wx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PBiF2pJ8gwVXQdqcxPkwef5qIYoPULfgfBSl/zzB8SM=;
        b=0dsRwUBD80LPyHoYs7tgvP325ljXwxQaR5CiKfobk97LEldxBKzZDdg9c0kzNfvXfB
         C80sE+4nbKXV9IamqjZAOqV28KYwxZOce1RtA0ugQKClWfmNqiQbcI6c6u1dSBvKBaO+
         SOHtgIZ7Iz2ImqHQCk/mk3QeefsIOwk/dDOR3yX8AdN2jJGE9LAe4w1FjFiXMl/aKjE8
         Hi4MnAyk8kDgnNXaYQu+mzwHG+/B7tcnjp3DIGi0y4iQ1nYM+D9qHWVuzZv7KYGoTD/7
         cAQxHXxl5F24W348QBlJnYXKmYR+TmSv6ks1emluaCxC92r2FiMuELalYJ7J7RYErWa0
         cf1A==
X-Gm-Message-State: AOAM531vEm3BBK7G8YiGZrhiJ3QQaIDUsqBEANuyvI2HDxllGh2OXnbB
        l92AZU2qZbzU4ry+RBR644KHel0fgNc7+pr4Fguj1LmT5yOeTw==
X-Google-Smtp-Source: ABdhPJwosDy4ZPUM692FTBlbaMlH9A0fIs5hdpdFNJQmZxe6Zock6NMjROmYDc3L6yxVOOW/5NZOFHXwc/uZikGN820=
X-Received: by 2002:a25:4d41:: with SMTP id a62mr3087615ybb.394.1633055435716;
 Thu, 30 Sep 2021 19:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210930121058.5771-1-chiyutianyi@gmail.com> <20210930132004.16075-1-chiyutianyi@gmail.com>
 <87pmsqtb2p.fsf@evledraar.gmail.com>
In-Reply-To: <87pmsqtb2p.fsf@evledraar.gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 1 Oct 2021 10:30:24 +0800
Message-ID: <CANYiYbHNBcDaoF+QE_+62EXUZD_caaJDFmt7v1_BddQfpdVcvg@mail.gmail.com>
Subject: Re: [PATCH v2] receive-pack: not receive pack file with large object
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 10:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Thu, Sep 30 2021, Han Xin wrote:
>
> > From: Han Xin <hanxin.hx@alibaba-inc.com>
> >
> > In addition to using 'receive.maxInputSize' to limit the overall size
> > of the received packfile, a new config variable
> > 'receive.maxInputObjectSize' is added to limit the push of a single
> > object larger than this threshold.
>
> Maybe an unfair knee-jerk reaction: I think we should really be pushing
> this sort of thing into pre-receive hooks and/or the proc-receive hook,
> i.e. see 15d3af5e22e (receive-pack: add new proc-receive hook,
> 2020-08-27).

Last week, one user complained that he cannot push to his repo in our
server, and later Han Xin discovered the user was trying to push a
very big blob object over 10GB. For this case, the "pre-receive" hook
had no change to execute because "git-receive-pack" died early because
of OOM.  The function "unpack_non_delta_entry()" in
"builtin/unpack-objects.c" will try to allocate memory for the whole
10GB blob but no lucky.

Han Xin is preparing another patch to resolve the OOM issue found in
"unpack_non_delta_entry()". But we think it is reasonable to prevent
such a big blob in a pack to git-receive-pack, because it will be
slower to check objects from pack and loose objects in the quarantine
using pre-receive hook.

> Anyway, I think there may be dragons here that you haven't
> considered. Is the "size" here the absolute size on disk, or the delta
> size (I'm offhand not familiar enough with unpack-objects.c to
> know). Does this have the same semantics no matter the
> transfer.unpackLimit?

Yes, according to setting of transfer.unpackLimit, may call
git-index-pack to save the pack directly, or expand it by calling
git-unpack-object. The "size" may be the absolute size on disk, or the
delta size. But we know blob over 500MB (default value of
core.bigFileThreshold) will not be deltafied, so can we assume this
"size" is the absolute size on disk?

--
Jiang Xin
