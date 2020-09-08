Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6E1C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20262087D
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C2Y16WKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgIHWK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:10:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65386 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgIHWKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 18:10:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 892E8EF69A;
        Tue,  8 Sep 2020 18:10:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oa+byDiI+CgXX1E1rc2fdKkX5eY=; b=C2Y16W
        KwznwEHXuJRcH8q8dM/qUJx6KiBvYOdpgcmtXJp6N0fHFrJ14jgJbAYnJ/eXYC61
        Fk3m6ktUnk4GFhQZilwpLY0Y3OMpZHQBgFp38xOlW8lW95sEzc7O3jtBNHOyqZ+j
        tK3kZ3TJBgq10r6jsXx5Ey6p30km3FSdf83hA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qYS010heuYb1jG5XEimc+g+owTZmdrV0
        zvGA7JPWpv/Ufj6F1AW9XPg0rmyWDTy+dbiKx6MxZo/Mvry1igZ8XyHuGROMPBdh
        kl60MUVQgMgAC9a4jorKbBsmJBl+gHACybNIjFetAQooymDVcnmCHg8aC6hho1Mu
        wU2oPzwVLtk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 828C4EF698;
        Tue,  8 Sep 2020 18:10:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF353EF697;
        Tue,  8 Sep 2020 18:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/3] format-patch: --interiff/--range-diff tweaks
References: <20200908071610.16714-1-sunshine@sunshineco.com>
Date:   Tue, 08 Sep 2020 15:10:49 -0700
In-Reply-To: <20200908071610.16714-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Tue, 8 Sep 2020 03:16:07 -0400")
Message-ID: <xmqqy2ljx6l2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27C94F2A-F220-11EA-ABA2-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This series addresses a few comments[2,3,4,5] which cropped up during
> review of the series which added --interdiff and --range-diff options to
> git-format-patch[1]. That series made it into 'next' before I could address
> the comments, so these patches (based upon 'master') make minor tweaks
> "incrementally" (over 2 years late).

The last step subtly changes the behaviour, if I am reading its
description correctly.  Does it deserve a documentation update, or
are we just making the code behave "better" but still within the
boundary of how it is documented to work, hence no need to update
the doc (but deserves an advertisement in the release notes)?

Thanks.
