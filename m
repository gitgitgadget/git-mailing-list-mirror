Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2179C20A10
	for <e@80x24.org>; Mon,  2 Oct 2017 02:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdJBCiD (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 22:38:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51834 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751179AbdJBCiC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 22:38:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C04C5A2543;
        Sun,  1 Oct 2017 22:38:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2wx7Ja7vGlDR
        mR8aQBLK2mM02s8=; b=Xlvb1ebVtm5LYOSFbvv4pKfbk0W3GNCXBLgKvUc8lg0I
        oU2uqTXBU84S6+hWU8JLH9brFJWOq4w6pKPs3rWdG0wnGwKmOekBsv25Z5dWla0x
        oqB5KIzr7eZwvPJ7CgETpwFimdkYFuUxAjl2Qn+Kv1VfrBH/zF1dhJyXJF5vY0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GGeNaH
        jGWI0QwaDojWFZz3Wr5ZL7HZC7ECp/FuN0UaB7tXZlWsHczt1NmF4PISHc9yNG2N
        cOLegELBzkKrf4Q+zNNqEIG+8bec6NxTTGZn6hiJsYSdykW6m2HMrCPfIfKxhDoD
        aKEyYz2/nhsMumiDHo8tfNUNZttVMlCJt6we4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EADDA2541;
        Sun,  1 Oct 2017 22:38:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13B50A2540;
        Sun,  1 Oct 2017 22:38:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/11] various lockfile-leaks and -fixes
References: <cover.1506862824.git.martin.agren@gmail.com>
Date:   Mon, 02 Oct 2017 11:37:58 +0900
In-Reply-To: <cover.1506862824.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sun, 1 Oct 2017 16:56:01 +0200")
Message-ID: <xmqqpoa6qnp5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B4C114CA-A71A-11E7-8B42-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Martin =C3=85gren (11):
>   sha1_file: do not leak `lock_file`
>   treewide: prefer lockfiles on the stack
>   lockfile: fix documentation on `close_lock_file_gently()`
>   tempfile: fix documentation on `delete_tempfile()`
>   cache-tree: simplify locking logic
>   apply: move lockfile into `apply_state`
>   apply: remove `newfd` from `struct apply_state`
>   cache.h: document `write_locked_index()`
>   read-cache: require flags for `write_locked_index()`
>   read-cache: don't leave dangling pointer in `do_write_index()`
>   read-cache: roll back lock on error with `COMMIT_LOCK`
>
>  apply.c            | 25 ++++++++-----------------
>  apply.h            |  8 +++-----
>  builtin/am.c       | 27 ++++++++++++---------------
>  builtin/apply.c    |  4 +---
>  builtin/checkout.c | 14 ++++++--------
>  builtin/clone.c    |  7 +++----
>  builtin/diff.c     |  7 +++----
>  builtin/difftool.c |  1 -
>  cache-tree.c       | 12 ++++--------
>  cache.h            | 19 +++++++++++++++++++
>  config.c           | 17 ++++++++---------
>  git-compat-util.h  |  7 ++++++-
>  lockfile.h         |  4 ++--
>  merge-recursive.c  |  6 +++---
>  merge.c            |  8 +++-----
>  read-cache.c       | 26 ++++++++++++++------------
>  sequencer.c        |  1 -
>  sha1_file.c        | 16 +++++++---------
>  tempfile.h         |  8 ++++----
>  wt-status.c        |  8 ++++----
>  20 files changed, 110 insertions(+), 115 deletions(-)

That's quite a lot of changes to the low-level code.  I'll need to
revisit this topic later once again, but from a cursory read did not
find anything glaringly wrong in it.  Thanks for working on this.
