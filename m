Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0396AEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 11:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjFTL03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjFTL02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 07:26:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C34CF
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 04:26:27 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-519608ddbf7so4758288a12.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1687260386; x=1689852386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hlub4yMYobEJ5HvQNTWQfgUmezHGN+X9jz5IApcQQ2M=;
        b=fm1f5h5rw3D8AFJxLjbfVkSGh7hAEj/ZBVoNgVjKrQ2SV6HGEj/93tqtiSvAuaW3qD
         eJWmovKiZlpnk+A1MphnrnJNL5mJOul40jr6eXf1UXEkx/7TWNTLT5bdpZ3oog8Q7Eu7
         gstmQl4GWcKGw03+qJO8LE2H2r6NgWWU0HHQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260386; x=1689852386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hlub4yMYobEJ5HvQNTWQfgUmezHGN+X9jz5IApcQQ2M=;
        b=Zto5GA67I4HIFnsz7hUJrSb4w67ww1r528/MxxkRPmsFSuauAOlkE/9hxmZpff8CsY
         X1oJpbVOnYlMPlWdlc5vTjDnUyhwXbPVC28mtJyc9hc2v09fV4Fl98fPPUrohTsH17mk
         xm6xmHmlbi6GDOBMOrzE+gyOUbpH6kFUoLbv/xGvDO5Y6CpSmzL1EQM7HFivVPmr0jnG
         D641sKEYpcGdAVZrP5xjaNswIrClzIe24BNePhvQ2q1zMiqv4sXw5364JfkMNdWe9RDu
         4lcZxBfOIzS3HsmaDqUFDDSvvsoozzrJAvZmhiGMFjYYnT+dyEV5+iqxZq5ASZWUIC56
         0MUA==
X-Gm-Message-State: AC+VfDwPoa+bUJBEvN98Ss4ABnjPLh0DLtn0d8b6a+SAk6eeg3UOaD0C
        dnpPv/njvdCXbfi+Dca4oUBk7n6RWcJDqvIt0yftR0tLBsyIM+SDyFUNyQ==
X-Google-Smtp-Source: ACHHUZ70AUwnK2glLV+Gb9sKTI48TxM/WwKHpw5I4f97Y3Sn2mIoWZ4PizjYl+Hf++J+/M5O7u645eiT0RT5p0aLkeE=
X-Received: by 2002:a05:6402:759:b0:51a:7bcf:c8f5 with SMTP id
 p25-20020a056402075900b0051a7bcfc8f5mr3089823edy.1.1687260385898; Tue, 20 Jun
 2023 04:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <m0ttze4qzl.fsf@epic96565.epic.com> <Y/VNiuI7OZ2YiXx8@tapette.crustytoothpaste.net>
 <m0pma14sbx.fsf@epic96565.epic.com>
In-Reply-To: <m0pma14sbx.fsf@epic96565.epic.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 20 Jun 2023 13:26:14 +0200
Message-ID: <CAPMMpoiC8oca0AVNy1f+zy26L_b-ADyNopY4zO3r+v6v-KEH=A@mail.gmail.com>
Subject: Re: [BUGREPORT] Why is git-push fetching content?
To:     Sean Allred <allred.sean@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Sean Allred <sallred@epic.com>,
        Kyle VandeWalle <kvandewa@epic.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2023 at 4:45=E2=80=AFPM Sean Allred <allred.sean@gmail.com>=
 wrote:
>
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > It's hard to know for certain what's going on here, but it depends on
> > your history.  You did a partial clone with no trees, so you've likely
> > received a single commit object and no trees or blobs.
>
> Yup, this was the intention behind `--depth=3D1 --filter=3Dtree:0`. The
> server doing this ref update needs to be faster than having the full
> history would allow.
>

FWIW, you're not alone - we do exactly the same thing, for the same
reasons, and get the same outcome: We want to create a tag in a CI
job, that particular CI job has no reason to check out the code, all
we know is we want ref XXXXX to point to commit YYYYY.

The most logical way to achieve that seems to be to do a shallow
partial no-checkout clone of commit YYYYY, and then push to remote ref
XXXXX, but the push ends up doing extra seemingly-unnecessary
jit-fetching work.

In our case it's still better than any alternative we've found, but
wastes a few seconds that we'd love to see optimized away.
