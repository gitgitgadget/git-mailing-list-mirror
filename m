Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F762C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B4E6198D
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhC1BgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 21:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhC1Bft (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 21:35:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA28DC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 18:35:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so10391037edu.10
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 18:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uJtPxcVj9QVWBadsSY+ArcZv6aH16ZFNNdB2MQe8n5A=;
        b=WR3PChVhuJof1p7oEGzJJKrpS+G1r0griwa7j7quNGmOJFlVnzFqO1eGykNfVEW4uf
         0M3t+Na9MhwN3VRrvKuAel2rMJhG6maQS2gNcJhh7N4AujP5GdDS3wwpsmZgUHl1b46G
         1yAf3SBVfdEGs8rKG/vsfYMgSz26uXrOA5/zjzKvnn3tKS55tOmGSdTtzbGRyI11rphV
         7dZkBv/MDA9hLP5XiZOIy3tI//XnIP+dfM45vjYYRu5a9Bx8WBp9BPs2qgjYTCFV8BpQ
         AwMWxJvBTPqMQsGGYVavJXP3CMn8ynruUfYbXG116kRcJ+PlxtB9d8GX9LnyuHNsXCl1
         e6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uJtPxcVj9QVWBadsSY+ArcZv6aH16ZFNNdB2MQe8n5A=;
        b=RtPTdiRsCe5F0qtvC+10lh4t0yTep3ye0XG6M02fH8JM/o6wIhZH3+r4hBOtufBfiT
         Lu4FBeOblVv5iyTeV9z4UjzRarT+gbmM8mNl4fjBJzuPKLzF4U+arztMXbTn7Mnb3nOa
         Zj6z0wiNA0Z9Qck0Wh1qqqg/EdFFVEXeTFwA4o1YoPjl1OZND+An6D0KzfZhg56kTmYR
         11YbsUVStxRIBHlms0SjY/8VGPLzu4AAPUzkw509+DYZUWyEWNLv82fQpe3oKyVqk1O/
         uhOC+d6i9MRV94V1C0qkEa0SqbKlRT0gukDYVukEQfrBmHv0Vq12cISnUHo1taLhAFkm
         X09w==
X-Gm-Message-State: AOAM533GQTl9usbL74W5HDFy9Iwy7lSzTItAdx/p3uQCBbkHNkP3FicS
        ZUqT193NZOPyS6cgaYcca21K0pe/l8NOrg==
X-Google-Smtp-Source: ABdhPJyzivm7bIvNTkJGq2WsPyl0cI/8VPf63N/GtBrcCyqUdX/Y+1ZYYWV075ul+bpMhg0vy6ZYyA==
X-Received: by 2002:aa7:cb82:: with SMTP id r2mr22496706edt.209.1616895347293;
        Sat, 27 Mar 2021 18:35:47 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m14sm6617670edr.13.2021.03.27.18.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 18:35:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] object tests: add test for unexpected objects in tags
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
 <20210308200426.21824-7-avarab@gmail.com>
 <YEdRhulqevMjlrLc@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YEdRhulqevMjlrLc@coredump.intra.peff.net>
Date:   Sun, 28 Mar 2021 03:35:46 +0200
Message-ID: <87h7kwnjpp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 09 2021, Jeff King wrote:

> On Mon, Mar 08, 2021 at 09:04:25PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Fix a blind spot in the tests added in 0616617c7e1 (t: introduce tests
>> for unexpected object types, 2019-04-09), there were no meaningful
>> tests for checking how we reported on finding the incorrect object
>> type in a tag, i.e. one that broke the "type" promise in the tag
>> header.
>
> Isn't this covered by tests 16 and 17 ("traverse unexpected non-commit
> tag", both "lone" and "seen")? And likewise the matching "non-tree" and
> "non-blob" variants afterwards?

Barely, those tests are mainly testing that rev-list doesn't die, and
only do a very fuzzy match on the output. E.g. checking `grep "not a
commit" err`, not a full test_cmp that'll check what OID is reported
etc.

> The only thing we don't seem to cover is an unexpected non-tag. I don't
> mind adding that, but why wouldn't we just follow the template of the
> existing tests?

I am following that template to some extent, e.g. using
${commit,tree,blob}. It just didn't seem worth it to refactor an earlier
test in the file just to re-use a single hash-object invocation, those
tests e.g. clobber the $tag variable, so bending over backwards to
re-use anything set up in them would mean some refactoring.

I think it's much clearer just do do all the different kinds of setup in
the new setup function.
