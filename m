Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93131C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 09:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D0861375
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 09:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhFIJtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 05:49:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56674 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbhFIJtk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 05:49:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B396C03CF;
        Wed,  9 Jun 2021 05:30:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9IVE/S6aE8ZxxErE6wMctQHTb68OyX2XPndBuh4z9tY=; b=iACk
        mVRn4JQW+YGkWI5c4OE+Kz7U17owaP9ZFuYlDOs0BInTf4SlfKzS6MsLeDmAy9Iy
        O4SxeFtEB2FPElfP2V6u9riwjX2GKWWsC2g0MANHraaO5OvHO1NmQtA057afyMiA
        xW6ci0zN5mxfmMOMqTAhtpxbrmw7+IyPaqhQ0II=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63539C03CC;
        Wed,  9 Jun 2021 05:30:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEF8DC03CB;
        Wed,  9 Jun 2021 05:30:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 1/4] promisor-remote: read partialClone config here
References: <xmqq35ttrqmj.fsf@gitster.g>
        <20210609042649.2322758-1-jonathantanmy@google.com>
Date:   Wed, 09 Jun 2021 18:30:25 +0900
Message-ID: <xmqqeedbidvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 525B411E-C905-11EB-B567-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I'm reluctant to add more fields to struct repository_format.

I am only suggesting to add one new member to either struct
repository or struct repo_settings, so that it becomes crystal clear
that struct repository_format is about each single repository, not
the global the_repository.  Other things that partial repository
support needs to keep *and* do not directly come from extensions
would not belong to repository_format and should not be added there,
but what we read from extensions.* for each repository belongs to
each instance of in-core repository structure and should be
discoverable starting from "struct repository", no?


