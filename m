Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C388C433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD6660F5D
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhJWVz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 17:55:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54732 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhJWVzz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 17:55:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80EC3E9B03;
        Sat, 23 Oct 2021 17:53:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ad87Ax7eNfhAy2Mxd5+HoIPSg6paA2kdUVgVVF
        rtdlI=; b=k2Ue6VEvz5lLDkvuxzejEniITkg5BwrnQ+YWHfhw7TQPNwpipa+ppF
        KHPP7yvPKCScRMYaLmEhhuJbb4ITz6oGMpiy26b4a43hZBTMVw/INLzHbtbuwRIY
        Du2W+oz97M/F+ArZmf17AsXkgVMnYpmmV0fMIA5Adi3kHZ8kegzSE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76FB9E9B02;
        Sat, 23 Oct 2021 17:53:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE579E9B00;
        Sat, 23 Oct 2021 17:53:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sven Strickroth <email@cs-ware.de>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: tortoiseplink ssh variant still needed?
References: <dad761bf-3121-8934-fad6-78610bc21121@cs-ware.de>
Date:   Sat, 23 Oct 2021 14:53:33 -0700
In-Reply-To: <dad761bf-3121-8934-fad6-78610bc21121@cs-ware.de> (Sven
        Strickroth's message of "Fri, 22 Oct 2021 18:13:20 +0200")
Message-ID: <xmqqtuh79zmq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABA64B5E-344B-11EC-8C87-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sven Strickroth <email@cs-ware.de> writes:

> IIRC tortoiseplink was initially created by TortoiseCVS which is
> nowadays not maintained any more 
> (<http://www.tortoisecvs.org/download.shtml>).
> In TortoiseSVN and TortoiseGit tortoiseplink was modified six years
> ago (around 2015-03-07) to ignore the "--batch" parameter and also
> accept "-p" additionally to "-P"  (cf. 
> <https://osdn.net/projects/tortoisesvn/scm/svn/commits/26348>).
>
> Therefore, my first question: Does Git still want to support very old
> versions of tortoiseplink or should I provide a patch which drops 
> support for it?

You sent the question to me so I am answering, but this depends on
(1) who the users who use TortoisePlink are and (2) by dropping
support for it, what we would gain.

I am guessing that nobody other than those on Windows use
TortoisePlink, and that everybody other than those who build their
own Git from source use Dscho's Git-for-Windows, and I further
assume that the GfW comes with its own copy of OpenSSH.

So our intended audience is those who started using Git on Windows
back when TortoisePlink was still a thing, are still happily using
TortoisePlink, and are willing to only update Git but not migrate to
OpenSSH.  How big that audience is, I do not know, as I do not do
Windows.

How much maintenance burden is the "support" costing us?  A quick
scan in connect.c tells me that the "add --batch to the command
line" would be the only thing we would be able to shed; everything
else seems to be shared with plink and putty.

So...?

