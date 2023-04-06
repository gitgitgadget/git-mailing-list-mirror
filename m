Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2391C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 02:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjDFCSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFCSd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 22:18:33 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861D96E88
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 19:18:32 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-545e907790fso598126697b3.3
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 19:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680747511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUQ00XdzI5u7TDS1BfpCsgNf9XxZBvXqNXLcVdq+uiY=;
        b=ZMQt+fNpNrShZIxbrd7Hg70esAGjepUXNtlv3LCgXj2wLZeoqgKvJXMl1zQDvxv1qG
         x7G+j35PtX+qi70cPTugS08xpYGwYzBk+gFBL4pYmT+c9eKg6XasEw4PBJZw7i0VMn2I
         DT8hpqcteEEnE6QfUQFgdNZCSyixfHLwQQEZZ6UD5HXVbvNSLweTAmdKKPD2OTLD+eo0
         44pefbUMs8ZhgyrFfHJu52BNftpH0AHWzhEMGhUg1s4OIsPoDl/h5oaAgtWJerv75pWs
         6Bk6XhHSS6nLeRu6y4dmQUAS71XPgn6woUlQF8RW51rNoXL4lhGUAKPEjtvF7TjFuIIz
         d1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680747511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUQ00XdzI5u7TDS1BfpCsgNf9XxZBvXqNXLcVdq+uiY=;
        b=qQSQBjADy3Kbhrv0Qy/dR49tEWLdlOT7agvzc46IxQSyPgLOFaGB0l6AneeBD/h8Ee
         MNbYoazB1sZ70e2p/OOUt+UpKTR3XnfEDjeRZO2NPBNC+nktc3FUc9MJBUoJecY/6/8r
         TAInc9e63GbvY6RWMG4cCBLfgzXP6I5CK2aY+j5GlwzBQwccYdAP8EILrQdbNmBgmSW9
         vyxbkgv0GoJIIflpHGTEQRa3BrrgHDawEN9laI1kd0TRaflB7xa8LzZgtLR08FrvW1kY
         rxrohAsMp2bUH4up1ytIxFOnAk2/SAeH1BDR+3D5i5qrSOZ/PJXaA05v1ZaTYYvXK7G2
         9udg==
X-Gm-Message-State: AAQBX9fsTKAIK4cgvS2nuYQLuBEpTLsmFF+pfI3sWOxJhATrQscFa/+V
        bUmPJyWfx3qh74c/EHBke7LS1LQRKPf7nkDvuSXoSk4w
X-Google-Smtp-Source: AKy350ZtmAxTXPLv0T1j3CXr5wFqSHtfUsDreZDTZdRbOydark+TKA1KEJhJVPEpP1Z87ledfFYzGKjkNligdhuJU2M=
X-Received: by 2002:a81:e545:0:b0:545:4133:fc40 with SMTP id
 c5-20020a81e545000000b005454133fc40mr4687015ywm.9.1680747511611; Wed, 05 Apr
 2023 19:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com> <ZC2LOAwycdaUawxM@ncase> <20230405165414.GA497301@coredump.intra.peff.net>
 <ZC2wppC62E7wOcqM@xps> <20230405181505.GA517608@coredump.intra.peff.net>
In-Reply-To: <20230405181505.GA517608@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 5 Apr 2023 21:18:20 -0500
Message-ID: <CAMP44s2_b0=Bm-NmDQ7ZVBen27ZtK9DpaF0gs965k1wXzzhARQ@mail.gmail.com>
Subject: Re: [PATCH] global: resolve Perl executable via PATH
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 2:09=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Wed, Apr 05, 2023 at 07:32:22PM +0200, Patrick Steinhardt wrote:

> IMHO we should aim for fixing those inconsistencies, and then letting
> people set PERL_PATH as appropriate (even to something that will find it
> via $PATH if they want to).

We can aim to fix all those inconsistencies *eventually* while in the
meantime make them runnable for most people *today*.

It's not a dichotomy.

--=20
Felipe Contreras
