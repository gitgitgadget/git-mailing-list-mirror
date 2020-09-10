Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C4AC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 04:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C955B2075E
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 04:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R8Rl19/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIJE2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 00:28:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50881 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJE2D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 00:28:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94D22F3DE1;
        Thu, 10 Sep 2020 00:28:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BhKDnwqifPblfQ70tDCdh3Lk0TY=; b=R8Rl19
        /I9FceDTg7CCeN0aw+Xloa/D8MjnYWgdQzeWaYDS00Fyzm0UBplRbIuzSTsdmnjy
        ZFGF6K+kLAVQNkXdc0pZU0dr7IUoizqD/0gmDQztOKxeDMIdCFqs3JPE8+5KqelF
        N+H2hWoZ0PXwkbcTu+lZvbp5eTu/E5tKD0qt0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=if5z6ekGj9yZHAN/7FsXjYtBakWfgghS
        tg8PhOFJ4XAnltr0Jmd5bmDfN3D2HiWxQgDvjYkpjgrOPngxkkTuSwNZyCVupAW8
        xMNI2cvrHoqnvZasJIdp8E8CSv4QoS5KGPJm36cKB33DEJzct4BrRsoc8+16Jxgj
        RI53j3Cgnas=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E742F3DE0;
        Thu, 10 Sep 2020 00:28:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2498F3DDE;
        Thu, 10 Sep 2020 00:27:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: Proposal: server-advertised config options
References: <20200907205242.GF241078@camp.crustytoothpaste.net>
        <C5I1TZ1OCN40.2BHKV9GD572FL@homura>
        <20200910014520.GJ241078@camp.crustytoothpaste.net>
Date:   Wed, 09 Sep 2020 21:27:56 -0700
In-Reply-To: <20200910014520.GJ241078@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 10 Sep 2020 01:45:20 +0000")
Message-ID: <xmqqr1ras1bn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00DF7BE2-F31E-11EA-86C7-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> ...  We've seen security
> problems in the past with .gitmodules multiple times because it's
> server-sent config (in the repository).

Exactly.  For some reason some people still seem to think that it is
wasteful that we force users to approve/reject copying from .gitmodules
to .git/config and push to read and use settings directly from the
former---I think it is a huge mistake.

> As a result, I'm very much opposed to allowing any config options to be
> copied from the server.

+1.

> It's also the standard approach that every project uses already, and it
> has the benefit that the user can inspect it at their leisure before
> running it.

+100 ;-)
