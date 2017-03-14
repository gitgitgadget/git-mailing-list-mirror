Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D417201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 17:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbdCNRlA (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 13:41:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59532 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753739AbdCNRk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 13:40:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98EE2697CC;
        Tue, 14 Mar 2017 13:40:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+cQBzgq4RXvUUVBEKrdRTOny5bY=; b=c0KhlK
        rp77orwfeVoz5BHye0NR/regXSbvf7xBI0kkm1YtwqB1VRnjj+QAuvAc3K/AuFBs
        cOyPODHL4FcDOfldxbynPaDagJGOH2ecJzkEj+gXCrqPiQMM9TV9EIu88IGlfqil
        W7v6g4J4OEyC65e8WeRVtHT26FC4RgwlZlYi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aqCZ9hvrRV5Zw5D2TGnUJOwkAMed9aGy
        /W1PLJa5TMaSsFscn5lsuZXcpY6jNhPRatQPVEGPIEct5hQSZjExf2Kt/gPizquQ
        go+5gw/+EP9d1kEM2NzDLSmkIhgKDq3CSIUQZ3J5INV+badtYUHB8FRyINCAxbpt
        gZBkx5dnjY8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 91A9A697CB;
        Tue, 14 Mar 2017 13:40:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09A21697CA;
        Tue, 14 Mar 2017 13:40:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 01/10] submodule--helper: add is_active command
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-2-bmwill@google.com>
Date:   Tue, 14 Mar 2017 10:40:50 -0700
In-Reply-To: <20170313214341.172676-2-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:32 -0700")
Message-ID: <xmqqh92vkb8d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E45EF20-08DD-11E7-916C-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> There are a lot of places where an explicit check for
> submodule."<name>".url is done to see if a submodule exists.  In order
> to centralize this check introduce a helper which can be used to query
> if a submodule is active or not.

    "Right now, is_submodule_initialized(), the underlying
    implementation of "submodule--helper is-active", checks exactly
    the same thing.  When submodule.<name>.url is set to a non-empty
    string, then it is initialized.  We'd want to change this
    definition in later steps of this series and having the checks
    centralized is a necessary preparatory step."

or something like that need to be tacked at the end to make it known
that 02-04/10 are meant as pure code clean-up without improvement in
behaviour.

"Tacking at the end" will make the whole thing awkward to read, and
that is because the flow of logic is inverted.  The first sentence,
"there are a lot of places...", is trying to state that there is a
problem worthy of fixing, but it does so without saying why it is a
problem in the first place.  After step 04/10 of this series, we
would still be able to say "There are a log of places where an
explicit call to "submodule--helper is-active" is done to see if a
submodule exists."  Is that still a problem?  The answer depends on
what motivated this change, and it is better to make the motivation
known in advance.

Here is my attempt to rewrite the whole thing.

    The definition of which submodules are of interest by the user
    is tied to the configuration submodule.<name>.url; when it is
    set to a non-empty string, it is of interest.  We'd want to be
    able to later change this definition, but there are many places
    that explicitly check this condition in the scripted Porcelain.

    Introduce the "is-active" subcommand to "submodule--helper", so
    that the exact definition of what submodule is of interest can
    be centrally defined (and changed in later steps).  In a few
    patches that follow, this helper is used to replace the explicit
    checks of the configuration variable in scripts.

You are adding the "is-active" subcommand, and the implementation
detail to do so is by using a new is_active() function, so the patch
title needs a bit of tweaking, too.

	Subject: submodule--helper: add is-active subcommand

> diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
> new file mode 100755
> index 000000000..f18e0c925
> --- /dev/null
> +++ b/t/t7413-submodule-is-active.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +
> +test_description='Test submodule--helper is-active
> +
> +This test verifies that `git submodue--helper is-active` correclty identifies
> +submodules which are "active" and interesting to the user.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	git init sub &&
> +	test_commit -C sub initial &&
> +	git init super &&
> +	test_commit -C super initial &&
> +	git -C super submodule add ../sub sub1 &&
> +	git -C super submodule add ../sub sub2 &&
> +	git -C super commit -a -m "add 2 submodules at sub{1,2}"
> +'
> +
> +test_expect_success 'is-active works with urls' '
> +	git -C super submodule--helper is-active sub1 &&
> +	git -C super submodule--helper is-active sub2 &&
> +
> +	git -C super config --unset submodule.sub1.URL &&
> +	test_must_fail git -C super submodule--helper is-active sub1 &&
> +	git -C super config submodule.sub1.URL ../sub &&
> +	git -C super submodule--helper is-active sub1
> +'

Looks sensible.

Thanks.
