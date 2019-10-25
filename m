Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA7C1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 09:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438857AbfJYJns (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 05:43:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65424 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438852AbfJYJns (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 05:43:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EE6825CC8;
        Fri, 25 Oct 2019 05:43:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WKJcXHo/Pcy1M/Twf9BE8BVOT7A=; b=sMBNfX
        QxQZPqju3qNU5eKSknkk5RS1oY0z3ExfNthTzL+DIvnUf7DaXks+ihzWBc8qp53A
        IADqgey55J8Yqm1PxsHxJPqAY6yEiIK5SI2EAx6/+VbuINaClcI/HNwzdE9lYeSO
        +AEs23UwlFV+n2dg8M1MA3O+YzYRjkKC/mtaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h7K4J25R5w7NERce1ArnckjwCmGYpSYv
        8grUBSXwQALYQijdJcMDXMITYGjgBp1mX6LbMYZd61OuLQftIjJ8T4migQt6S/wZ
        FTLr/KfLJ/BBUX4XYcf2kr9wDVORg2f1cJuh6shl8waBwMJ0j/lvNQqkAZDb/bcc
        DY6ImBdssug=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0788025CC6;
        Fri, 25 Oct 2019 05:43:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 714FD25CC5;
        Fri, 25 Oct 2019 05:43:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Miriam R." <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy][PATCH] abspath: reconcile `dir_exists()` and `is_directory()`
References: <20191024092745.97035-1-mirucam@gmail.com>
        <20191024114148.GK4348@szeder.dev>
        <xmqqmudpee57.fsf@gitster-ct.c.googlers.com>
        <CAN7CjDB9mRTNRKRoE8XfLz4in5gV6pxrKrqcjLPfthDHaf20nA@mail.gmail.com>
Date:   Fri, 25 Oct 2019 18:43:46 +0900
In-Reply-To: <CAN7CjDB9mRTNRKRoE8XfLz4in5gV6pxrKrqcjLPfthDHaf20nA@mail.gmail.com>
        (Miriam R.'s message of "Fri, 25 Oct 2019 10:59:42 +0200")
Message-ID: <xmqqzhhpb1nx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1327AF0-F70B-11E9-B4AE-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Miriam R." <mirucam@gmail.com> writes:

> Ok, then after discussion, finally the issue tasks would be:
>
> - Add path_exists() that will work same as file_exists(), keeping for
> now the latter.
> - Use path_exists() instead of dir_exists() in builtin/clone.c.

Sounds about right.

> And also:
> - Rename is_directory() to dir_exists(), as it is the equivalent to
> path_exists()/file_exists(), isn't it?

I wouldn't go there in the same series, if I were doing it.  I'd
expect that such a patch would be more noisy than it is worth if
done in a single step.  In order to avoid becoming a hindrance to
other topics in flight, an ideal series to do so would support the
same functionality with both old and new names, convert code that
use the old name to use the new name, possibly in multiple patches
to avoid unnecessary textual conflicts (i.e. some of these patches
made to areas that are seeing active development will be discarded
and need to be retried later when the area is more quiet) and then
finally the function wither the old name gets removed.

You would not want to mix the first two bullet points that are
relatively isolated with such a long transition.
