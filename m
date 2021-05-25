Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C367C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184A6613F9
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhEYGd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 02:33:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56915 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhEYGdy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 02:33:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 776F8135F78;
        Tue, 25 May 2021 02:32:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WfJ2RK8WomRzfd6E4RY/fLHgMniIIU1Bf/NSYM
        CrvSg=; b=T8X06sG/zwxyXo8V0chmt+pLg6B3aeLGkMcROTUnUEUYrA5mTsjwUe
        EG9wRPjBe8XTCcpw9JuJu6MHXH3CFvGL02Zs1cpuYhuOqCWPxQ6b4Ezs6EWtZKoD
        mrClY+36WPAN4uYve9Gw0mhHjvZcOkZdzO/oZLiQUt/wLOR4+2MNM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 605DD135F77;
        Tue, 25 May 2021 02:32:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 97775135F71;
        Tue, 25 May 2021 02:32:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
        <YKwMU13DOtTIgaeP@google.com>
        <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
        <YKwd2e5VxVmU6zqj@nand.local> <87fsybohy5.fsf@evledraar.gmail.com>
        <YKxBIP4lkoPeCYvb@nand.local>
        <68a2bf8f-07e8-b117-a3f4-862654c781b4@gmail.com>
Date:   Tue, 25 May 2021 15:32:21 +0900
In-Reply-To: <68a2bf8f-07e8-b117-a3f4-862654c781b4@gmail.com> (Derrick
        Stolee's message of "Mon, 24 May 2021 20:39:55 -0400")
Message-ID: <xmqqy2c3fhmy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F675EE0A-BD22-11EB-85E2-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> So we silently convert -1 to 2^64-1, and call it a day.
>
> That works for me. I'll send a v2 with that tomorrow unless someone
> presents a better option.

I'll queue with this tweak for tonight's integration run.

Thanks.

1:  d327f7d3b9 ! 1:  e2b05746e1 t1092: use GIT_PROGRESS_DELAY for consistent results
    @@ Commit message
         values may be different as those indexes have a different number of
         entries.
     
    -    Instead, use GIT_PROGRESS_DELAY=100000 to ensure that any reasonable
    -    machine running these tests would never display delayed progress
    -    indicators.
    +    Instead, use GIT_PROGRESS_DELAY=-1 (which will turn into UINT_MAX)
    +    to ensure that any reasonable machine running these tests would
    +    never display delayed progress indicators.
     
         Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ t/t1092-sparse-checkout-compatibility.sh: init_repos () {
      	(
      		cd sparse-checkout &&
     -		"$@" >../sparse-checkout-out 2>../sparse-checkout-err
    -+		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
    ++		GIT_PROGRESS_DELAY=-1 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
      	) &&
      	(
      		cd sparse-index &&
     -		"$@" >../sparse-index-out 2>../sparse-index-err
    -+		GIT_PROGRESS_DELAY=100000 "$@" >../sparse-index-out 2>../sparse-index-err
    ++		GIT_PROGRESS_DELAY=-1 "$@" >../sparse-index-out 2>../sparse-index-err
      	)
      }
      
    @@ t/t1092-sparse-checkout-compatibility.sh: init_repos () {
      	(
      		cd full-checkout &&
     -		"$@" >../full-checkout-out 2>../full-checkout-err
    -+		GIT_PROGRESS_DELAY=100000 "$@" >../full-checkout-out 2>../full-checkout-err
    ++		GIT_PROGRESS_DELAY=-1 "$@" >../full-checkout-out 2>../full-checkout-err
      	) &&
      	run_on_sparse "$@"
      }
