Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F88DC433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 22:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF0D22B2D
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 22:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgLVWH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 17:07:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53856 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgLVWH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 17:07:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F6D1103290;
        Tue, 22 Dec 2020 17:06:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=av+Y3rrQyUjzXJjmqhn1K7BViaI=; b=rQ/JZT
        ooHbMktjHCToIT+SkM0FpVnowkLAf0uDGOyYoMtzUz9sl9/v4tUADsk0MgWrmvvV
        22cryunwG2wH6OJEsQIxYvTMvLHb8AzFDSt8x6fkMTar4MBl9QzFbz5iCD/dkaVU
        r0qQeXsryLHBsfLBW7ydZQqlrtzn/C7NPvaxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZTB7xKmP5Rs4PFnAaii0VukACS6E93mA
        +GPDDLGzGRGTh//TiLNKoDDDLOmDULD+Dcq4dJ1hUzLOB21vrLI4g8AeTuf5lYzL
        882VWBqTTBnOw5W+//I614vwV4ssSr13nRBlUBPwiCzUKIb+ZZhA0wFSuvQBARXr
        q4rbNkKoEcc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 895D610328F;
        Tue, 22 Dec 2020 17:06:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D261310328E;
        Tue, 22 Dec 2020 17:06:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Cloning with remote unborn HEAD
References: <20201211210508.2337494-1-jonathantanmy@google.com>
        <cover.1608673963.git.jonathantanmy@google.com>
Date:   Tue, 22 Dec 2020 14:06:43 -0800
In-Reply-To: <cover.1608673963.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 22 Dec 2020 13:54:17 -0800")
Message-ID: <xmqqwnx9fqbw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA8AB038-44A1-11EB-91A6-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks Junio for informing me of the test failures. Turns out that it
> was partly because I didn't memset oid (and in some code paths, it gets
> read without being written to), and partly because I didn't set
> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME. Here's an updated patch set with
> the fixes.
>
> Jonathan Tan (3):
>   ls-refs: report unborn targets of symrefs
>   connect, transport: add no-op arg for future patch
>   clone: respect remote unborn HEAD

Having to unset the GIT_TEST_* environment even when we have an
explicit "git -c init.defaultBranch=<val>" is a bit awkward and
frustrating, but hopefully this would futureproof the tests for
the current and future world ;-)

Will replace.

>
>  Documentation/config.txt                |  2 +
>  Documentation/config/init.txt           |  2 +-
>  Documentation/config/lsrefs.txt         |  3 ++
>  Documentation/technical/protocol-v2.txt | 10 ++++-
>  builtin/clone.c                         | 19 +++++++--
>  builtin/fetch-pack.c                    |  3 +-
>  builtin/fetch.c                         |  2 +-
>  builtin/ls-remote.c                     |  2 +-
>  builtin/remote.c                        |  2 +-
>  connect.c                               | 29 ++++++++++++--
>  ls-refs.c                               | 52 +++++++++++++++++++++++--
>  ls-refs.h                               |  1 +
>  remote.h                                |  3 +-
>  serve.c                                 |  2 +-
>  t/t5606-clone-options.sh                |  8 ++--
>  t/t5702-protocol-v2.sh                  | 11 ++++++
>  transport-helper.c                      |  7 +++-
>  transport-internal.h                    | 13 +++----
>  transport.c                             | 29 ++++++++------
>  transport.h                             |  7 +++-
>  20 files changed, 164 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/config/lsrefs.txt
>
> Range-diff against v3:
> 1:  7d20ec323a ! 1:  a66e50626e ls-refs: report unborn targets of symrefs
>     @@ ls-refs.c: static int send_ref(const char *refname, const struct object_id *oid,
>      +	int flag;
>      +	int oid_is_null;
>      +
>     ++	memset(&oid, 0, sizeof(oid));
>      +	strbuf_addf(&namespaced, "%sHEAD", get_git_namespace());
>      +	resolve_ref_unsafe(namespaced.buf, 0, &oid, &flag);
>      +	oid_is_null = is_null_oid(&oid);
> 2:  b5a78857eb = 2:  14f3962adc connect, transport: add no-op arg for future patch
> 3:  c2303dc976 ! 3:  e770fc46eb clone: respect remote unborn HEAD
>     @@ t/t5606-clone-options.sh: test_expect_success 'redirected clone -v does show pro
>       
>       test_expect_success 'chooses correct default initial branch name' '
>      -	git init --bare empty &&
>     ++	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
>      +	git -c init.defaultBranch=foo init --bare empty &&
>      +	test_config -C empty lsrefs.allowUnborn true &&
>       	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
>     @@ t/t5702-protocol-v2.sh: test_expect_success 'clone with file:// using protocol v
>       '
>       
>      +test_expect_success 'clone of empty repo propagates name of default branch' '
>     ++	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
>      +	git -c init.defaultBranch=mydefaultbranch init file_empty_parent &&
>      +	test_config -C file_empty_parent lsrefs.allowUnborn true &&
>      +
>     ++	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
>      +	git -c init.defaultBranch=main -c protocol.version=2 \
>      +		clone "file://$(pwd)/file_empty_parent" file_empty_child &&
>      +	grep "refs/heads/mydefaultbranch" file_empty_child/.git/HEAD
