Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBBBC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFA261288
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbhDLLF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbhDLLF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:05:26 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43CFC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:05:08 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id x14so1705042vsc.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hr+0edRUxpm0Telap3Qqx/eUCwBAv/ysJz6E8+LS+1I=;
        b=S6xy3/VIKpX1nSaENwfxy7kz0qoERMxjqgDkFlfxAsFfkhi5RwqbeHO/wTW0y53mVa
         meapsGRlO4IVsI7Jcdj90FUiGPQWLlzrJMPUYnYPrHiroItjtOTPsCQwz6fQp2X0dYRC
         E803uF17qnrBYE8OMUZHiz2NMwdKfBs9YZojOdQnPH2Suxh69lYk2aYE44z7fslq1oZ7
         EJtpnDHm4+ypMTBhmbsmnwtdmD0kV2dOwULfO4QxePX89bl6YNUs73Up0uO0ojragEJW
         s3RvVk/VBEj5qZAeCOG3diENhApObBw5XAz2G08vpN6LUFc0BBZGh0CcZFGWho7dFsWk
         ebQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hr+0edRUxpm0Telap3Qqx/eUCwBAv/ysJz6E8+LS+1I=;
        b=kIuojmxITXmFp8fcVSo03HdU11VnMl8+qC0e/Aac1P2XX9w7syyZJfjT5bm97PalHM
         sWYRIbuIG68u7avZbgU1SeDsgLi58YQxvmRBSP8iIBPd+N8YCNsF7NIp7eQqPEajX1Gi
         FDog7791KVanXaPZe/76YKiis40nLIw2MoAeYqBJeUiN5KZASGrrba21Bch4Av/MSlHB
         to9BqBm5+rB39eeJAU9qLyOGCjxlOl8Cce8dzR9jSlz+bwDdShGzjyNg14eURkiocEkL
         LWUCB7HP/32MZ6vpo3pvO9EsMqkoN8ZWh4WLRfWN2RZwbdqUoBgBRZvTqkk/gbeqxnay
         mJBg==
X-Gm-Message-State: AOAM530j3pf4aebiqO/btr8SzYiFADuC4Jx9hwFyg2xYHT0jye6bkFGu
        5ZPZIitCFKoNcx4Sp1rLQKoAZlHEwyPu7ZAXoz9YsA==
X-Google-Smtp-Source: ABdhPJyHE6Qy57SgLeRUn3Ao82dFDIpf6HilnkP60se3o9bA1bM7RTzgdGzKcwJWVsdY1virGxKETQkLCzqHu0tvK7I=
X-Received: by 2002:a67:e34e:: with SMTP id s14mr733122vsm.50.1618225507790;
 Mon, 12 Apr 2021 04:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqk0pcqtxf.fsf@gitster.g> <CAFQ2z_NQdGfxUSd7kVvWaT-HG_-LSwM_WG+GqJj9fjky0F=ZTg@mail.gmail.com>
In-Reply-To: <CAFQ2z_NQdGfxUSd7kVvWaT-HG_-LSwM_WG+GqJj9fjky0F=ZTg@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 12 Apr 2021 13:04:56 +0200
Message-ID: <CAFQ2z_P=MqT81gLjov6A471Z9sd69qQTep8KG8M8=LO9pJtkpQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2021, #02; Thu, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 12:59 PM Han-Wen Nienhuys <hanwen@google.com> wrote=
:
>> * hn/reftable (2021-03-12) 15 commits
>>  - Add "test-tool dump-reftable" command.
>>  - git-prompt: prepare for reftable refs backend
>>  - Reftable support for git-core
>>  - reftable: rest of library
>>  - reftable: reftable file level tests
>>  - reftable: read reftable files
>>  - reftable: write reftable files
>>  - reftable: a generic binary tree implementation
>>  - reftable: reading/writing blocks
>>  - reftable: (de)serialization for the polymorphic record type.
>>  - reftable: add blocksource, an abstraction for random access reads
>>  - reftable: utility functions
>>  - reftable: add error related functionality
>>  - reftable: add LICENSE
>>  - init-db: set the_repository->hash_algo early on
>>
>>  The "reftable" backend for the refs API.
>>
>>  What's the status of this topic?
>
>

(now without HTML)

I have an update in the pipeline that will address stale files on
Windows, and I can explode the series further. However, it is
fundamentally blocked on someone willing to spend some time reviewing
the series; this seems to be out of my control.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
