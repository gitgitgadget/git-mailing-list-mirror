Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A6C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 00:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbiFOATz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiFOATz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 20:19:55 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F3D3F8B2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:19:52 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id y63-20020a638a42000000b003fd47b6f280so5707398pgd.12
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=vwWIaKORuhE9nR6TEeLwNM2C272S/M41/mVUtKQAGOQ=;
        b=tBIVRhaBYM/Tm/OKYl7nVlybye7dYjxikdqXMFSxVfVzHqADGULF465Cd9rC4oQKBd
         GuyBqshwGikdGUXlhx1yWEP4Wz35/exU58HcQEYnKoEtlJV880qfiupNPTvzzKO8V1I8
         sRTPEp76pgDz+5vdduPJvPgq5I5zEBLVoiBrMOOLziTqMa7TQjTx5beREuBOTsg+Ib5p
         HwXBRJ1UYhd4C6gRcvUZKSP/va/mrLAvC13ycm8Oipi74dt2L9Lk64qtiWXsQutau6xP
         KXEW/icEmV8Lsj3OIJ6HpOX8HVemCooMogYsN0+HMP3HWlvELCBk/zTk/ov8Knvsn30I
         itNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=vwWIaKORuhE9nR6TEeLwNM2C272S/M41/mVUtKQAGOQ=;
        b=CLU02Kp/9aVxKP/LS1Z7ESDC9J0vhC0slL2ay/73HRr08gcOLGTDfNZazSdRv40w+c
         Pd5DEvf1ORN590Hu5TbgJanaJjlqM9PT5MnRQvQi9e8GiU2EXGhU/p3Bvn70YhFAPW2C
         iGyCIAUwWg3J0k2e+RyzWThLG/csKe00M1GTBB3mkRQshHOGuXLQKq2FFTkvNlVmFr2R
         p0NkZpJaJ1sq1iLZNFVSIAtAcSdcywjtsLaZZVr8a4JN13eucQ7FDFvaPxH+xrb7gTzD
         VBFnDKEhOVp1M4WSw0SxP8MXX7ki4ewnPVR2ObQz/gQIq/4TiuSTdlpD2Kube6PjbayZ
         sRPQ==
X-Gm-Message-State: AOAM5317HubbA+4VzBr3KsbTrj+eELt4NImSebULYUeiP4ksHLXOH+C0
        Uovxtvr4BD4noe4J2uZ6ByBcq9iasnB5tw==
X-Google-Smtp-Source: ABdhPJwyoJEuzMmbm/+RjbBElRpX3HYazUr6RzMfX7hutrySICDUCc3CZ/nVw1er3kgDjBs/vm+lVipsoILbxw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:9a7:b0:51c:3e28:1501 with SMTP
 id u39-20020a056a0009a700b0051c3e281501mr7106969pfg.86.1655252391681; Tue, 14
 Jun 2022 17:19:51 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:19:50 -0700
In-Reply-To: <patch-v2-05.12-ef3265a588e-20220613T220150Z-avarab@gmail.com>
Message-Id: <kl6llety6amx.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com>
 <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com> <patch-v2-05.12-ef3265a588e-20220613T220150Z-avarab@gmail.com>
Subject: Re: [PATCH v2 05/12] submodule--helper: have --require-init imply --init
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> [...]
> We'll still need to keep the distinction between "--init" and
> "--require-init" in git-submodule.sh. Once cmd_update() gets
> re-implemented in C we'll be able to variables and other code related
> to that, but not yet.

Small typo maybe?

  re-implemented in C we'll be able to *change* variables and other code
  related to that, but not yet.
