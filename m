Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A0DC433ED
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405DD600D4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhD1Hlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:41:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50908 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1Hln (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 03:41:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ADC36C9906;
        Wed, 28 Apr 2021 03:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=StZvPpHFole4tsBkyDSbJ9eSGbvn+726rVu4hL
        csCzU=; b=EtZec+C+1DdrDnJfnMChvoRpLLvlp68v+qyf+FmaW3jOIqQToW3KHD
        f1CZomOm7mykYfpeU1HIvvtBU9UksR9G8YdStVjGDNIYTXg7dQdzvf/CKc+iGNsg
        x7/62l3m16EBZBnpZw6WSTzNOxlm9lYT0sV22TbIwCI/otvnPARXA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4BE4C9905;
        Wed, 28 Apr 2021 03:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2EA9AC9904;
        Wed, 28 Apr 2021 03:40:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, ross@skydio.com, abe@skydio.com,
        brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-apply: add --quiet flag
References: <20210427194106.14500-1-jerry@skydio.com>
Date:   Wed, 28 Apr 2021 16:40:57 +0900
In-Reply-To: <20210427194106.14500-1-jerry@skydio.com> (Jerry Zhang's message
        of "Tue, 27 Apr 2021 12:41:06 -0700")
Message-ID: <xmqq35vac0vq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12611326-A7F5-11EB-9233-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Replace OPT_VERBOSE with OPT_VERBOSITY.

While it is not an incorrect statement, it is odd to have such an
implementation detail nobody cares as the first thing in the log
message, though.

> This adds a --quiet flag to "git apply" so
> the user can turn down the verbosity.

Sure, I think you can do "apply --no-verbose" to do the same thing
without any change, but we introduced VERBOSITY to replace VERBOSE
exactly so that --verbose can be countermanded with --quiet, and
this patch is a good example of the application of that feature.

I wonder if this deserves a test.

Also, does "git am" have an "--quiet" option (or "--verbose" for
that matter), and if so, should it pass it down to underlying "git
apply" (this is not a rhetorical suggestion --- it is a genuine
question---I am not particularly interested in changing "am")?

The patch text looks good.

Thanks.
