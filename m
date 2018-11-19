Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEA261F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 03:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeKSOIP (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 09:08:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64047 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeKSOIO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 09:08:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36F362DFAC;
        Sun, 18 Nov 2018 22:45:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7zS6ea4xFYwrdRWx5zuCPb3gN6I=; b=if80FX
        zpjIK0PKAKCsv9FxgTOL5gQi7rOXaN5fLlzruAemsH+MOqf6BIGptsicyp8dN8oc
        YpnLcrmQKpbNQrRAqwvxjWgl+Baf3Aob1G5LkWj+IrO7AuRQkkvZ2mesZkq/msVz
        WEzbmQJ6FQl8NnrAqPHCu4NXneznWaa3m48gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FyKyVfZgu6dM4xx/Z5POmeCVsrZHNO6K
        ZrmYoF7coSw1OG/rrc5BCTtc9OVwFUM8McAGB11OOH17NSiG+sP3zvEvvxgeIqUB
        S0hzNRBSQOMaO+VIldLCKqkfIS/oHbQOVPXaOksC9i1ACZC+NAhnFFO9TX7SXx+w
        m5GpZZgL6us=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3115C2DFAB;
        Sun, 18 Nov 2018 22:45:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3CD832DFAA;
        Sun, 18 Nov 2018 22:45:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
References: <20181115005546.212538-1-sxenos@google.com>
        <xmqqd0r4i29w.fsf@gitster-ct.c.googlers.com>
        <CAPL8Zisv-Q04Y_jQzMN7G9fG9rkWwxh4travnSw6cG0ZUFivkA@mail.gmail.com>
        <xmqqftvxertd.fsf@gitster-ct.c.googlers.com>
        <CAPL8ZisfhNqN3gh0E_=mwXuBPGRZ9fKgyQ=HWNFx_9m2job-=g@mail.gmail.com>
Date:   Mon, 19 Nov 2018 12:45:53 +0900
In-Reply-To: <CAPL8ZisfhNqN3gh0E_=mwXuBPGRZ9fKgyQ=HWNFx_9m2job-=g@mail.gmail.com>
        (Stefan Xenos's message of "Sun, 18 Nov 2018 19:33:33 -0800")
Message-ID: <xmqq36rxenm6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EE7E77C-EBAD-11E8-84A5-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> writes:

>> I meant the project's history, not the meta-graph thing.
>
> In that case, we agree. The proposal suggests that "origin" should be
> reachable from the meta-graph for the cherry-picked commit, NOT the
> cherry-picked commit itself. Does that resolve our disagreement, or is
> reachability from the meta-graph also undesirable for you?

Sorry, I confused myself.

Yes, I do mind that the "origin" thing in the meta history to pin
the old commit whose contents were cherry picked to create a new
commit, which is separate from the old commit that was rewritten to
create a new commit.  The latter (i.e. the old one) I do not mind to
get retrieved when such a meta commit is fetched, and all of us of
course would want the new one, too (which is the whole point of
adding the meta commit to help other commits built on the old one
migrate to the new one).  But I simply do not see the point of
having to drag the history leading to "origin", and that is why I am
moderately against recording "the change in this came from that
commit via cherry-pick" in a meta commit.
