Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396D2C04FFB
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 20:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjITULT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjITULQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 16:11:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD67130
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 13:10:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C028C1A8085;
        Wed, 20 Sep 2023 16:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=RzkcgHqZgYJ6cPPN0TCxwmvK0kEG9USBvfR+l4
        vpxBo=; b=ZSuAlv32kexrQkawLSdQBg9D4aFVKJEMTn1/F4MgGV1uy9BJcsC6GP
        I+rf5++5RFxtjNoqqcJBlhENLter+dsuYypj9FzJlXPr9GbJsb0vGruyz90a9nLA
        3nhYWe9tVqcVjqzJOxEygUAZdutDnmcAExSqvkoCBRs4tbPa7j53M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B60511A8084;
        Wed, 20 Sep 2023 16:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A62A1A8083;
        Wed, 20 Sep 2023 16:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        mark via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, mark <870355373@qq.com>,
        wangsirun <wangsirun@zhidaoauto.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] fix: check parameters in json-write.c
In-Reply-To: <dc45106c-d569-3438-d2ff-c3c94b6161d7@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 20 Sep 2023 16:02:00 -0400")
References: <pull.1576.git.git.1695124498925.gitgitgadget@gmail.com>
        <ZQne3ThSw6HVmNJc@nand.local>
        <dc45106c-d569-3438-d2ff-c3c94b6161d7@jeffhostetler.com>
Date:   Wed, 20 Sep 2023 13:10:55 -0700
Message-ID: <xmqqil848v1s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEB7EDF2-57F1-11EE-8FBC-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I suppose it is OK for the 2 string-value cases to assume a NULL pointer
> could be written as "" in the JSON output.  Although, I kinda think a
> NULL pointer should call BUG() as we have in the various assert_*()
> routines. It really is a kind of logic error in the caller.

FWIW, that is my preference, too.

> Regardless what we decide for the <string-value> case, in the <key>
> case, the resulting JSON would not be valid. We need for the key to
> be a non-empty string.  For example { "" : 1 } is not valid JSON.
> So the key case should call BUG() and not try to hide it.

I do not have a strong opinion on this side, and leave it up to the
area experts ;-)

>
> So I'm leaning towards just making it a BUG() in all cases, but I'm
> open to the other mixed handling.
>
> Jeff
