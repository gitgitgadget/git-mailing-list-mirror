Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE493C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 21:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiGGVzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 17:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbiGGVzq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 17:55:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4F599C6
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 14:55:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D85E1B97F5;
        Thu,  7 Jul 2022 17:55:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/AJ1NtC8ahvqTKfNF5HkB0FWD9ddVDiAbMDYPa
        PjXF8=; b=ngfA/9n54Llw6m4lv9AHev2UQB1l9oaMoctQMpTT8iivPxrklKUSY/
        eDQuClsWt0CRGcYr+gJQBoCxSFZ9fkNpwMIrz8WdyAMVO3KmzlQ58+fzbyYypqET
        ocjKH+y1GCI7kytbAPHP7WBma5ZTTFkiOtL7yeSOA9ifMDYHuAFsE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 947EE1B97F4;
        Thu,  7 Jul 2022 17:55:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 48DC51B97F3;
        Thu,  7 Jul 2022 17:55:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 4/4] cat-file: add mailmap support
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
        <20220707161554.6900-1-siddharthasthana31@gmail.com>
        <20220707161554.6900-5-siddharthasthana31@gmail.com>
Date:   Thu, 07 Jul 2022 14:55:41 -0700
In-Reply-To: <20220707161554.6900-5-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Thu, 7 Jul 2022 21:45:54 +0530")
Message-ID: <xmqqwncoy4de.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BC791EE-FE3F-11EC-8A26-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> +char *replace_idents_using_mailmap(char *object_buf, size_t *size)

Does this function need to be extern?  If nobody other than callers
in cat-file would call it, perhaps it should be file-scope static.

> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	strbuf_attach(&sb, object_buf, *size, *size + 1);
> +	const char *headers[] = { "author ", "committer ", "tagger ", NULL };

This is decl-after-statement.

> +	apply_mailmap_to_header(&sb, headers, &mailmap);
> +	*size = sb.len;
> +	return strbuf_detach(&sb, NULL);
> +}

