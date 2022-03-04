Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5312DC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 02:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiCDCSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 21:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiCDCSn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 21:18:43 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7873EA89
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 18:17:55 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93FDA10943B;
        Thu,  3 Mar 2022 21:17:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WeU+pivyDRPh0w4AQBJ7TDwgt4d61QRfQksDxL
        Ha/1o=; b=x7NQe2Eu4WsNkSlT2i/wd0/JDgQobtkZQYFlaL/KhWh8fQ1+A2pVIr
        1vRwNGtWlfseXrs294R+QY1gX2qNmADizILFeRxtzCCCpyUcAiLrTxVtLhBxBIp+
        nc8AFjytOYl37v97qaMXOWu4M/gwH99xunIAG7j12JM497ndCz85I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BAD6109439;
        Thu,  3 Mar 2022 21:17:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F2A52109437;
        Thu,  3 Mar 2022 21:17:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 10/10] submodule: fix latent check_has_commit() bug
References: <20220224100842.95827-1-chooglen@google.com>
        <20220304005757.70107-1-chooglen@google.com>
        <20220304005757.70107-11-chooglen@google.com>
Date:   Thu, 03 Mar 2022 18:17:51 -0800
In-Reply-To: <20220304005757.70107-11-chooglen@google.com> (Glen Choo's
        message of "Thu, 3 Mar 2022 16:57:57 -0800")
Message-ID: <xmqq4k4e5uls.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C8DB634-9B61-11EC-9565-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> When check_has_commit() is called on a missing submodule, initialization
> of the struct repository fails, but it attempts to clear the struct
> anyway (which is a fatal error). This bug is masked by its only caller,
> submodule_has_commits(), first calling add_submodule_odb(). The latter
> fails if the submodule does not exist, making submodule_has_commits()
> exit early and not invoke check_has_commit().
>
> Fix this bug, and because calling add_submodule_odb() is no longer
> necessary as of 13a2f620b2 (submodule: pass repo to
> check_has_commit(), 2021-10-08), remove that call too.
>
> This is the last caller of add_submodule_odb(), so remove that
> function. (Submodule ODBs are still added as alternates via
> add_submodule_odb_by_path().)
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  submodule.c | 35 ++---------------------------------
>  submodule.h |  9 ++++-----
>  2 files changed, 6 insertions(+), 38 deletions(-)

Looks reasonable.  Will queue.

Thanks.
