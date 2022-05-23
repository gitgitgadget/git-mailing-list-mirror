Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C58C433FE
	for <git@archiver.kernel.org>; Mon, 23 May 2022 18:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbiEWSsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 14:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbiEWSim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 14:38:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C7170F2A
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:18:07 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A70A120F54;
        Mon, 23 May 2022 14:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MyuBd8xej6NGX4V178PLddihVcCfNHLwzpKU6m
        yY7MU=; b=Wc6EiYb7+tybp2tuUh2XLybqnXz/UAsxGgmYesxLVwtblT1I75jRX4
        dinwSTbTR5VbGuvAGObkzlIFfXQbh16FlDQgp2XrZxKY223PVS+9uhNdODF43WUx
        dX8JQ3lDUxBy33QUkvibnAmxrAwWqLOLPvaPk4iTjt6NIKd2uzJNM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22A25120F51;
        Mon, 23 May 2022 14:14:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85E5E120F4F;
        Mon, 23 May 2022 14:14:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Carl Smedstad via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carl Smedstad <carl.smedstad@protonmail.com>
Subject: Re: [PATCH] check-ignore: --non-matching without --verbose
References: <pull.1236.git.1653310466062.gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 11:14:16 -0700
In-Reply-To: <pull.1236.git.1653310466062.gitgitgadget@gmail.com> (Carl
        Smedstad via GitGitGadget's message of "Mon, 23 May 2022 12:54:25
        +0000")
Message-ID: <xmqqilpwru9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2975B500-DAC4-11EC-BE64-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carl Smedstad via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The motivation for this is to use the underutilized invocation of
> --non-matching without --verbose to create a shorthand for what could be
> achieved by:

Not commenting on the patch itself, but ...

>
>     find . |
>       git check-ignore --verbose --non-matching |
>       grep $'^::\t' |
>       sed -e 's/.*\t//'

... feeding grep output to sed caught my eyes.  Isn't that equivalent to

	git ... |
	sed -n '/^::\t/s/.*\t//p'

?
