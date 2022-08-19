Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10380C28B2B
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 18:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350079AbiHSSH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350132AbiHSSHE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 14:07:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8349C275A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:54:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 018AE1AC879;
        Fri, 19 Aug 2022 13:54:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cFFwHZsQR7yqrA/t53ZppnPqhwvC6T2hqp5pXD
        Q5WDE=; b=H7iKHPFnH8cszn5HGMfLv77Q2GhxwcpZVnEvorFUpmh8/TH6L8CSBo
        5e5vw1VWnlOdQZgJEjkrm5H8WO0AzVTDwAdP+akYqg5gFG2NqxTxlzJwMTMhoKgY
        Y1y95nhkvR+XmfWkpjH6PiUCtVPjRmgDxS0qJeg0a2qEGGxX0Ytmw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDE931AC878;
        Fri, 19 Aug 2022 13:54:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A06D11AC872;
        Fri, 19 Aug 2022 13:54:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/3] revision: allow --ancestry-path to take an argument
References: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
        <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com>
        <b810b3c8a2a7a9d121fc7c0438b4e4f3679557da.1660883290.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 10:54:30 -0700
In-Reply-To: <b810b3c8a2a7a9d121fc7c0438b4e4f3679557da.1660883290.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Fri, 19 Aug 2022
        04:28:10 +0000")
Message-ID: <xmqq7d34m84p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA5E37E2-1FE7-11ED-8A26-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  			ancestry_path:1,
> +
> +			/* True if --ancestry-path was specified without an
> +			 * argument. The bottom revisions are implicitly
> +			 * the arguments in this case.
> +			 */
> +			ancestry_path_implicit_bottoms:1,

The above comment explains why this is called "implicit" very well.
The earlier round used "need", but the word missed the essense (i.e.
ancestry_path argument is implicit and not given, so we need to
compute bottoms and use them instead).  The new name is certainly
better.

