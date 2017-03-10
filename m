Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81AD11FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 22:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933094AbdCJWNP (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 17:13:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60774 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932731AbdCJWNN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 17:13:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEB656B27E;
        Fri, 10 Mar 2017 17:13:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EjUqsAsHhm5UV81tuAI8zJY9ptg=; b=OXW/1G
        0qLyrOqrK6Ywuv7fWQV6SUrkntbjTh/qoCkmSu61b3J3IRXVDImo+SKo7W4FDdeS
        YUhmp+EDAfQT7tffXpYp3NcYr7Vy7IxD5rfyo7JE+kBqNBz9nf7FjuF9Pxjcu8fz
        ZlKQTJIekz955zNI8ppOEjoey31s7H52B+Uvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UFSE2lrzDg2iwDIEUwe7IDWp3KVkIpDp
        sLJh+j/4TNidWqfvGMf0KvtuSIHMoag5wjGAau8gB0f1v2g3WI0GtxDZOsn/uYfi
        7heN3h2wkMt8beDFmadsZypOxSSCzjIVjhNwfBVz2NGpujc8ZH9EygsXCGYq2Ide
        6i7rVI320kM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C96156B27D;
        Fri, 10 Mar 2017 17:13:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4731B6B27A;
        Fri, 10 Mar 2017 17:13:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: git-push branch confusion caused by user mistake
References: <CABURp0pf=4BE=E7qeOmYAcqJb=qDeGJ1EFyfCf+hDtKjjMD=ng@mail.gmail.com>
Date:   Fri, 10 Mar 2017 14:13:10 -0800
In-Reply-To: <CABURp0pf=4BE=E7qeOmYAcqJb=qDeGJ1EFyfCf+hDtKjjMD=ng@mail.gmail.com>
        (Phil Hord's message of "Fri, 10 Mar 2017 13:44:30 -0800")
Message-ID: <xmqqzigswzk9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF929532-05DE-11E7-9712-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> I think git should be smarter about deducing the dest ref from the
> source ref if the source ref is in refs/remotes, but I'm not sure how
> far to take it.

My knee-jerk reaction is "Don't take it anywhere".  

Giving a refspec from the command line is an established way to
defeat the default behaviour when you do not give any and only the
remote, and making it do things behind user's back, you would be
robbing the escape hatch from people.

It often is useful in real-life workflow when "git push $dest
origin/master" does exactly the way it works now, which I actually
use myself.  Imagine that you have two repositories, use one of them
primarily to interact with the outside world and do your work, but
you then occasionally push from that primary repository to the other
one, instead of logging into the host that has the other one and
running a fetch on that host from the outside world.  Your "trying
to be clever when given a colon-less refspec" will force people to
type "git push $dest origin/master:origin/master" in such a case.


