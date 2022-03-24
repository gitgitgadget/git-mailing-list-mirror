Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D562DC4332F
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 04:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbiCXEyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 00:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbiCXEyl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 00:54:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BFF3897
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 21:53:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9857B12633F;
        Thu, 24 Mar 2022 00:53:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=B9x75ih1td8wD9OlAr8yrmolP
        xagKo+uFoYSKUxhtro=; b=jRlgA20swJRMKd042gPJKgHw019MaJx5rQlXdVk+Y
        auuXl7zCQgRsPoHZ+rxRPCzFLCDjm6YfOkQnpXOuHIFe8zg1ogmZMmQtmCwRKhWh
        oMwZsPhWyTEPx5GZCqhh4Ma2gnfxRI3aS6ZboCqxnjwSIfb9eebJ4SYrZ868I30K
        sM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F51312633E;
        Thu, 24 Mar 2022 00:53:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFC1412633D;
        Thu, 24 Mar 2022 00:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 08/27] revisions API users: use release_revisions()
 needing "{ 0 }" init
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
        <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
        <patch-v2-08.27-42ad1208934-20220323T203149Z-avarab@gmail.com>
Date:   Wed, 23 Mar 2022 21:53:05 -0700
Message-ID: <xmqqy210kl3i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4BBFC670-AB2E-11EC-9326-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Use release_revisions() to various users of "struct rev_list" which
> need to have their "struct rev_info" zero-initialized before we can
> start using it. In all of these cases we might "goto cleanup" (or equiv=
alent),

I didn't look at the bisect code, but the bundle one looks iffy from
the point of view of API cleanliness.  If we have not yet called
repo_init_revisions() on a revs, we should refrain from calling
release_revisions() on it in the first place, no?
