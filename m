Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67510C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DDB2078B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YR2GExwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393545AbgDOPsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:48:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60900 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390652AbgDOPsE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 11:48:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA4BE61D93;
        Wed, 15 Apr 2020 11:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0R0iqJ8WC/GtCB72PnmoEt8TEas=; b=YR2GEx
        wKnzqwFiAur5qUjgjiKYOqHAysvR8Ybz+UiqW2WfcwiqJA2xWoIZviBBqp2Otgcv
        tjwmOG6gaHa22Y1t8+wqmtOAg0cjyHXesVQPplRsFrxz2iQBtv48qudQDXPCBjh2
        ViywQgZUXl+zOK09CzKRBK/pj9Sj6PFTgcXnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tv6aPhvQK+hA1W/rpdQtw2EckjTsvQiL
        VwEe6ce2LoHxo9dLeyoqodwtYkGjzPZHaKf2ikheKr19F+Cwai381ok1Sx7dIgkm
        r6HuOFjWRlZqjnPEPKqnuRYJVo0SIzvyfKGR1XBn5Zkcc4eFRZZVxPipnKIlBzxB
        WJSg6XivTp4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A288461D92;
        Wed, 15 Apr 2020 11:48:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBECE61D90;
        Wed, 15 Apr 2020 11:48:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v12 3/7] receive-pack: add new proc-receive hook
References: <xmqq3697cax0.fsf@gitster.c.googlers.com>
        <20200414123257.27449-4-worldhello.net@gmail.com>
Date:   Wed, 15 Apr 2020 08:48:00 -0700
In-Reply-To: <20200414123257.27449-4-worldhello.net@gmail.com> (Jiang Xin's
        message of "Tue, 14 Apr 2020 08:32:53 -0400")
Message-ID: <xmqqo8rs7ntb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CD9BCF6-7F30-11EA-A465-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 2cc18bbffd..fbbb01135e 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -13,6 +13,7 @@
>  #include "remote.h"
>  #include "connect.h"
>  #include "string-list.h"
> +#include "string.h"
>  #include "sha1-array.h"
>  #include "connected.h"
>  #include "argv-array.h"

What are you using from the system <string.h>, that is not covered
by existing inclusion of "git-compat-util.h"?  

Don't include any system header directly in our *.c code (unless it
is a platform-specific compat/ thing).
