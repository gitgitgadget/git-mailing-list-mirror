Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25090C33CB1
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED528214AF
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 18:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VLvco+67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgA0SSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:18:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58812 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgA0SSb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 13:18:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13AB3563B7;
        Mon, 27 Jan 2020 13:18:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wZZWBuIKKcw/
        QmMVTIDC148yf1Q=; b=VLvco+67l7vfYO7ihzwb+BOi9riY6yWgF9uZqwtW/lfY
        Pri1j+B3zmzOSPhZDBnbLOnmdb5NjAH/s4DB4ha18xfdFw4jk/exVo365WoCVlwc
        gbciH3gSQ8gbIY+Q9rPlkzgqRfRiqlenXKFAiLQzwGJ6kfGzAQGnM78fN8wG55Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=C2gl47
        NQUYcK8bIP5VCxNUoZ65s/q2r3ymX6RHCJ8G86z/6nkEqylPFXm+gD2hqRQyQjq9
        Bi8Df74eZKirVFuji0K3xQQRpfoaz4mE2x4sTnyRK0MB9mFKcj4SxU2zn18t54KB
        uceqlIbLb4MJ4XN89xZTOLxfUR3Z+fqTioAf8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A550563B6;
        Mon, 27 Jan 2020 13:18:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B677563B5;
        Mon, 27 Jan 2020 13:18:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter =?utf-8?Q?K=C3=A4stle?= <peter.kaestle@nokia.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, pc44800@gmail.com
Subject: Re: [PATCH v2] Fix status of initialized but not cloned submodules
References: <23e3d410-5271-a919-aa03-9e776cf72f7c@nokia.com>
        <1579601532-10694-1-git-send-email-peter.kaestle@nokia.com>
        <xmqq4kwl512y.fsf@gitster-ct.c.googlers.com>
        <9192695a-0b3f-d166-7efa-84f57e091c2c@nokia.com>
        <xmqqblqs3hbv.fsf@gitster-ct.c.googlers.com>
        <41a835a3-3809-eda8-fb3c-30fe9fac1a24@nokia.com>
Date:   Mon, 27 Jan 2020 10:18:27 -0800
In-Reply-To: <41a835a3-3809-eda8-fb3c-30fe9fac1a24@nokia.com> ("Peter
        =?utf-8?Q?K=C3=A4stle=22's?= message of "Mon, 27 Jan 2020 09:52:21 +0100")
Message-ID: <xmqqv9owbw5o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A85C366-4131-11EA-A0EE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter K=C3=A4stle <peter.kaestle@nokia.com> writes:

> ...  I mean, the outer git repo should treat the inner one as standard
> file structure and not as a submodule until the user explicitly calls
> the "git submodule add" command.  And thus "git submodule status"
> should completely skip it.  Calling "git status" in the outer repo
> should list the inner one as "untracked" or?

I agree that is a sensible expectation.

