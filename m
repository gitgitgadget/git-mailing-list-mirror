Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599FFC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 16:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408956100C
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 16:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhGTP2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 11:28:13 -0400
Received: from m12-12.163.com ([220.181.12.12]:53439 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239148AbhGTPPX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 11:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=uMHp1
        D5cXnnwXbHD9Lc8ZFCb3BIZxksHPAaQ/68dM+U=; b=JlyJ3Lw4abbwPIZ8d8Vin
        dsT8sz8U+Ci6JA73GFFBxwdFIgy9BmEfllRrGj4eg8Y5ji1SI2SD2YEXgUkYi+2B
        z3MbBE8yDpcI/JOmbETi2wuRYSGd+a6vdyk7pC5bsSsHQT0KnJiVxyXCZH8GwKcC
        +JRB5/XNuffNEiK4RnEDRA=
Received: from smtpclient.apple (unknown [115.198.205.80])
        by smtp8 (Coremail) with SMTP id DMCowAAHtlKd5vZgqnFVPw--.29783S3;
        Tue, 20 Jul 2021 23:07:10 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3] packfile: freshen the mtime of packfile by
 configuration
From:   Sun Chao <16657101987@163.com>
In-Reply-To: <xmqqlf61j19i.fsf@gitster.g>
Date:   Tue, 20 Jul 2021 23:07:09 +0800
Cc:     Taylor Blau <me@ttaylorr.com>,
        Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Martin Fick <mfick@codeaurora.org>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <60EFBDBF-8A9F-4004-82C1-C7C1E9D1778E@163.com>
References: <pull.1043.v2.git.git.1626226114067.gitgitgadget@gmail.com>
 <pull.1043.v3.git.git.1626724399377.gitgitgadget@gmail.com>
 <YPXluqywHs3u4Qr+@nand.local> <xmqqlf61j19i.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-CM-TRANSID: DMCowAAHtlKd5vZgqnFVPw--.29783S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1DGr18GFyUuFyrtr1kXwb_yoWfGFg_WF
        Z2vasrXrs0gFykJr4qkr47KFWkJF48G348J34jgrs8t34kZFs8GFn0g3s09F12ka109Fya
        vrZIq3ySv3yUWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0-6pDUUUUU==
X-Originating-IP: [115.198.205.80]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiDx7VglUMY3IRrwAAsw
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> 2021=E5=B9=B47=E6=9C=8820=E6=97=A5 08:07=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Taylor Blau <me@ttaylorr.com> writes:
>=20
>> Hmm. I'm still quite unconvinced that we should be taking this =
direction
>> without better motivation. We talked about your assumption that NFS
>> seems to be invalidating the block cache when updating the inodes =
that
>> point at those blocks, but I don't recall seeing further evidence.
>=20
> Me neither.  Not touching the pack and not updating the "most
> recently used" time of individual objects smells like a recipe
> for repository corruption.
>=20
>> My opinion is that it is not, and that the bizarre caching behavior =
you
>> are seeing is out of Git's control.
>=20
Thanks Junio, I will try to get a more detial reports of the NFS caches =
and
share it if it is valuable. Not touching the mtime of packfiles really =
has
potencial problems just as Taylor said.=

