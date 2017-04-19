Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05630207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 04:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdDSESF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 00:18:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54116 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750827AbdDSESE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 00:18:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D360484965;
        Wed, 19 Apr 2017 00:18:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Raz2dVjfrNKf5QXz2ZlX93aRHnY=; b=TvvtHv
        99cKQiTNKpEeEXCRGjn1/HsvCT9g7BCkFexoa9frUFJPMQikvlYIF4WJC6OmE1e7
        CIzXqCER5Nz4A472FY/2cDe4tV+bvr95ZqOrsL7y6ORMgryCh0cBi6cCzAvsSF0T
        hvtboKhTosaruNZQnqyX7h47yuZCZU9mwRZUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ODd6u4OtIT+8+gDMHEfwj3GYEWyQJBbI
        lvSSB8u3Scwz9RXXcHpLMG1P/6h4808R3UdjWx+0PBUG+Q9i8QohDTAgUnOnQwTW
        jzS+XyKyHk/YeKwS8fPO4C7XXyQX1hTrcKzhZwawGpHARFt/yFwnSZ7blOOsKoji
        l9FfSEb0RXM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAD0184963;
        Wed, 19 Apr 2017 00:18:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 296EB84962;
        Wed, 19 Apr 2017 00:18:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        jonathantanmy@google.com, philipoakley@iee.org
Subject: Re: [PATCHv2 4/4] builtin/reset: add --recurse-submodules switch
References: <20170418213725.7901-1-sbeller@google.com>
        <20170418213725.7901-5-sbeller@google.com>
Date:   Tue, 18 Apr 2017 21:18:00 -0700
In-Reply-To: <20170418213725.7901-5-sbeller@google.com> (Stefan Beller's
        message of "Tue, 18 Apr 2017 14:37:25 -0700")
Message-ID: <xmqqfuh5av47.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DB3B752-24B7-11E7-9DC1-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> git-reset is yet another working tree manipulator, which should
> be taught about submodules.
>
> One use case of "git-reset" is to reset to a known good state,
> and dropping commits that did not work as expected.
>
> In that case one of the expected outcomes from a hard reset
> would be to have broken submodules reset to a known good
> state as well.  A test for this was added in a prior patch.

When "git reset --hard" at the top-level superproject updates a
gitlink in the index to a commit that was different from what was
checked out in the working tree of the submodule, what should
happen?  Do we reset the tip of the current branch in the submodule
to point at the commit the index of the top-level records?  Do we
detach the HEAD in the submodule to point at the commit?  Something
else that is configurable?  Or do we just run "git reset --hard"
in each submodule (which may leave submodule's HEAD different from
what is recorded in the index of the superproject)?

"... to a known good state as well" does not help answering the above.

