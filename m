Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615AACE7AFC
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 18:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjI1SYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjI1SYN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 14:24:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2EDBF
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 11:24:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF0B01B1C1A;
        Thu, 28 Sep 2023 14:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=jALFK2HFQs+aC+lC8FcOibvryJ4HTA1tqch5zX
        I3VcM=; b=tN7UHxZodxoFNFIFuGv67HlKSnDOVm5x2hYgotg5I41Fb4FqlYZMA0
        1BwBof6pOFI48IjGTtZ9RZeiSg5+2GQLu2KRF4vggcZl1eT9qSwzzl9qgcgKwKE8
        0Y6h1fKIg34uvtIxKacoudpA9J1FjHOQV/LWBCj9wvuyuVY3JEuRE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8A8D1B1C18;
        Thu, 28 Sep 2023 14:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1416D1B1C17;
        Thu, 28 Sep 2023 14:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joanna Wang <jojwang@chromium.org>
Cc:     git@vger.kernel.org
Subject: Re: Supporting `git add -a <exclude submodules>`
In-Reply-To: <xmqqsf6yjhhm.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        28 Sep 2023 11:11:01 -0700")
References: <CAL-HyEbxGqxid3vsvDk3Z0Gd3swbNP4qcXhApadu8ZgvRkr3WA@mail.gmail.com>
        <xmqqsf6yjhhm.fsf@gitster.g>
Date:   Thu, 28 Sep 2023 11:24:08 -0700
Message-ID: <xmqqfs2yjgvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37B113F2-5E2C-11EE-9777-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> By the way, I am surprised that "diff.ignoreSubmodules=all" is
> abused by anybody that way.  It depends on the implementation detail
> that we internally use the diff machinery to find which paths are
> not modified, and I would even say it is a BUG that "commit -a" pays
> attention to the configuration variable that way.  I would recommend
> strongly to stay away from that approach or your tools will get
> broken when the bug gets fixed.

Sorry, but I take this part back.  This is an explicitly documented
feature of the variable, so users and scripts alike should be able
to depend on.  It still feels like a layering violation, but it is
too late to "fix" it now.

