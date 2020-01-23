Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4445C33CAA
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 21:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2CA20665
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 21:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L2xmAxu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgAWVoP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:44:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60801 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgAWVoP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 16:44:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B038A392FD;
        Thu, 23 Jan 2020 16:44:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=+Xc2XR/gavKHFwxoUKwboPtn4HU=; b=L2xmAx
        u5eac2wWVal6Sgo6fYqq5W43tOGjU+YN4VCCA+K8MBvWkDQQmZmmr2HRuPmrHKVU
        INjKCV41IcA8PJnvHOellVAlCnPmSzFmPGT3zTfdsCr5l3sQiSlinGQqn4y1Ca1V
        kfPgbPHxXtaEzaet1HtIR0SRk9E19M2KGpTA8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eTo6UFJLa7mX/oEOZWs1OYent2/cdPT7
        2OD7jD5KmkKIIzxFltXicg+lTgBHmhhr+P1pTrGQMuAlhl++Dpcslnfi1kw3ObOz
        TsJrK8X3BA55N8ubFkvRvfbEAV9ZxazyGpOTBEmy+fyC2I0FboiC7x+AuzJPCNRp
        oMOgRoIheak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A669B392FB;
        Thu, 23 Jan 2020 16:44:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 140E5392FA;
        Thu, 23 Jan 2020 16:44:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH 0/5] Reftable support git-core
In-Reply-To: <pull.539.git.1579808479.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 23 Jan 2020 19:41:14
        +0000")
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Thu, 23 Jan 2020 13:44:09 -0800
Message-ID: <xmqqy2tx3l1y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DA7FE38-3E29-11EA-9B07-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This adds the reftable library, and hooks it up as a ref backend.

Just a quick impression before getting into details of individual
steps.

 * With this series, the reftable backend seems to take over as the
   default and only backend.  We would need to design and decide how
   repositories would specify which backend it uses (I personally do
   not think we need to allow more than one backend to be active at
   the same time) before we take this series out of RFC status.

 * What's reftable/VERSION file?  Does it really have what you
   intended to add?

 * Mixed indentation and many whitespace breakages make the code
   distracting to review.

 * Comparison with 0 is written as "if (!strcmp(a, b))" in this
   codebase, and never "if (0 != strcmp(a, b))".

 * We unfortunately do not use var defn "for (int i = 0; ..." yet.

 * We do not use // comments.

Thanks.


> Han-Wen Nienhuys (5):
>   setup.c: enable repo detection for reftable
>   create .git/refs in files-backend.c
>   Document how ref iterators and symrefs interact
>   Add reftable library
>   Reftable support for git-core
>
>  Makefile                  |   23 +-
>  builtin/init-db.c         |    2 -
>  refs.c                    |   18 +-
>  refs.h                    |    2 +
>  refs/files-backend.c      |    4 +
>  refs/refs-internal.h      |    4 +
>  refs/reftable-backend.c   |  780 ++++++++++++++++++++++++++++
>  reftable/README.md        |   12 +
>  reftable/VERSION          |  293 +++++++++++
>  reftable/basics.c         |  180 +++++++
>  reftable/basics.h         |   38 ++
>  reftable/block.c          |  382 ++++++++++++++
>  reftable/block.h          |   71 +++
>  reftable/block_test.c     |  145 ++++++
>  reftable/blocksource.h    |   20 +
>  reftable/bytes.c          |    0
>  reftable/constants.h      |   27 +
>  reftable/dump.c           |  102 ++++
>  reftable/file.c           |   98 ++++
>  reftable/iter.c           |  211 ++++++++
>  reftable/iter.h           |   56 ++
>  reftable/merged.c         |  262 ++++++++++
>  reftable/merged.h         |   34 ++
>  reftable/merged_test.c    |  247 +++++++++
>  reftable/pq.c             |  116 +++++
>  reftable/pq.h             |   34 ++
>  reftable/reader.c         |  672 ++++++++++++++++++++++++
>  reftable/reader.h         |   52 ++
>  reftable/record.c         | 1030 +++++++++++++++++++++++++++++++++++++
>  reftable/record.h         |   79 +++
>  reftable/record_test.c    |  313 +++++++++++
>  reftable/reftable.h       |  396 ++++++++++++++
>  reftable/reftable_test.c  |  434 ++++++++++++++++
>  reftable/slice.c          |  179 +++++++
>  reftable/slice.h          |   39 ++
>  reftable/slice_test.c     |   38 ++
>  reftable/stack.c          |  931 +++++++++++++++++++++++++++++++++
>  reftable/stack.h          |   40 ++
>  reftable/stack_test.c     |  265 ++++++++++
>  reftable/test_framework.c |   60 +++
>  reftable/test_framework.h |   63 +++
>  reftable/tree.c           |   60 +++
>  reftable/tree.h           |   24 +
>  reftable/tree_test.c      |   54 ++
>  reftable/writer.c         |  586 +++++++++++++++++++++
>  reftable/writer.h         |   46 ++
>  setup.c                   |   20 +-
>  47 files changed, 8530 insertions(+), 12 deletions(-)
>  create mode 100644 refs/reftable-backend.c
>  create mode 100644 reftable/README.md
>  create mode 100644 reftable/VERSION
>  create mode 100644 reftable/basics.c
>  create mode 100644 reftable/basics.h
>  create mode 100644 reftable/block.c
>  create mode 100644 reftable/block.h
>  create mode 100644 reftable/block_test.c
>  create mode 100644 reftable/blocksource.h
>  create mode 100644 reftable/bytes.c
>  create mode 100644 reftable/constants.h
>  create mode 100644 reftable/dump.c
>  create mode 100644 reftable/file.c
>  create mode 100644 reftable/iter.c
>  create mode 100644 reftable/iter.h
>  create mode 100644 reftable/merged.c
>  create mode 100644 reftable/merged.h
>  create mode 100644 reftable/merged_test.c
>  create mode 100644 reftable/pq.c
>  create mode 100644 reftable/pq.h
>  create mode 100644 reftable/reader.c
>  create mode 100644 reftable/reader.h
>  create mode 100644 reftable/record.c
>  create mode 100644 reftable/record.h
>  create mode 100644 reftable/record_test.c
>  create mode 100644 reftable/reftable.h
>  create mode 100644 reftable/reftable_test.c
>  create mode 100644 reftable/slice.c
>  create mode 100644 reftable/slice.h
>  create mode 100644 reftable/slice_test.c
>  create mode 100644 reftable/stack.c
>  create mode 100644 reftable/stack.h
>  create mode 100644 reftable/stack_test.c
>  create mode 100644 reftable/test_framework.c
>  create mode 100644 reftable/test_framework.h
>  create mode 100644 reftable/tree.c
>  create mode 100644 reftable/tree.h
>  create mode 100644 reftable/tree_test.c
>  create mode 100644 reftable/writer.c
>  create mode 100644 reftable/writer.h
>
>
> base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/539
