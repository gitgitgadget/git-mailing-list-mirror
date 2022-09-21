Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68935ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 18:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiIUSMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiIUSMs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 14:12:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DA87EFE4
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 11:12:46 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E34B21CE334;
        Wed, 21 Sep 2022 14:12:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MSgtMGxqvYEvGaVhYMsiuusIQVx6M0khE3aH/P
        GLFf0=; b=AjffwI26fQVGZBVstlWk1cB+uDvH/rmCR7q9v/BJIDvcZVOpCPE8mi
        MVOy+RdH+A84/VcpBEixDB99DUMwF5aOJeppU11chOUXts308hvHriaqg+/d+HDY
        RJMZ8iP0vQjNvl11gJ1vOAqVuWrkhHCXaAlCslGfONrFJ2jsFPmV4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DBB121CE333;
        Wed, 21 Sep 2022 14:12:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A07681CE332;
        Wed, 21 Sep 2022 14:12:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] merge-tree: fix segmentation fault in read-only
 repositories
References: <pull.1362.git.1663774248660.gitgitgadget@gmail.com>
Date:   Wed, 21 Sep 2022 11:12:41 -0700
In-Reply-To: <pull.1362.git.1663774248660.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 21 Sep 2022 15:30:48
        +0000")
Message-ID: <xmqqedw438bq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC495E0A-39D8-11ED-8D5B-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +test_expect_success 'merge-ort fails gracefully in a read-only repository' '
> +	git init --bare read-only &&
> +	git push read-only side1 side2 &&
> +	test_when_finished "chmod -R u+w read-only" &&
> +	chmod -R a-w read-only &&
> +	test_must_fail git -C read-only merge-tree side1 side2
> +'

Doesn't this test need a prerequisite to guard against those whose
filesystem lacks SANITY?


