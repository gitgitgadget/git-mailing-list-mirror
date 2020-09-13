Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87430C43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 21:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D1120672
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 21:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OFhV9d3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgIMVpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 17:45:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62505 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgIMVpc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 17:45:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 174F86A9FA;
        Sun, 13 Sep 2020 17:45:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GppzPFISj9BuUiENOkJ41I7wRUQ=; b=OFhV9d
        3DcRODUaLStkn1rY/1WOMafid6rGq1gpmmK6PplXdcfDQbf/r6BOuIJQ8RrDoeSC
        +oDZdJfd4JL+xj6pe8lkUbS28yaR5Q5llCqqNAwdLN5SyfQLM596R6YixlS7oton
        mXoPQNUY7ED+RfGjnO4GxjflLikMTBbBTwcZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uOG/KI7h9hhsU0vz6/Lk4svM5tvtAj9O
        cXlTfQDNfCXfNBi5WzdNixNCyUaOvDWNsIS5UMBsqoDtXYF2xSIzbgn+LzfaQ8Kn
        MvLYyshu/YLxKP6BhPt8sMNTqyqmagijDjxxnF3xnoYTrAg6eyQoPgDudbd83sH1
        Ub7M2O+x/5E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EE196A9F9;
        Sun, 13 Sep 2020 17:45:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83D926A9F8;
        Sun, 13 Sep 2020 17:45:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] builtin/diff: parse --no-index using parse_options()
References: <cover.1599332861.git.liu.denton@gmail.com>
        <cover.1599723087.git.liu.denton@gmail.com>
        <ea6717e7b3a8b89fc3750505678321803cde78dc.1599723087.git.liu.denton@gmail.com>
        <xmqqo8mdpji9.fsf@gitster.c.googlers.com>
        <20200913083122.GA189023@generichostname>
Date:   Sun, 13 Sep 2020 14:45:28 -0700
In-Reply-To: <20200913083122.GA189023@generichostname> (Denton Liu's message
        of "Sun, 13 Sep 2020 01:31:22 -0700")
Message-ID: <xmqqsgblmjuv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7115EF24-F60A-11EA-9119-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> It should be taught to be handled by
>> diff.c::diff_opt_parse() instead, like all other "diff" options.  I
>> simply do not see what makes "--merge-base" so special compared to
>> other options like "-R", "--color-words", etc.
>
> Unfortunately, despite the above, I don't think we'll be able to handle
> this in diff_opt_parse(). --merge-base won't be common to all diff
> modes. It'll only work with diff-index and diff-tree, so it'll have to
> be handled in those modes specifically.

Yes, I think we can follow precedences, like the "--cached" option,
"builtin/diff-index.c::cmd_diff_index()" knows about it and it is
also handled by "builtin/diff.c::builtin_diff_index()".

Thanks.


