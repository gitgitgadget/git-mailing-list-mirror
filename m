Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56AB20193
	for <e@80x24.org>; Thu,  4 Aug 2016 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758810AbcHDQqQ (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:46:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758859AbcHDQpj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2016 12:45:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D613731548;
	Thu,  4 Aug 2016 12:45:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ggho+BrRx38X
	vhZ80HsIT8LsZVI=; b=UEYARIkbHXrIXoay3jcGgcvs0zy0xcV4mxRQgBlk3x0m
	5qxYs0nfeHAGgVboIbiVC7jo/aBoO4aYZdKl2i9Pnj3lFyYeImSF+uCUxfGWejRj
	xDguEo9oYwxRl/rSMdylWZI2cv6/IDjx6AAxAml1ssaSd+BSxYYb9bKswjJ8trA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=giaW/Y
	TLmkpNPuWVE1hOpUePIE1MKdwbYXfGbaMnAE/vH+FmMeADeM4tGp+VqB3qSBLJTR
	WH7/2fypQeWtqSYQSvSKCdMJ3iC8Kz3SDolV5ikFPMx13Nhtn1LPzyvksyQ/NMeR
	FVdgK724sCBMhckzdhrR2c0qJmNK6AzZuhzLk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDFBC31547;
	Thu,  4 Aug 2016 12:45:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D3BA31546;
	Thu,  4 Aug 2016 12:45:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Andrew Keller <andrew@kellerfarm.com>
Cc:	Git List <git@vger.kernel.org>
Subject: Re: obsolete index in wt_status_print after pre-commit hook runs
References: <5988D847-25A2-4997-9601-083772689879@covenanteyes.com>
	<2ED67396-2530-4D1C-8F21-1C30983DB9DC@kellerfarm.com>
	<CAPc5daWZofdZnE0VQyFX2sBQyEDvAPmU+4rmHe5rvh7eH001ZA@mail.gmail.com>
	<xmqqh9bqlfto.fsf@gitster.mtv.corp.google.com>
	<CDE30958-C112-4C26-A0EA-499BFCD4E07F@kellerfarm.com>
Date:	Thu, 04 Aug 2016 09:45:22 -0700
In-Reply-To: <CDE30958-C112-4C26-A0EA-499BFCD4E07F@kellerfarm.com> (Andrew
	Keller's message of "Wed, 3 Aug 2016 14:25:22 -0400")
Message-ID: <xmqq60rg5vq5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D70D0544-5A62-11E6-BD98-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Andrew Keller <andrew@kellerfarm.com> writes:

> In summary, I think I prefer #2 from a usability point of view, however I’m having
> trouble proving that #1 is actually *bad* and should be disallowed.

Yeah, I agree with your argument from the usability and safety point
of view.

> Any thoughts?  Would it be better for the pre-commit hook to be
> officially allowed to edit the index [1], or would it be better
> for the pre-commit hook to explicitly *not* be allowed to edit the
> index [2], or would it be yet even better to simply leave it as it
> is?

It is clear that our stance has been the third one so far.

Another thing I did not see in your analysis is what happens if the
user is doing a partial commit, and how the changes made by
pre-commit hook is propagated back to the main index and the working
tree.

The HEAD may have a file with contents in the "original" state, the
index may have the file with "update 1", and the working tree file
may have it with "update 2".  After the commit is made, the user
will continue working from a state where the HEAD and the index have
"update 1", and the working tree has "update 2".  "git diff file"
output before and after the commit will be identical (i.e. the
difference between "update 1" and "update 2") as expected.

If pre-commit were allowed to munge the index to have the file in
the "update 3" state, the resulting commit would have that version
of the file in its tree.  By definition, "update 1" and "update 3"
are different (that is what it means to allow pre-commit to munge
the index); where should the differences between "update 1" and
"update 3" go?  It is clear that pre-commit thought that the
contents in the "update 1" state is bad and "update 3" state is
better (that is why it made that fix), so after the commit is made,
we would want to have "update 3" in the index.  But what would you
do to the working tree file, which is in "update 2" state?  If you
do not do anything, "git diff" would show the remaining edit the
user had before starting the commit (i.e. difference between "update
1" and "update 2") plus a reversion of the edit pre-commit made
because what the working tree has, "update 2", is based on "update 1"
and has never heard of the change pre-commit did.

But leaving the working tree file as-is is the only safe choice, as
I do not think we want "git commit" to _create_ new conflict in the
working tree by attempting to merge (we _could_, and implementing it
would be a trivial thing to do by calling ll_merge() to three-way
merge "update 2" and "update 3" that are both based on "update 1",
but the result from the end-user's point of view is too _weird_).

So, I tend to think we should not allow pre-commit to munge the
index.  We should be able to detect fairly cheaply if pre-commit
munged the index by remembering the trailing SHA-1 of the index file
given to the pre-commit hook before running it, and reading the
trailing SHA-1 of the index file left after the pre-commit hook and
comparing them.  And we would yell at the user that his pre-commit
munged the index and abort.

Or something like that.



