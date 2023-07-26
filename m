Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA58C0015E
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 04:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGZElQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 00:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZElN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 00:41:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475301989
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 21:41:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC5D021E01;
        Wed, 26 Jul 2023 00:41:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hcX2OjrFt64xKJDRU7krUNbPbCDxUIRAF/VwUH
        b2d+0=; b=kQaqqQD1OVWRwLLQzQe5EgDy3qMyKpnnjT8KmVzMm6kQzrqqEidM4l
        jJMMW52Qxu/kd4AlQMTVKzh/2LwUN8K9Ig9fE9sIe3brP+oA18i+6+FIdaiivy2I
        8wq0sBCsYRuByygr0WGYym+B/h6y3D4w4muhxr7sXOxUrKlH4XWSs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B57B521E00;
        Wed, 26 Jul 2023 00:41:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2288F21DFE;
        Wed, 26 Jul 2023 00:41:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Arver <linusa@google.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] SubmittingPatches: simplify guidance for
 choosing a starting point
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <5ec91d02b7ae767cc9b2395e1c0fa10e1424c0c5.1689314493.git.gitgitgadget@gmail.com>
        <xmqq5y6mpfhm.fsf@gitster.g> <owlyy1j3fo8d.fsf@fine.c.googlers.com>
Date:   Tue, 25 Jul 2023 21:41:06 -0700
In-Reply-To: <owlyy1j3fo8d.fsf@fine.c.googlers.com> (Linus Arver's message of
        "Tue, 25 Jul 2023 18:36:18 -0700")
Message-ID: <xmqqwmynffod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2B9E732-2B6E-11EE-A505-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

>>  * An very old but still severe bug in tagged versions would want to
>>    be fixed ideally not on top of 'maint' but on top of the latest
>>    tagged version in the same maintenance track.  E.g. if the commit
>>    X introduced the bug, you may ask "git describe --contains X" the
>>    oldest version the commit appears in, say "v2.30.0-rc2-gXXXXXX".
>>    Then you would run "git checkout -b fix v2.30.9" to start the
>>    branch to fix it.
>
> In this example, are we using v2.30.9 as a starting point, not v2.30.0
> because v2.30.9 is the latest tagged version that is in 'maint'? 

Yes, the example assumes that the last maintenance release for
v2.30.x series is v2.30.9.  But this kind of fix happening is
sufficiently rare and I do not think regular contributors should
have to worry too much about it.  If the affected area had tons of
changes between v2.30.9 and 'master', a fix on such an old base
would require a lot of work merging upwards, adjusting to newer
codebase, and it only makes sense to go that length for high value
fixes (aka "security patch").  The rules that apply for such a fix
would be vastly different (e.g. the review may be done behind closed
doors with small number of reviewers, not on the public list).

> I think this nugget of knowledge should be included in a v3 of this
> series. Will update.

So, while it may help improve understanding of the philosophy behind
the regular procedure to know, I am not sure it is worth spending a
lot of lines to describe it when we are giving a piece of advice for
general "bugfix and/or new development".  Some bugs are simply not
worth the trouble of going back for more than two maintenance
tracks to fix.

Thanks.



