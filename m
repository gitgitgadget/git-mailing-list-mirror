Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E68FC77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 19:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbjELTes (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbjELTeq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 15:34:46 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA88A5E
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:34:45 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6ab38a85a1eso2393531a34.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683920085; x=1686512085;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jvx/7uc1FiNK1zZEdyb3FGVjqso2fLJ+IX2xgkJQb3I=;
        b=Li9mIcHDFcyT00uqmEyueewnm1t+Sfz8hlryodhoPV1+ecECTITX3cdl3NunsQhA1S
         EAF7fDxP+fytKMKUkYXhEGcTMWm93M7sqrYoIJW93KXvtlYG/p9JtDTx3UR90+1MNt1z
         of3rZxu1Pukot7/3UkKty9rpxQ7w6tk6zaYGlaMDnSPsM1XE+6asVAL47v7AXM74QpmD
         CYEFskGSyY1v0NJWSvQD7Ee1ifSPLIoSjShGcykS/HUPirrQIWoZOa5LqT4pZMZ+7x5z
         QR4H9TYR4H0GyIrQJwricUstkkAtWRc+fbsyZFsOaTL0bMhi052b3hHC6xhMHdqpgvEb
         XN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683920085; x=1686512085;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jvx/7uc1FiNK1zZEdyb3FGVjqso2fLJ+IX2xgkJQb3I=;
        b=iy8X+5NN2h+IbdwqL81T0v2u09QkQAZTJRSD0hC5Y7lt1AuwAwP7lbUSOK3Ku3iX9A
         ZIxGaNQbS2MA2WRxV0AWo9gOIquMdSPvgp12aY9jNP0KJs9aiirJY9wjATAiuU4yrGzh
         Gxt/j2kYm/OvPOafpl5ZTXCEeiiSycOHniEVWEr5MQePdBGJkBe46tn/myTF93dZdK6H
         xL3z2JK4INIt6bDPIq0l5S2pL4bzV9FUwgMdvs5FaxfJ8qcBB/2EAm5Opaxd4OfMz+T5
         n9q0D2wHL995AJpPMzVAx5y+rnW+rdBekvy5IYB9YcBq5uj8a/lZs3CZUAvEU6JhgkZE
         sZKg==
X-Gm-Message-State: AC+VfDymMtcBUYcA3pD5HAwZ4Nj2Scd3AV7VbV60TeLMMPHZMGeWrq3m
        QX80GU1yX6Yyuh8gvMC4VdA=
X-Google-Smtp-Source: ACHHUZ5lIvmYq+d6dKrSMFXcU/rbFLVfQzre3uMoTzF+wMqvznWsp5ioM2ukJVttPGD1ffGrcl1xUA==
X-Received: by 2002:a9d:6e0f:0:b0:6ab:75a1:ee1b with SMTP id e15-20020a9d6e0f000000b006ab75a1ee1bmr4147686otr.36.1683920084716;
        Fri, 12 May 2023 12:34:44 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g25-20020a9d6c59000000b006a652d3ad74sm4936049otq.69.2023.05.12.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:34:44 -0700 (PDT)
Date:   Fri, 12 May 2023 13:34:43 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <645e94d38510f_21989f294c6@chronos.notmuch>
In-Reply-To: <xmqqo7mpqy6g.fsf@gitster.g>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
 <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
 <xmqqo7mpqy6g.fsf@gitster.g>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@univ-lyon1.fr> writes:
> 
> > https://public-inbox.org/git/51E3DC47.70107@googlemail.com/
> >
> > Essentially, Stefan Beller was using 'git show --format="%ad"' and
> > expecting it to show only the author date, and for merge commits it
> > also showed the patch (--cc). I suggested -s and noticed that the
> > option wasn't easily discoverable, hence the patch series to better
> > document it and add --no-patch as a synonym.
> >
> > Probably I did not get all the subtleties of the different kinds of
> > outputs. I guess I considered the output of diff to be the one
> > specified by --format plus the patch (not considering --raw, --stat &
> > friends), hence "get only the output specified by --format" and
> > "disable the patch" were synonym to me.
> 
> Thanks for double checking.  It matches my recollection that we (you
> the author and other reviewers as well) added "--no-patch" back then
> to mean "no output from diff machinery, exactly the same as '-s' but
> use a name that is more discoverable".
> 
> > Looking more closely, it's
> > rather clear to me they are not, and that
> >
> >   git show --raw --patch --no-patch
> >
> > should be equivalent to
> >
> >   git show --raw
> 
> Yeah.  If this were 10 years ago and we were designing from scratch,
> the "no output from diff machinery, more discoverable alias for
> '-s'" would have been "--silent" or "--squelch" and we would made
> any "--no-<format>" to defeat only "--<format>".
> 
> It is a different matter if we can safely change what "--no-patch"
> means _now_.

We can. As we have been able to do backwards-incompatible changes in the past,
will keep doing in the future.

You yourself proposed a backwards-incompatible change here [1].

> Given that "--no-patch" was introduced for the explicit purpose of giving
> "-s" a name that is easier to remember, and given that in the 10 years since
> we did so, we may have acquired at least a few more end users of Git than we
> used to have, hopefully your change have helped them discover and learn to
> use "--no-patch" to defeat any "--<format>" they gave earlier as initial
> options in their script, which will be broken and need to be updated to use a
> much less discoverable "-s".

That is not true.

`--no-patch` is not used to defeat any `--<format>`, it's used to disable
output, for example this:

  git show --no-patch

There is zero point in writing:

  git show --patch --no-patch

Because `--patch` is already the default.

But all of these would keep working fine if we change the semantics of
`--no-patch`.

It's not true that they will be broken.

It's only when the default is a format other than patch, or a format other than
patch is explicitely specified, for example:

  git diff-files --no-patch
  git show --raw --no-patch

Potentially the number of users who actually do this is *zero*.

A few users for some reason may have come to rely on the above behavior, but a
few users might have come to rely on the following behavior as well:

  git show -s --raw

Which your patch [1] breaks.

[1] https://lore.kernel.org/git/20230505165952.335256-1-gitster@pobox.com/

-- 
Felipe Contreras
