Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B56C433E0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB93206F0
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tPybHQC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGXT5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:57:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58968 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXT5x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 15:57:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E39B174EA3;
        Fri, 24 Jul 2020 15:57:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1g9VYoHVXBSYAmAxYBx05ZrFEJg=; b=tPybHQ
        C697tbKLiV40n69hFNukGZN/3kvb2XAYRVx47uLDQ5f/OYxCuNUZlPbYiUyRllDv
        iYe8FcaJk1lzljxzsv4aayReaGJUf+3Yu7jeUeRPIQ+ZUWZXKf01kRHCpzi7gCr5
        BGF6VRKg8iOCEQFC4CFRNRck7k8HCa/AVOD7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FNMO9OOndVDh865O6W+PMhIhkErUvV1D
        L+bZo6gs4H8y8i5marLOe+SFla3DEI7tiOhwOLc2Z19QAkaGPdPyO20hcbTyag02
        tByvfEQ/kXto0Boc6z4Ag5q5YpCJqggH5MUkr3vXK3J3pqFLACo6tp8H0T8gzGcO
        YjzJS3WU+/A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9C6C74EA2;
        Fri, 24 Jul 2020 15:57:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 674B574EA1;
        Fri, 24 Jul 2020 15:57:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 09/18] maintenance: add loose-objects task
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <83648f48655ba68126110018d81c1d2e2bcc7a6f.1595527000.git.gitgitgadget@gmail.com>
        <xmqqr1t2osm3.fsf@gitster.c.googlers.com>
        <b861244c-af0d-581f-b1c8-6c6cb667eed8@gmail.com>
Date:   Fri, 24 Jul 2020 12:57:49 -0700
In-Reply-To: <b861244c-af0d-581f-b1c8-6c6cb667eed8@gmail.com> (Derrick
        Stolee's message of "Fri, 24 Jul 2020 10:50:12 -0400")
Message-ID: <xmqqk0yslm82.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F415EC44-CDE7-11EA-8A8E-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>  * In a partial clone, it is likely that we get loose objects only
>    due to a command like "git log -p" that downloads blobs
>    one-by-one. In such a case, this step coming in later and picking
>    up those blobs _will_ find good deltas because they are present
>    in the same batch.
>
>  * (I know this case isn't important to core Git, but please indulge
>    me) In a VFS for Git repo, the loose objects correspond to blobs
>    that were faulted in by a virtual filesystem read. In this case,
>    the blobs are usually from a single commit in history, so good
>    deltas between the blobs don't actually exist!

Let me stop here by saying that I am now starting to worry about
overfitting the repacking strategy to lazy clone repositories.  I am
perfectly fine with the plan to start with just one strategy overfit
for partially cloned repositories, as long as we make sure that we
can be extended it to suit other access/object acquisition patterns.



