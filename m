Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB7C63697
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 06:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10B92078E
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 06:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mBMtHwAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgKWG7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 01:59:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53405 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgKWG7g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 01:59:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15BD5EA2B5;
        Mon, 23 Nov 2020 01:59:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7/WcZT0tVR307XFs910U2HdP1J0=; b=mBMtHw
        Anv+f37nUcJQliYZwKz1Mggf/WujJjw4s0xx0qGuvOZAsIU7XwmSlP8aLffP4C8C
        E954iZwpIL+wmhri/LcYx+LeqhiL/Cpl3DuvmoceSiBOpSzKxnn1XWVCOnGTG28Y
        iK24d836CWMoc4fIAuT5atbdsgxeGA4W4NHQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LDy2/Gx6rYjH5TMj5lv4UIxxmrjupR12
        k8/GPPvY3YdREzmp6HfvFb71/xMpZzoXOxp6VRLmi6AO16NMlCIeZU4n79cZei+B
        8ZQbtwP3PbQ3XJlQDWyNZDWWU0D6o+MpGKh0cME+rVKFIXlwY/GYMpNydxIUr1a1
        wvy8vrfyYpw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E1E3EA2B3;
        Mon, 23 Nov 2020 01:59:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5A25EEA2A6;
        Mon, 23 Nov 2020 01:59:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     nate@roosteregg.cc
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] notes.c: fix a segfault in notes_display_config()
References: <20201123032342.24566-1-nate@roosteregg.cc>
        <20201123032342.24566-2-nate@roosteregg.cc>
Date:   Sun, 22 Nov 2020 22:59:31 -0800
In-Reply-To: <20201123032342.24566-2-nate@roosteregg.cc> (nate@roosteregg.cc's
        message of "Sun, 22 Nov 2020 22:23:41 -0500")
Message-ID: <xmqqzh38o8x8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70DD7820-2D59-11EB-BB2E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nate@roosteregg.cc writes:

>  	if (*load_refs && !strcmp(k, "notes.displayref")) {
>  		if (!v)
> -			config_error_nonbool(k);
> +			return config_error_nonbool(k);

"git grep config_error_nonbool" tells us that this is the only
instance that ignores the return value from the function and does
not cause the caller to die.

Looks good.  Thanks.
