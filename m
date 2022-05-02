Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D9C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 17:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386580AbiEBRPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 13:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386581AbiEBRPy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 13:15:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53A62E5
        for <git@vger.kernel.org>; Mon,  2 May 2022 10:12:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 61B9813609D;
        Mon,  2 May 2022 13:12:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DLBR/HGWyQEOsnMOkVslzIH182ccWtYFDRmGE+
        gnYe8=; b=hpNwhOu0gZCdXGNKvNcdduM+UN4YoybC+kENxaRi9MFohpkm09WduR
        vHbz/yw1pQmajo+IuWZ6uRDoBPFOyi49PTWWSs7uVBvudixDJMOmAdSV9c57Mk8w
        WCuj9W/Qn1o4ggvFk6GpA9vdmtpyZs5lCidZ9wPFbArOqBpeg5GhU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59D7713609C;
        Mon,  2 May 2022 13:12:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B2AF413609B;
        Mon,  2 May 2022 13:12:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: plug a miniscule leak
References: <xmqqlevl4ysk.fsf@gitster.g>
        <5e8eff95-d768-439d-e2df-d575a0038ffd@github.com>
Date:   Mon, 02 May 2022 10:12:22 -0700
In-Reply-To: <5e8eff95-d768-439d-e2df-d575a0038ffd@github.com> (Derrick
        Stolee's message of "Mon, 2 May 2022 09:43:05 -0400")
Message-ID: <xmqqzgjzzwnd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 089523F0-CA3B-11EC-8FAD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> -	if (option_origin != NULL)
>
> This technically wouldn't hit your rule, since "E" isn't just the
> variable name, as we typically do with our style. Is that something
> that Coccinelle automatically simplifies?
>
>> +	if (option_origin != NULL) {
>
> Do you want to take this opportunity to drop the "!= NULL" here?
>
>> +		free(remote_name);
>>  		remote_name = xstrdup(option_origin);
>> +	}
>> >  	if (remote_name == NULL)
>
> Or do you want to keep similar style from the surrounding code?

I think that it is better to leave that particular clean-up to
the equals-null.cocci topic started by Elia; I know having them
separate would cause a merge conflict, but even if I change them
here, it will result in the same merge conflict anyway ;-)
