Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D53D1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeAEUOb (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:14:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65021 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbeAEUOa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:14:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0265DCDEF9;
        Fri,  5 Jan 2018 15:14:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sVg4E8uN8gsg/TNN/mM5p8yM2B0=; b=NYctNM
        dCS3EtFKo8/7fqDQuN3L3lfo6GlZ7Rd2DMrP3FP6Tq3P5BopxZFjLrQJkOtguAa8
        i6haBgh8+NhrqkC9ojSbxm2idPvH7nkMrWnX3MyUtQd9lkzG5Bf/hN26mk5JULvw
        LnRs5dUsZvFoksbP2SA6pWhmhMzOiutVdqErA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M4FITAt58HF2KJse+qKuWIb3dDQYrv4C
        YDtFhcT+UIJYS//iWpw1EdMxbnGmo1whjjWC4RIP0ONIuNBuAn9qkmZsJNWwiEB8
        M3VbrN0PhzfqtTQ746D/zCmKty5o5wRqOUGXi3T0v4TpOqFZkYWO2qHXJidJsNy2
        bpC/eDT+ams=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ECB9ECDEF8;
        Fri,  5 Jan 2018 15:14:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69E36CDEF7;
        Fri,  5 Jan 2018 15:14:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Carl Baldwin <carl@ecbaldwin.net>, Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
        <20171225035215.GC1257@thunk.org>
        <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
        <3447055.jsE6nH3DQt@mfick-lnx>
Date:   Fri, 05 Jan 2018 12:14:28 -0800
In-Reply-To: <3447055.jsE6nH3DQt@mfick-lnx> (Martin Fick's message of "Thu, 04
        Jan 2018 12:54 -0700")
Message-ID: <xmqq4lo0cbbv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08F5437E-F255-11E7-872B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Fick <mfick@codeaurora.org> writes:

> These scenarios seem to come up most for me at Gerrit hack-
> a-thons where we collaborate a lot in short time spans on 
> changes.  We (the Gerrit maintainers) too have wanted and 
> sometimes discussed ways to track the relation of "amended" 
> commits (which is generally what Gerrit patchsets are).  We 
> also concluded that some sort of parent commit pointer was 
> needed, although parent is somewhat the wrong term since 
> that already means something in git.  Rather, maybe some 
> "predecessor" type of term would be better, maybe 
> "antecedent", but "amended-commit" pointer might be best?

In general, I agree that you would want richer set of "relationship"
than mere "predecessor" or "related", but I do not think "amended"
is sufficient.  I certainly do not think a "pointer" embedded in a
commit object is a good idea, either (a new commit object header is
out of question, but I doubt it is a good idea to make a pointer
back to an existing commit as a part of the log message).

You may used to have a set of n-patches A1, A2, ..., An, that turned
into m-patches X1, X2, ..., Xm, after refactoring.  During the work,
it may turned out that some things the original tried to do are not
sensible and dropped, while some other things are added in the final.
series.  

When n==m==1, "amended" pointer from X1 to A1 may allow you to
answer "Is this the first attempt?  If this is refined, what did the
earlier one look like?" when given X1, but you would also want to
answer a related question "This was a good start, but did the effort
result in a refined patch, and if so what is it?" when given A1, and
"amended" pointer won't help at all.  Needless to say, the "pointer"
approach breaks down when !(n==m==1).

