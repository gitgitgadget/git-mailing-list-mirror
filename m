Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601FEC433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 00:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiEEATL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 20:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiEEATJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 20:19:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD0318B26
        for <git@vger.kernel.org>; Wed,  4 May 2022 17:15:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8452111FD1C;
        Wed,  4 May 2022 20:15:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y9PhWbwH+cazKkwDxIiF1UUwC51nIeOg8KLB12
        yzZko=; b=flg0qh8qxkz5ceVEgvHYdVfNcvzX7JU8TGgnWbpRloCyylot6qR2FJ
        FAQKXzChvI+SxzG0yhsWqw+iTJRzt6M+3thVFeQ8vMvOHIpmEuPBVfIhy/KIXtHg
        ZYevN6j5aJydmFzPFXD+Rqo4XoBigiYl3GUowV1T8vYtTmiHMfVyY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79D7D11FD1B;
        Wed,  4 May 2022 20:15:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DED9811FD1A;
        Wed,  4 May 2022 20:15:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 3/8] object-store: add function to free object_info
 contents
References: <20220328191112.3092139-1-calvinwan@google.com>
        <20220502170904.2770649-1-calvinwan@google.com>
        <20220502170904.2770649-4-calvinwan@google.com>
        <xmqqzgjztt7s.fsf@gitster.g>
Date:   Wed, 04 May 2022 17:15:27 -0700
In-Reply-To: <xmqqzgjztt7s.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        02 May 2022 16:23:03 -0700")
Message-ID: <xmqqv8ukkf6o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7827BD3A-CC08-11EC-A01E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	if (object_info->typep)
>> +		free(object_info->typep);
>> +	if (object_info->sizep)
>> +		free(object_info->sizep);
>> +	if (object_info->disk_sizep)
>> +		free(object_info->disk_sizep);
>> +	if (object_info->delta_base_oid)
>> +		free(object_info->delta_base_oid);
>> +	if (object_info->type_name)
>> +		free(object_info->type_name);
>
> 	if (PTR)
> 		free(PTR);
>
> can and should be written as
>
> 	free(PTR);
>
> If we are reusing object_info after calling this function, we
> _might_ want to use FREE_AND_NULL() instead of free().

> As this breaks my build cycle ("make sparse" is part of my
> post-integration check), I have added this workaround on the tip of
> the topic, but please make sure I do not have to redo that when you
> reroll.
>
> Thanks.

Again, this breaks the build at GitHub CI (static-analysis), I added
this workaround on the tip of the topic, merged it to 'seen' and
pushed the result out, but please make sure I do not have to redo
that when you reroll.

Thanks.
