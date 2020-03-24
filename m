Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C8DC43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEA52076E
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 18:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KQsHhhrZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgCXSkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:40:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62239 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCXSkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 14:40:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62EFC58F06;
        Tue, 24 Mar 2020 14:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LTV7X60EckFk+OkUvVEbC8UKwCI=; b=KQsHhh
        rZgXa8/ymKdxF67h3Jy/KpfJ21Mv6oK0Xbm+z2eyW6xGONeFtjN7YJFDJNjq6KAf
        D/0tBTIyj60zoGjmHUPTixXeA8B/q5WFD3qhZk9unjdNHNc5ex6veMEIWt3RQzAu
        bVLfomM1Ztl0whB5BVnv+kM5xBmAWTaHhCPIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CqO1Y6U6uXU/mAE7vPRDZJJB1d5ZagPl
        EmMw8ZJqVq3af692HdOvs0UYTPaYk85GU9/TSvFouIkzsEKsjtdUbNSeM2qo78tK
        RtM/7Ewq2MyC0RvZE0WAOdN0uFELiiaTKa0ftgC21+LOKQ1jDcBZEQsx0j8nwkuB
        CAWQIL8w5n4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4EBF458F03;
        Tue, 24 Mar 2020 14:40:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80F9358F01;
        Tue, 24 Mar 2020 14:40:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Avis <ed.avis@qmaw.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature request: 'git grep' over multiple working trees
References: <MN2PR11MB3663C042590097D7A7F4B2409DF10@MN2PR11MB3663.namprd11.prod.outlook.com>
Date:   Tue, 24 Mar 2020 11:40:09 -0700
In-Reply-To: <MN2PR11MB3663C042590097D7A7F4B2409DF10@MN2PR11MB3663.namprd11.prod.outlook.com>
        (Ed Avis's message of "Tue, 24 Mar 2020 07:49:13 +0000")
Message-ID: <xmqq369x38c6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E42CD17E-6DFE-11EA-BEF2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Avis <ed.avis@qmaw.com> writes:

> If the current directory contains several git working trees (each
> in its own subdirectory) then 'git grep' should search all of
> them.  It would be roughly equivalent to
>
> % for i in * ; do (cd $i ; git grep whatever); done
>
> except that the filenames listed would have the full path.

I am not sure where that "should search" comes from.

In my $HOME/w directory, I have working trees of various
repositories, belonging to different and unrelated projects.
Should "git grep foo" in there search in everywhre?

Are you looking for "grep -r --exclude=.git" (not a git command at
all)?

In other words, surely anybody can wish anything nonsensical, but I
do not quite see the point for adding such a mode to "Git".

It sounds like saying 'git grep' "should" search all of them if the
current directly is a git repository with several git commits, which
would be roughly equivalent to

    git rev-list --all |
    while read rev
    do
	git grep -e pattern... $rev
    done

Similarly, you could say that 'git grep' "should" search all of them
if the current directory is a git repository with several branches,
which would be roughly equivalent to

    git for-each-ref --format='%(objectname)' refs/heads/ |
    while read rev
    do
	git grep -e pattern... $rev
    done

Neither of the above smell like a reasonable use of "should", at
least to me, and yours does not, either.

What is the real use case, if any, of what you are proposing?
