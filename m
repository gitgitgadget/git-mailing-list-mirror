Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C6C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 08:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359419AbiD0IfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 04:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiD0IfW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 04:35:22 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9230575
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 01:32:10 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id y27so563413vkl.8
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JdkiFH5djCTM1aR6T1gvdpvxNee4u0+Hm0Y3U2w/GA8=;
        b=dbdAO4Fv/wR5pX3kIN0E8skCNcXSez2mtf8WgP42No6h2axBA0oj9VNorJVJjcngbu
         fy4IMW7a40HSy4PqPcn35iRgBaWbRY7N3gPnybYySuqY7QQ02q95wCzvppNr6usQSUmP
         POiIbY2s+igrC6kbog/K6BJZcPwt4nsYc6U+c2U0MYgqOMqGl3DJnCjNmv7UzC4w14uq
         rgS9AhvWg32O4mAR8IoaTQ5UAIJMr0aVuwjuuV/tMogl3Ytjv6y8pG3ottYKfYHkQK62
         wU1X3iJpEi4nxd1UUHL9Lt0K0Xfjgx/qxHYsb/WlcobmRhAQsO3K/M19rShrgQIjXQIW
         fYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JdkiFH5djCTM1aR6T1gvdpvxNee4u0+Hm0Y3U2w/GA8=;
        b=zIECS1pgRyAOqn1IEXfbfhzrlmuS0ZTOvgZ7Sma2gf6ZX7c12v9BMyyyCB/yJqi06V
         jYrjniTrG0kNnKEB0J8WYuuF/ipwA75P+eH0X6xBncmcRWYcwag0cMvIPO+sVAC680Js
         NkaIyY5Q0p/LV/TicWIPQgdPvtxTMtMBzjgGgP4AMMwXBmEwXfv+Wf22HOH/Ju3zssvJ
         UYPJuHjPX/Ge3KOXcmraHQxerBEnCzaF58lLfCnKay3cUXL/1shNsN57/iI0fVhLe1I5
         hUlDQRgzXRJgntiDaJBvyADq0hR8Cphmj6UYRrzxl5jB1cUG80zj65gZu6OtrV7tDraD
         ETKA==
X-Gm-Message-State: AOAM5315EamR5/+PcW3VLAOdIV52UOAlIphvlnrRP9qoS87kHMjpdijA
        PQlSgmYakGQiTd8OqZ9yR+WWleU2g0PhvgIZ9Ok=
X-Google-Smtp-Source: ABdhPJyfaZt2UBvyecNDTYDCmL3PjskThHp2Gcpjgpf3TLN9mUt8Q7NktK2wlmtEiHsOmh/hsRqk7uUDCwVzwSuEbXo=
X-Received: by 2002:a1f:38c2:0:b0:349:9667:9232 with SMTP id
 f185-20020a1f38c2000000b0034996679232mr8349251vka.16.1651048329978; Wed, 27
 Apr 2022 01:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220427080412.37766-1-carenas@gmail.com> <CA+zfrf-6c7BG-PDehHKh6_8zWdu=NeM9gL6zN8Ug+oT9fAOfqw@mail.gmail.com>
In-Reply-To: <CA+zfrf-6c7BG-PDehHKh6_8zWdu=NeM9gL6zN8Ug+oT9fAOfqw@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 01:31:59 -0700
Message-ID: <CAPUEsphL6TARGuhjvCiXXt+CQZd1+c22KBw5n-XCvnP176yz8Q@mail.gmail.com>
Subject: Re: [PATCH] setup: avoid uninitialized use of is_safe in ensure_valid_ownership
To:     Matheus Valadares <me@m28.io>
Cc:     Johannes.Schindelin@gmx.de, derrickstolee@github.com,
        git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 1:17 AM Matheus Valadares <me@m28.io> wrote:
>
> That=E2=80=99s not needed. Fields in an aggregate constructor that are no=
t named are initialized to 0.

Could you point me to the C99 specification that documents that if you
have it at hand?  Even if not strictly necessary, it seems like good
code higiene as its effect is hidden.

FWIW, it broke a change I was doing on top of this where I removed the
" .path " initializer to set it later and was suddenly getting random
unrelated errors because this field was not initialized.

Carlo
