Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C26EC33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED3420748
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IxOkGs3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgAQUc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:32:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56901 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgAQUc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 15:32:26 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFF3E3902E;
        Fri, 17 Jan 2020 15:32:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+rgwTyJULl1ffUv4MgkK5ZLpb2o=; b=IxOkGs
        3my2nI8M+U2+upS/tFuTN1onArcXmUSV2QQVtK3884ZGTbRSWrifPjIECV77cKJT
        ctARaKsKFFXDg1sZ7FMWYGCUhbUPH7t9bVDFuD6iF+bro6QFIVYJOd7PQu4M7Isl
        uBS25qUiYgw9mD37dl+zGqPKrS/QRd0K8EeWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u+T/W0OTv0/DrRPjbWTVUlMvqTgrBNac
        gYHwm24xV+TcOLbD2YgWvhSOM39JtbkfH9tn8zkPDfao6tTkg/Ule9jardKpc7op
        YTK4ro3nALwUT0ZI7AdBBwTcTWpWHQv2mFSjtuK5d2j1vcqW3ys0SIjpKkV6WTM0
        pOdAwkyJIpY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E63293902D;
        Fri, 17 Jan 2020 15:32:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C99D3902A;
        Fri, 17 Jan 2020 15:32:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/4] t2405: use git -C and test_commit -C instead of subshells
References: <pull.523.git.1579263809.gitgitgadget@gmail.com>
        <5060ce3d64419369b2912c395a880fb49a0a3137.1579263809.git.gitgitgadget@gmail.com>
        <CAPig+cQgh+gmrDwSqJz1hHViBxTP6UDkuHjKTRLbackcxeQE9A@mail.gmail.com>
Date:   Fri, 17 Jan 2020 12:32:22 -0800
In-Reply-To: <CAPig+cQgh+gmrDwSqJz1hHViBxTP6UDkuHjKTRLbackcxeQE9A@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 17 Jan 2020 08:45:12 -0500")
Message-ID: <xmqq5zh9esdl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7782A924-3968-11EA-BF69-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Jan 17, 2020 at 7:24 AM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The subshells used in the setup phase of this test are unnecessary.
>> Remove them by using 'git -C' and 'test_commit -C'.
>
> The subshells may not be necessary, but the code feels cleaner before
> this patch is applied since all the added "-C foo/bar" noise hurts
> readability. So, I'm "meh" on this patch and wouldn't complain if it
> was dropped (though I don't insist upon it).

I dunno.  Each of these subshells did not do much after going into
its subdirectory, so repetition of "-C foo/bar" did not bother me
that much.

>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>> diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
>> @@ -6,32 +6,16 @@ test_description='Combination of submodules and multiple worktrees'
>> -               git commit -m "file1 updated"
>> +       git -C origin/main commit -m "add sub" &&
>> +       test_commit -C origin/sub "file1-updated" file1 file1updated &&
>> @@ -49,7 +33,7 @@ test_expect_success 'checkout main' '
>> -       grep "file1 updated" out
>> +       grep "file1-updated" out
>
> Why this change? Is it because test_commit() mishandles the whitespace
> in the commit message? If so, it might deserve mention in the commit
> message of this patch. (Even better would be to fix test_commit(), if
> that is the case.)

FWIW I had the same reaction on that dash in "file1 updated".
