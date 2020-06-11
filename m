Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF0CC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 20:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C4E20720
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 20:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RSL/4LR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgFKU1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 16:27:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52284 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFKU1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 16:27:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 543F96370B;
        Thu, 11 Jun 2020 16:27:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UiWtWS3rLPVXCjNN6Dhco0QNiwI=; b=RSL/4L
        R79gD987gpK7nqzMhZmkxCIeYxzeWg0Eu6SQeHaGwYy+j4TdHRlQkprj7VfQLE7y
        kpF861JQO47+LQjTQHOjeH6rhY/BI4aQqZ00defekbS95By4GYfmYvhAUgLW/Di1
        jv3bcuaC0u5IjpvxWKq9V/Djfhrxup9UkXsM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xdq6IuJjBZliPn8UteY2ZcQu02SRVVQ1
        ugkrumDy4Xt7oU+rQCcw7ROFazFGwt5CvbdT6yWGygCq8zBeDROvn8uHB2Vbh79k
        qepzKgB8tH/Ot4HrF9APIYHudCEF3ngh+vrZ5MW1oxQ+i1BMf5D2P7fU9fmExcx9
        7hz0aVlFMMA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D04B6370A;
        Thu, 11 Jun 2020 16:27:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDD9C63709;
        Thu, 11 Jun 2020 16:27:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-files: treat "i-t-a" files as "not-in-index"
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
Date:   Thu, 11 Jun 2020 13:27:22 -0700
In-Reply-To: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Thu, 11 Jun 2020 21:46:40 +0530")
Message-ID: <xmqq4krhjql1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4C3AB50-AC21-11EA-B93E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> The `diff-files' command and related commands which call `cmd_diff_files()',
> consider the "intent-to-add" files as a part of the index when comparing the
> work-tree against it. This was previously addressed in [1] and [2] by turning
> the option `--ita-invisible-in-index' (introduced in [3]) on by default.
>
> For `diff-files' (and `add -p' as a consequence) to show the i-t-a files as
> as new, `ita_invisible_in_index' will be enabled by default here as well.
>
> [1] 0231ae71d3 (diff: turn --ita-invisible-in-index on by default, 2018-05-26)
> [2] 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist in
>                 index", 2016-10-24)
> [3] b42b451919 (diff: add --ita-[in]visible-in-index, 2016-10-24)

Is there any place where we still run the internal diff machinery to
compare the index and the working tree without setting the
ita_invisible_in_index bit on with this patch applied, and if so,
why?  Does the justification why that other place needs to leave
the bit off apply to this codepath as well?

What I am trying to get at is if this is helping only one usecase
for "diff-files" while breaking other usecases.

On the other hand, if there is no longer anybody who wants
ita_invisible_in_index off, perhaps we can get rid of the bit and
lose many conditionals.
