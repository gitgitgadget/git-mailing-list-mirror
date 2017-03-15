Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8FB202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 16:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdCOQP3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 12:15:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61466 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751014AbdCOQOj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 12:14:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 839F37BFE9;
        Wed, 15 Mar 2017 12:14:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IfdlMuGVMmwoWk6+ho/Nh5mb7nQ=; b=RENIhZ
        A08AsAn3252826QtUJtDT0pYgPsJtYI8ZrB2CPqIdtcPY4gKIez7zsx25KsL3JDw
        mO0bGKRPZ9D8c9qToWgrQXPEPV+zYQG7u6tdgEVstZBnFD0TpOZrtofHQqjdP+IB
        okhL5MZc6PdxZsdL81OQmce5l0OhRuCPRtChU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d/V7onASsbghWwRh/h6nHGeko5lm0T5b
        yRKDm0EPJNTj4ktSs+1ng28sgncNx4InORvix6F/9QO6zK2rQZm9WBa3l6vHVUyL
        rwbWDblyWQtAJP03vMrdMbS51Mqv//b3VtKnLegYZussL0lFkWP8IJ/Gym8RGU7v
        9VeUHJTziV4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DB137BFE8;
        Wed, 15 Mar 2017 12:14:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC6177BFE7;
        Wed, 15 Mar 2017 12:14:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFD PATCH 3/3] name-rev: Allow lightweight tags and branch refs
References: <cover.1489581340.git.git@drmicha.warpmail.net>
        <db54f291407ef34080fe9e8c9dbdd482b4b3698d.1489581340.git.git@drmicha.warpmail.net>
Date:   Wed, 15 Mar 2017 09:14:35 -0700
In-Reply-To: <db54f291407ef34080fe9e8c9dbdd482b4b3698d.1489581340.git.git@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Wed, 15 Mar 2017 14:15:10 +0100")
Message-ID: <xmqqmvcmfrf8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C100CE4-099A-11E7-8E7F-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Consider the following:
> ...
> "git describe past present future" gives
>
> past
> past-1-g5ad942f
> future
>
> because (as documented) it does not consider lightweight tags, and thus
> has to describe present from the past.
>
> "git describe --tags past present future" gives
>
> past
> present
> future
> 
> because (as documented) it does consider lightweight tags.
>
> "git describe --contains past present future" gives
>
> past^0
> future~1
> future^0

Nice illustration to convince anybody that "git describe --tags
--contains" should give "past present future" (or "past^0 present
future^0").  I am not sure if it is a good idea in general to change
the output to include "present" when "--tags" is not given, though.

For _this_ example, it does give us a more useful result, but the
example was to constructed to illustrate the case where the new
behaviour is more useful, and does not serve to convince us that it
won't have negative impact X-<.
