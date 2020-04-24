Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D18C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F4920776
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IWDPKHWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDXWxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:53:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53122 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDXWxi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 18:53:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 436E1D61F9;
        Fri, 24 Apr 2020 18:53:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WHGZ9RK+erhPl+pWsD8hUoaKuPo=; b=IWDPKH
        WAfIVVrOpgGVuoiu3mmSDTSLyfAZS6N/8adIkyHRIV/RZl4oXk8bQzE6ysC1JdAf
        l1JT2lvgbdymgzzfzkTPm7sFud2xkzBO11dbWcDy1CxMAuEGuuC1pqh3qLRdcDPf
        qbd7Y2g+QSCtFgYtuKnfKs2Lv3Ufgb5XrFK6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l9ouVg/k76wqDibsjWMP1ls0WfJM6zvF
        WI0yxMlfIZK8oLNNIcDko6/LOkIV1mSeDDMdijt5YOARSY4XjipJ9zflSFjgHfI0
        epejMBsW9uoDmYAIulAAlcyf6JGkihImP9suZDYXWbGr8sbjcCCKRImI3hbDczh2
        JJ2DF7ndN4A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D353D61F8;
        Fri, 24 Apr 2020 18:53:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69F16D61F7;
        Fri, 24 Apr 2020 18:53:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2]  credential: handle partial URLs in config settings again (master)
References: <pull.620.git.1587767749.gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 15:53:31 -0700
In-Reply-To: <pull.620.git.1587767749.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 24 Apr 2020 22:35:47
        +0000")
Message-ID: <xmqqwo64a42c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C9DD908-867E-11EA-B708-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This is a companion patch to https://github.com/gitgitgadget/git/pull/615,
> but targets maint instead of maint-2.17: There is not really a good way to
> get those patches into maint by merging because the final patch looks quite
> a bit different by necessity (after 46fd7b390034 (credential: allow wildcard
> patterns when matching config, 2020-02-20) the urlmatch machinery is
> supposed to handle credential.<url>.* config parsing).
>
> IMHO the easiest strategy would be to apply these patches on top of maint,
> then merge the other patches on top of maint-2.17 with -s ours.

Thanks for a quick help.
