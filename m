Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058E41F462
	for <e@80x24.org>; Thu, 23 May 2019 19:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbfEWTOi (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 15:14:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55375 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387468AbfEWTOe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 15:14:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4994E13F8A6;
        Thu, 23 May 2019 15:14:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=QvppdZ0xS8Q8mQ+mWWdI0xVSeZQ=; b=lb87d+r
        SWPuO4+Ck61VLkdYeiwjeW1YY52w5+etjgTpPa0Q7SKHvxRV+ovc/tAnXgbmfFLf
        hiKk8TBQfTqqINTmo/qRSJOSjRBDvbfKzgRgqwI+wsklWpeZXL1km8pGdhlH/WoQ
        O71e4+WaphrU5wsE65b/Lzr9f/Jq0btx5JjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=adiCCvD82uPrw7dvkyQbRjp2tpH5pXWdR
        f0gekUO5WoOJRE7AaodJcndsKGlaSV/18bYzzBVkdZMb1RQAco9ytljcO7LvLYy5
        OlJck2oIpUDK4aGESfVdGNEWxsAjrC97KrBYbNJXak5cKME/leXTrMW2YQ748J1S
        9CloKuTvkM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41F7213F8A5;
        Thu, 23 May 2019 15:14:32 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B452F13F8A4;
        Thu, 23 May 2019 15:14:31 -0400 (EDT)
Date:   Thu, 23 May 2019 15:14:30 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git-packagers@googlegroups.com
Subject: Re: New diff test failures on s390x architecture (was: [ANNOUNCE]
 Git v2.22.0-rc1)
Message-ID: <20190523191429.GO3654@pobox.com>
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com>
 <20190523150416.GL3654@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523150416.GL3654@pobox.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: FE5F105E-7D8E-11E9-93FF-72EEE64BB12D-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I wrote:
> While running the 2.22.0-rc1 tests on Fedora, I hit a few
> new test failures since 2.21.0 -- but only on the s390x
> architecture.
> 
> I haven't had time to dig into these the past few days, so I
> thought I would send what I do have in case the problem is
> obvious to someone else.  I think all of the failing tests
> are due to `git diff` commands.
[...]
> I don't have direct access to these s390x builders.  I may
> be able to arrange shell access (or even reproduce this with
> qemu's s390x emulation).

I poked around a little with a qemu s390x instance and see
the same failures.

One simple failure in t4015 is with:

    git diff -w >out &&
    test_must_be_empty out

Using git-2.21.0 this succeeds, while git-2.22.0-rc1 fails
and produces:

    diff --git a/x b/x
    index d99af23..22d9f73 100644
    --- a/x
    +++ b/x
    @@ -1,6 +1,6 @@
    -whitespace at beginning
    -whitespace change
    -whitespace in the middle
    -whitespace at end
    + 	whitespace at beginning
    +whitespace 	 change
    +white space in the middle
    +whitespace at end  
     unchanged line
    -CR at end
    +CR at end

I am guessing it's no coincidence that this only fails on
s390x and it is the only big endian architecture in the
fedora build system.

-- 
Todd
