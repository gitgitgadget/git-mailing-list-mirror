Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2FA2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 02:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752261AbdKVCou (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 21:44:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53601 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752232AbdKVCot (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 21:44:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF80ABAB93;
        Tue, 21 Nov 2017 21:44:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8rLGAgBM+444bJ8bLDShahWSnLo=; b=MJGzqm
        OPVOFtL9sGlItIc7gYp9zu91ujgoJyPBuluKi4RdJWK8/aQv1uezShIrOxF2Ybtz
        2QA3ek5AwieqR27RXK0PJTTszuKyr6GAnUAZhGxhoNTwe+q5EroqoyooF8dc/viE
        +yINiJifgjdsA5ZuffCUe/B8jVmYKE48f0qdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iM2c+lwW/qIA3D+MeNpej5fHNaU1yI2Y
        mpTfQ07RIg0lGa9/t4+4x6aAevZvzFA4xaVh9sjVJwAdgFUJX0zaaXwi/KihvHja
        PvD5m1eUhVoWVhMNzmojVydysUK2udm2+kjx1l49FUMO0mNTf+Z1wy2PA2ZzVQLg
        oUb66roG1T0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E71DDBAB92;
        Tue, 21 Nov 2017 21:44:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68AEBBAB91;
        Tue, 21 Nov 2017 21:44:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v3 00/33] Add directory rename detection to git
References: <20171121080059.32304-1-newren@gmail.com>
        <CAGZ79kbVzDEv=rj7X6EhWZyAFd+fq+nwG8c+raqu9tXv_z9f4A@mail.gmail.com>
        <CABPp-BFm7ZcYbie-n-ASmb6MDyJXW3G8YdtHRAzpVNgOvwK5MA@mail.gmail.com>
Date:   Wed, 22 Nov 2017 11:44:46 +0900
In-Reply-To: <CABPp-BFm7ZcYbie-n-ASmb6MDyJXW3G8YdtHRAzpVNgOvwK5MA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 21 Nov 2017 17:12:05 -0800")
Message-ID: <xmqqpo8bvxpd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B2D52A0-CF2F-11E7-A233-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Interesting; tbdiff looks cool.  Junio hasn't queued this series yet,
> but it's easy enough to reconstruct the old one.  It does weigh in
> pretty heavy, and I'm slighly worried about gmail mangling all the
> lines, but I'm going to give it a shot anyway.  If it's too mangled,
> I'll try to repost using git-send-email.  It does weigh in at over
> 1600 lines, so it's not small.

It seems that you have installed tbdiff correctly.  The below seems
to match what I saw when I queued this round, relative to the
previous one.

What I often do when I see a new round of patches is:

    $ git checkout en/rename-directory
    $ git checkout master... ;# detach at the base of the old
    $ git am -s mbox ;# take the new 
    $ git tbdiff ..@{-1} @{-1}..

to compare the old and new.  Often (but not with this topic) earlier
parts of the topic are identical between the old and the new, so I
may rebase the new to preserve the commit timestamp of the old one
when it happens after the above sequence of commands.  For example,
if I see these in tbdiff

    1: 7893bf1720 = 1: f17207893b commit #1
    2: c291293b2e = 2: 93b2ec2912 commit #2
    3: a7d3c870a3 ! 3: 87b5e236a1 commit #3
        @@ ... @@@

then we know up to commit #2 are the same as before, so I'd do

    $ git rebase --onto c29129eb2e 93b2ec2912

by using the two commit object names on the last "=" line in the
output.  Then, running the same tbdiff again:

    $ git tbdiff ..@{-1} @{-1}..

would now show the output starting from "commit #3".
