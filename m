Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D19221F667
	for <e@80x24.org>; Wed, 16 Aug 2017 19:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbdHPTJt (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 15:09:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51643 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752175AbdHPTJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 15:09:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB3C0A4DC2;
        Wed, 16 Aug 2017 15:09:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZrLXSv99Tds+0Ieff/Oj3WHlSIc=; b=E7KnIg
        lEvdPozOUGDjPCUwcYZpDjPoG0PNnD40Tdr9ZPV/HIh6l6V8jHg3A8k6iiouH60K
        eK9xh+FCmRB9f2eUJl7db/rKTJbzEalApOJLWIL5NSzAdsg+2sMBGBE/ZTXL9FBa
        v62ZXG7WueMOTdUpHug8Y8EipOpvCwJfI4uU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m/gdUWG6vhKxFbG962Ya0q4MOWXZgQwx
        4zGrdkCyrULUHLfMORXldtcbw1TdYUN9Wo8OYQyUOU66qcqGYoVC5g1N1kJ/18ia
        mXlfAqaSF43UZEN3o3dCkQXmEEH/tQWLFWa7kvC2eUtKKGamL/UgiCgoYeWEfxxp
        zRX/OX0gwew=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2E3FA4DC1;
        Wed, 16 Aug 2017 15:09:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 346A2A4DBE;
        Wed, 16 Aug 2017 15:09:47 -0400 (EDT)
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
Date:   Wed, 16 Aug 2017 12:09:46 -0700
In-Reply-To: <09ce545a-31ff-aa9f-d03c-3cb68ed26230@gmail.com> (Kaartic
        Sivaraam's message of "Wed, 16 Aug 2017 23:43:09 +0530")
Message-ID: <xmqq378rl479.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7850E61A-82B6-11E7-80C3-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Wednesday 16 August 2017 12:28 AM, Junio C Hamano wrote:
>> Some refactoring to make it easier to reuse it from the new caller
>> would be necessary. 
> Sorry but I think I don't get that correctly. What's the "new caller"
> being referred to here?
> What should be refactored?

You said that "checkout" does not do a necessary check that is done
in "branch", so presumably "branch" already has a code to do so that
is not called by the current "checkout", right?  Then you would add
a new caller in "checkout" to trigger the same check that is already
done in "branch", but the code "branch" uses _might_ be too specific
to the kind of data the current implementation of "branch" uses and
it _may_ not be easy to call it directly from "checkout" (I didn't
check if that is the case).  If so, then the check implemented in
the current "branch" may need to be refactored before it can easily
be called from the new caller you would be adding to "checkout".


