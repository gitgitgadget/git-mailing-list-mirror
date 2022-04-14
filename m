Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B92C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 18:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiDNSWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 14:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiDNSWF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 14:22:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7624033E13
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 11:19:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A83917DB5E;
        Thu, 14 Apr 2022 14:19:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qIkhw8DF4scJ2lIIYxjB9p5pt2MUF8UTF+/lrS
        8+fQo=; b=NwXFMbY8cDR+ttPajWpBRgRoGURk3Dg4j6azrXx2H0f3F9JNzOqqDw
        l+6zl8NoYuvWMpPLzgtq5GA5b4ALZaJZhHmkuMZKYqOkNmxcvLNXr51e+26fvpAq
        2VTYNqvhbf01IeJhwN6O4iaCTPz/DsyHO4YY1iQra9LSoBgZ2IMKk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D62117DB5B;
        Thu, 14 Apr 2022 14:19:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7FA9517DB5A;
        Thu, 14 Apr 2022 14:19:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Bare repositories in the working tree are a security risk
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqwnfs4kud.fsf@gitster.g>
        <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqbkx31sc0.fsf@gitster.g>
Date:   Thu, 14 Apr 2022 11:19:31 -0700
In-Reply-To: <xmqqbkx31sc0.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        14 Apr 2022 10:35:11 -0700")
Message-ID: <xmqq7d7r1qa4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FAF14F8-BC1F-11EC-BDA0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Yes, I mean that even the current directory will be ignored when
>> discovery is disabled.
>
> OK.
>
>>>                                                I am not sure that
>>> is realistically feasible (I am thinking of cases like "git fetch"
>>> going to the remote repository on the local disk that is bare to run
>>> "git upload-pack"), but if the fallout is not too bad, it may be a
>>> good heuristics.
>>
>> Good detail - I hadn't considered the impact on our own child processes.
>> I suspect this might be a huge undertaking. Unless there is significant
>> interest in this option, I probably won't pursue it further.

> I do not necessarily think so.  The entry points to transport on the

By "not" I meant "this might be huge? It may not be".  Sorry for
being unclear.

> server side are quite limited (and the client side is dealing with
> your own repositories anyway), and they already know which directory
> in the server filesystem to hand to the upload-pack and friends, so
> it would be a matter of passing GIT_DIR=$there when they call into the
> run_command() API, if they are not already doing so.
