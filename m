Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2CDC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 19:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbiBJTXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 14:23:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiBJTXf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 14:23:35 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D682B1020
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 11:23:36 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FA521197EE;
        Thu, 10 Feb 2022 14:23:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Uow9RJhpskl3
        gwqSzA0QMB4FpRyxjfBRr+QDlTJ/CcQ=; b=Enutc+Pyw+R+ey39gfNu0WeO/KFJ
        NTR2PYQtr9Km2M1yRHS+9ODN93X//j93Zu52tEvfNgE8bW7d9LsWrTfhgt2Qf/7N
        0Jt1yiOPOTg3iF0nZhZ/ngtZ7frM8ohrCTkKAkEs+y6xxvnGOZzv4/QolbpWMCsz
        h079DDLdLdxahMQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 242121197ED;
        Thu, 10 Feb 2022 14:23:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8670B1197EC;
        Thu, 10 Feb 2022 14:23:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
        <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de>
        <xmqqbkzigspr.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2202081406520.347@tvgsbejvaqbjf.bet>
        <xmqqbkzhdzib.fsf@gitster.g>
        <b49d396d-a433-51a4-2d19-55e175af571a@web.de>
        <xmqqk0e364h7.fsf@gitster.g>
        <6f3d288a-8c2f-0d63-ea17-f6c038a9fa3e@web.de>
Date:   Thu, 10 Feb 2022 11:23:34 -0800
In-Reply-To: <6f3d288a-8c2f-0d63-ea17-f6c038a9fa3e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 10 Feb 2022 20:10:35 +0100")
Message-ID: <xmqqk0e2frux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F1175C08-8AA6-11EC-86D3-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> Yes, which is exactly how this (and existing --add-file) makes
>> Konstantin's plan much less useful.
> People added untracked files to archives before --add-file existed.
>
> --add-file-with-content could be used to add the .GIT_ARCHIVE_SIG file.
>
> Additional untracked files would need a manifest to specify which files
> are (not) covered by the signed commit/tag.  Or the .GIT_ARCHIVE_SIG
> files could be added just after the signed files as a rule, before any
> other untracked files, as some kind of a separator.

Or if people do not _exclude_ tracked files from the archive, then
the verifier who has a tarball and a Git tree object can consult the
tree object to see which ones are added untracked cruft.

> Just listing untracked files and verifying the others might still be
> useful.  Warning about untracked files shadowing tracked ones would be
> very useful.

Yup.

> Some equivalent to the .GIT_ARCHIVE_SIG file containing a signature of
> the untracked files could optionally be added at the end to allow full
> verification -- but would require signing at archive creation time.

Yeah, and at that point, it is not much more convenient than just
signing the whole archive (sans the SIG part, obviously), which is
what people have always done ;-)
