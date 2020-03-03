Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E792C3F2D7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9FC20863
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xwq+zXcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgCCOUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:20:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55859 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgCCOUi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 09:20:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41EFFC785D;
        Tue,  3 Mar 2020 09:20:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oIhqA51AS3so
        dncBFQuJPZfxUQI=; b=xwq+zXcGkaPC7tVDR6Voosrft+qpHBnREHDcqcsLARt9
        NddXdamabIhX5PYzRoT3WO8ahNuJ1Uuly2SI7q7DUcnMJ4FEJxTfpVYJTPhma6GQ
        qnsOEPGmf4Rw0hupNH9DTCv9DDyFET2JH3n0+yL46hk7BI+hQuZ23NzyB51BDgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CPdkgB
        GMHTrmyBEKzAXfyZxypUIpNXHkSGPiOrPsKNwIhPvaHzA447TYZtOq2kKBsQBsA2
        M27G3grfnZtzqu8PGl9k1eWtWAkml+CqcFPGKA6uj3r4wNmcpDyE8CqhQFG6VnCU
        o+Tm7wh8OwXiFlL4tTwg0eFvMzQRzPy/3/m9Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 393D0C785C;
        Tue,  3 Mar 2020 09:20:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 63346C785A;
        Tue,  3 Mar 2020 09:20:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Ralf Thielow via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase-interactive.c: silence format-zero-length warnings
References: <pull.567.git.1582835130592.gitgitgadget@gmail.com>
        <87196142-8473-7d19-4edd-7452eaefda1c@gmail.com>
Date:   Tue, 03 Mar 2020 06:20:32 -0800
In-Reply-To: <87196142-8473-7d19-4edd-7452eaefda1c@gmail.com> (Alban Gruin's
        message of "Tue, 3 Mar 2020 11:17:46 +0100")
Message-ID: <xmqqh7z5a5an.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2568016E-5D5A-11EA-AC1B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>> Fixes the following warnings:
>>=20
>> rebase-interactive.c: In function =E2=80=98edit_todo_list=E2=80=99:
>> rebase-interactive.c:137:38: warning: zero-length gnu_printf format st=
ring [-Wformat-zero-length]
>>     write_file(rebase_path_dropped(), "");
>> rebase-interactive.c:144:37: warning: zero-length gnu_printf format st=
ring [-Wformat-zero-length]
> ...
> On a tangent: what's wrong with empty format strings?

Those functions that are truly printf-like, such a call would be
no-op and an indication of possible typo ("did you forget a %s or
something?"), I presume.

But many of our functions that take printf-like format strings will
do useful things even when an empty string is given, so the warning
is unwanted.
