Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3133BC433E2
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 18:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92C020735
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 18:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pWORpypO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgILSPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 14:15:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56809 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgILSPu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 14:15:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7322AF4474;
        Sat, 12 Sep 2020 14:15:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7ticJ+M2FrDHAHZRH0YtNmwa3ZU=; b=pWORpy
        pOyHhC+VBjuWwKx1tVM6JzvwbsR1TzOGJd5RZQYNA9rBGUyamsIiPOYp4/dRfeqo
        dPa94AN7tVRRa+KR9WX+5oLXa6+QUiabPFAOhqAbqTsA3mVmRBDI1Aif68NFcQMC
        ofI8WECjyhTHfr3omKjDBGE6Lsvi7Q0l8uRfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VUgeYVs7GEseO2+Sj5Twhqn47qAHRHJ4
        EB9j+wmymbyqf7F0d7dRQxXA6AFTVgQ81UmDvGF4xL6qEuGK7j8mG1m66Gaq4hJy
        KkRM2h8+of+Ng/jOs1iTiccjwcZGOIoArKqKf3xF2ZQ/Y9TBpnwt27HeKXgBWszM
        eSa19kj4ymo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6BDDFF4473;
        Sat, 12 Sep 2020 14:15:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A9775F446F;
        Sat, 12 Sep 2020 14:15:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/2] push: make "--force-with-lease" safer
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
        <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
Date:   Sat, 12 Sep 2020 11:15:42 -0700
In-Reply-To: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Sat, 12 Sep 2020 20:34:57 +0530")
Message-ID: <xmqqa6xuoo8h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F984B6A2-F523-11EA-A1F7-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> The `--force-with-lease[=<refname>[:<expect]]` option in `git-push`
> makes sure that refs on remote aren't clobbered by unexpected changes
> when the "<refname>" and "<expect>" ref values are explicitly specified.

If you did a feature with different semantics to satisfy Dscho's
need, then this is no longer "make force-with-lease safer", I would
think.  Hopefully it is just the cover letter.

> The new option `--force-if-includes` will allow forcing an update only
> if the tip of the remote-tracking ref has been integrated locally.
> Using this along with `--force-with-lease`, during the time of push
> can help preventing unintended remote overwrites.

"if-includes" sounds quite sensible.  I think you want to lose the
word "lease" from the configuration variable name.  I do not think
it should be on by default, though.

Thanks.
