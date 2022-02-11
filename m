Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926C6C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 21:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240745AbiBKV1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:27:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiBKV1N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 16:27:13 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA3CC5D
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 13:27:11 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9622123E46;
        Fri, 11 Feb 2022 16:27:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Vn1Ah2Vmu0cR
        PQzPi5sSxaix6NGVhh+rA57C4bLBoFs=; b=Le+iO4hTwd0UKxKgHf8+IAl77fv9
        ywrfDmPTusQTu6jTys1LESN6+jdlVNCgCH7g5Gi0RFkg50ziuqrWbM7jPRTHiTVr
        gm7Cr0Vz17RzmXATKZo6PaL+fLP+DRptjASK7eDkhCs4wcvXllF/rtpUWapUAQLx
        p5m8XBvAY6Nkzj4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4D3C123E45;
        Fri, 11 Feb 2022 16:27:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6E51123E44;
        Fri, 11 Feb 2022 16:27:07 -0500 (EST)
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
        <xmqqk0e2frux.fsf@gitster.g>
        <f83ed995-6dff-bc41-8782-48ac9f1a2651@web.de>
Date:   Fri, 11 Feb 2022 13:27:06 -0800
In-Reply-To: <f83ed995-6dff-bc41-8782-48ac9f1a2651@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 11 Feb 2022 20:16:43 +0100")
Message-ID: <xmqqk0e19jrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5D998718-8B81-11EC-B4D4-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> Or if people do not _exclude_ tracked files from the archive, then
>> the verifier who has a tarball and a Git tree object can consult the
>> tree object to see which ones are added untracked cruft.
>
> True, but if you have the tree objects then you probably also have the
> blobs and don't need the archive?  Or is this some kind of sparse
> checkout scenario?

My phrasing was too loose.  This is a "how to verify a distro
tarball" (without having a copy of the project repository, but with
some common tools like "git") scenario.

The verifier has a tarball.  In addition, the verifier knows the
object name of the Git tree object the tarball was taken from, and
somehow trusts that the object name is genuine.  We can do either
"untar + git-add . && git write-tree" or its equivalent to see how
the contents hashes to the expected tree (or not).

How the verifier trusts the object name is out of scope (it may come
from a copy of a signed tag object and a copy of the commit object
that the tag points at and the contents of signed tag object, with
its known format, would allow you to write a stand alone tool to
verify the PGP signature).

Line-end normalization and smudge filter rules may get in the way,
if we truly did "untar" to the filesystem, but I thought "git
archive" didn't do smudge conversion and core.crlf handling when
creating the archive?


