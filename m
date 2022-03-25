Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95762C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 00:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357050AbiCYAtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 20:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239525AbiCYAtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 20:49:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E26BB900
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 17:47:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33B75193027;
        Thu, 24 Mar 2022 20:47:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9rIA73xHGN1T8Sfh/fEypY59sGkiQs3Zx7/oct
        Jikf8=; b=FPyxMEll/9WXccJYmue8Yo4CczjNqORg85EKfpC/g2rygP5fUweF6b
        c1ox1sZ2W4nCB00ff9qivBGKBNc7UTg4zouKu14oXBPiSO6i9eIvV7oAD+D3wB0u
        BabKI1LfGUZ73U0TQAnq+P5dKIn1jfkMHkXk3htTqcxBdGmd3of1A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B4A0193026;
        Thu, 24 Mar 2022 20:47:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 94653193023;
        Thu, 24 Mar 2022 20:47:56 -0400 (EDT)
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
        <xmqqy210kl3i.fsf@gitster.g>
        <220324.868rszmga6.gmgdl@evledraar.gmail.com>
        <xmqqwngji72a.fsf@gitster.g>
Date:   Thu, 24 Mar 2022 17:47:55 -0700
In-Reply-To: <xmqqwngji72a.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        24 Mar 2022 10:39:09 -0700")
Message-ID: <xmqqr16qeu2s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 362274FA-ABD5-11EC-A8FC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Without such a mechanism to clearly say "here is what we initialize

"what" -> "where and how".

> a rev_info", the first call to repo_init_revisions() looks like the
> place that initializes a rev_info, and call to release_revisions()
> on a rev_info that did not go through repo_init_revisions() looks
> like a call to free() of a pointer that hasn't been assigned the
> result from an allocation from the heap.  That is where my "iffy
> from the API cleanliness POV" comes from.
