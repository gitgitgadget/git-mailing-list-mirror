Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F00C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 21:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2253824125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 21:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QZUlxd02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAUV6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:58:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61759 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgAUV6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 16:58:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42BAFA2902;
        Tue, 21 Jan 2020 16:58:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LRtfx/+LopD3rEpd8WrIBa4S5Ks=; b=QZUlxd
        02ELIg3JrwpcfkugFjI22lYST+ZMjdar8Js1E9rrqJ0r/647y4/uHklHrFLjOYgf
        GTbJ0qtLJad719UJ+w+taIto8RFsu2ClnfH5YJ1FgSa2sh5MtIM0LZTZUJfNITxn
        4zkGoiqeHIUf54QqYCzWeT1PYKsR5OkrZ3+yI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FulYrCDdeI4oJXkSzZagWRlk0/ugfxwk
        pELw9Urpg2MSjKMI1tYH9/FgZwGE6oNGvVNytdQj3vfL5dXujQCRKa7Q1FJyrAeJ
        bisU/sDKWkVyMXVFNEsbsbH0atEezrxq29Gttei/m5fWh+bLwvJktufGS6l3Xruq
        NGoJDTtF1Ek=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A8FBA2901;
        Tue, 21 Jan 2020 16:58:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 66B07A28FF;
        Tue, 21 Jan 2020 16:58:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     sunshine@sunshineco.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 2/2] t6025: use helpers to replace test -f <path>
References: <CAPig+cQX=jB1KTKcOMVE9u0jX-ZXt_vQBndkzqqQWORu5iFxeA@mail.gmail.com>
        <20200118083326.9643-1-shouryashukla.oo@gmail.com>
        <20200118083326.9643-7-shouryashukla.oo@gmail.com>
Date:   Tue, 21 Jan 2020 13:58:11 -0800
In-Reply-To: <20200118083326.9643-7-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Sat, 18 Jan 2020 14:03:26 +0530")
Message-ID: <xmqqtv4o8ob0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EE6B628-3C99-11EA-B84E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> Take advantage of helper function 'test_path_is_file()' to
> replace 'test -f' since the function makes the code more
> readable and gives better error messages.

Looks good.  Thanks.
