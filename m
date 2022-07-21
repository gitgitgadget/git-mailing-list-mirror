Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84AACCA485
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiGUQ5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiGUQ5U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:57:20 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7967789A6A
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:57:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1DE41ACB22;
        Thu, 21 Jul 2022 12:57:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=EHjDJ2n90krIsQGm/JEiplJKh0rC0l5zem83Cd
        CRTS8=; b=EDrLapntiHHiVwOSCEpVmfAMeHVHHv38idjMFhxTuMBXDPfwfF4nz/
        IItNhbSy5hlz9jiJWcH5dkVoS1Lh1msWtd3vGLvqoxHyD4vsgpV8AIKp9z9W8beF
        5E6gETyKnU4XxLaiog9+AKG9TuMllAkOO2H3J6yT9x7L8HvQ3UoRs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA4331ACB21;
        Thu, 21 Jul 2022 12:57:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 932BB1ACB20;
        Thu, 21 Jul 2022 12:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "tenglong.tl" <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, git@jeffhostetler.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 2/2] tr2: shows scope unconditionally in addition to
 key-value pair
In-Reply-To: <20220721132748.37848-3-tenglong.tl@alibaba-inc.com> (tenglong
        tl's message of "Thu, 21 Jul 2022 21:27:48 +0800")
References: <20220721132748.37848-1-tenglong.tl@alibaba-inc.com>
        <20220721132748.37848-3-tenglong.tl@alibaba-inc.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Thu, 21 Jul 2022 09:57:10 -0700
Message-ID: <xmqqh73ajteh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29F4A60A-0916-11ED-8B7B-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"tenglong.tl" <dyroneteng@gmail.com> writes:

> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index dcd0429037..229f31ab31 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -717,6 +717,7 @@ The "exec_id" field is a command-unique id and is only useful if the
>  {
>  	"event":"def_param",
>  	...
> +	scope: <a string that 'git config --show-scope' would return>
>  	"param":"core.abbrev",
>  	"value":"7"
>  }

Everything in these examples use concrete values and follow the real
syntax (e.g. param is enclosed in double-quotes and so is its value
core.abbrev; even though core.abbrev is not the only param that can
be reported by a def-param event, it is used as a concrete example.
The same story goes for value).  The new "scope" thing stands out
like a sore thumb.  I think the above should read more like

	"event":"def_param",
	...
	"scope":"global",
	"param":"core.abbrev",
	"value":"7"

or something.  Pick your favourite value for scope.

Other than that, these two patches make quite a lot of sense.

Thanks.
