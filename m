Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA4DC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185FA22B48
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 22:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iv+CeJWJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLKWUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 17:20:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57169 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLKWUA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 17:20:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 560A338EEC;
        Wed, 11 Dec 2019 17:19:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jPX5+jli+kuyqr/fR/IvKaNsBok=; b=iv+CeJ
        WJ1X7rNRG2RI+UhcuVdnAd5bBZy6ZKEBfHE4Glf9/iWFs2y0f3A5IL/tpPMEAOII
        VzBrxgwbJPJXFEDs7u6sSzTtGCU4zUJhmQsG0xnmtVgDIfXIlVm37e9SQRi5Mi/I
        CHHe2Vdfz82APPbsiuz+zxSm69+aSw/LMHwNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P7oDvi0yYus6CxLyjiSB+ASSOwFZ5MFC
        1Rr3LMx1KgKmn60vSDMnukRj6EbXRg7lHOjTTANxVh9jbWVK6ZVtmeFqD6n+uvHX
        cG0S+j6yJfFZD2LDcSzftAYo+2Mnzj7JVPul2PH73IZY6lbWjp64YaWaNTD10XsN
        86HbKHb7HPw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C5EA38EEB;
        Wed, 11 Dec 2019 17:19:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ABC1D38EEA;
        Wed, 11 Dec 2019 17:19:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH] config: add string mapping for enum config_scope
References: <20191211220933.48678-1-emilyshaffer@google.com>
Date:   Wed, 11 Dec 2019 14:19:57 -0800
In-Reply-To: <20191211220933.48678-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Wed, 11 Dec 2019 14:09:33 -0800")
Message-ID: <xmqqsglqmrn6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DFA1FEE-1C64-11EA-8A04-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> If a user is interacting with their config files primarily by the 'git
> config' command, using the location flags (--global, --system, etc) then
> they may be more interested to see the scope of the config file they are
> editing, rather than the filepath.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Note: This commit has been cherry-picked out of the "configuration-based
> hook management" topic, at
> lore.kernel.org/git/20191210023335.49987-1-emilyshaffer@google.com
>
> It turned out that I wanted to use it for git-bugreport as well - to
> explain the origin of the configs we are printing in the bugreport,
> without directly exposing the user's home directory path.
>
> This seems to have similar work to https://github.com/gitgitgadget/git/pull/478
> which I believe hasn't been mailed yet; but that change is targeted
> towards the builtin config command, rather than the config library.
> Since I wanted to use the library, I'm sending on my own now. Maybe
> this commit will be useful to that change's author.

One thing I wondered about this in the original version was if the
returned value should be localized.  In the context of the original,
the --porcelain mode refused to give this information in its output,
so it was OK to always localize the returned value to satisify the
other caller who wanted end-user-facing output.

But as a more general helper, I am not sure if this is the most
useful way to implement it.  Shouldn't the function rather return
the machine-readable tokens and allow callers to localize it as
needed with its own _() around the returned value?  I dunno.

