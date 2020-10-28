Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63887C55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBB224724
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 21:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lRxH/AFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgJ1Vrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:47:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61223 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgJ1Vrr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 17:47:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78A3D8AD23;
        Wed, 28 Oct 2020 16:12:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AEEylZj6YcJrEaxBo39Wpluii1E=; b=lRxH/A
        FvjZP2rTsqVBhwmk+pfWbY3u3BMnoZ4KTH5A/mjMXzsLqMtNyb4o95BfbA1ZMvy5
        D1tg02iBlaNjQaClQqNP4/H4d7TB7dyxaFgR8wqvHWK8nRYTWm30GZi6QUtEa/W9
        bESlFqx6OnCasCrQ22rtGrRhYSOoxXIPFey54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MLzHYgkVXCF6QRV3p/7KitrBKWedUh2a
        EW8SaMDmaDkU639/VGtZmKzF7Oc/+1PxW+TNTNfT6wsVPHfkwQEmkQG/dvNtZS86
        q4pN+o2F1NW9XUG3V2kcVTGu189rfBCteOz9UH/AviWNnJiilELTkds7wcMLd/wm
        xC2srKnhS0o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 706128AD21;
        Wed, 28 Oct 2020 16:12:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF5538AD20;
        Wed, 28 Oct 2020 16:12:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] t5411: start using the default branch name "main"
References: <pull.760.git.1603839487.gitgitgadget@gmail.com>
        <f997166db4c29d971a2343f70c9d9a0505a8cc4b.1603839487.git.gitgitgadget@gmail.com>
        <xmqqa6w69l3j.fsf@gitster.c.googlers.com>
Date:   Wed, 28 Oct 2020 13:12:00 -0700
In-Reply-To: <xmqqa6w69l3j.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 28 Oct 2020 13:00:48 -0700")
Message-ID: <xmqq5z6u9kkv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D740D30A-1959-11EB-935B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
>> +	test_skip="In transit for the default branch name 'main'"
>> +	test_done
>> +}
>> +
>
> IOW, I do not see the point in _conditionally_ skipping the rest of
> the test in this step.  I'd however understand it if we always skip
> the rest in 1/4 and then enable the rest only when testing with
> 'main' as the default in 4/4, when all the necessary pieces in
> t/t5411 have been converted.

Another way to protect the test well would be to keep the "unless
testing with master, skip all" prerequisite check you wrote above,
but add

    GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master

immediately before that.  We can flip it to use 'master' at the
final step in the series.

That way, we will not be affected by the GIT_TEST_* environment
variable that is passed to these scripts by the tester.  I think
I'd prefer to do it that way, instead of unconditionally skipping,
as the result would be more self explanatory.

Thanks.
