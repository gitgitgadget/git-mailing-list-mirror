Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C383A20437
	for <e@80x24.org>; Tue, 10 Oct 2017 23:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756609AbdJJXbw (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 19:31:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58647 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756596AbdJJXbv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 19:31:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB5EB9B608;
        Tue, 10 Oct 2017 19:31:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oDNVOY9RG5Kavnrxyq3LCKczAwY=; b=l5o9ki
        JGlRqfF9MQIxOZ9JHekQ73dRygF59xuy7SSm72pwvWuei79guqCXEnihe2kZQcgy
        X0cW6BvU9t+Q+i44cZ8aTNURJW97qcv/7H5r68xpgDrb3hHhvd3TC0NAzZUBpblr
        CHkjdtAsBvyzSg+CV0gLKodfJR4eaBgAtJXuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WathRScJDZB24JJLK5raT11qYISrUWWW
        +1b2xvoJJXC1H6amkO9uQiBpDPKO3vHZK8VtzeVq1s8u5OLra+Q6tDYB34qxnw8a
        O7eP9RKMc51EM6PR2jRBbfWDIpiqeMt8yB2zjguSibWLhwP/hzqpNxJnK5v4VlVZ
        7EtnqQNRTg4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E05A79B607;
        Tue, 10 Oct 2017 19:31:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12A5E9B602;
        Tue, 10 Oct 2017 19:31:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Josh Triplett <josh@joshtriplett.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper repository setup
References: <20171006222544.GA26642@sandbox> <20171006223234.GC26642@sandbox>
        <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
        <20171010130335.GB75189@book.hvoigt.net>
        <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
Date:   Wed, 11 Oct 2017 08:31:37 +0900
In-Reply-To: <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
        (Stefan Beller's message of "Tue, 10 Oct 2017 11:39:21 -0700")
Message-ID: <xmqq7ew2pokm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A128D40-AE13-11E7-9149-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So you propose to make git-add behave like "git submodule add"
> (i.e. also add the .gitmodules entry for name/path/URL), which I
> like from a submodule perspective.
>
> However other users of gitlinks might be confused[1], which is why
> I refrained from "making every gitlink into a submodule". Specifically
> the more powerful a submodule operation is (the more fluff adds),
> the harder it should be for people to mis-use it.

A few questions that come to mind are:

 - Does "git add sub/" have enough information to populate
   .gitmodules?  If we have reasonable "default" values for
   .gitmodules entries (e.g. missing URL means we won't fetch when
   asked to go recursively fetch), perhaps we can leave everything
   other than "submodule.$name.path" undefined.

 - Can't we help those who have gitlinks without .gitmodules entries
   exactly the same way as above, i.e. when we see a gitlink and try
   to treat it as a submodule, we'd first try to look it up from
   .gitmodules (by going from path to name and then to
   submodule.$name.$var); the above "'git add sub/' would add an
   entry for .gitmodules" wish is based on the assumption that there
   are reasonable "default" values for each of these $var--so by
   basing on the same assumption, we can "pretend" as if these
   submodule.$name.$var were in .gitmodules file when we see
   gitlinks without .gitmodules entries.  IOW, if "git add sub/" can
   add .gitmodules to help people without having to type "git
   submodule add sub/", then we can give exactly the same degree of
   help without even modifying .gitmodules when "git add sub/" is
   run.

 - Even if we could solve it with "git add sub/" that adds to
   .gitmodules, is it a good solution, when we can solve the same
   thing without having to do so?



