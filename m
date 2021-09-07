Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8693EC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6513361152
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343748AbhIGU3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:29:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52734 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhIGU3M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:29:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE48A1447C5;
        Tue,  7 Sep 2021 16:28:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=iDIJ4/VTkdjBGOpMjadeOFpHXJKb/nwiv5xHGG/Jfu8=; b=qkU3
        Rno4HSOFPEQ+PKAGWKzaaMJPFH95nHcf6eAw4QrFpRpKGU9u2jpmmeXgK1CdONOj
        KTRzR8s06uYQqWIY5CmXh7rDWBk6Re00LfvZrB9pepmYBODAxsTA91c446po4LBr
        Tm7dS3jRqknBxjKWx/86+0HgxpmM/pY3b1vhNUk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7ECE1447C4;
        Tue,  7 Sep 2021 16:28:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3AED21447C2;
        Tue,  7 Sep 2021 16:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calum McConnell <calumlikesapplepie@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] Add support for new %w wildcard in checkout filter
References: <20210906181002.625647-1-calumlikesapplepie@gmail.com>
Date:   Tue, 07 Sep 2021 13:28:01 -0700
Message-ID: <xmqqilzc9lm6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19F86C82-101A-11EC-B199-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Subject: [PATCH 1/3] Add support for new %w wildcard in checkout filter

Please write your title to help readers of "git shortlog --no-merges".
With the above, readers would not know where the %w would newly be
allowed to appear, what it does, and how it helps what use case.

> When building content filters with gitattributes, for instance to ensure
> git stores the plain-text rather than the binary form of data for certain
> formats, it is often advantageous to separate the filters into separate,
> potentially complex scripts.  However, as the $PWD where content filters
> are executed is unspecified the path to scripts needs to be specified as
> an absolute path.

Isn't $PWD at least stable in a repository, relative to the top of
worktree or something?  IOW, isn't the above raise a separate
documentation issue that is better solved without any new code?

> That means that the guide for setting up a repository
> which uses scripts to filter content cannot simply consist of "include
> the following lines in your .git/config file", and it means that the
> otherwise safe operation of moving a git repository from one folder to
> another is decidedly unsafe.

If these paths are given as absolute paths (e.g. ~/filter-scripts/),
the repositories that refer to these can be moved freely, as long as
the location of the the directory that holds these auxiliary scripts
is kept stable, no?
