Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5866C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 10:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2C42073A
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 10:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc77FN/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgIVKml (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 06:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVKmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 06:42:40 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB4CC061755;
        Tue, 22 Sep 2020 03:42:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j11so22206519ejk.0;
        Tue, 22 Sep 2020 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+Y3ed1m6nxjnbHLRR7kUi5TDx9qWoo/PyUUq5YncPkQ=;
        b=gc77FN/+PjhKvNJYSNmj/RHYPujDbUWk/cUVuQqtKFdmWarskSmquza3mijS6jIA5+
         ak1YP1WizrX6/ZGF6c6QSsm/RmR2BvlU1XRoT1NRovbmIuma0Tkb/T+lh46Uy1c/7QTW
         ZD+eCbdoNHR1QR2t55XNlYObp7toeOzhBkGBveTiOI33w2668qS+ifZzjVc/K7CawcwE
         QlFA9lTB8sHCJ3qU6T/iOq+eVg1ZtTWbcL0P75aiflleJFDPeMcEBijaNxu1/QIrbnwy
         RaJnRV8P/Vn3IDSfc9aL4S7puoXWHMQsWXgppat0HqMcQOUNGEnQM8yjdc0Po2q6xA/g
         dPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+Y3ed1m6nxjnbHLRR7kUi5TDx9qWoo/PyUUq5YncPkQ=;
        b=EUjZiqfRD+GDJcis5DPFeQqs5xyG45foQRRrOvvY2TYzf0HuFzTGhFFwTQswhf04g6
         OMJEmOyH6wi41/sCUS6asY54sjvXSGFu+pG9VkBzO5azulNWWw/o6ir64mn6GcyyLaJQ
         s2O8pYpn5VuTUdIBgJqRP8l04WADukOIrgNQdHOn51FH6AAUiS1KudsoRAhmLMJ6l72d
         ICOdFk5dT1+3P8r0sFjW75jwgstF+iHuWD6ckDiIab9lgZO7Ik+O8V6ckzMINn3NM+L+
         n3TiHcE045iPdNt/97vyGav2aMy3EvkQl6k/97Qc7hWVYGDWazN1cR0ojNa+78IGrbCE
         TDTw==
X-Gm-Message-State: AOAM532PbTOxK6Kb7VfMAJeU1QyahYWGmgwrbOHiUI0PHzx03A+lHDca
        IrqNgPqp+VV/soBExPkiY54=
X-Google-Smtp-Source: ABdhPJwV5H6ovaIEDPQAeeiyuR9yCRVTy0SBUft2EFQ4Txu48oZqqdFYWA0UGlHHm9oeauKW66dApA==
X-Received: by 2002:a17:906:5046:: with SMTP id e6mr4333881ejk.449.1600771358998;
        Tue, 22 Sep 2020 03:42:38 -0700 (PDT)
Received: from evledraar (dhcp-077-248-252-018.chello.nl. [77.248.252.18])
        by smtp.gmail.com with ESMTPSA id r13sm10680949edo.48.2020.09.22.03.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 03:42:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     git@vger.kernel.org, tytso@mit.edu,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when core.fsyncObjectFiles
References: <87sgbghdbp.fsf@evledraar.gmail.com> <20200917112830.26606-2-avarab@gmail.com> <20200917140912.GA27653@lst.de>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <20200917140912.GA27653@lst.de>
Date:   Tue, 22 Sep 2020 12:42:37 +0200
Message-ID: <877dsmhz36.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 17 2020, Christoph Hellwig wrote:

> On Thu, Sep 17, 2020 at 01:28:29PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Change the behavior of core.fsyncObjectFiles to also sync the
>> directory entry. I don't have a case where this broke, just going by
>> paranoia and the fsync(2) manual page's guarantees about its behavior.
>
> It is not just paranoia, but indeed what is required from the standards
> POV.  At least for many Linux file systems your second fsync will be
> very cheap (basically a NULL syscall) as the log has alredy been forced
> all the way by the first one, but you can't rely on that.
>
> Acked-by: Christoph Hellwig <hch@lst.de>

Thanks a lot for your advice in this thread.

Can you (or someone else) suggest a Linux fs setup that's as unforgiving
as possible vis-a-vis fsync() for testing? I'd like to hack on making
git better at this, but one of the problems of testing it is that modern
filesystems generally do a pretty good job of not losing your data.

So something like ext4's commit=3DN is an obvious start, but for git's own
test suite it would be ideal to have process A write file X, and then
have process B try to read it and just not see it if X hadn't been
fsynced (or not see its directory if that hadn't been synced).

It would turn our test suite into pretty much a 100% failure, but one
that could then be fixed by fixing the relevant file writing code.
