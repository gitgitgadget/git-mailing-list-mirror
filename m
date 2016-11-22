Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068711FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 23:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934100AbcKVXhh (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 18:37:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63563 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932474AbcKVXhg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 18:37:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B2E6519E2;
        Tue, 22 Nov 2016 18:37:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K+tBq2HHV0+J7jhyT0mgORFKPXc=; b=GTQMlx
        5MIsKoJSTQ4I3bdFkd6mFcFlquK+XaKTNyS1tuatcPJkvrMktsuELLlnvfvtM65u
        cSifKPxebCcxZY4t0XBUNyCj/Ugovp1q8Z8JOor5XREqmYLvOt7rHmhMcIQ3N3YW
        E7svpTENaMXGYGCglUVFfHHsN48ntXPQhThfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s9/M281l+w+i/rAXmiPWcqyRXk8LfsDA
        rS4E88h/zn70XRENVnSQCoF2gLsEpnajluhsXEeTb++SfuuYpV6w3x0Ds7p8Xqt9
        mVw5NoIf5mpQ0zmVjHZc7O9mLnEjB93kwVM0KsOW+OVGrNLkdJw2mHmNOxDxcVVH
        x8Q5RvolAxA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5224A519E1;
        Tue, 22 Nov 2016 18:37:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAAED519E0;
        Tue, 22 Nov 2016 18:37:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v5 5/6] grep: enable recurse-submodules to work on <tree> objects
References: <1479499135-64269-1-git-send-email-bmwill@google.com>
        <1479840397-68264-1-git-send-email-bmwill@google.com>
        <1479840397-68264-6-git-send-email-bmwill@google.com>
        <xmqqshqjnmtc.fsf@gitster.mtv.corp.google.com>
        <20161122232105.GC65825@google.com>
        <20161122232815.GD65825@google.com>
Date:   Tue, 22 Nov 2016 15:37:33 -0800
In-Reply-To: <20161122232815.GD65825@google.com> (Brandon Williams's message
        of "Tue, 22 Nov 2016 15:28:15 -0800")
Message-ID: <xmqqk2bvnl1e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A510A5AE-B10C-11E6-832B-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> > So this change may have an impact on "git ls-tree -r" with pathspec;
>> > I offhand do not know if that impact is undesirable or not.  A test
>> > or two may be in order to illustrate what happens?  With a submodule
>> > at "sub/module", running "git ls-tree -r HEAD -- sub/module/*" or
>> > something like that, perhaps?
>> 
>> Maybe unrelated, but it looks like wildcard characters are overridden in
>> ls-tree.c per '170260ae'.  As such wildmatching just doesn't work with
>> ls-tree.  so `git ls-tree -r HEAD -- "*"` results in no hits.
>
> Wrong commit.  Its this one (f0096c06bcdeb7aa6ae8a749ddc9d6d4a2c381d1)
> that disabled wildmatching since it is 'plumbing'

OK.  Things that share tree-walk other than "ls-tree -r" are still
affected, no?
