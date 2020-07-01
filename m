Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF66C433E1
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F008207FB
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 16:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp1ifF6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732166AbgGAQOH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgGAQOH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 12:14:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE87C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 09:14:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z13so24649225wrw.5
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AmsiYNE7WLZkOeF8omYW4KWeVmLyoPtFWI6SVOjFXpk=;
        b=Rp1ifF6puKbYd0nLV8/3b46fU3KAH1ZqipHD1Zf4+IxRBZ7zcQX9O+zvb2EeIIw4MS
         ZCXlEtQA/etXH9O2+FrOEGZOE02qSOqBgVUddMEToa0t2QO1MiVt38MxKn3b8anWrKKD
         +GsJgPvx1vNFsyeMYElbguXRlhlpY2rVD+PL0IJT9BXCMAofFF0dUib5RZZuqfD7l3ka
         t2VKvIsDoIkij2i6wM8oJhpmYEDn86T4bNrc7CkxRRtSMO8BlgUHmuKO62dsnnXIHqbP
         BP13joZj++bd1zW3iUfDPhFeFCb0yS9pNW3ytWiK216LoG6PeeZJlWdlH8qt7VZ6hqkJ
         LYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AmsiYNE7WLZkOeF8omYW4KWeVmLyoPtFWI6SVOjFXpk=;
        b=pE2khlVtKzkec6ByDJw/0x3k2dsw1T8c1HdsTbc9pJJ8I7+JF9sw43NdlWhqp0JSHh
         t1BoSPgUUDz52Hbenja1kzn6JDZ3+CWcXzJ7D36EEWGvraZHvjno97iYfQg2Td4rdjBF
         4OGrbmdXfcpuWj45yDdOkuZESuvBSfVvxXpMGtgzT7xv37nFBIpRpZDBlxR7bs2YOX3I
         3nJ39fGZ53zSE16weCLIYxNFXQLJi0tSgqW4FbR0WxgZjkTwoU0jHwQ458AUGKJd+bk+
         IlVqyrdjRAp2jhzj7WFLdAxy1+TROBbs5QI7ZcIKVn8AI2cbnRej1Biye9N6ulEgsDfE
         pgVw==
X-Gm-Message-State: AOAM530MnkclZTGedpjoNmgR9doXqjFr+TdW9faDO8eeo2WBH0X+gd+q
        xCic3d7PKIyAjp+IDBevvXw=
X-Google-Smtp-Source: ABdhPJyVrNyafx09gQvE6CClsodetkQYEP23caL3hUPSalg5EWiN/MwomcDbsiEjDxn6KMojTrWIOQ==
X-Received: by 2002:adf:ff8d:: with SMTP id j13mr26679828wrr.11.1593620045678;
        Wed, 01 Jul 2020 09:14:05 -0700 (PDT)
Received: from [192.168.1.116] (2-229-250-51.ip199.fastwebnet.it. [2.229.250.51])
        by smtp.gmail.com with ESMTPSA id z132sm7697416wmb.21.2020.07.01.09.14.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 09:14:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Built Git 2.27.0 from sources on macOS Catalina fails on "make
 profile"
From:   Fabio Frumento <frumento.fabio@gmail.com>
In-Reply-To: <20200701161018.GD6726@coredump.intra.peff.net>
Date:   Wed, 1 Jul 2020 18:14:03 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C72555F0-4CAE-4488-B32E-FD06D1204935@gmail.com>
References: <618374D7-60E1-4942-B29F-4F2EA261996F@gmail.com>
 <20200701153726.GC6726@coredump.intra.peff.net>
 <E9210645-66F4-4B76-BB26-C8282AE23B3D@gmail.com>
 <20200701161018.GD6726@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You got it!

++ test_must_be_empty err
++ test_path_is_file err
++ test -f err
++ test -s err
++ echo ''\''err'\'' is not empty, it contains:'
'err' is not empty, it contains:
++ cat err
LLVM Profile Warning: Unable to track new values: Running out of static =
counters.  Consider using option -mllvm -vp-counters-per-site=3D<n> to =
allocate more value profile counters at compile time.
LLVM Profile Warning: Unable to track new values: Running out of static =
counters.  Consider using option -mllvm -vp-counters-per-site=3D<n> to =
allocate more value profile counters at compile time.
LLVM Profile Warning: Unable to track new values: Running out of static =
counters.  Consider using option -mllvm -vp-counters-per-site=3D<n> to =
allocate more value profile counters at compile time.
++ return 1
error: last command exited with $?=3D1
not ok 5 - pretend we have a fully passing test suite

Ok now I know I have to solve the LLVM generating this issue.

Thanks a lot

Fabio

> Il giorno 1 lug 2020, alle ore 18:10, Jeff King <peff@peff.net> ha =
scritto:
>=20
> On Wed, Jul 01, 2020 at 06:00:49PM +0200, Fabio Frumento wrote:
>=20
>> I get several messages like this
>>=20
>> LLVM Profile Warning: Unable to track new values: Running out of =
static counters.  Consider using option -mllvm -vp-counters-per-site=3D<n>=
 to allocate more value profile counters at compile time.
>=20
> That could be related. I don't know enough about llvm's profiling to
> say. If it's just a warning and not terminating the process, that =
might
> be OK. But some of the tests check the stderr from Git. If the =
profiled
> binaries are producing extra messages, that could cause a problem (and
> it looks like t0410.15 that you posted does make sure stderr is empty,
> so this seems a likely culprit).
>=20
>> I=E2=80=99ve checked the scripts in the t folder, they use #!/bin/sh =
while
>> I=E2=80=99m using zsh could  it be of some relevance? Which shell are =
they
>> supposed to be run?
>=20
> They're generally run with whatever $SHELL_PATH is set by the Makefile
> knobs, which defaults to /bin/sh. The interactive shell you're using
> shouldn't be relevant.
>=20
> -Peff

