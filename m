Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F79C433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 18:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B78EC20781
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jBCa0LoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389946AbgFYSVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:21:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52405 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389648AbgFYSVI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 14:21:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5085EE2B0C;
        Thu, 25 Jun 2020 14:21:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T0fmyVtmVNF5NXN9byrqeGhL1Hw=; b=jBCa0L
        oHLbu/X7foLnvjYLsCHTJ+fk3QJ3SIqZahbNpavZUUt6YTalYgIrUmy+ZDaDibe3
        W+fhDsuUF9dVa+FWVRT5GRHSXt9BZs9YxQC1nWP+8o+Y+SAtc48eyCvy6fzE5TSD
        uqCOPZJ45N3W/h+lymdg5dvcHZuwcz5d+bNN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rgx+UUlsNZEWU5JEWYMHQVAJUavLuE/6
        KE1k5JVTphHWYH/IHweuwRfcb13F3Zx+daJDg6FJCtAI4U511yJTQY3XFX0OqXhb
        2kftLnAtBqQvmGSX0YtPJFn5GziLhE8SmKJz0Z9bcXvbwwlsvBjiXNqlxMUKx+rW
        2pSZeUj0vzQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 480A2E2B0B;
        Thu, 25 Jun 2020 14:21:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8A5DBE2B0A;
        Thu, 25 Jun 2020 14:21:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/2] diff-files --raw: show correct post-image of intent-to-add files
References: <pull.654.v3.git.1593010066.gitgitgadget@gmail.com>
        <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
        <69256ab9107c3dba0dc007b69cc0ce98a9b91f9a.1593107621.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Jun 2020 11:21:01 -0700
In-Reply-To: <69256ab9107c3dba0dc007b69cc0ce98a9b91f9a.1593107621.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 25 Jun 2020
        17:53:40 +0000")
Message-ID: <xmqqeeq33t2q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0F2627E-B710-11EA-8C88-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The documented behavior of `git diff-files --raw` is to display
>
> 	[...] 0{40} if creation, unmerged or "look at work tree".

"on the right hand (i.e. postimage) side" is missing, which is
crucial in this description.

> This happens for example when showing modified, unstaged files.

Modified I would understand.  We notice that the contents on the
work tree is different from what is in the index, and we tell the
consumer "look at work tree".  I do not think you meant "unstaged",
though.  If truly removed from the index, diff-files won't even know
about the path.  You probably meant "removed from the working tree",
but 0{40} in that case means totally different thing (i.e. it would
be a (D)eletion record, so 0{40} on the postimage side is a filler,
not even "look at work tree").  What would make more sense to
describe might be

	This happens for paths that are modified, or unmodified but
	stat-dirty.

Either case, we tell the consumer to check the "work tree".

> For intent-to-add files, we used to show the empty blob's hash instead.
> In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
> 2017-05-30), we made that worse by inadvertently changing that to the
> hash of the empty tree.
>
> Let's make the behavior consistent with modified files by showing
> all-zero values also for intent-to-add files.

Well described.

Thanks.
