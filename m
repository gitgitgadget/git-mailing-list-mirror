Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40D6C00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 17:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiHARtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbiHARtq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 13:49:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9120B2ED45
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 10:49:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id f22so3742120edc.7
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UTI0bIGGzT0wwnSuaNLf8wLhHw4dwayvQzPf0cXTlXM=;
        b=Rb55BZBJlqCwMKzVYm4Rz73Gr2BOmSdR4JoRlOHOEbjcjx8yatOvqTZH7YB5ZZT6dn
         RE3RtAFknS3pijDTx8PNBnMVaAe7ToytNui9Y5Mxabic5qr2YiT8WJx4cHwwtiDe2psn
         2CsZqtHiHMUF5hHJ3nyqlQTChE0VnVvmrbpGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UTI0bIGGzT0wwnSuaNLf8wLhHw4dwayvQzPf0cXTlXM=;
        b=W3Y1beZGDalafrgdDuUJEt3MXFNAgJzqUlXyBsPvZsFos7UmtVWzeeEXQAjFSmI1kd
         60+Sn/2NQns0+KgoLGA82KidnXwwb4ezRIe1QniZ/4ysR3+6guV8FbctdxHFsJvc2KNK
         pm7pegt+E5Ce+0/noKrwp0wG7snwLH2tOVJTSIOyzSfVbUkmU7QBbCBe0tmVJbKCMoI4
         jNkUQocOvYrwP41gM7Wudb5EsrgmpHBpewkh75VReQXV2xuSpUqcagqMAjf+2EvM/Plt
         HZosaCuhTD/nqUUa56pVRaX0pSqVB0EiahFt+oy95EMg2sjuX4kntAbNcU27qvXc6C4n
         00PA==
X-Gm-Message-State: ACgBeo1f+Deuk/c5Wf3rfb5pMp9wgxhUA7JuIK83ErCE74HXG88ZsgRE
        KLrFtN0y7yKiTDAWNpRRbjMnJURB8mi9WX9tuh4=
X-Google-Smtp-Source: AA6agR6P7GqRbJ9jQhHfes7dVKF+REEOFfr4smNlxOqzVlrtEA0RcxXUwAWTH49NoMGRXL2Jzh8c0A==
X-Received: by 2002:a05:6402:5190:b0:43d:da02:566a with SMTP id q16-20020a056402519000b0043dda02566amr2038431edd.187.1659376183998;
        Mon, 01 Aug 2022 10:49:43 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906301300b006fef0c7072esm5460541ejz.144.2022.08.01.10.49.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 10:49:43 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 129-20020a1c0287000000b003a2fa488efdso3104290wmc.4
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 10:49:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr11930591wmq.154.1659376182763; Mon, 01
 Aug 2022 10:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
 <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
 <YuXKaLXhnR3mVlWk@coredump.intra.peff.net> <xmqqzggpyu7q.fsf@gitster.g> <YugPER9UsH1z6MZo@coredump.intra.peff.net>
In-Reply-To: <YugPER9UsH1z6MZo@coredump.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 10:49:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8EaHnM_OcHrw=+sT3VPAkTUpzeaQ8EjTDLUENK58HSw@mail.gmail.com>
Message-ID: <CAHk-=wg8EaHnM_OcHrw=+sT3VPAkTUpzeaQ8EjTDLUENK58HSw@mail.gmail.com>
Subject: Re: "git symbolic-ref" doesn't do a very good job
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

)(

On Mon, Aug 1, 2022 at 10:36 AM Jeff King <peff@peff.net> wrote:
>
> No, sadly, that isn't the rule. See afe5d3d516 (symbolic ref: refuse
> non-ref targets in HEAD, 2009-01-29) which tightened it to "refs/heads"
> and then e9cc02f0e4 (symbolic-ref: allow refs/<whatever> in HEAD,
> 2009-02-13) which had to loosen it.

But it seems that at least this issue won't affect check_refname_format().

Hmm. Looking at that again - even without ALLOW_ONELEVEL I don't
actually think check_refname_format() requires "refs/" per se. So the
HEAD check isn't actually made redundant.

I wonder what the intended semantic meaning of ALLOW_ONELEVEL really
is supposed to be. It seems to really only require *one* slash - but
it doesn't really end up checking that it's in the "refs/" hierarchy,
it can be anywhere.

I guess the only thing it disallows is literally HEAD and MERGE_HEAD
and the like. But it's a bit odd, because it would seem to possibly
allow you to use "refs" that point to the objects/ directory or
similar.

Maybe the refs/ protection comes in somewhere later, I didn't really
go around to check.

                Linus
