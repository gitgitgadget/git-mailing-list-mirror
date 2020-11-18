Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7855AC2D0E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2D022202
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 00:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A1upUFSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKRAKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 19:10:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65376 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgKRAKs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 19:10:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B4EA936D3;
        Tue, 17 Nov 2020 19:10:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X6TMpeDMNqe6dny9VyRxm2pHxCA=; b=A1upUF
        SxruwCp5XK+NSeYGYaOaPzbNlGmx6lTqRHFATrrzQqYum4SMKsCuynkqvzXxttzI
        Db4PjGdxkQtOV1SSLXLztocGCC6gBdLfL0P1OaMY3zw+9CHRq1txek0EEw/aoT8i
        oLypTGQ/rUcu5Uxn+1rzhRBHz21SDJK6r1QbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aFj8txvkDlpPX7OR6JeVHyPWQqjPpql2
        CIaAq/0GH7dIuZ1rgcEpxtiSRkAi9dJHGjEZj5a1FP8Y8pWd7Q5rPoWYTsfG8c7O
        F45S4o1yXKkzYRH9kDenTN0vWavaPobmwtnhQH/Wwilfv8j/X9Ds5KRJiYnU+eWg
        qw4bysRshks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9321F936D2;
        Tue, 17 Nov 2020 19:10:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20208936D1;
        Tue, 17 Nov 2020 19:10:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
        <CAMP44s3750bSdmw4A=KU=UgffOPiQwB8ECk9YRPe8mh50Og8Ow@mail.gmail.com>
Date:   Tue, 17 Nov 2020 16:10:45 -0800
In-Reply-To: <CAMP44s3750bSdmw4A=KU=UgffOPiQwB8ECk9YRPe8mh50Og8Ow@mail.gmail.com>
        (Felipe Contreras's message of "Tue, 17 Nov 2020 17:16:53 -0600")
Message-ID: <xmqqmtzf4j96.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 816DF79E-2932-11EB-AFAB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If we already know "origin/HEAD" is very likely pointing to the
> integration branch, then why do we need to know what that branch is
> called in that particular project?
>
> Just refer to that branch as "origin/@", or just "origin".

"git merge origin" turns into "git merge origin/HEAD", I think, and
we had it for quite some time.

But repositories may not even have any origin to begin with.  The
one I am typing this message in certainly does not.  And we need
some fallback default when origin/HEAD cannot be used anyway, and
that is where the convention comes in again.  You cannot escape from
it, and ...

> That would work for projects that follow the convention, and those who
> don't. Why does the tool need to care?

... certainly it would not work for me.

