Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B746C63703
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 23:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiLGX0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 18:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiLGX0i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 18:26:38 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AACC89ADF
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 15:26:26 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3d0465d32deso206092067b3.20
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 15:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPawf4lLwLsw+7SoDwNnquhxtzEFskP9yEb/vYY3Deg=;
        b=R++aRC4WOjt2kyNBobP6Vm29QR8lxv6JqW4vF1Xog9AoSCA6UB41gRUEr+VXrSE32K
         8+I44koF5oWzoRm2xuEAZ1mknm2AFOQ+B0Fqqi1N7zR6825ro7oIekLr/Yfc0whqAfYd
         SHUrs0nC6aiQAgPXxQjUF1m+OzvK1GB24sqnwwrEqtMpmTNErqIlMy33RYeoUB7vxgGA
         hEiO5A1748pj5UYN1JUXIMCzcFFoj9pkGxSopuaU1+rv6NtzI0oJkX6sN6nbKoIlrMbk
         sEq0LzmFmz0B0g8KufMP5boO+wTJ+nHMxnN2gIZnnM4WdEgN4uvKIkrzrv/A3xLr4Lcz
         76GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yPawf4lLwLsw+7SoDwNnquhxtzEFskP9yEb/vYY3Deg=;
        b=v7rNmc3LbqTBNE9GhXIR42p+X7LF+RZcU1djhs9OSJkxudkpTwEPAQM7+WoxvDsy5a
         DNv90UBf35/1jHMF6RaaPV4wadTiJwM82jIYFSG3wDI9T/9mjZuuo7oE1whguUkT5Wd2
         O4J6JQG378h83NU+aYfnbGbrNhZhNzXXVOAl76f6X8DPx8JKSgk9QUoQeJXbduol0DdW
         CQC+pY/jAiY01xaCbRVIlfteAWikLNHUBysGGuPHb26U5fPU0Ic8fxoVMg8/eOSMRgQu
         c5lr6SuH5frVCI1TyWLFB+AIKL7H7K+p5tBVK0gX6f8TE488QQAMjuMZf3OqAtnXhGJh
         W6WQ==
X-Gm-Message-State: ANoB5pnbkLv3kkE8saenqoq/NgDCv9TCQF86P9nZEkpkaFo01i35aAlN
        Vs5YS4EYWqrdtbaM/rQy1cQrvX4xLoZc+fnnwW6p
X-Google-Smtp-Source: AA0mqf6qDl43/pcLj2nPtI4Bb5qbm58qgSglPP2Rlt+WKI0KiZrWg+GUXhBS8oQ0OT095nXlIbKz3xSP6awJqRfVn7BT
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:e801:0:b0:3e7:c742:f827 with
 SMTP id r1-20020a0de801000000b003e7c742f827mr18780801ywe.91.1670455585448;
 Wed, 07 Dec 2022 15:26:25 -0800 (PST)
Date:   Wed,  7 Dec 2022 15:26:23 -0800
In-Reply-To: <221207.86pmcva2s8.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207232623.1439026-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/3] object-file: emit corruption errors when detected
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Yeah, I think that's even better, although...

[snip]
=20
> > It's also kind of weird that map_loose_object_1() is a noop on a
> > negative descriptor. That technically makes this correct, but I think i=
t
> > would be much less surprising to always take a valid descriptor, and
> > this code should do:
> >
> >   if (fd)
> > 	return -1;
> >   return map_loose_object_1(r, path, fd, size);
> >
> > If we are going to make map_loose_object_1() less confusing (and I thin=
k
> > that is worth doing), let's go all the way.
>=20
> ...maybe we should go further in the other direction. I.e. with my
> earlier suggestion we're left with the mess that the "fd" ownership
> isn't clear.

With Peff's suggestion I think we can make the function always close
the fd. If we find it not to be clear, we can rename the function
to ..._close_fd() or something like that.

Thanks to both of you for your suggestions.
