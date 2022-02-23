Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA68EC433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242233AbiBWVHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242209AbiBWVHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:07:46 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCF611177
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:07:17 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DCFBF18B1D8;
        Wed, 23 Feb 2022 16:07:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z1Xfaot30VxcIhnVGnoAazhbwaJI8nuH0ogBR/
        dHmvc=; b=RSU5LxtiMrVuCf6itxCKTNZQmk06jZqNZTx7+vFg9ZqnFL0Ks0mBhJ
        xunhkpykgUlinbvIW7vSeI0Uq+EyKltFesRVQ2PSjrGNRZt/q7o/rUOb2FgxUsPu
        wYRPzI+LqSKjSIK5kfHwv8Qb3fpwRJg/KYVdHWH3JCjQURJCSKhzQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D525418B1D7;
        Wed, 23 Feb 2022 16:07:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 47E1E18B1D6;
        Wed, 23 Feb 2022 16:07:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Shubham Mishra <shivam828787@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/2] t0001: remove pipes
References: <20220222114313.14921-1-shivam828787@gmail.com>
        <20220222114313.14921-2-shivam828787@gmail.com>
        <CAP8UFD1FVuoe7V3JU+hExsbjWTkNZFCZFV4qc65YLd4ow-Da5w@mail.gmail.com>
Date:   Wed, 23 Feb 2022 13:07:12 -0800
In-Reply-To: <CAP8UFD1FVuoe7V3JU+hExsbjWTkNZFCZFV4qc65YLd4ow-Da5w@mail.gmail.com>
        (Christian Couder's message of "Tue, 22 Feb 2022 21:32:30 +0100")
Message-ID: <xmqqsfs9thq7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9285BA86-94EC-11EC-8A35-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Only the exit code of the command before the pipe is ignored.
>
> Also it's ok to use pipes if the command before the pipe is not `git`.
> We trust regular commands to just work and we test only `git`.

Both very good points.  So ...

>> -               find .git/worktrees -print | sort >expected &&
>> +               find .git/worktrees -print >tmp && sort tmp >expected &&
>
> Please put the `find` and `sort` commands on 2 different lines when
> they are separated with &&.

We do not want to split this pipeline into two commands.
