Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0641FC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiCDW7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 17:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiCDW7L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 17:59:11 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4922DE00C
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:58:23 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FF6E179F37;
        Fri,  4 Mar 2022 17:58:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r/u/Y05yeoQjXBeFc9ieTi4KskwlFp5IkRM3Gc
        Gc0zg=; b=sSl6E75XSGlapYusFIMf8eofecYZQft3VJP9VCWbl3LSWTj9+3sbH+
        FF/lUYkKE2ASp/NGE3sRLdVTF+ORnJuSjU3KjJyEUOh0ZE1IAnWhCSN0x7dkny6+
        MWT3jBqWNul+miGeirlMSM5rzOH67LsC1nPvZEtFcWJSV8h1M0KuE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 987EF179F36;
        Fri,  4 Mar 2022 17:58:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 21D04179F35;
        Fri,  4 Mar 2022 17:58:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 07/11] bundle: safely handle --objects option
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <1476a9495c53a165e6971afe75205889524fe7ca.1645638911.git.gitgitgadget@gmail.com>
        <83bfbce4-3c79-031a-5961-429145910409@jeffhostetler.com>
Date:   Fri, 04 Mar 2022 14:58:19 -0800
In-Reply-To: <83bfbce4-3c79-031a-5961-429145910409@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 28 Feb 2022 11:00:03 -0500")
Message-ID: <xmqqilstxr3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95FDD58A-9C0E-11EC-BE00-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 2/23/22 12:55 PM, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>> Since 'git bundle' uses setup_revisions() to specify the object
>> walk,
>> some options do not make sense to include during the pack-objects child
>> process. Further, these options are used for a call to
>> traverse_commit_list() which would then require a callback which is
>> currently NULL.
>> By populating the callback we prevent a segfault in the case of
>> adding
>> the --objects flag. This is really a redundant statement because the
>
> Nit: I stumbled over "...because the bundles are constructing..."
> Is there a better wording here??

"... because the command is constructing ..." should be sufficient,
I hope?
