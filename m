Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B45DC2D0C3
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 02:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9F220663
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 02:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HHarqQsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLYC0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 21:26:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50292 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfLYC0X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 21:26:23 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F0062A95A;
        Tue, 24 Dec 2019 21:26:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v3lqE4uu8WnKE4BDeyI5qvUNx1w=; b=HHarqQ
        sa4GM9ja96hqvnkqrg20sLP9JQ5pTJr5U2p/hA3uoiUNpDdui1k7tt0ATgWOh6cr
        MOvdZvANO23eNYwHSM/IoOcWlGW4yR+hsj5gfzL6zAWX5TWJ2f+BaJUZ4kYRHhVf
        5K0TT8wCr3UqF5V36oV0Bmee0Uu7ISXqnfln8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IjobFyW8iyULXNJqliuMgBBHgRGbRKLl
        x6GfJ/KHypDPVVhkIVswSs6jJtYHQFu12M2H8gb17Vr6KC2hfRatAOvaakWTvVpD
        VBRXtq8pvFBLHhD3a5ygCTNJuc1BOjl3bd9hQK7LZ+6exANEHdmJ9Dd1LKZe2DYc
        ZOZck5kLg0Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7750F2A959;
        Tue, 24 Dec 2019 21:26:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E0A252A958;
        Tue, 24 Dec 2019 21:26:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] format-patch: make format.outputDirectory relative to worktree
References: <9422e4225143b2b908bd1fed9a510b9333bf34a2.1577191015.git.liu.denton@gmail.com>
        <xmqq36d95xwh.fsf@gitster-ct.c.googlers.com>
        <20191224220544.GA1917@generichostname>
Date:   Tue, 24 Dec 2019 18:26:19 -0800
In-Reply-To: <20191224220544.GA1917@generichostname> (Denton Liu's message of
        "Tue, 24 Dec 2019 17:05:44 -0500")
Message-ID: <xmqqtv5p3zuc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F03BBE40-26BD-11EA-9058-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> ... Maybe `worktree:path/from/top` or
> `^path/from/top` or something like this?

I recall seeing a similar idea with a bit better syntax discussed
when we talked about path-type values in the configuration system,
where we use "~WORD~/" prefix to expand to Git specific special
places in the filesystem, just like "~USER/" prefix expands to the
home directory of the user.  E.g. "~gitdir~/config" may expand to
point at the per-repository configuration file in the current
repository, and "~worktree~/Makefile" may be the top-level Makefile
checked out in the current worktree.  This depends on the fact that
nobody sane has username ending with tilde (and if there is such a
user, tough luck for that user).  I'm tempted to credit Dscho for
the idea but it could have been by J6t.

Does anybody have a pointer to the discussion thread?
