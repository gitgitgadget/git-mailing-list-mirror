Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350BDC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 17:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbiDARFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346341AbiDARFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 13:05:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5317C6386
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 10:03:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 394001926FA;
        Fri,  1 Apr 2022 13:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xluXr1ryhWg1iqU83i6laV2WGP12eCC1o2RjbI
        4XVe4=; b=OLqtP/S/PhiO+uY6OxW5QTDYneX7ozeC63fZdrWpaoA14QhdWHNIYk
        4m4spY9igKL7Nr+nu2wLwxMamgRs7YJnXf0FwYQvj3pnOxFzI4GzZaINIO5fzxVv
        4p1Y/R8vEdSBYHDF3xXKjmrLZrc2ZAGKBR8SnOOssfRsDl1HjvLH0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 313E91926F9;
        Fri,  1 Apr 2022 13:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 89EB51926F8;
        Fri,  1 Apr 2022 13:03:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 05/27] revision.[ch]: split freeing of revs->commit
 into a function
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
        <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
        <patch-v4-05.27-2d0ed57ec2e-20220331T005325Z-avarab@gmail.com>
        <e1bdb860-070b-8596-2a32-e9bc3ad354b0@gmail.com>
Date:   Fri, 01 Apr 2022 10:03:44 -0700
In-Reply-To: <e1bdb860-070b-8596-2a32-e9bc3ad354b0@gmail.com> (Phillip Wood's
        message of "Fri, 1 Apr 2022 16:15:06 +0100")
Message-ID: <xmqqlewoybv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0EC7E7A-B1DD-11EC-AF19-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>   +static void release_revisions_commit_list(struct rev_info *revs)
>> +{
>> +	if (revs->commits) {
>
> This guard copied for the original is not needed, free_commit_list()
> will handle NULL just fine.

Thanks for a careful reading.
