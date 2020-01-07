Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F37C33C8C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 17:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0958208C4
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 17:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AFS3LQt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgAGRBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:01:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57238 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgAGRBR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 12:01:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE0B22BF4A;
        Tue,  7 Jan 2020 12:01:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cKFmDxe0rLO3l0sx/+PMBsD46os=; b=AFS3LQ
        t+TviYANWTa3ehSgSBJ5uWhSLB5Ix4UC8OkC1hN5eoNJUV5+vdN29jcQRKI5Qiwu
        PViVWS93bwZOQdkWdC4yhFN3vs2Z21OazJgIDCBf4ymb6atoBZUsVVC87x9Ztajb
        cNewcPh2jxYRE4Ael66M+Rlj1EPZGibgPNIbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LJjNN3ub8uLZdj0mUedImnDygX2rGFvU
        fC8cqaFA+Gdt3slgd8vUKOoVbGRp+oWeE8y2kpxlMFZICnt9bSCfo7hGkBxUBhNo
        Ue/NNHcToq7Pxn1lbLWKkwdvsvROx9Ph5DxqdffqknpFSk48BYuTHNuyXHJmbudT
        vbTnGfgcZ1o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3A3E2BF49;
        Tue,  7 Jan 2020 12:01:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26B8C2BF47;
        Tue,  7 Jan 2020 12:01:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Liam Huang via GitGitGadget <gitgitgadget@gmail.com>,
        Liam Huang <liamhuang0205@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/1] Update imap-send.c, fix incompatibilities with OpenSSL 1.1.x
References: <pull.516.git.1578391376.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2001071313580.46@tvgsbejvaqbjf.bet>
Date:   Tue, 07 Jan 2020 09:01:14 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001071313580.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 7 Jan 2020 13:19:24 +0100 (CET)")
Message-ID: <xmqqv9pn5hgl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 509C1184-316F-11EA-AD1B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Liam,
>
> On Tue, 7 Jan 2020, Liam Huang via GitGitGadget wrote:
>
>> Some APIs have been changed since OpenSSL 1.1.0, so fix incompatibilities
>> with OpenSSL 1.1.x.
>
> In your PR, the "Checks" tab shows that this breaks the build for all
> non-32-bit Linux builds and for Windows. Here is an excerpt of the failed
> `linux-clang` build:
> -- snip --
> ...
> Could you fix those compile errors, please?
>
> While at it, please also fix your author email: it should match your
> _real_ email address, i.e. "liamhuang0205@gmail.com", not
> "Liam0205@users.noreply.github.com".

Also, please do *not* CC iterations of a patch to me that hasn't
seen a concensus that it is a good idea on the list yet, unless
you know I am the area expert and am interested in seeing it.

Thanks.
