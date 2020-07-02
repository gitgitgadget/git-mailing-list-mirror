Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60A7C433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 15:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B33E207D4
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 15:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE5XIdzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgGBP6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBP6V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 11:58:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D76C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 08:58:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s9so32826539ljm.11
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Z2mMq4Y33FXTJ6VaDnG4YuUSplVBxB6/P2LquJ1uqmk=;
        b=SE5XIdzPTmVwOI9lg3/hAKmf0jmjX5DVS9jSPWzdHyCJFCs/L0RyOJremtX8TKo7AR
         L80STTvTfjx8rIjPVPhCkZq/xE+eOFI4Ew9QB2MYiBB3jZqyR92yI6r/G/w9hM2En5Uq
         mhKExkXtYO9f2CZ1p+bE1fw9hTtpFfOuyxYxUHHBaSRFxQeSubMA9qMMgcZ0VtJ3bQ/3
         vMFWPKL7lm9NZKMQI1sZR9LtQlA7YCdr793E/tX3Gr6a+SkzEb0vIcmWzbdn+d46BwBx
         uKqGwMXP982fjv2MCIbEweiE37zY8pX/euv0OBufYUagLVWsEFRoW4K5t6EEs46s/jLJ
         AUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Z2mMq4Y33FXTJ6VaDnG4YuUSplVBxB6/P2LquJ1uqmk=;
        b=mRiiZyK7wEXO0YoQBAYrq+G4Ax2zw2CBWHFfsWHP9egP+gprjP5V1wdLf4DmyzHwAV
         Q6Ea7dp05MBOlvWtjXsrAjWwFvT7S1o+83GkpznvhRuoyphTOh0pOIWGx9K74t8o6umJ
         CL1/9Eaou27knpC6DD/efjjxjO0yKtLdW03XR28xbfVH/a9T4EITMIUkKC+8O1BwvyWu
         ld6wKIc54Gy9nCK2OTJ5zWsh3REUSbaIkZ50tc7VEg2RGriNNZtzcsWjgUbFw3cOx5Kg
         VITX8loWzkma1U6WhgdJcrTyEv+NaUcnAjO2jY9R4jF1QcMrBNuv6ogio0+pJ6OUMB5u
         SnnQ==
X-Gm-Message-State: AOAM533Y1SfDBlb/6eWdQoEeuzfyBKiXYtFWr09kbC48sL6G3+reozfL
        fRu0k3RrDDdXQmSPTi+/LT1X/DHRTrMdE5Ccms/yKjizfGA=
X-Google-Smtp-Source: ABdhPJzQdJLRN/m16C/XrcdPumNrzOJANSBjUPhsnaUwrBvSYTHEuCoWwxRZVrf05Rl5d1ken1eajr7Zr9kFwjeVYPg=
X-Received: by 2002:a2e:9186:: with SMTP id f6mr13554617ljg.386.1593705499077;
 Thu, 02 Jul 2020 08:58:19 -0700 (PDT)
MIME-Version: 1.0
From:   Jakub Trzebiatowski <cubuspl42.1@gmail.com>
Date:   Thu, 2 Jul 2020 17:58:08 +0200
Message-ID: <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com>
Subject: Is git compliant with GDPR?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've been using git for years, but I've never before taken part in the
discussion on the mailing list. I have a simple question, which
probably isn't easy to answer.

Is git compliant with GDPR, the EU data protection law?

Before I'm able to commit with git, I'm asked for my first and last
name. That is personal data.

GDPR, Article 4, point (1):
=E2=80=98personal data=E2=80=99 means any information relating to an identi=
fied or
identifiable natural person (=E2=80=98data subject=E2=80=99); [...]

That data is handled by the git utility. It's sent to other parties
operating remote git servers (as a result of my commands, but as far
as I know that's not relevant). It sounds like it's being processed.

GDPR, Article 4, point (2):
=E2=80=98processing=E2=80=99 means any operation or set of operations which=
 is
performed on personal data or on sets of personal data, whether or not
by automated means, such as collection, recording, organisation,
structuring, storage, adaptation or alteration, retrieval,
consultation, use, disclosure by transmission, dissemination or
otherwise making available, alignment or combination, restriction,
erasure or destruction;

This data is processed with a compatible computer owned by the end
user for the purpose of identification of git commits. It's sent to
other parties only when specific commands are given. All this was
defined by git authors/contributors (from all around the world).

GDPR, Article 4, point (7):
=E2=80=98controller=E2=80=99 means the natural or legal person, public auth=
ority,
agency or other body which, alone or jointly with others, determines
the purposes and means of the processing of personal data; [...]

Git authors can be considered joint controllers.

If we'd assume the above interpretations, there would be many, many
consequences.

I'm not a lawyer, and I have no idea if this interpretation is
reasonable. I don't even know if I'd like it to be. But here are some
facts: GDPR does focus on protecting the end user. Possibly, it's the
most strict data protection law in the world. It doesn't care how
difficult it is to adjust the organisation for compliance and it
doesn't care where the controller is located, as long as it processes
personal data of EU citizens (if I understand it correctly).

Are there any lawyers in the git community? Could The Linux Foundation
help with legal support? It's a very non-trivial issue. It's non
obvious how local software relates to GDPR, and it's even more
difficult with Free/Open Source software with many, many authors. But
if the aforementioned interpretation was assumed, the git authors
could be held responsible for non-compliance.

Best,
Jakub
