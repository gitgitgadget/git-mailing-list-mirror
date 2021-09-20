Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C4C433FE
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 18:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E57A611AF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 18:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381592AbhITSio (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 14:38:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59971 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344657AbhITSgi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 14:36:38 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1305F63D7;
        Mon, 20 Sep 2021 14:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WMhInR2ilypPegxh9Eisef4joNBWDTcCzYOm0x
        oby+8=; b=EbdNOr4HLH4sd52rCPtIlhVO1AYtNZ19XKzWeUTgcpM4+GVqvhgX5m
        hR+KvirxF/XMu1n6RGoU5LfDilmry7hgWiz9oXAb22wGh+jQeRD6kf8WKprLHDSn
        X/i579eP5r2i/kiIwyo5oY/uygpo5/z5OaI4iz7dhOoW9dMyb3qFw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6903F63D5;
        Mon, 20 Sep 2021 14:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11735F63D4;
        Mon, 20 Sep 2021 14:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alan Blotz <work@blotz.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/4] difftool: use a strbuf to create the tmpdir path
References: <YUaduDIYoW8Fo+5s@coredump.intra.peff.net>
        <20210919023329.23356-1-davvid@gmail.com>
Date:   Mon, 20 Sep 2021 11:35:07 -0700
In-Reply-To: <20210919023329.23356-1-davvid@gmail.com> (David Aguilar's
        message of "Sat, 18 Sep 2021 19:33:29 -0700")
Message-ID: <xmqqr1djayec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B9FA4B0-1A41-11EC-9BF3-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> Use a strbuf to create the buffer used for the dir-diff tmpdir.
> Strip trailing slashes "/" from the value read from TMPDIR to avoid
> double-slashes in the calculated paths.
>
> Add a unit test to ensure that double-slashes are not present.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Changes since v1:
> - Updated to use strbuf_trim_trailing_dir_sep().
>
> Thanks Peff!

> @@ -333,11 +332,11 @@ static int checkout_path(unsigned mode, struct object_id *oid,
>  static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
>  			struct child_process *child)

This is taken hostage by the topic 'ab/retire-option-argument',
which is not yet in 'master' and can never be merged to 'maint',
which is not something you may want to do if this topic is meant as
a bugfix.

I may queue this topic on top of a merge of 'ab/retire-option-argument'
into 'master' for now.

Thanks.
