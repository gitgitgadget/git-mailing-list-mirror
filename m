Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83354C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 17:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240418AbhLUR1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 12:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhLUR1t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 12:27:49 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32365C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 09:27:49 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id j10so8524603vkk.12
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 09:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3aT/dAKLQqmo8vSgLGw2YwHpkD4wgCfZnwuP32QLtIE=;
        b=K3vSuwfmrz8Vsjcz90PEmA0FcNJ0X8Od89P2XEtdP4vwIbF5U/wmd6EX+JLhIj1EVi
         Dg0m0C549q2d/ZX+fwM+oyKfaCz1UjkwZFtym5xIsyIGxVbj2ex7+JysQD3FmiNY1Ir8
         oZAcPFqu8+pdOFBLdRYnrBnStYEL/iV/RDlbfLN5uokKQPNLbq058BX3LQ8nylaGLPfY
         OtjO4hElABAS8XhhxWlsdU03cM+UB/Ze4KlLt7L7zXNaPldHdf1RJEL0LbkwP+vC0rhO
         I+dOQQOXzYSqJO93kEurA0RxTkRznBTYh1QbyAcYHhE+GPJFeHxDYF0VNhd+bpxT8gkm
         DvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3aT/dAKLQqmo8vSgLGw2YwHpkD4wgCfZnwuP32QLtIE=;
        b=PcJdLLajjnsmAnupsCvWRjP7K6Zc4vSyn3HaJEagVTQjT5+ColmE/d3tZIOhVrRa6f
         SujkpYNMVfWilDV2wQgCs4FB7EuPTG69tLYm4s8/IfLD9+CjA5bEUR3OxmfNuxIAuTG7
         Ek9nv0G5GjCpbN0E46sptS8oIEKa9idmV5YPJhJatSDa90l3IEws3IfQmpz5YFuyqZc0
         iEiaBg68QX49uVWwtNZgJTBA+zJcoVM/PRJZM5jIqynWlhCvu2g98X3Z/bKwxytqu+h+
         Va8uZUhw3v149HWkA0R4cm8Y6kieGTUkCKbKZ1xE7ASAv3nHhqEW7vVAy3KJYsefVhS5
         fqJQ==
X-Gm-Message-State: AOAM531APJ+EtldOCPapDsYu2aH7I91mL+fiu9WDJDqqW5v/BkwZpFzI
        oX+83eOTcDnHYVAeoSd51NoG8ZEpQ6W64WE62geQUppZjbCEtw==
X-Google-Smtp-Source: ABdhPJwElrkFYCMgiKngVPDsBNdjEaIGG06iwBpzd4KUXfzYTZr8xrUWRhOtSnhtK2avkBoeVeBT8nub978diPl65oo=
X-Received: by 2002:a1f:a3ca:: with SMTP id m193mr1760218vke.4.1640107668115;
 Tue, 21 Dec 2021 09:27:48 -0800 (PST)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 21 Dec 2021 18:27:36 +0100
Message-ID: <CAFQ2z_MckMjRG9bOHeaKfFDkqG5L0AAz2V-uUSwMKTdh3MicGA@mail.gmail.com>
Subject: t5327 log expiry
To:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

Your recent work on cruft packs breaks with reftable. I suggest the
following change

- rm -fr .git/logs &&
+ git reflog expire --all --expire=3Dall &&

to make the test independent of ref storage format.
--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
