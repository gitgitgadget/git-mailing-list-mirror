Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B19F20229
	for <e@80x24.org>; Tue,  1 Nov 2016 18:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbcKASLj (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 14:11:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60242 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752666AbcKASLi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 14:11:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87F3B4A2D4;
        Tue,  1 Nov 2016 14:11:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xvsqDjZ153vKcPIaGnVqLDWyJIE=; b=r/CPH2
        JSfEp38yBkETTCBTIAELZuL1adMHkSVR6bBNvV3l3aWNG1GXHFm3S88T05h8PM80
        bLpXLf6hfETTiJoulB9eB+0V7PpsQu9Dsl4pgrD6H/Vpv5ZuD0MJRC/eupuOw9NE
        xJ5Ypn8PCGAy9XVBARcRVJuu+8xT2NZL1VqIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xV9p4PrZDGTy/HzHW9FFF25dDQ7Y0BGB
        f/ZHBOFHn5bGs3Ldu0SQzKS0o0iqyUwiSf8AX4RvP2SDPfo/fzAmNAA4jPjRVNSu
        aPDEaz3fxuM2ATdz2NrGmnVjeqtFNcFDlwkB4lqhIcNPkqVsCh/lR9R/7oslpysK
        9K5qDNQTxO4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 804974A2D3;
        Tue,  1 Nov 2016 14:11:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 117414A2D2;
        Tue,  1 Nov 2016 14:11:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Halde\, Faiz" <fhalde@paypal.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git issue
References: <BY2PR0601MB16400EAC3E9683841907F4B2A2A10@BY2PR0601MB1640.namprd06.prod.outlook.com>
        <20161101174526.e2tilsriz2fqaru3@sigill.intra.peff.net>
Date:   Tue, 01 Nov 2016 11:11:34 -0700
In-Reply-To: <20161101174526.e2tilsriz2fqaru3@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 1 Nov 2016 13:45:26 -0400")
Message-ID: <xmqqy413oysp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0766146-A05E-11E6-8E59-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 01, 2016 at 10:28:57AM +0000, Halde, Faiz wrote:
>
>> I frequently use the following command to ignore changes done in a file
>> 
>> git update-index --assume-unchanged somefile
>> 
>> Now when I do a pull from my remote branch and say the file 'somefile'
>> was changed locally and in remote, git will abort the merge saying I
>> need to commit my changes of 'somefile'.
>> 
>> But isn't the whole point of the above command to ignore the changes
>> within the file?
>
> No. The purpose of --assume-unchanged is to promise git that you will
> not change the file, so that it may skip checking the file contents in
> some cases as an optimization.

That's correct.  

The next anticipated question is "then how would I tell Git to
ignore changes done to a file locally by me?", whose short answer is
"You don't", of course.

People may however wonder, if Git can make things more automatic if
the user is willing to tell her intention of what should happen to
"somefile" in the example above when an operation requested cannot
proceed while ignoring the local changes.  For example, "ignore my
change and overwrite as needed" could be such an instruction (and it
is obvious what should happen in that case when "git pull" was
done--just clobber it with the version from the other side).

As I do not think of other sensible alternative behaviour, and I do
not think Git should make it easy to lose local changes when the
user is doing things like "pull" [*1*], it leads to the longer
answer to the question, which is again "You don't" ;-).


[Footnote]

*1* Things like "git checkout [<tree>] [--] <path>", "git rm -f" and
    "git reset --hard" are ways to explicit request nuking the local
    changes, and presence of these commands do not contradict with
    "do not make it easy to lose local changes", of course.

