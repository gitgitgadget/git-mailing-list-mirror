Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA38AC433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 17:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbiDNRFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbiDNREt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 13:04:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33FFDE29
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 09:42:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 753CE12F9EC;
        Thu, 14 Apr 2022 12:42:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0AXG6LadwkE28oK9w86LDNrYpT9e2KN+xcKVBu
        iX5e4=; b=e3wGW8z9OtKQ07Pbx20pUREaCxTRDUpL6GdbsUwVD17ouA4fwuRnms
        2H2seXG5NL1S51PRLBWCJfPz7cEKU+wQIH4rUIemmTe2vVKgJuNJ1zjll5taZ6BQ
        a/f7ggcpeie02sGStcppQx7fL0XBvVILSLaHslE8odyqT1/vqKNAg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C08212F9EB;
        Thu, 14 Apr 2022 12:42:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC59512F9EA;
        Thu, 14 Apr 2022 12:42:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        git <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC] [PATCH v2] t1011: replace test -f with test_path_is_file
References: <xmqq1qy3igif.fsf@gitster.g>
        <20220412203722.10484-1-siddharthasthana31@gmail.com>
        <CAP8UFD3RtQecxOQWVeapH1CYsMiY2+MoHeugb9bvOsFVnozy=w@mail.gmail.com>
Date:   Thu, 14 Apr 2022 09:42:34 -0700
In-Reply-To: <CAP8UFD3RtQecxOQWVeapH1CYsMiY2+MoHeugb9bvOsFVnozy=w@mail.gmail.com>
        (Christian Couder's message of "Thu, 14 Apr 2022 10:19:07 +0200")
Message-ID: <xmqqy2071urp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E37A37EA-BC11-11EC-A55B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In the commit message it might be nice if there were some explanations
> about why `test_path_is_missing PATH` should be used instead of `!
> test_path_is_file PATH` or `test ! -f PATH` or `! test -f PATH`.

Meaning "the original used '! test -f foo' but what it meant was
that it did not want to see 'foo' on the filesystem, regardless of
its type, so it should have been '!test -e foo' to begin with"?

I guess it does not hurt, as the original would have passed by
mistake if these paths were on the filesystem as directories, but
the new code would behave differently, and even if it is a "bugfix",
it still is a behaviour change that may be worth explaining.

> The diff part of the patch looks good to me. Thanks!
