Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB3B20969
	for <e@80x24.org>; Wed, 29 Mar 2017 22:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbdC2WOe (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 18:14:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57830 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932255AbdC2WOd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 18:14:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57C648440B;
        Wed, 29 Mar 2017 18:14:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vr2M0jTy3IUq9LG388it7MVNK0g=; b=D4FSEO
        7bkqX2yt1ke68t7vaelxcxCjnSJaS1mxeYKb2L6DW+6XufE+XeGGh1/tglALI+oz
        j8jPMc6BRMr5HjfZ091iLYSxTBMUr73IKwQFq3q4qLUqA4mz9i/kUnvGc5G6o/pk
        SitIM+ydUV1+Zn+fsHhMHx93advUS1jMENG9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w/kqURhkUcvBAwADRKYabkFvrSTLJPkE
        EwEA05U71Uvu14KD+siWODTGsjx985xT3MLiKdUiIqXG8CEf8NWKSLVN6s0Nonpf
        +vKGIz3kUQmZajJ9D6NEI0l+nd+9IrdQFA0e5yJm9Jro46qhs6YcVYF2yazLU4oE
        kV6BM8kn9dU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E47884407;
        Wed, 29 Mar 2017 18:14:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF91684402;
        Wed, 29 Mar 2017 18:14:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2017, #12; Wed, 29)
References: <xmqqk27791ws.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 29 Mar 2017 15:14:29 -0700
In-Reply-To: <xmqqk27791ws.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 29 Mar 2017 15:02:59 -0700")
Message-ID: <xmqqfuhv91dm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14C41D62-14CD-11E7-B8B7-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * mg/name-rev-debug (2017-03-29) 3 commits
>  - name-rev: provide debug output
>  - name-rev: favor describing with tags and use committer date to tiebreak
>  - name-rev: refactor logic to see if a new candidate is a better name
>  (this branch uses mg/describe-debug-l10n.)
>
>  "git describe --debug --contains" did not add any meaningful
>  information, even though without "--contains" it did.
>
>  Waiting for jc/p4-current-branch-fix to settle.
>  This replaces jc/name-rev.

Regarding this "p4 fix", which is this one:

> * jc/p4-current-branch-fix (2017-03-27) 2 commits
>  - DONTMERGE git-p4: "name-rev HEAD" is not a way to find the current branch
>  - git-p4: add failing test for name-rev rather than symbolic-ref
>
>  "git p4" used "name-rev HEAD" when it wants to learn what branch is
>  checked out; it should use "symbolic-ref HEAD".
>
>  The tip one (i.e. real fix) needs to be redone by somebody
>  competent with Python and git-p4 codebase.

does anybody want to volunteer rewriting the "DONTMERGE" one, which
is shown below, in a better way?  Two things that I find disturbing
are

 * there is another "git symbolic-ref HEAD" invocation immediately
   before the context we see in the patch, which feels redundant;

 * the [11:] is to strip the leading "refs/heads/"; there should be
   a more Pythoninc way (which may even be used in existing code in
   git-p4.py) to do so.

If I hear from nobody in a few days, I'll have to merge the crappy
one below to 'next' to allow Michael's "name-rev" updates to move
forward.

Thanks.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 16 Mar 2017 22:56:22 -0700
Subject: [PATCH] git-p4: "name-rev HEAD" is not a way to find the current branch

This function seems to want to learn which branch we are on, and
running "name-rev HEAD" is *NEVER* the right way to do so.  If you
are on branch B which happens to point at the same commit as branch
A, "name-rev HEAD" can say either A or B (and it is likely it would
say A simply because it sorts earlier, and the logic seems to favor
the one that was discovered earlier when all else being equal).  If
you are on branch B which happens to be pointed by an annotated tag
T, "name-rev HEAD" will say T, not B.

Use "symbolic-ref HEAD" instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-p4.py                | 2 +-
 t/t9807-git-p4-submit.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0cfc8668d6..6a448a573b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -549,7 +549,7 @@ def currentGitBranch():
         # on a detached head
         return None
     else:
-        return read_pipe(["git", "name-rev", "HEAD"]).split(" ")[1].strip()
+        return read_pipe(["git", "symbolic-ref", "HEAD"]).strip()[11:]
 
 def isValidGitDir(path):
     if (os.path.exists(path + "/HEAD")
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 4e625fad07..643258500b 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -139,7 +139,7 @@ test_expect_success 'submit with master branch name from argv' '
 	)
 '
 
-test_expect_failure 'allow submit from branch with same revision but different name' '
+test_expect_success 'allow submit from branch with same revision but different name' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
 	(
-- 
2.12.2-510-ge1104a5ee5

