Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075D1C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54DF20639
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 01:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WtVcWivC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHZBmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 21:42:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61477 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgHZBmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 21:42:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE31E77D99;
        Tue, 25 Aug 2020 21:42:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R0mOgoo/xbx6zmNpbb+juF5wCyU=; b=WtVcWi
        vCMsEfa0fQwDPX60WrKsFQkn8YFAmrtJ9RmwJTurHv+A6jvJJMO4Qj5GK3FfGjXo
        L079FaLuFUWC7cj//DfZVfaCI3+IiafljDfOzNw4P+TFkNCW9OxX7wZUtFu8MtRf
        sw+5zH0KGW5LXCicfBk2q8F9zphecR7W5eMs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mj4fxP2YTTBuMreXfus383XUaVeXnS6J
        L5Sxk9yBd3/6O3IdoYKd+8gv8AklTKa75uDUVq2/v6fAPDLoS5mByWv+EouuL97F
        +gr9gRehnGF0k4p4icquQCJDgCnmE59Xb3m6VVK0f3M9Puw0ZcbfMbesYh6w5GG3
        Hv8IHwByBIc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C55BD77D98;
        Tue, 25 Aug 2020 21:42:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B80277D97;
        Tue, 25 Aug 2020 21:42:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 2/3] cvsexportcommit: do not run git programs in dashed form
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200826011718.3186597-1-gitster@pobox.com>
        <20200826011718.3186597-3-gitster@pobox.com>
        <CAPig+cR-eYCVQLRa0rVhgJ8L60-zCS_aK6_nVERcrXSyApdihw@mail.gmail.com>
Date:   Tue, 25 Aug 2020 18:42:15 -0700
In-Reply-To: <CAPig+cR-eYCVQLRa0rVhgJ8L60-zCS_aK6_nVERcrXSyApdihw@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 25 Aug 2020 21:28:29 -0400")
Message-ID: <xmqqeenuxjwo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F21C472-E73D-11EA-8F80-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Aug 25, 2020 at 9:17 PM Junio C Hamano <gitster@pobox.com> wrote:
>> This ancient script runs "git-foo" all over the place.  A strange
>> thing is that it has t9200 tests successfully running, even though
>> it does not seem to futz with PATH to prepend $(git --exec-path)
>> output.
>
> t/test-lib.sh takes care of that for us, doesn't it?

It generally shouldn't, I think.

We have bin-wrappers directory and we shouldn't be copying things we
would install in libexec/git-core/ in real life.
