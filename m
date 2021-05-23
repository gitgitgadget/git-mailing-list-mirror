Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A58FC47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 15:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B696611CB
	for <git@archiver.kernel.org>; Sun, 23 May 2021 15:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhEWPDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 11:03:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50217 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhEWPDY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 11:03:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 679C811F012;
        Sun, 23 May 2021 11:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=S3z9g0MERmnBGb8oiN+WXe2oV1zKiVcFziDXN0U69HU=; b=XW/G
        UZGFKXuh0TPshMRsBAqx7zvg7OG5ffPNxJsfXn4N8wZ6Q2/ML0SXBcx/m6nXqjpo
        MRbjzqctTZDHmyESIXrqVgboAvGNw7HA+xXMFM09U1MnRZ+rTGSBqv+QzT3YMllz
        n0/t9PIeJdySD4nZlma3ImYWWJbo/J/3/KHx968=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61F3911F010;
        Sun, 23 May 2021 11:01:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A765E11F00E;
        Sun, 23 May 2021 11:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>, git@vger.kernel.org
Subject: Re: fast forward merge overwriting my code
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
        <8f3d4d1e-18f4-ccb2-9439-80a5812c2f36@iee.email>
Date:   Mon, 24 May 2021 00:01:53 +0900
Message-ID: <xmqqo8d1o5ni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0992298-BBD7-11EB-BBAA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 22/05/2021 16:48, Andre Ulrich wrote:
>> .... Then I use
>>
>> git checkout master
>>
>> and
>>
>> git merge testing
>>
>> I would expect git to tell me "hey, wait, you have changed some of the
>> first lines in the .txt file. When you merge, your code on master will
>> be altered". But git just merges everything in.
> ...
> maybe `git merge --no-ff testing` for use of a command line option
>
> or setup your .gitconfig e.g. `git config --global merge.ff no`,
> but also `git config --global pull.ff yes` if you are using `git pull`
> (=fetch + merge)

I didn't get an impression that this has anything to do with
fast-forwarding, though.  The file in question has changes on the
"testing" branch since it forked from "master", and the user is
merging, i.e. the user _assumes_ that the tip of each branch suits
his/her purpose better than the tip of the other branch, hence wants
to take improvements on both branches incorporated into a single
history--- which is the point of "merging" the testing branch into
the master branch.  The result of merging might reveal that the tip
of the other branch wasn't as great as s/he earlier thought, in
which case s/he may want to undo the merge.  But if the result of
merging better suites his/her purpose, it would be an improvement
over where 'master' used to be (and it would also be an improvement
over where 'testing' used to be), and the world makes a progress.

In this particular case, the "master" side did not move since the
two branches forked, so the merge was to take improvements made on
"testing" into "master", and if the edit to the file in question
made on "testing" were bogus, the merging operation of course will
bring that breakage in, together with all the other changes.  Since
the lack of any progress on the "master" side does not change this
picture, I do not think fast-forwardness has anything to do with
what Andre is complaining about.

"git merge" cannot be expected to inspect the file and point out
"no, the edit they made on the testing branch is totally bogus,
don't merge it".  That is left for humans and tools other than Git
(like test suite) may help them.


