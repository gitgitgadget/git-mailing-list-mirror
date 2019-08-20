Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B16F01F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfHTSYd (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:24:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53442 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfHTSYd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:24:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 136487AA56;
        Tue, 20 Aug 2019 14:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bUorTOrlgCUC+lUO8byjyw4AHAM=; b=CwQTtq
        kJO9D0uiIw8ARjZhFKFOnVscejJlbMg75xljp7/rqoq9e3414B+WP5trvQAlpnfU
        QjTQmsU6T3xwFUTWClo4YVBtP55iHkSj9v+g/fxPQI00i6tvwhR+W6xzR3ygmA4G
        61TTIjOsqOLj9uvAjhUun1WhCc0MQfVfWe4ko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uOj3fEnviFBKAFAB13Q/ltcoIR0lnPfh
        IVqEB1QQQ4MxLstrJ9qJLQdN+1dBX1DiUQ0NxP50K3tEJBFkQsrKZKNLavMl+Hqo
        Npa5s/21IZfBenLjbwAyJCkyGkTv5BwLM6r/IULZljPCXucNLjm07HgEBSxnGtQG
        DfOG4/M1EIA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09C317AA55;
        Tue, 20 Aug 2019 14:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 356E67AA53;
        Tue, 20 Aug 2019 14:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/2] apply: reload .gitattributes after patching it
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
        <20190818184403.861907-1-sandals@crustytoothpaste.net>
        <20190818184403.861907-3-sandals@crustytoothpaste.net>
        <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
        <20190820024505.GH365197@genre.crustytoothpaste.net>
        <18fcc7db-7c09-3fbf-1e3f-81be99f4bb17@gmail.com>
Date:   Tue, 20 Aug 2019 11:24:28 -0700
In-Reply-To: <18fcc7db-7c09-3fbf-1e3f-81be99f4bb17@gmail.com> (Phillip Wood's
        message of "Tue, 20 Aug 2019 09:52:48 +0100")
Message-ID: <xmqqd0gzvgo3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C01111A6-C377-11E9-9611-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> Do you know why -m and -i aren't affected?
>>
>> I had to look, but I believe the answer is because they use the
>> sequencer, and the sequencer calls git merge-recursive as a separate
>> process, and so the writing of the tree is only done in a subprocess,
>> which can't persist state.
>
> The sequencer has been running in a single process for a while now. We
> do fork for 'git merge' sometimes when processing 'merge' commands but
> 'pick' commands are all done in a single process by calling
> do_recursive_merge().
>
> Best Wishes
>
> Phillip
>
>> Should we move the merge-recursive code into the main process, we'll
>> likely have the same problem there.

So we actually have the same issue already?
