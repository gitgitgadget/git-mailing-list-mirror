Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497CC20286
	for <e@80x24.org>; Tue, 12 Sep 2017 06:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbdILGtV (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 02:49:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61083 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750987AbdILGtU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 02:49:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 071C090C94;
        Tue, 12 Sep 2017 02:49:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9c/sUydTXuFyiAgpfC2rdolVQW0=; b=kxl53R
        i5+njIWGgb4JhcLcE6vBNEuCsacSrBPlXEEfp0/2rF6sq/nlN8lXcGq9Y0WFHQFf
        XWNZPHOMhZUu4qE/Yj3W3NZ4jmsTQTbbJJz03ElMOBtuSazh5ehGnYQ8LkfC0X2O
        mf1N/BEwNgJWjzH8/SMYtcwa95by/Yju7qAXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hUQ0vFQM+gyUsep1G7QUWcWyt1WBVi+R
        oYeSKIFb9Q9frwXu4YGV7/pub0f1+7VpaolN/x7VboCUYvCMj8Ywbb9pSfEJcHRi
        +pFkNop3p2o+U4qpJJlnwGQXtrDsxbxU2S0tV+eL9Rk5shX4Yl75XX62ZZh+Nzpd
        2maQp3SNTxY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F17E390C90;
        Tue, 12 Sep 2017 02:49:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A23490C8F;
        Tue, 12 Sep 2017 02:49:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
Subject: Re: [PATCH v3 1/2 / RFC] builtin/branch: stop supporting the use of --set-upstream option
References: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
        <20170814085442.31174-1-kaarticsivaraam91196@gmail.com>
        <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
        <772aaebf-81ea-ac22-9d2f-35d0778f502f@gmail.com>
        <xmqqfucsr73w.fsf@gitster.mtv.corp.google.com>
        <09ce545a-31ff-aa9f-d03c-3cb68ed26230@gmail.com>
        <xmqq378rl479.fsf@gitster.mtv.corp.google.com>
        <1502935475.1710.5.camel@gmail.com>
Date:   Tue, 12 Sep 2017 15:49:18 +0900
In-Reply-To: <1502935475.1710.5.camel@gmail.com> (Kaartic Sivaraam's message
        of "Thu, 17 Aug 2017 07:34:35 +0530")
Message-ID: <xmqqtw081kep.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 805ED63E-9786-11E7-94CB-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Wed, 2017-08-16 at 12:09 -0700, Junio C Hamano wrote:
>> You said that "checkout" does not do a necessary check that is done
>> in "branch", so presumably "branch" already has a code to do so that
>> is not called by the current "checkout", right?  Then you would add
>> a new caller in "checkout" to trigger the same check that is already
>> done in "branch", but the code "branch" uses _might_ be too specific
>> to the kind of data the current implementation of "branch" uses and
>> it _may_ not be easy to call it directly from "checkout" (I didn't
>> check if that is the case).  If so, then the check implemented in
>> the current "branch" may need to be refactored before it can easily
>> be called from the new caller you would be adding to "checkout".
>> 
>> 
> Thanks. Now I get it. What about doing that check in
> branch.c::create_branch or branch.c::validate_new_branchname? I guess
> creating a branch named HEAD isn't that good an idea in any case. Doing
> the check there might prevent a similar situation in future, I guess.
> Further "branch" and "checkout" do call branch.c::create_branch which
> in turn calls branch.c::validate_new_branchname.

The above analysis sounds sensible, so it appears that you already
found a function that is shared in the two codepaths, and have a
good plan to make them consistent?

I was sweeping my mailbox to collect loose ends that haven't been
tied down, and noticed that this topic does not seem to reach a
conclusion.  Do we want to reboot the effort?  Or should we just
throw it in the #leftoverbits bin for now?

Thanks.
