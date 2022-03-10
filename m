Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4BFC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 02:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiCJCeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 21:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiCJCeA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 21:34:00 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AB1D4474
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 18:33:00 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 225D1126686;
        Wed,  9 Mar 2022 21:32:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KOb6jmU8CeXb91iiGVDXpyNEs6p1caD9enDIca
        V4F8s=; b=lUTt2PZXowaVnGSV+r26VrUXQyJtnhTl4WLx4V1LrD2j0ySCeILvGb
        exH04M4NaQK7ZX7qe5znxEBauXEGEZ6kba8bGZg+Mt1vlnhj7wJj1yUP371bjjI6
        G5zHQg6nZuUC7PGJUHA9PI4sWT46pW8TP2pBU2yAxYtmblSWkyTTE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17E5E126685;
        Wed,  9 Mar 2022 21:32:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D802126684;
        Wed,  9 Mar 2022 21:32:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
References: <20220310004423.2627181-1-emilyshaffer@google.com>
        <20220310004423.2627181-3-emilyshaffer@google.com>
Date:   Wed, 09 Mar 2022 18:32:57 -0800
In-Reply-To: <20220310004423.2627181-3-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 9 Mar 2022 16:44:22 -0800")
Message-ID: <xmqqpmmuh6zq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 662AA4C2-A01A-11EC-81E7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +test_expect_success 'submodule update adds submodule.hasSuperproject to older repos' '
> +	(cd super &&
> +	 test_unconfig submodule.hasSuperproject &&

So, before we run the test, we unconfig the variable in the SUPER
repository, and then

> +	 git submodule update &&

update the submodule, and then

> +	 test_cmp_config -C submodule true --type=bool submodule.hasSuperproject

go in to the submodule and check the value of the variable?

Shouldn't the first part be more like

	(cd super &&
	 test_unconfig -C submodule submodule.hasSuperproject &&

if we want to make sure "submodule update" sets it there?

> +	)
> +'
