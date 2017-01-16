Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60CE20756
	for <e@80x24.org>; Mon, 16 Jan 2017 07:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbdAPHok (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 02:44:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52363 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751233AbdAPHoi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 02:44:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3218C57014;
        Mon, 16 Jan 2017 02:44:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2ISWczIWqvEzDAyrwM7XcpFnpnM=; b=nmlZzX
        7zhQlLqp/jiBz1Vb8vHuPAXc4+CIo0pv/Rpl5pFuYkSrLgWl9kaFSLQOAb7U2hV2
        63MviuCbD89afzWQzfvppnt0oCeQ0MDKoHSWv646tll9thfMde3qIzW898VjfdQt
        mAzd4uC20Zsj51GcUa+lSqrWfj/caLnjXdRcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xBUA91i+4fcjXo+FBArHIw0nbZrjSdSs
        +dZzZ3S9Vjjl+lWz+kHxEY+EI0jZ9tfd23fYmTlmOYlIOljXTANI+vhX0gLFr9Iv
        1050QNV05yRmqJTKmL57AaJTUU6b/nfscZwDfjh5hDpAEra13ryNPgdUb2lEigMg
        4CMB+rHYk2A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A0CF57013;
        Mon, 16 Jan 2017 02:44:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FA9F57012;
        Mon, 16 Jan 2017 02:44:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Different merges from translation perspective
References: <CAP6f5MkOoDUqHCvLNQ+xJGWTbrdecet9W_JK5y7JeAnBpGeAaw@mail.gmail.com>
Date:   Sun, 15 Jan 2017 23:44:35 -0800
In-Reply-To: <CAP6f5MkOoDUqHCvLNQ+xJGWTbrdecet9W_JK5y7JeAnBpGeAaw@mail.gmail.com>
        (Alexander Shopov's message of "Mon, 16 Jan 2017 06:41:57 +0200")
Message-ID: <xmqq37gjbg9o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0D1D002-DBBF-11E6-93A6-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Shopov <ash@kambanaria.org> writes:

> What is the difference between simple, fast forward, automatic and
> trivial merge?

"fast forward" and "trivial" (and "automatic" to some degree) are
technical terms with precise meaning.  Other phrases that are
related to "merge" that are not in your list are "already
up-to-date" and "real merge".

I do not think "simple" is among these words, but I can see it used
colloquially to mean "a real merge that is easy to resolve",
e.g. "if you get conflicts that is not simple, you may have to study
what both sides did carefully before you can decide the correct
merge result".

When you are on commit X and trying to merge commit Y, various
things can happen.  

 * There is one case where nothing happens.  You may have cloned
   from another repository and the tip of the branch was at commit Y
   back then---since then you built on it and you are now at commit
   X, and nobody else did anything in that repository in the
   meantime.  You try to merge from there, and find that the tip of
   the branch is still Y.  Your history leading to X contains
   everything the other side of the history leading to Y contains,
   so there is no need to do anything.

   We say that in this situation, your branch is already up-to-date.


 * There is another case where no new commit is created.  You may
   have cloned like the above case and got commit X, and haven't
   done anything since then, while others worked on the branch to
   advance the tip to commit Y.  You try to merge their work.  Their
   history leading to Y contains everything you have in your history
   leading to X contains.  The only thing we need is to "fast forward"
   your tip of the branch from X to Y, and make the index and the
   working tree to match.

   We say that in this situation, your branch can be fast forwarded.


 * All other cases, we need to come up with a new state that is the
   result of merging X and Y, and record it as a child commit of
   both X and Y, i.e. create a merge commit.  

   We say that this situation requires a real merge.

 * When a real merge is needed, there are a few subcases.

   - The two histories being merged may have changed their own set
     of files, without overlap.  Your commit X, since your history
     diverged from the history that leads to commit Y, may have
     worked only on the source file, while commit Y, since it
     diverged from your history, may have worked only on the
     documentation file, in a hypothetical two-file project.  In
     such a case, the copy of the documentation file you have at
     commit X is in the state the file was in when the histories
     diverged, and only the other side modified it, and we can take
     the documentation file from commit Y (i.e. the other side) as
     the result.  Similarly, because only you changed the source
     file while the other side didn't touch it, we take the source
     file from commit X.  We can come up with the merge result
     without even inspecting the file contents.

     The act of coming up with the result of the merge by pure
     equality of the file contents (i.e. one side modified, the
     other side left intact) is called "tree level merge", and a
     merge, all of whose paths can be resolved by tree level merge,
     is called "trivial merge".

   - If a merge is not "trivial", we'd need to dig down to "file
     level merge".  The contents of a file that was touched by both
     sides need to be computed. 

   - In a merge that requires "file level merge", you and the other
     side may have modified the same file, but touched different and
     non-overlapping parts.  You may have updated text in section 1
     of the documentation file while the other side may have fixed
     typo in section 3.  We use the same "three-way merge" principle
     used in the "tree-level merge"; if you did not touch a part of
     file that was modified by the other side, we take what the
     other side did, and vice versa, to come up with the merge
     result.  There are other ways to mechanically come up with the
     file level merge result that the user can supply (low level
     merge drivers).  The result of such a mechanical merge, when
     successfully recorded, is often called "automatic merge".
