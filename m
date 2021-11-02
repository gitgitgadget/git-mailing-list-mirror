Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E8BC433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 00:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB0E60F5A
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 00:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhKBAgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:36:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51003 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhKBAgl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 20:36:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30D0DFBB60;
        Mon,  1 Nov 2021 20:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XiA2BNbr63ytw8FBsHI3tr88zsPpkTDr16PE+w
        +AKqc=; b=BkQIy8cM4YM0A2nHgG3xQDAijMGcRZtEdBmdDoev4rorPuSF9dlMPe
        zxNah1GUmFTrOT5SrvZ+Cppir9qo0JQY7guE4CtgCXzuRMP4N2ycOMNS2Zezj8zO
        BXQCEJ1pT5G4/VeLYdecKhLDcUzIHr6a5Zr07u01Hoy+dsFQ/cfME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26672FBB5E;
        Mon,  1 Nov 2021 20:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33C2EFBB5C;
        Mon,  1 Nov 2021 20:34:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com, <jrnieder@gmail.com>
Subject: Re: [PATCH v4 04/13] dir: fix pattern matching on dirs
References: <kl6lzgqnv2dn.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 01 Nov 2021 17:34:05 -0700
In-Reply-To: <kl6lzgqnv2dn.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 01 Nov 2021 17:15:48 -0700")
Message-ID: <xmqq7ddr9z0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 961D0036-3B74-11EC-AE60-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> This patch changes the behavior of .gitignore such that directories are
> now matched by prefix instead of matching exactly.
>
> The failure that we observed is something like the following:
>
> In "a/.gitignore", we have the pattern "git/". We should expect that
> "a/git/foo" to be ignored because "git/" should be matched exactly.
> However, "a/git-foo/bar" is also ignored because "git-foo" matches the
> prefix.
>
> I'll prepare a test case for this as soon as I figure out how to write
> it..

FWIW, reverting this commit (and nothing else) from 'master' does not
seem to break any test.  That does not necessarily mean much (it may
be indicating a gap in the test coverage).
