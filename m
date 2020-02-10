Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F5C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D202082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jw8Jxla/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgBJWEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:04:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64963 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbgBJWEr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:04:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E4ABA1417;
        Mon, 10 Feb 2020 17:04:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rO0P1gQBslKF5hcL4y5rR4yY1XI=; b=jw8Jxl
        a/KxzyodJcegkrFt3Hra2Na2clP3Tql1oosyISKeUQ9YNz/shGWjWNYTzzSQM8Pw
        WPmXXPrct0t1SS/CK/VoeEf+S9FBoWw+AEuG15f9X37ZhVdFYx7/GCcXC/24veyj
        mFQOE9+W8anAvT8Jx2AzvoDUbDEd2ajtOVMCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RSgOAOyywaDjCy2NagilP2aaLaxHqLXd
        fSANllAxiXwVk6qZPD17pl8jRbS0RPBVTDF2vr9PcN/0e+wbCe9JkcdDG0ldBbod
        kIERqMpNrTS00p6a0OftpZ0+owv5iWfP/7QcU/LTKX/UDDICEvrg0mtWkS+/8fgb
        ispyTSJPLJU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 973F9A1416;
        Mon, 10 Feb 2020 17:04:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C4FB2A1415;
        Mon, 10 Feb 2020 17:04:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Toon Claes <toon@iotcl.com>
Cc:     git@vger.kernel.org
Subject: Re: URL rewrites for submodules
References: <87wo8ucgar.fsf@iotcl.com>
Date:   Mon, 10 Feb 2020 14:04:40 -0800
In-Reply-To: <87wo8ucgar.fsf@iotcl.com> (Toon Claes's message of "Mon, 10 Feb
        2020 21:56:28 +0100")
Message-ID: <xmqqv9oexfnr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5741CB8A-4C51-11EA-8D90-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toon Claes <toon@iotcl.com> writes:

> Hi,
>
> I recently learned about rewriting URLs. Pretty cool feature. Learned
> about it here:
> https://jonhnnyweslley.net/blog/how-to-rewrite-git-urls-to-clone-faster-and-push-safer/ 
>
> But I've been doing some testing, and this feature does not seem to work
> for git submodules. Is it like that by design, so are there technical or
> practical limitation why we would not like to have this feature on
> submodules too?

Wouldn't these submodules have their own .git/config where you can
define the rewrite rules?  It depends on why you use the rewriting
rules but some common reasons why you rewrite URL A to URL B would
apply regardless of which project hosted at A you are accessing,
namely, performance and convenience.  And in such a case, you do not
necessarily want to have the rewrite config in the per-repository
configuration file of the top-level superproject.  If you define
them instead in $HOME/.gitconfig, that would apply equally to all
repositories you would access.
