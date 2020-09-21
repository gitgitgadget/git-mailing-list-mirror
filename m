Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D04C4727D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FC423A62
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 22:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LuguoKkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgIUWSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 18:18:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51703 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUWSM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 18:18:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 012A6FC880;
        Mon, 21 Sep 2020 18:18:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pghFjVCXAZXggvasvQExf0a5I/c=; b=LuguoK
        khKwv6q+LZPwBsIdt08tlVj3Ti+fIDGnaWIBT4/PtsH1RsGBapu1N6f5YbxJN5Lv
        SOkbryvrZOU43+QQ9hwTNtXkOCdQG4gDinXY7jPK4ds6TuNUcnTehKDMscN9miSz
        M6fWtFFla731szDFgZd9B81ED+sEG02mCXL6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WEw4KyDLRDXqIdK1zWXSB+zUYeQqbxmO
        +Cdl/J1D5SQVW05NJFH7zlEJUDZ1QqiOL731qcMOxx6pyw/uJ+rjp7gjPcG1oHER
        50N8jyz2zIyzahgbCJiCwBHP9N8XNgiWm0Bmj+iA3tTdGksdonFciQgXZLOJ5Rd/
        Yzeca2nj01A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EFCC3FC87F;
        Mon, 21 Sep 2020 18:18:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 487ECFC87C;
        Mon, 21 Sep 2020 18:18:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
        <xmqq363gs1mt.fsf@gitster.c.googlers.com>
        <20200918104833.GB1874074@generichostname>
        <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
        <20200920110148.GA227771@generichostname>
        <xmqqzh5jf73t.fsf@gitster.c.googlers.com>
        <20200921172740.GA946178@generichostname>
        <xmqqwo0met17.fsf@gitster.c.googlers.com>
        <20200921215409.GA1018675@generichostname>
Date:   Mon, 21 Sep 2020 15:18:06 -0700
In-Reply-To: <20200921215409.GA1018675@generichostname> (Denton Liu's message
        of "Mon, 21 Sep 2020 14:54:09 -0700")
Message-ID: <xmqqblhyepup.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53E5E19E-FC58-11EA-99CC-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This does not happen because at the top of diff_get_merge_base(), we
> have
>
> 	for (i = 0; i < revs->pending.nr; i++) {
> 		struct object *obj = revs->pending.objects[i].item;
> 		if (obj->flags)
> 			die(_("--merge-base does not work with ranges"));
> 		if (obj->type != OBJ_COMMIT)
> 			die(_("--merge-base only works with commits"));
> 	}
>
> which ensures that we don't accept any ranges at all.

I think we should lose that loop, or at least the first test.

If we are not removing the support for "A..B" notation and still
accept "diff A..B" happily, not accepting "diff --merge-base A..B"
would appear inconsistent to the users.  

The same applies to "A...B".

Thanks.

