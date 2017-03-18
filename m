Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF2D42095D
	for <e@80x24.org>; Sat, 18 Mar 2017 02:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751292AbdCRCOC (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 22:14:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62511 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751072AbdCRCN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 22:13:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B4417E283;
        Fri, 17 Mar 2017 21:36:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Eek5C+4BCmpk1yPq4OvbpOWVQQ0=; b=NowNrF
        SS7BmtjoaX5/sgyFdlOgsU2K7QfBqatod4e5ear6pLenHQ58eOgUrV1VkzgdGoix
        H+V45FyCg3Bs+BariqJD4cMYSCQGS7Ke1Q4vtQFGgweiE/JKfwlB5joUam2fyPer
        hM2FkOUiHkY3XooyAGNKngwlPd7MU6bm9K5fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c52i8auAPaKUIUhF1zMbP7XMs2wb00qD
        fBaDKin7doc7E9NhE+gW0P3ZmWSGXJvaeBpxtc8q0+r8E2AawKHf6af5BYu06MVe
        D6dV8m7tAbzqSTeHx7C0IpUyBqNuC/CRQq8TrsdhsvyNRQqeYxmvDMv0ATBt7Yeh
        22AIJvvzjCA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63F7C7E282;
        Fri, 17 Mar 2017 21:36:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA6487E280;
        Fri, 17 Mar 2017 21:36:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on the file system
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
        <20170317225110.13417-1-sbeller@google.com>
Date:   Fri, 17 Mar 2017 18:36:43 -0700
In-Reply-To: <20170317225110.13417-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 17 Mar 2017 15:51:10 -0700")
Message-ID: <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 584CC6B6-0B7B-11E7-A0D3-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> -List details of each worktree.  The main worktree is listed first, followed by
> -each of the linked worktrees.  The output details include if the worktree is
> -bare, the revision currently checked out, and the branch currently checked out
> -(or 'detached HEAD' if none).
> +List details of each working tree.  The main working tree is listed first,
> +followed by each of the linked working trees.  The output details include if
> +the working tree is bare, the revision currently checked out, and the branch
> +currently checked out (or 'detached HEAD' if none).

I do not think this is correct.

Think of a "worktree" something that roughly corresponds to
different location you can refer to with $GIT_DIR.

A $GIT_DIR may be a true repository.  Or it may be borrowing many of
the things from its primary repository.  Even though "git worktree"
Porcelain may not currently be equipped to create a "bare" $GIT_DIR,
there is no fundamental reason that a secondary "worktree" must have
a working tree, i.e. a "worktree" could be a "bare" one (it would be
the first use of per-worktree config; a secondary worktree that is a
bare can be made by borrowing from the primary worktree that has a
working tree).

Now, what does "git worktree list" enumearate?  It does not list
"working trees"; its output are list of things, each of which you
could point at with $GIT_DIR and work with.

