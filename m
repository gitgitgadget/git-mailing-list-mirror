Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF6EC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbiBHBFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbiBGXaq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:30:46 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BCBC061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:30:43 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56F2811BA27;
        Mon,  7 Feb 2022 18:30:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IMch9IwPUF0u
        S85ARXQ0J6giBdCjAYM8zzQFFVtZ7s4=; b=wrMhyFsIAz+bnAISGER9HpMzA2ps
        SNoj4Dqoif5ptTXC0i0D2Lx/e7AoOZsrZxtOrnRWAnZhUIBU6cHHeEY1pxdDxHdJ
        DbN5fnCqmW5AiX9F2TZuIq2/tZhmcHS3VyNtHuTQ1w3FTr7AOba6OqJMpsypa4zc
        Z9b9LfTQ7Y0nLlE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DD8011BA26;
        Mon,  7 Feb 2022 18:30:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD6FF11BA25;
        Mon,  7 Feb 2022 18:30:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
        <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
        <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de>
Date:   Mon, 07 Feb 2022 15:30:40 -0800
In-Reply-To: <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 7 Feb 2022 20:55:02 +0100")
Message-ID: <xmqqbkzigspr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F6EE67EC-886D-11EC-8B93-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> We could use that option in Git's own Makefile to add the file named
> "version", which contains $GIT_VERSION.  Hmm, but it also contains a
> terminating newline, which would be a bit tricky (but not impossible) t=
o
> add.  Would it make sense to add one automatically if it's missing (e.g=
.
> with strbuf_complete_line)?  Not sure.

I do not think it is a good UI to give raw file content from the
command line, which will be usable only for trivial, even single
liner files, and forces people to learn two parallel option, one
for trivial ones and the other for contents with meaningful size.

"--add-blob=3D<path>:<blob-object-name>" may be another option, useful
when you have done "hash-object -w" already, and can be used to add
single-liner, or an entire novel.

In any case, "--add-file=3D<file>", which we already have, would be
more appropriate feature to use to record our "version" file, so
there is no need to change our Makefile for it.

