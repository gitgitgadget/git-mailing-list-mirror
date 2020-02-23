Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E29DC35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 06:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F271206ED
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 06:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="asd44FCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgBWGK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 01:10:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53388 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgBWGK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 01:10:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 158F2BE375;
        Sun, 23 Feb 2020 01:10:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dEwNBDHK6JbvshKXtoHatQNLDes=; b=asd44F
        Cd197mwr1aTDeNSaBAOMbZEwmjtdTQOU0jfdoXYNK9jr0mLOwRu4mEKwlBSUe8HD
        7TVYTJw9rzotXn4thkFv3n0Ozf+iYhECChaMaj3AIxzzVClLqhcglO+yLlnQwzI1
        4SrBvqbhEz50TYWz4xYqg255SlfezbvhtsGNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TUY9tVFuBmHYYCcOqoDr/yje+7eQx6Oq
        HSD2GT/yc8tcafVie6qN2JcnQLXqkulV99V68WYm61XaB/eB5A7EFjMWAbvLXk0a
        1gjh30MnEn/UE/Sb7GThVYg4cuQ6+KOhySKUVAo2KArWrp/WS0a7eZPV2sHxx+At
        dq7cqPpNNIw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 011C0BE374;
        Sun, 23 Feb 2020 01:10:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1969FBE373;
        Sun, 23 Feb 2020 01:10:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 3/4] bug: denyCurrentBranch and unborn branch with ref namespace
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>
        <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
        <b3e573d44a99a828e710f06b723942107189afeb.1582410908.git.gitgitgadget@gmail.com>
Date:   Sat, 22 Feb 2020 22:10:51 -0800
In-Reply-To: <b3e573d44a99a828e710f06b723942107189afeb.1582410908.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Sat, 22 Feb 2020 22:35:06
        +0000")
Message-ID: <xmqqk14dsuj8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FA9A8B0-5603-11EA-BAC8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_failure 'denyCurrentBranch and unborn branch with ref namespace' '

Please do not chdir around in the test script.  The next person who
adds new test after this test will be surprised that his/her test
does not start at the top-level of the test/trash directory, but in
the "original" subdirectory.

And no, adding "&& cd .." at the end of this &&-cascade is *not* a
fix---when any of the steps chained with && fails, such a "we have
moved the process to a wrong place, so let's move back with 'cd ..'"
will not get executed.

> +	cd original &&
> +	git init unborn &&
> +	git remote add unborn-namespaced "ext::git --namespace=namespace %s unborn" &&
> +	test_must_fail git push unborn-namespaced HEAD:master &&
> +	test_config -C unborn receive.denyCurrentBranch updateInstead &&
> +	git push unborn-namespaced HEAD:master
> +'

What is often done to fix is to execute what you need to run in a
subshell, e.g.

	test_expect_success 'demonstration' '
		(
			cd original &&
			git init unborn &&
			...
			test_must_fail git push ... &&
			git -C unborn config ... &&
			git push ...
		)
	'

The use of "git config" instead of "test_config" in the above
illustration is deliberate---the latter does not work and should not
be used inside a subshell.

> +
>  test_done
