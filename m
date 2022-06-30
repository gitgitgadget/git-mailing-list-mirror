Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B426C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiF3Xlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiF3Xlv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:41:51 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864E523B5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:41:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D18211A9CE4;
        Thu, 30 Jun 2022 19:41:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ATSjd1FTPlOk1DT7ne3Gk63W2t6TxlnF0rib21
        Hd8Ec=; b=uwYevJhzzxFn9+zbq2RTJfMMBlq9u6j+jOsE+d9xzogORR2rfIWp+J
        tDtuwyY42C9t+2JgtYPqyvDNQ1fm0mmyaanVK2LybQBhTqzg3eW42UVN8XOTw02y
        CqOmbZm/VgnaSD+nQ9WdK7/nsqRjJ9Ta1qLv0lc4FBO/zcZTtPPRU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CADE91A9CE3;
        Thu, 30 Jun 2022 19:41:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 695821A9CE2;
        Thu, 30 Jun 2022 19:41:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 3/3] cat-file: add mailmap support
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
        <20220630142444.651948-4-siddharthasthana31@gmail.com>
Date:   Thu, 30 Jun 2022 16:41:42 -0700
In-Reply-To: <20220630142444.651948-4-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Thu, 30 Jun 2022 19:54:44 +0530")
Message-ID: <xmqq4k01btxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 326AD9C4-F8CE-11EC-96E3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> +char *replace_idents_using_mailmap(char *object_buf, size_t *size)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	strbuf_attach(&sb, object_buf, *size, *size + 1);
> +	rewrite_ident_line(&sb, "\nauthor ", &mailmap);
> +	rewrite_ident_line(&sb, "\ncommitter ", &mailmap);
> +	rewrite_ident_line(&sb, "\ntagger ", &mailmap);

This shows why you want to fix the existing function first before
inflicting its poorly designed API to more callers.  There is no
sensible reason that you have to make three calls to the helper
function.
