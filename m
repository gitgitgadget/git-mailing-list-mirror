Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A07C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 21:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E5723F27
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 21:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404899AbgLJV1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 16:27:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55472 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404875AbgLJV1W (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 16:27:22 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E329A77B4;
        Thu, 10 Dec 2020 16:26:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gO3XrEzAl+TpfUKwW+uwCQzMbRg=; b=ALMkuE
        FB5/5FllMtBEf5rcVQheMzzpCrCQ6mjnCPCKQlc65Ru7Mvj+gAXrk0ITqup7Jgu5
        atNye51TGw8/BfHwn6JfKqAp2lQZ0peOkVK+aPS24QDQesjahT+PV/VPyYkX2j9s
        C+GjEe0PQH8SxVIP5J3ji7NoG0aR3atl7GWcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dppM9J+yU1hO+bua3nIJCpSju9P80qiD
        kM3Wcl4denGD+jnYiNqRKk/b6frKc9/Q/jnA8EmG6QBx//ZcW82us9fIyV/zJDBr
        4zOz9YCROFBrqVeSeyMG10V01ttGktnjTvQGArdfGKY+mA6SR8gw2ice9bpoi0Li
        xgUhzURpZik=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66FC5A77B3;
        Thu, 10 Dec 2020 16:26:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6D74A77B2;
        Thu, 10 Dec 2020 16:26:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
        <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
        <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
        <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
        <xmqq360f4npg.fsf@gitster.c.googlers.com>
        <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
        <xmqqtusv362t.fsf@gitster.c.googlers.com>
        <xmqqpn3j32ka.fsf@gitster.c.googlers.com> <87k0tqdasa.fsf@osv.gnss.ru>
        <CABPp-BE7r4iUc6VD60Bdi+fF2bBn6_ZwVPrz_niFpY=LTZMXzw@mail.gmail.com>
Date:   Thu, 10 Dec 2020 13:26:39 -0800
In-Reply-To: <CABPp-BE7r4iUc6VD60Bdi+fF2bBn6_ZwVPrz_niFpY=LTZMXzw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 9 Dec 2020 23:26:44 -0800")
Message-ID: <xmqqwnxptks0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64250DEA-3B2E-11EB-9D99-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ....  I know what
> diff --exit-code does, but I'm really not sure what git-log's
> --exit-code does (random guess: sets the exit code to an OR of what
> git diff would have shown for any one of the commits shown?).

The end of cmd_log_walk() does try to return diff_result_code(), but
diff_flush() can reset .has_changes to 0 or set it to 1 each
iteration, so I do not think it is "set .has_changes to 0, and never
reset to 0, but flip it to 1 if any change is found", which would
have had some chance of giving us "OR'ed together" semantics.

