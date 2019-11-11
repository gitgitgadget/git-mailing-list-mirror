Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 752851F454
	for <e@80x24.org>; Mon, 11 Nov 2019 01:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKKBn5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 20:43:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58297 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfKKBn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 20:43:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9E043D6BE;
        Sun, 10 Nov 2019 20:43:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ayHXzkzXUTDH2oivuFveSg7wkOE=; b=Q+RktM
        UrE45vj7mmsqZwDVS7vLvtbzy56wCj2eYhbngwXixTuFzd52UgLhIaN6Z19v3/B8
        B97gN/fYSS1qxyF2ZWjOk9sAcH/+1vj8ar36Diq2zCZDYKK+GDI7U50Hq4G2rw8N
        2dqVVYnItn6bVMnWJqT9UhPSeexTadVMH3Zio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pQZbSwuJAzkRYF+DG+JApiKfCskUYPo8
        4p/fTjaQ0GRVZLkLWbVonsyysu5eprRZZ4+ichkqUIk3dgKtmLzM6j5/aU5KYZYy
        lXGHbyDRXJKuq8ng8w8Uxrwda1gzDagaqjyk60aF9o8mIh1YLWOwllDD5hPKmsFA
        qEZuPOuLNPg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1A253D6BD;
        Sun, 10 Nov 2019 20:43:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D46E3D6BC;
        Sun, 10 Nov 2019 20:43:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Utsav Shah <ukshah2@illinois.edu>
Subject: Re: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 10:43:53 +0900
In-Reply-To: <pull.458.git.1573196960.gitgitgadget@gmail.com> (Utsav Shah via
        GitGitGadget's message of "Fri, 08 Nov 2019 07:09:19 +0000")
Message-ID: <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B81FE682-0424-11EA-95D6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com> writes:

> At the very least, this patch mitigates an over-eager check for split index
> users while maintaining good invariants for the standard case.

OK, it sounds more like this "it does not make any sense to compare
the position in the fsmonitor bitmap (which covers the entire thing)
with the position in just a split part of the index (which covers
only the delta over the base index)"?  If that is the case, it means
that the "check" is even worse than being "over-eager"---it simply
is not correct.

Thanks, will queue.
