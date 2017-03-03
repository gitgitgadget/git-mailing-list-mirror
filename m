Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A3820279
	for <e@80x24.org>; Fri,  3 Mar 2017 19:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbdCCTN5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 14:13:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50203 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751820AbdCCTNw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 14:13:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEEA964138;
        Fri,  3 Mar 2017 14:05:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aTOK68ySVSE1wpU0F6GWY+1OcYM=; b=AJ/lr4
        hzq7asw9mph7WdIJ4ljoc6nZYmbfj6PQhhOcRYBr5RHdKasooWMcJ40DeiyExUBX
        ECcfreviGqBGV1rH6KD0oahqIxRAGe1IBjRMUuoFP2Opvcs0ok706nYPO7kyUoD9
        voMuk6+AXcyJvMf2UWdrS78SRiYe8I3jt0fmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fgOAZtfzIqrfbY2l1Q6Z8e8+iF8ZQflF
        TodTBmObVQK5q4Wpv5rh9egJjtbR5EyY81PcUtxl6NHZITaw8EeFPWSRCMkRJ3P4
        ccrJ10dlo0s+izj6t4LwltfxhtpCdOYdftcjFKJgVl9+2LSV7OVi5Cj3ns4poaqI
        ZLqYWGUHyps=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E798264137;
        Fri,  3 Mar 2017 14:05:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E63A64135;
        Fri,  3 Mar 2017 14:05:21 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, sschuberth@gmail.com,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 3/3] config: add conditional include
References: <20170224131425.32409-1-pclouds@gmail.com>
        <20170301112631.16497-1-pclouds@gmail.com>
        <20170301112631.16497-4-pclouds@gmail.com>
        <xmqqo9xkhosj.fsf@gitster.mtv.corp.google.com>
        <20170303063052.xkjoipuaohcwdl4n@sigill.intra.peff.net>
Date:   Fri, 03 Mar 2017 11:05:20 -0800
In-Reply-To: <20170303063052.xkjoipuaohcwdl4n@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 3 Mar 2017 01:30:52 -0500")
Message-ID: <xmqq4lza9o5r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 594149BC-0044-11E7-8006-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That was how I had originally envisioned the namespace working when I
> introduced include.path long ago. And I think Duy's v1 used that, but
> the feedback was that it was not sufficiently obvious that the
> subsection was a conditional.

I am not sure about "obviousness", but I agree that we do not know
that "conditional include" would be the only thing we want for the
second level for "include.path" directive.  "include-if.<cond>.path"
is better for that reason.

I presume that you could still do

	[include "if:gitdir=$path"]
		path = ...

i.e. design the second level to begin with a token that tells
readers what it means (and assign "if:" token for "conditional
include"), but I do not think it is worth it.

I also imagine that

	[include]
		condition = ...
		path = ...

is easier to read and write by end-users, but it probably is not
feasible because it requires too invasive change to the current code
to teach it to grok such construct.

Between "include-if" and "includeIf", if people find the latter not
too ugly, I'd prefer to keep it the way Duy posted.  Because of the
way "include.path" and "include-if.<cond>.path" work, we can declare
that they are not like ordinary configuration variable definition
at all but are higher-level directives and that may be a sufficient
justification to allow "-" in its name, though, if people find
"includeIf" too ugly a name to live.

