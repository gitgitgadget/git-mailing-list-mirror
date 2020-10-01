Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ECCC4363D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 00:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A552087D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 00:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xqqYmhLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbgJAAbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 20:31:11 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62626 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730873AbgJAAbH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 20:31:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08C20102A3A;
        Wed, 30 Sep 2020 20:31:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dl9Lt5wSWCsv+7EG1qWS/N/bTNc=; b=xqqYmh
        LsgbeRhEQdjLVeWT77S7/sgeQGLiRRh2Y8S7b51j5oKjsZXrlCT351/14+5/CfY6
        CBjKthGSJ3QBFfZYKyW2L9jUS68MVMKGWBWVmtmlAR1s82Uv54+qVefKOzAGIHfP
        ba0nbQBjC2nb/PjPabm+07+KuKoFXpBHdwrWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LWSoMR4FugyLpO/FKTPR7nrYF60DvIdx
        2DeJPMVA4MdNFkQVEt7/86blOFJRTDW8m7sUZZCL0I6crNzrZg0mq7k8QZCuiv4k
        XR6aAMSG9PVggDQNXEI+IE4HClz3bVA46TGYdE0kQEhGp9JucaC8DiylIMruuepl
        N2nb3U7Y6iA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00E8A102A39;
        Wed, 30 Sep 2020 20:31:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4CBFD102A0E;
        Wed, 30 Sep 2020 20:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <20200930232138.3656304-2-shengfa@google.com>
        <xmqqpn62essa.fsf@gitster.c.googlers.com>
Date:   Wed, 30 Sep 2020 17:31:00 -0700
In-Reply-To: <xmqqpn62essa.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 30 Sep 2020 16:41:57 -0700")
Message-ID: <xmqq7dsaeqij.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6280201C-037D-11EB-AA2E-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +test_expect_success 'commit date shows timezone offset +0000 when user.hideTimezone is true and reset' '
>> +        git config user.hideTimezone true &&
>> +        git commit --amend --reset-author &&
>> +        git log -1 > output &&
>> +        grep "Date: .* +0000" output
>
> This one IS interesting, but keep the GIT_AUTHOR_DATE set and
> exported.  As long as that is from a timezone different from UTC, we
> are testing what we want to test here.

Note.

Once GIT_AUTHOR_DATE and friends are set fully including timezone,
we won't even read TZ because there is no need to.  But you can do
something along these lines:

	test_config user.hideTimeZone true &&
	(
		export GIT_AUTHOR_DATE=@1600000000 TZ=UTC-09 &&
		git commit ... &&
		git show -s --format='%aI' >output &&
		echo 2020-09-13T15:26:40+03:00 >expect &&
		...

I think (haven't actually tested) "git commit --date=<datestring>" option
is handled the same way, i.e. comparing these two would be a way not
to touch the environment variable.

    TZ=UTC-09 git commit --date=@1600000000 ... &&
    TZ=UTC-09 git -c user.hideTimeZone=true commit --date=@1600000000 ... &&
    git show -s --format='%aI' HEAD~1 >output0 &&
    git show -s --format='%aI' HEAD~0 >output1



    







