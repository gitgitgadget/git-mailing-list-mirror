Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70899C3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 22:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C0A20848
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 22:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RhrfAsLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCBWhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:37:33 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54453 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBWhd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 17:37:33 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1393EC2911;
        Mon,  2 Mar 2020 17:37:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EUa/MivPt41v2P5taBBCxEs9k4o=; b=RhrfAs
        LuDOU0uFaMpqnNXEg2nFliqcDCpAsc9vZeQK8PHKAv+YrjG8+CDQ65f8Ln7y0Un8
        WockcnRSmjr+0RocFFLeTgcHgEB4iqu+Geyg8yW4nRLUJPHHN7uROkzUGuC3TVGL
        sX1sec9armdHZO9P8QCBVODzorDyTgAVJlSuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bO+hAuVIKlKchaIPm/+kWB34Oo+tZjNv
        F3zgtz9nCXzJSZs2GXXzfDE51keZRPl6p/1mZGLYVECYxCLGV4BNyW8vHlawfLpF
        jkyFQIZz0ZTk30RxIDD9URHJ9Pa32dfEESJ7R5o0gOZd2kvYJ7zD20v1p/CDwxGE
        oQqK7NUmCUo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EC933C2910;
        Mon,  2 Mar 2020 17:37:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12E72C290F;
        Mon,  2 Mar 2020 17:37:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, rcdailey.lists@gmail.com, newren@gmail.com,
        rsbecker@nexbridge.com, annulen@yandex.ru, tytso@mit.edu
Subject: Re: [PATCH v3] pull: warn if the user didn't say whether to rebase or to merge
References: <20200229212258.373891-1-alexhenrie24@gmail.com>
Date:   Mon, 02 Mar 2020 14:37:26 -0800
In-Reply-To: <20200229212258.373891-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sat, 29 Feb 2020 14:22:58 -0700")
Message-ID: <xmqqtv369ye1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65EBC6E6-5CD6-11EA-A528-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> v3:
> - Fix segfault if opt_ff is NULL
> - Don't say that the behavior will change in a future version of Git
> (that hasn't been decided yet)
> - Mention that pull.ff=only is also an option
> - Mention git config's --global option
> - Make the warning message longer and more clear in general
> ---
>  builtin/pull.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Another thing tests noticed was that this broke #5521.2.
