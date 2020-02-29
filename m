Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AD0C3F2C6
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 16:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F322468E
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kH1uUyo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgB2QdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:33:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54912 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgB2QdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 11:33:12 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 661EF533DD;
        Sat, 29 Feb 2020 11:33:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f5YitepilI792PUEjBWoNunZi00=; b=kH1uUy
        o6cRgrvAzXaboQGp2mpqYH5KlOcOMxe2Y1SBOt10IdZacrxtSBgz6CbLAl2EtOy9
        UybPrxZH/UBhjMVMd+cgzU9PFMrCaXewy8R5NC3BCvcF/ChUh9GidC3Vk4NaO6tr
        bknLWbdtqnJz4EFjTc1byypzEXsYhiB4bx2MA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k91Jm2KlILQyA8WCuIVslvYwPy7LHSAg
        TNWnjVx+Yj0PAbVfAnNq2VJ98nUnTfQibNUypv/ZW0odT2Bu+5jJ2EA6tYIHbcnn
        IXoXTZ35BPSSIdX7QSSErHm0NF/wAJtmNBtXYDNONEqEej1qD+iKd38V3qYvN7+c
        j8C0v4QFh6k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C944533DC;
        Sat, 29 Feb 2020 11:33:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE464533DB;
        Sat, 29 Feb 2020 11:33:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        rcdailey.lists@gmail.com, newren@gmail.com, rsbecker@nexbridge.com,
        annulen@yandex.ru
Subject: Re: [PATCH] pull: warn if the user didn't say whether to rebase or to merge
References: <20200228215833.319691-1-alexhenrie24@gmail.com>
        <xmqqeeuecngu.fsf@gitster-ct.c.googlers.com>
        <20200229030344.GG101220@mit.edu>
Date:   Sat, 29 Feb 2020 08:33:08 -0800
In-Reply-To: <20200229030344.GG101220@mit.edu> (Theodore Y. Ts'o's message of
        "Fri, 28 Feb 2020 22:03:44 -0500")
Message-ID: <xmqq7e05cq0r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BF11E94-5B11-11EA-9F75-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Theodore Y. Ts'o" <tytso@mit.edu> writes:

> I'd also note that there are some workflows that assume that --rebase
> is *never* a good thing, even for contributors.  We can decide whether
> we want to bias the git man page in favor of one workflow as opposed
> to another, for the sake of new git users, but I don't think it's
> accurate to say (or even imply) that there are only two workflows:
> contributor/rebasing and maintainer/merging.

Thanks for raising this.
