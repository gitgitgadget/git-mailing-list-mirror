Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E5120323
	for <e@80x24.org>; Wed, 22 Mar 2017 19:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935453AbdCVTaP (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 15:30:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64242 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936217AbdCVTaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:30:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9B9F7E890;
        Wed, 22 Mar 2017 15:29:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H/LoRlF/fAMo2EoMHR+nC4IXRV4=; b=vVEvH4
        4iFACvMvlWzEIojpCLNB43OSCN3skH5SCtktFECpJVHzeTxw7B6Lt8uI52uB8gPj
        KrCGfzwbfTGCtvrfwoSo4x9Uto38j1qRWXq8F6kFr2++Sx6PeeBoB2brP4xN+gO7
        c5Bb21AzV9guMbtMP+CSkYi8Sf489rsHrEyq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cBncryNt6CTq8Do659ooRmfCLEPqsjsG
        JO5taMYk8bZjvDpnmy0F7EN0TCMrRQAvNeyLNhUkP167hhZ7wmdu8zekwCjeOTsU
        a19eheImDJax8tZMdLKAPR+nel5zQixjOBG2NFUXVteujuEg6QSFMYXwHMG5gX1I
        iTWW16QeljA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1A4C7E88F;
        Wed, 22 Mar 2017 15:29:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D2DA7E88E;
        Wed, 22 Mar 2017 15:29:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
References: <20170322065612.18797-1-larsxschneider@gmail.com>
Date:   Wed, 22 Mar 2017 12:29:49 -0700
In-Reply-To: <20170322065612.18797-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Wed, 22 Mar 2017 07:56:12 +0100")
Message-ID: <xmqqwpbhjej6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EB2C6E92-0F35-11E7-8ACC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Therefore, we did the following:
> * Johannes Schindelin set up a Visual Studio Team Services build
>   sponsored by Microsoft and made it accessible via an Azure Function
>   that speaks a super-simple API. We made TravisCI use this API to
>   trigger a build, wait until its completion, and print the build and
>   test results.
> * A Windows build and test run takes up to 3h and TravisCI has a timeout
>   after 50min for Open Source projects. Since the TravisCI job does not
>   use heavy CPU/memory/etc. resources, the friendly TravisCI folks
>   extended the job timeout for git/git to 3h.

The benefit is that Windows CI does not have to subscribe to the
GitHub repository to get notified (instead uses Travis as a relay
for update notification) and the result can be seen at the same
place as results on other platforms Travis natively support are
shown?  

Very nice.

> Things, that would need to be done:
> * Someone with write access to https://travis-ci.org/git/git would need
>   to add the secret token as "GFW_CI_TOKEN" variable in the TravisCI
>   repository setting [1]. Afterwards the build should just work.

We need to make sure this does not leak to the execution log of
Travis.

For example, in https://travis-ci.org/git/git/jobs/213616973, which
is a log of the documentation build for #1335.6 ran for the 'master'
branch, you can see "ci/test-documentation.sh" string appearing in
the log twice.  This comes from "script:" part, which is the same
mechanism this patch uses to invoke the new script with sekrit on
the command line.

I am expecting that no expansion of "$GFW_CI_TOKEN" will be shown in
the output, but I've seen an incident where an unsuspecting 'set -x'
or '$cmd -v' revealed something that shouldn't have been made
public.  I want to make sure we are sure that the command line this
patch adds does not get echoed with expansion to the log.

Is GFW_CI_TOKEN known to be safe without double-quote around it, by
the way?

> Things, that might need to be done:
> * The Windows box can only process a single build at a time. A second
>   Windows build would need to wait until the first finishes.

Perhaps instead of accumulating pending requests, perhaps we can
arrange so that Travis skips a build/test request that is not even
started yet for the same branch?  For branches that are never
rewound, a breakage in an earlier pushout would either show in a
later pushout of the same branch (if breakage is not fixed yet), or
doesn't (if the later pushout was to fix that breakage), and in
either case, it is not useful to test the earlier pushout when a
newer one is already available for testing.  For branches that are
constantly rewound, again, it is not useful to test the earlier
pushout when a newer one is already available for testing.

> diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
> new file mode 100755
> index 0000000000..324a9ea4e6
> --- /dev/null
> +++ b/ci/run-windows-build.sh
> @@ -0,0 +1,55 @@
> +#!/usr/bin/env bash

I know this is not a usual scripted Porcelain that must be usable by
all users, but I do not see anything that requires bash-ism in the
script.  Can we just do "#!/bin/sh", avoid bash-isms, and follow the
usual coding guidelines in general?

> +[ $# -eq 3 ] || (echo "Unexpected number of parameters" && exit 1)

i.e.e.g "test $# = 3" || ...

> +# Check if the $BUILD_ID contains a number
> +case $BUILD_ID in
> +	''|*[!0-9]*) echo $BUILD_ID && exit 1
> +esac

Too deep an indent of a case arm, i.e. align them with case/esac, like

        case $BUILD_ID in
        ''|*[!0-9]*) echo $BUILD_ID && exit 1
        esac

Thanks.
