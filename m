Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B87C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 16:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC4620767
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 16:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cBtjz7W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403912AbgFYQex (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:34:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59594 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390796AbgFYQew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 12:34:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7ADCF75EC6;
        Thu, 25 Jun 2020 12:34:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PWFkHGUSM39yztIMCfwN7DfGKvI=; b=cBtjz7
        W7N2cFkl+q2VSgmxsbAInHVFS7+CTcBZY8JDJNYROTpSp73YFjtjMivs/OGfEh1i
        OCj0SdRhoizmmSMe4X3M1mdhJJeS7uErq96OerMUqXv7SUczJKyRM8cGryMFu76d
        Ix6+LqP/6eL0oQ6dQUPkwnBAK5Ku54L5rjmKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WlEcvtacJmnKmN3BKsBWb/Zzv1WadG4x
        LIhrsoCcRRukTTtJBRBGoo4hrEAqiwquAkjtB01CmjTU7jzhgl9/dHE7YY4OkZ4L
        xxbEYN6v9/jKiABOoi8cxx/izTvQltl+BH9gGzMBIxwvlXyQ+pxVw5nHJge5YfkC
        n98e+h6UzA8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 727ED75EC5;
        Thu, 25 Jun 2020 12:34:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F341575EC4;
        Thu, 25 Jun 2020 12:34:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, szeder.dev@gmail.com,
        l.s.r@web.de, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 00/11] More commit-graph/Bloom filter improvements
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
        <pull.659.v2.git.1592934430.gitgitgadget@gmail.com>
        <xmqqftak5aa0.fsf@gitster.c.googlers.com>
        <429f38a2-9346-f6f7-bd69-2fd63828ae7c@gmail.com>
        <xmqq7dvw5699.fsf@gitster.c.googlers.com>
        <4b08360d-04ab-b614-196b-76124f1d54ef@gmail.com>
Date:   Thu, 25 Jun 2020 09:34:49 -0700
In-Reply-To: <4b08360d-04ab-b614-196b-76124f1d54ef@gmail.com> (Derrick
        Stolee's message of "Thu, 25 Jun 2020 09:38:42 -0400")
Message-ID: <xmqqy2ob3xzq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA0186A4-B701-11EA-BF27-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Question: Should these be GIT_BLOOM_SETTINGS_* instead of GIT_TEST_...?
> I ask because this _could_ be a way to allow user customization,
> without making it as public as a config option. Or, should I just do
> the work and add config settings in this series?

Other than when testing and/or debugging, what are the expected
reasons and situations an individual would want to use customized
settings?  Once a decision is made to use one customized setting for
a repository, does it make sense for a setting other than that one
setting for the same repository, or is it something very handy if we
can use different settings on a whim?  

My gut feeling is that it should be added as per-repo configuration
but only after a use case is found, and GIT_TEST_* would be the way
to go.

Thanks.
