Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E4DC433E0
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 17:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0AF20787
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 17:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AWSyBc+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGVR0L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:26:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59680 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGVR0L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 13:26:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59041D2130;
        Wed, 22 Jul 2020 13:26:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LGYanyhhDproL1YbxvlJMpd8Jhg=; b=AWSyBc
        +7KJSlKWSVOu6ZKBSc6/GJ4FAvpjSPIovk8eWw4pCRDaIBv3GX/HTvjpHb3T7+QO
        Omg16wi7tOpCsi8ECaxSZqdhAgbQ4R6Nzv8/3aqFuickIMgnAyN11m5wxIsHpeNX
        CMaR4aVFNTjx2wrQlG2Ow8BZxz66cwSZcWSsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oPmTOyCBZhVb8e9RVIfL6SPi+wyKpt73
        pnTfBdXKYW7aGTHIdRnvW8b14oxCN1cUvjNEloyYK+k6/Y6BX5675pN3QZ0jDdhK
        L4GBn8s5nQbRneG647cImB7cHzgFusXrqeOEUtZqFBvMg18Y74/cfz6bN4oav1by
        RY0fHsEe7Sc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 51F85D212F;
        Wed, 22 Jul 2020 13:26:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9BD94D212E;
        Wed, 22 Jul 2020 13:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <20200722074530.GB3306468@coredump.intra.peff.net>
Date:   Wed, 22 Jul 2020 10:26:04 -0700
In-Reply-To: <20200722074530.GB3306468@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 22 Jul 2020 03:45:30 -0400")
Message-ID: <xmqqmu3r5umr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CFA4C94-CC40-11EA-BB1D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jul 22, 2020 at 07:50:08AM +0200, Johannes Sixt wrote:
>
>> Am 22.07.20 um 01:29 schrieb B. Stebler:
>> > I have been looking for a tool to display merge conflicts, that instead
>> > of showing the two versions of the conflicting section, would show the
>> > diff for that section in both conflicting commits.
>> 
>> Perhaps you want to configure `merge.conflictStyle=diff3`? It does not
>> exactly show a diff, but it writes the base version of the conflicted
>> part in addition to "ours" and "theirs".
>
> Yeah, I find diff3 is usually sufficient. But the contents of the base,
> "ours", and "theirs" sides are also available in the index:
>
>   # diff between base (stage 1) and ours (stage 2)
>   git diff :1:file :2:file
>
>   # diff between base (stage 1) and theirs (stage 3)
>   git diff :1:file :3:file
>
> I thought we had added nice aliases for "ours" and "theirs" instead of
> the hard-to-remember stage numbers, but I think we only did so for
> things like "git checkout --ours", etc.
>
> The big downside here, of course, is that it's showing the diff for the
> whole file, not just one hunk (on the other hand, I often find the
> trickiest conflicts are ones where the changes unexpectedly span
> multiple hunks).

Yup, I often find myself comparing the base part (lines between |||
and ===) with our part (lines between <<< and |||) and their part
(lines between === and >>>) while looking at the diff3 output to see
what unique change each side did, in order to come up with a
conflict resolution.

I do this often enough to wonder if I should write a small "filter"
that I can pipe a whole "diff3" <<< ... ||| ... === ... >>> region
to and convert it into to diffs, but not often enough to motivate
me to actually write one ;-).
