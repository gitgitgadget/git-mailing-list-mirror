Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB061FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 02:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbcICCXJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 22:23:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54620 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751917AbcICCXH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 22:23:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92ECD3C366;
        Fri,  2 Sep 2016 22:23:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=/rNCDRnbCzimo+bKr/fwnxyocNU=; b=xIF+cIrkBaLMZX48w1u4
        JuemYv/PalrNTeKBD9CpRwv1nV6F1bAOZm9nKlzO4QCcH+ONKLkHXN+9vlWo7KAy
        rBnBxPidBC2bXubaNASIr8MdR2Ka+SZLMl2n2tUxu3szFOJ2KMUiioDBUQMWVf5z
        s521V2aj/uBGMkUWnRw1/Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=PgA0I1XdVL5rPEHe6Y8QxKA7jeoen6fnXvrgYw9ImJ38JG
        3mK04dkALTYzCs/YB3huozW71QwtNqX2a1eox10xOHxzXQBzaFATZG3pn/81vyvR
        cMBiTuCSMuBWeiTzF2HDwPjxr+s8BRKLq1Qmg6zlwveIuV5BIC9/rJQ3nfpnA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A82F3C365;
        Fri,  2 Sep 2016 22:23:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11F833C364;
        Fri,  2 Sep 2016 22:23:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer: support folding in rfc2822 footer
References: <1472846322-5592-1-git-send-email-jonathantanmy@google.com>
Date:   Fri, 02 Sep 2016 19:23:04 -0700
Message-ID: <xmqqy439rabb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5916B496-717D-11E6-9CF4-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Sample-field: multiple-line field body
>  that causes a blank line below

I am not sure this is unconditionally good, or may cause problems to
those with workflows you did not consider when you wrote this patch.

Not being too lenient here historically has been a deliberate
decision to avoid misidentification of non "footers".  Does Git
itself produce some folded footer line?  If Git itself produced such
folded lines, I'd be a lot more receptive to this change, but I do
not think that is the case here.

A slightly related tangent.  An unconditionally good change you
could make is to allow folding of in-body headers.  I.e. you can
have e.g.

	-- >8 --
	Subject: [PATCH] sequencer: support in-body headers that are
         folded according to RFC2822 rules

	The first paragraph after the above long title begins
	here...

in the body of the msssage, and I _think_ we do not fold it properly
when applying such a patch.  We should, as that is something that
appears in format-patch output (i.e. something Git itself produces,
unlike the folded "footer").
