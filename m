Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B011F461
	for <e@80x24.org>; Tue,  3 Sep 2019 22:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfICWZH (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 18:25:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54568 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfICWZH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 18:25:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 432261910F;
        Tue,  3 Sep 2019 18:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aP7/WdXiKa2OahoFZdvsLX4IN18=; b=DjzVHL
        DXWv3SxkipB/6RIXMIm9zKrmBj6/Tlke71AQc3NtTq3CO5rQoPB6bRWjpwG++bv1
        Ba63Ahr4Ln3Ql/K0BXJHJVxEM9d32tksviuHAYKiwF4ZfA4BeqRbZkQuPQmFoX9b
        fGSEdHLymOBHojGOmFBU0z2vlnNNd2jm9eEj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d/fD38IFpPPkx+2JUiFCBl8NIfj5yXL6
        hyZdmWAmquAZzETJ3Dh9xX4H0N+LddsvqqWBUq+0beImogtVBERd7WvOQzXTBRdx
        S2BpsfEhsVNtOFab30WcGTjy5J+tXVXuAE3EGJ2O1b0lpZFaDLJhIzQhWD6QTbov
        MQCAdVg5qCw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 368161910E;
        Tue,  3 Sep 2019 18:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CA111910C;
        Tue,  3 Sep 2019 18:25:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/4] t6006: simplify and optimize empty message test
References: <20190828002210.8862-1-newren@gmail.com>
        <20190903185524.13467-1-newren@gmail.com>
        <20190903185524.13467-2-newren@gmail.com>
        <xmqq1rwxt7eu.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHx7=kZJ5rgz5q8xRSbVtbE-UEHMyZxjvEq1tRXW7mCzQ@mail.gmail.com>
Date:   Tue, 03 Sep 2019 15:25:02 -0700
In-Reply-To: <CABPp-BHx7=kZJ5rgz5q8xRSbVtbE-UEHMyZxjvEq1tRXW7mCzQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 3 Sep 2019 14:58:12 -0700")
Message-ID: <xmqqk1aprpa9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACD8025C-CE99-11E9-A0EC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Ah, good catch.  I checked out the commit before 1fb5fdd25f0
> ("rev-list: fix --pretty=oneline with empty message", 2010-03-21), to
> try and see the error before that testcase was introduced.  I tried it
> on a repo with both an actual empty commit message, and one with a
> commit message consisting solely of a newline.  Both styles exhibited
> the bug that the testcase was introduced to guard against.

That's a good thing to know to decide what is a reasonable
thing to do here.

As we are creating two commits, perhaps adding one with and another
without the extra blank line may give us more diversity, and
explaining why we are adding two slightly different one
(i.e. because the original bug was there for both shapes of commits)
would help us not wasting the time we already spent discussing this
change ;-)

Of course, we can alternatively just keep the patch as-is and update
the explanation as to why we are testing with commits different from
the original when we are supposed to be making this change for
performance reasons (i.e. the symptom manifests either way, so why
not using the form that is easier to create?).

Thanks for working on this ;-)
