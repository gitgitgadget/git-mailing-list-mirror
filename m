Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54205ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 14:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiISO2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiISO2k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 10:28:40 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772DF27B26
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 07:28:39 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id k14so14185681vkk.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 07:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=gE3oWxnnXLLHTsR3mJhrRV69ZxS3O1Biyw7y99QvNoo=;
        b=JSR8fm7tw9VrOAR0+s0jOKtvjZCxMwMg5sIFNqsP0jwDHw33DU/wg/jaEIhQshhp+d
         zE9SDfZJJPr6VnNBKqGwqiv/hujRC83qeuIW13yL0wWjg9W5rye7DtTz79KDSOGyXCoA
         mQC4a9gLRvOCnLny7QXLtQtWxftouDzrc3+4UnG3lc6eCcI8oulLcUd6QyrZNdFt3+Qj
         hlCm9pK52Hp5IwzpUdrD63obx9XVleaTKCV+Bv7pi3gYIPgYOAL5rRX8XaSCEVZUTdy8
         EF3bO5uQ/jZcWq2En3aLDGefgWrL0mI1XZWagj+T/bBJK9EbP8UHvMzEhad6qFnEQ1LA
         TtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gE3oWxnnXLLHTsR3mJhrRV69ZxS3O1Biyw7y99QvNoo=;
        b=Fry27Ekoja/PAtbfgIIF7XYQQZPdNWrIsi6vZww6QYwf5i9GC5zsxFR5cnXcnBuuYh
         7e9fRGRKlZxLWbrXVwbChiGP7QMB2UsdrF+PGVLiYr6sLTRmEpBLe2hHwI11QFv0Kihz
         kbpp3PdYJSwJU2eT9aVrB2Qk74q5DC90g/JKzwPcOrCWzgba8vK40bOjb0hkVgmmuo3o
         2fdA0le0g8fNOM3rAWf18wSwXSLaZXHknhCpaVGJkmjv/o9N10xIMEc7zoyOy+e2l1+4
         S5eajIP3OVTVwCeFqvYaNjDHb8a7NsAKOk9KAjACFVZ1yHxOZ2y7SlXRPRs3LlnCnOGO
         1CCA==
X-Gm-Message-State: ACrzQf3UnrviXNyN/zDbGPxVChM3+T92XgWRiKyipPhxjw10HTbDcAA/
        IjNMdvYhZdYY+BI42puPPD66YMWFAbF1wzQZC97kVw==
X-Google-Smtp-Source: AMsMyM6pm8nz0k72B/6ClTpJ5niBs03JV5WyzzqoXVahZ3nNAYQb7BxmD0yD73ddUzP+o7U7t9ODpxDnH62ADebzAHo=
X-Received: by 2002:a05:6122:250:b0:3a2:4919:98c3 with SMTP id
 t16-20020a056122025000b003a2491998c3mr5847567vko.30.1663597718020; Mon, 19
 Sep 2022 07:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com>
 <xmqq1qsge71x.fsf@gitster.g> <xmqq35cwcpws.fsf@gitster.g> <xmqqillrb7qs.fsf@gitster.g>
In-Reply-To: <xmqqillrb7qs.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 19 Sep 2022 16:28:25 +0200
Message-ID: <CAFQ2z_PBWbdKgbaqLO6iXB8WEhG=CTjetrEgm7wHacDi_n8VHw@mail.gmail.com>
Subject: Re: [PATCH] refs: unify parse_worktree_ref() and ref_type()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2022 at 5:43 PM Junio C Hamano <gitster@pobox.com> wrote:
> then a better approach would be to have a small helper
> parse_local_worktree_ref() and make the primary one into something
> like
>...

Thanks, good idea. I'm sending you a v2.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
