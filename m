Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68DDC38BE2
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503FF21556
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 20:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HXntgfXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXUUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:20:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62531 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBXUUS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 15:20:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C96FF51BC7;
        Mon, 24 Feb 2020 15:20:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4BMD1/8z6D26z7RL57IV1V19zRM=; b=HXntgf
        XsqkDtKockaGxCjnSGQ1FZSm0Ui6lSukGyn4OXqadUuTmMMFb+ZPqZyJFHdiap+T
        NgRopJNhIFHIfi4IBgIl920nBaUBggkFjVCsAN1ThioSi8jF2rsIlsaos44kQdeE
        EcqLYt0PZJf8HmgEy7Z28JCzAp+3DRAIYh7yE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qZG/7aPw9WLevzQlxsxAr/HtUeaikvKK
        vcmOqKaTNvOWP/4lwRomyIRBWCWOZn82X92NltrsglgKhGsmjaJDEhLzc9EZuyF1
        duGLx3MIou3Cfl2RB48KYDdVZjdIncgdl9fldKF2EGyRGQvFpbu7FfxfCP9xWzmZ
        k34dxQ2fPXE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF92051BC5;
        Mon, 24 Feb 2020 15:20:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D60651BC4;
        Mon, 24 Feb 2020 15:20:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] worktree: drop unused code from get_main_worktree()
References: <20200224015935.19190-1-sunshine@sunshineco.com>
        <20200224064049.GD1015967@coredump.intra.peff.net>
Date:   Mon, 24 Feb 2020 12:20:13 -0800
In-Reply-To: <20200224064049.GD1015967@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 24 Feb 2020 01:40:49 -0500")
Message-ID: <xmqqh7zfpwjm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 113F63E8-5743-11EA-B256-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Feb 23, 2020 at 08:59:35PM -0500, Eric Sunshine wrote:
>
>> This code has been unused since fa099d2322 (worktree.c: kill parse_ref()
>> in favor of refs_resolve_ref_unsafe(), 2017-04-24), so drop it.
>
> Looks obviously correct, unless we are depending on some side effect of
> get_git_common_dir(). And if we are, then that should be fixed. ;)

Heh, get_git_common_dir() could be implemented to have some "setup"
kind of side effect for the first call to it, but what is removed is
the second call ;-)  Besides, the body of get_git_common_dir() is a
mere three lines that does not have any side effect, so...

