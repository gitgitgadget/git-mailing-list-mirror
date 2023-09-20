Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B497CD4933
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 23:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjITXVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITXVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 19:21:45 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623E0C1
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 16:21:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CCD531A97EB;
        Wed, 20 Sep 2023 19:21:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=GPQKkIybjCdY6COld4fYK2g/kXfaAOXr/mVUYq
        /LyqI=; b=I9lzhxbgAURgYyHf5nNOdjrfs4gGYxa5S0gctSKLX59+9QdQtKxD9D
        LQ72uaidFiub+kWkAgS1Agat9MJl+l/7F8saGLfrgEI9wKSvphlfhtHt0ULRLdIM
        ZvT21K9pe/2xnJ6sfOw8c2UAdE9+RnaAOu/jjXrdpqb+GsZgPsi/M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C50571A97E9;
        Wed, 20 Sep 2023 19:21:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 343121A97E8;
        Wed, 20 Sep 2023 19:21:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/2] t/t6300: introduce test_bad_atom()
In-Reply-To: <xmqqy1h078tf.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        20 Sep 2023 15:56:28 -0700")
References: <20230920191654.6133-1-five231003@gmail.com>
        <20230920191654.6133-2-five231003@gmail.com>
        <xmqqy1h078tf.fsf@gitster.g>
Date:   Wed, 20 Sep 2023 16:21:38 -0700
Message-ID: <xmqqmsxg77nh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 734C77BA-580C-11EE-AFBD-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_bad_atom tag 'taggeremail:localpart trim' \
>> +	'fatal: unrecognized %(taggeremail) argument:  trim'
>
> It is strange to see double SP before 'trim' in this error message.
> Are we etching a code mistake in stone here?  Wouldn't the error
> message say "...argument: localpart trim" instead, perhaps?

I tried.  The fatal message does say ...argument: localpart trim" as
I suspected, when you ask for 'taggeremail:localpart trim'.

I think I know what is going on.  With the [PATCH 1/2] as-is, this
piece does not pass.  But because the error message from parsing
gets broken by [PATCH 2/2], after applying [PATCH 2/2], the error
message will become what the above test expects, hiding the new
breakage in the code.  And it probably was not noticed before you
sent the patches, because you did not test [PATCH 1/2] alone.




