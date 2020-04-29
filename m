Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E08C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1245A205C9
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n+m2eIh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD2TYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:24:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53352 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2TYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 15:24:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 51483C972E;
        Wed, 29 Apr 2020 15:24:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QbySkCC5URyIzDkYfIsEi/hb5zc=; b=n+m2eI
        h+MxR8lTcq+HVTOXH/KIcwb+ASxuZ+0T06kal9X9HMdSUCbeMPQOCGalsj1zqhr1
        JM0kS1h6n1gyAyxyIRxgFDU+FRJKY48hnihzqOWYAWZtYOXuApyRfzEPsDvhHcqw
        tmkVrp+Ly9aB3jJB7dQVEXgozkBX89TWOUK6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MYCSiTqfOIzq8rcKWWP6nITLOdr23txg
        fw7tnd6zB8ttKbQ6G7U36kcS00zSnmt5KdcU572FgPzbM4qOLtj1Mc0tYqdDnUM0
        8s5eLzCFm9mbD0cV/NQlRYARN0QA6ZsnGhZUMT5ZZ6wKWm3Qhv3D4A1ltz5cMsYN
        yofJ2mJO6ew=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4970FC972B;
        Wed, 29 Apr 2020 15:24:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 956FBC9729;
        Wed, 29 Apr 2020 15:24:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] lib-submodule-update: pass OVERWRITING_FAIL
References: <cover.1588162842.git.liu.denton@gmail.com>
        <22eacd20a8213c3281974a6c103fd2d00c95efaa.1588162842.git.liu.denton@gmail.com>
Date:   Wed, 29 Apr 2020 12:24:48 -0700
In-Reply-To: <22eacd20a8213c3281974a6c103fd2d00c95efaa.1588162842.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 29 Apr 2020 08:22:26 -0400")
Message-ID: <xmqqpnbqw0vz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17E6C756-8A4F-11EA-8CBA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> We are using `test_must_fail $command`. However, $command is not
> necessarily a git command; it could be a test helper function.
>
> In an effort to stop using test_must_fail with non-git commands, instead
> of invoking `test_must_fail $command`, run
> `OVERWRITING_FAIL=test_must_fail $command` instead. Increase the
> granularity of the test helper functions by specifically choosing the
> individual git invocation which is designed to fail.

Sorry, but I do not know why this is a good idea.

>  test_submodule_switch_common () {
> +	OVERWRITING_FAIL=
>  	command="$1"
>  	######################### Appearing submodule #########################
>  	# Switching to a commit letting a submodule appear creates empty dir ...
> @@ -443,7 +446,7 @@ test_submodule_switch_common () {
>  		(
>  			cd submodule_update &&
>  			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
> -			test_must_fail $command replace_sub1_with_directory &&
> +			OVERWRITING_FAIL=test_must_fail $command replace_sub1_with_directory &&

Here, $command may or may not be a git command and more importantly,
it could be a shell function, right?  Then we need to take it into
account that 

	VAR=VAL shell_function args...

will not work, no?

Some shells do not make this a single-shot environment variable
assignment that will not persist once the single function invocation
returns.

