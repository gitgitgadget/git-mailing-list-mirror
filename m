Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD18C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 18:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349087AbiE0SlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 14:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244925AbiE0SlC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 14:41:02 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75EEE2798
        for <git@vger.kernel.org>; Fri, 27 May 2022 11:40:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A634B19B2C7;
        Fri, 27 May 2022 14:40:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JTgI2MW/UUJbm5NlU/eS2pUm80gzAFbnsuCenP
        Q0ZFw=; b=RSSv2Cf3r0TuyBGkxkUH9RpeFWTlgttc4oFsEwaFDgVrmr5aoZtx9/
        V8QFvxvgDLQMjPE2Mz72lYHJnGwYHYhfOPxAptHM9B/WY3lHDkI4ABKeeE7+7xK7
        QC3T6FOXUl+kc7tQwTdkALJbzFdQzAo71J1+bBUVWnDRCmD0yeWIo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D12A19B2C6;
        Fri, 27 May 2022 14:40:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E90819B2C5;
        Fri, 27 May 2022 14:40:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] urlmatch: create fetch.credentialsInUrl config
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
        <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
        <xmqqsfou3l0q.fsf@gitster.g>
Date:   Fri, 27 May 2022 11:40:47 -0700
In-Reply-To: <xmqqsfou3l0q.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        27 May 2022 11:09:25 -0700")
Message-ID: <xmqqo7zi3jkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86A6FA38-DDEC-11EC-9A82-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It does make me wonder if we want another parser in the new
> function.  Wouldn't it be easier to manage if we inserted a
> call to 
>
> 	if (passwd_off)
> 		apply_fetch_credentials_in_url(result,
>         			user_off, user_len, passwd_off, passwd_len);
>
> just after the strbuf_detach() we see near the end of the function, where
> apply_fetch_credentials_in_url() only reads the configuration and
> calls warning or die as appropriate?

The new function does not even have to take user_off and user_len,
and work only with the while string with <ofs,len> pair for the
password, I think, as that is the only thing it redacts in the
output.  Sorry about the noise.
