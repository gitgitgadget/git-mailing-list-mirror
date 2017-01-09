Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E7B1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 22:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764262AbdAIWxp (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 17:53:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53613 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753301AbdAIWxo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 17:53:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A6FE5FD10;
        Mon,  9 Jan 2017 17:53:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CtGbVkPDoYft
        D9MTMEProOonc18=; b=BaxDbc6gShN2MqGBdfdZAFjOrWsLV8quZ2POLFuSDPUZ
        H+MnlP6BpEzXk/1YYymoT/BbsFl1tX6mLaUwceNFMyQ07vlOef5Hb3MXy1PMn5aw
        Q9G8wZb/e4Vf1eHndLowmqnUjKkEe5OQ8mQy7vYj9wHgKNx24l2yhLcW8Q3ioQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=q+gVPp
        DX6YEtNEl+mgEbiGiOhAnwJOzdcj5hWcV6//+LfqLYFI6O1PikQwRTEBy7ShOFmr
        y9nbaT03YTNzGzUK5ugw4HEyj+4fSIuHMkyIKGatJb08JoXAR7vWfpP2r0yHaDon
        GPMZnD2WMLKmtmyteGrsFkK0x5KkW0wWnhjms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 916DD5FD0F;
        Mon,  9 Jan 2017 17:53:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EED285FD0E;
        Mon,  9 Jan 2017 17:53:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, peff@peff.net
Subject: Re: [PATCHv7] pathspec: give better message for submodule related pathspec error
References: <20170109224330.28405-1-sbeller@google.com>
Date:   Mon, 09 Jan 2017 14:53:41 -0800
In-Reply-To: <20170109224330.28405-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Jan 2017 14:43:30 -0800")
Message-ID: <xmqqeg0bu9oq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7830251E-D6BE-11E6-99BF-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Every once in a while someone complains to the mailing list to have
> run into this weird assertion[1]. The usual response from the mailing
> list is link to old discussions[2], and acknowledging the problem
> stating it is known.
>
> This patch accomplishes two things:
>
>   1. Switch assert() to die("BUG") to give a more readable message.
>
>   2. Take one of the cases where we hit a BUG and turn it into a normal
>      "there was something wrong with the input" message.
>
>    =C2=A0 This assertion triggered for cases where there wasn't a progr=
amming
>  =C2=A0   bug, but just bogus input. In particular, if the user asks fo=
r a
>    =C2=A0 pathspec that is inside a submodule, we shouldn't assert() or
>  =C2=A0   die("BUG"); we should tell the user their request is bogus.
>

Is it only me who sees funny black rectangles in front of these four
lines instead of blanks, by the way?

>   This comes as a single patch again, replacing sb/pathspec-errors.
>   It goes directly on top of bw/pathspec-cleanup.
>  =20
>   v7:
>   do not rely on "test_commit -C" being there, nor the infrastructure
>   to request a "good" submodule upstream. Just create a submodule outse=
lves
>   to test in.
>  =20

Thanks.

> diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-sub=
module.sh
> new file mode 100755
> index 0000000000..d952ae2cae
> --- /dev/null
> +++ b/t/t6134-pathspec-in-submodule.sh
> @@ -0,0 +1,40 @@
> +#!/bin/sh
> +
> +test_description=3D'test case exclude pathspec'
> +
> +TEST_CREATE_SUBMODULE=3Dyes

Did you mean to keep this?

> +. ./test-lib.sh
> +
> +test_expect_success 'setup a submodule' '
> +	test_create_repo pretzel &&
> +	(
> +		cd pretzel &&
> +		touch a &&

This is better spelled as

		: >a &&

because use of touch, when you do not care about the file timestamp,
is misleading.

Thanks.
