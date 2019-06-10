Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5477F1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 16:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfFJQcp (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 12:32:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52412 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfFJQcp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 12:32:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A00D69468;
        Mon, 10 Jun 2019 12:32:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r+1gjSxGv4Eno9N4nGNejZJFuIo=; b=C+EiPb
        vH/EN03hpoidaNfSDJBE4P9sVicQujW4tqyW81kXVrzuy280z4eZkH5Ve8zujY2O
        FRH/DBv40j7HshRoQDqJfVqIRCv02Q4a4jV/nHES7W8FHu+JPbyoO2LU+HE4F4Jz
        Afhm0fRHw5jlWq4Sbe94U71E4ZWtI9bhwz/dM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RaiKIvQMy46fuPizuWJbfcjDOVpiYR3N
        2mDla8WegIqDOnJrLt3lVgK94LXdQk77BhuUpneoAY7Jc9Mwnc1IOdtklZUmtuSC
        PyUE/YESRE1o3VTHGOjDkLv4TvNOvBJ83m6XhISaeJPMTmMd36fY2kwN7K5M0RbS
        mNAHffKfkQ8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02E5069467;
        Mon, 10 Jun 2019 12:32:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 14EC269464;
        Mon, 10 Jun 2019 12:32:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] t0001: fix on case-insensitive filesystems
References: <pull.151.git.gitgitgadget@gmail.com>
        <1dd56d034efb6ff251bdac8d099052175f4777a0.1560005022.git.gitgitgadget@gmail.com>
        <20190609201302.GX8616@genre.crustytoothpaste.net>
Date:   Mon, 10 Jun 2019 09:32:37 -0700
In-Reply-To: <20190609201302.GX8616@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 9 Jun 2019 20:13:02 +0000")
Message-ID: <xmqqo935o0yi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D2F514A-8B9D-11E9-BA09-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>>  test_expect_success 'init with separate gitdir' '
>>  	rm -rf newdir &&
>>  	git init --separate-git-dir realgitdir newdir &&
>>  	echo "gitdir: $(pwd)/realgitdir" >expected &&
>> +	downcase_on_case_insensitive_fs expected newdir/.git &&
>
> I wonder if there's maybe a simpler way. If we canonicalize paths when
> writing them to the gitdir file, then writing "$(pwd -P)" on the line
> above should produce the right result.
>
> Now, technically, POSIX doesn't require case canonicalization of the
> path with "pwd -P", but then again, POSIX doesn't permit
> case-insensitive file systems, and we know the behavior on macOS uses
> bash, which does the right thing in this case because it calls
> realpath(3). I've tested that it also does the right thing on Linux when
> the worktree containing the Git checkout is in a path with symlinks.
>
> I don't know how that works on Windows, but if it does, it might be
> simpler.

Yup, it would be a worthwhile avenue to pursue; on the negative
side, a single-liner "no, unfortunately that would not work on
Windows" would also be useful.

Thanks.
