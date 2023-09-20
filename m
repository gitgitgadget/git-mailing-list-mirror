Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6175CE79DE
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 15:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbjITPBq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235298AbjITPBk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 11:01:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6719091
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:01:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 109B136694;
        Wed, 20 Sep 2023 11:01:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ebDmCwS92OEMc7vQ0m6V5feJWjXke9ImzmEksa
        l0WGo=; b=eQ+sS8m5NdkDLgd9KYhvxXRcEciS/C7jFU0UnjHzfCSCYgiQEajNDG
        9POFBckYxuQfmfkK5bUaFEXTGUBokS7SIxGkWFuKh/KcTnQbCA2K7bQtpCHb7guI
        SIA4s5i/MYEFtvRiGbPJTyaG28iUZCTWhbyi4YCaM7Lt5S3f/YtoY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 07CF936693;
        Wed, 20 Sep 2023 11:01:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 256F836692;
        Wed, 20 Sep 2023 11:01:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v3 13/13] trailer doc: <token> is a <key> or <keyAlias>,
 not both
In-Reply-To: <20230919225926.2189091-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 19 Sep 2023 15:59:26 -0700")
References: <20230919225926.2189091-1-jonathantanmy@google.com>
Date:   Wed, 20 Sep 2023 08:01:28 -0700
Message-ID: <xmqq8r90dh2v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94810DBA-57C6-11EE-A2E7-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -248,34 +258,40 @@ With `add`, a new trailer will be added.
>>  +
>>  With `doNothing`, nothing will be done.
>>  
>> -trailer.<token>.key::
>> -	This `key` will be used instead of <token> in the trailer. At
>> -	the end of this key, a separator can appear and then some
>> -	space characters. By default the only valid separator is ':',
>> -	but this can be changed using the `trailer.separators` config
>> -	variable.
>> +trailer.<keyAlias>.key::
>> +	Defines a <keyAlias> for the <key>. The <keyAlias> must be a
>> +	prefix (case does not matter) of the <key>. For example, in `git
>> +	config trailer.ack.key "Acked-by"` the "Acked-by" is the <key> and
>> +	the "ack" is the <keyAlias>. This configuration allows the shorter
>> +	`--trailer "ack:..."` invocation on the command line using the "ack"
>> +	<keyAlias> instead of the longer `--trailer "Acked-by:..."`.
>> ++
>> +At the end of the <key>, a separator can appear and then some
>> +space characters. By default the only valid separator is ':',
>> +but this can be changed using the `trailer.separators` config
>> +variable.
>
> I think all the other patches will be a great help to the user, but I'm
> on the fence about this one. Someone who knows these trailer components
> by their old names might be confused upon seeing tne new ones, so I'm
> inclined to minimize such changes. I do think that the new names make
> more sense, though.

As long as the new names describe the world order better than the
old description, I do not mind rephrasing the documentation, and you
seem to find the more descriptive <keyAlias> easier to understand
compared to the non-descriptive <token>.  Adding a concrete example
(ack vs acked-by) is also a good change.

