Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB5C432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 14:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1042230E
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 14:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBOBwoOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfKTOW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:22:27 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:38189 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfKTOW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 09:22:27 -0500
Received: by mail-vs1-f41.google.com with SMTP id u18so16174093vsg.5
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 06:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TYHpyANurRVnriXw9VAWwpAlxTp+c6e7XNnm4IPGS+I=;
        b=SBOBwoOQ3RTy2CxOSElDs4avANAv1KbEWG9qVXUxme3MbyWT7nUgTUSdOoxII2Laqm
         q87unqxlEdb6gd0dkTMcx2nr3rwnvsgoqRtjQ7v+tNFF/kTnwj7SqeRhZ4mQOmn7CoMy
         K1gdY3Vwmd5f5QAsiIlsJQNXPptwLS3V4mfDAF+TRtJOMJBE3n6zEvQ9W/+1J8mVY/KF
         pKaFL/ecJYYJMPKPuJRWZjU2DhfrcY/p5DSSAetu6passHScY60ihGkzvmHV31lwKKkJ
         1w+pXg6ffxsFXjCHD3NLzqv60sMfBLnmqWK4YknwZi2DsvNrs0+vd94V3dv7kw23U9eM
         HOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TYHpyANurRVnriXw9VAWwpAlxTp+c6e7XNnm4IPGS+I=;
        b=fvZPAXaC4qoEzl8kcqiepHnZFh41ionB/GSzC3IZHzSlpYvCiXJ3lT9Sjea0kKChYj
         jZwkCO0l7ER7R4jA9+BnEeW/VAEb12cKB8vquWHkgeT4hSulClLipIKuBua8f7sWiEPQ
         egxZk0TM8YCLFBY65XpnF84Tv/NsfSxpMxiJ0TGBl2/aDkgVx/tCm0IPCmT6n4IvF1eS
         IgVNrhdLLESiQhYSYrsNu5kH1DFF1I6RiSz5z+YmrxD9dIYQGRoGhnJW5IchPyGjcOiy
         9HH8COUvC+5AWQLsIkMHNhDifd8FSN9MXhQew++/9BLA53lRbp3rZs2XgTcpPsHo0QhK
         jwYQ==
X-Gm-Message-State: APjAAAX0h/r9JWhQk3K9OweBwo6g4pB+6F4n4x7kT/mGcIHwa1YC6MUB
        C1MFFKZem3TZsunUgwPaPNxd/kMNDh+02U/ONdIbSg==
X-Google-Smtp-Source: APXvYqxRa4vE7IbNo4GbAozg/qccPbU7HxdF+P4yxoFa4Zp4mSDSbpY3uPDQFQ5+XFeNFXbyeZ32PKMMtP6EXFOCgF0=
X-Received: by 2002:a67:ee13:: with SMTP id f19mr1813646vsp.49.1574259745688;
 Wed, 20 Nov 2019 06:22:25 -0800 (PST)
MIME-Version: 1.0
References: <CAFQ2z_Pe1Pdjy22VmCMzf4Gvx3wte1eQRn_PjSisJbr9_y7bbg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1911201247410.15956@tvgsbejvaqbjf.bet> <CAFQ2z_PiuFe=ZKNaZG3=2AqjcNRb-k5-CYSXeN6MQ0r5sv4S=g@mail.gmail.com>
In-Reply-To: <CAFQ2z_PiuFe=ZKNaZG3=2AqjcNRb-k5-CYSXeN6MQ0r5sv4S=g@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 20 Nov 2019 06:22:10 -0800
Message-ID: <CAFQ2z_PBPPQuJYA-mvKz532GikBXureOi1ePr7YdBRJbxOJCeA@mail.gmail.com>
Subject: Re: Reftable format implementation in C and Go
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 20, 2019 at 6:19 AM Han-Wen Nienhuys <hanwen@google.com> wrote:
>> Would you mind, however, to relicense the code under a license compatibl=
e
>> with GPLv2? Currently your code is under the Apache License (which I hea=
rd
>> somewhere is probably incompatible with the GPLv2 used by the Git
>> project):
>> https://github.com/google/reftable/blob/6cd8dbb4106d18627f442d3148de71d7=
db43d4b6/c/api.h#L1-L13
>>

according to our open source lawyers, Apache is actually compatible
with GPLv2, but I think we could dual-license the code.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
