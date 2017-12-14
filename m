Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FBF21F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753448AbdLNVIn (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:08:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57251 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753281AbdLNVIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:08:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 612E9C97E8;
        Thu, 14 Dec 2017 16:08:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aBgiS8jgs2g1fx68moMK0PY5WHQ=; b=Zqwhp9
        TnS/piAVCTlztkMaDJ3oGnWUrlFVZxVQNzrdeMjQ2K3yV7OtA4uXlINf2/JkeHFC
        yjvyufpXQxohSPCBtVd4XkQCCpjKudaB7+RuBqUhD+/pK3Xc6Eu5P/GoTUMCmzxS
        EGhzzNxGatD4wF1hpbWBabmRjKiEBSFBlm8uc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=knKmCRk3zppk2eJhdTfGwtvOThjrfAnv
        a+ez2xDLz/br3mNsO+gjkQZCG2pG/uTgDutQkVHUCyoMhYsDnfuwsZyyAy+swKqk
        JZTVlTeBzbzMTyrcqHr+m0wncRTMMIrYk7ewbm0GCG2uo+20ZNnw+gfQ9YnjDPQn
        mKUAxPmNkTA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57505C97E7;
        Thu, 14 Dec 2017 16:08:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4260C97E6;
        Thu, 14 Dec 2017 16:08:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2017, #03; Wed, 13)
References: <xmqqzi6mutcc.fsf@gitster.mtv.corp.google.com>
        <1513255038.6351.2.camel@gmail.com>
        <xmqqk1xpusyh.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 14 Dec 2017 13:08:40 -0800
In-Reply-To: <xmqqk1xpusyh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 14 Dec 2017 09:20:38 -0800")
Message-ID: <xmqq1sjxt3tz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6647DEA-E112-11E7-B909-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I think you only sent 3/3 in newer rounds, which made it not to
> apply to my tree.  If you meant to drop changes in 1/3 and 2/3,
> perhaps because they were needless churn, then 3/3 needs to be
> updated not to depend on the changes these two made.

Here is what I reconstructed to suit my taste better ;-)

-- >8 --
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date: Mon, 27 Nov 2017 22:51:02 +0530
Subject: [PATCH v4 1/3] rebase: consistently use branch_name variable

The variable "branch_name" holds the <branch> parameter in "git
rebase <upstream> <branch>", but one codepath did not use it after
assigning $1 to it (instead it kept using $1).  Make it use the
variable consistently.

Also, update an error message to say there is no such branch or
commit, as we are expecting either of them, and not limiting
ourselves to a branch name.

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 git-rebase.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 60b70f3def..5526b17a36 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -528,15 +528,18 @@ case "$#" in
 	branch_name="$1"
 	switch_to="$1"
 
-	if git show-ref --verify --quiet -- "refs/heads/$1" &&
-	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
+	# Is it a local branch?
+	if git show-ref --verify --quiet -- "refs/heads/$branch_name" &&
+	   orig_head=$(git rev-parse -q --verify "refs/heads/$branch_name")
 	then
-		head_name="refs/heads/$1"
-	elif orig_head=$(git rev-parse -q --verify "$1")
+		head_name="refs/heads/$branch_name"
+	# If not is it a valid ref (branch or commit)?
+	elif orig_head=$(git rev-parse -q --verify "$branch_name")
 	then
 		head_name="detached HEAD"
+
 	else
-		die "$(eval_gettext "fatal: no such branch: \$branch_name")"
+		die "$(eval_gettext "fatal: no such branch/commit: \$branch_name")"
 	fi
 	;;
 0)
@@ -547,7 +550,7 @@ case "$#" in
 		branch_name=$(expr "z$branch_name" : 'zrefs/heads/\(.*\)')
 	else
 		head_name="detached HEAD"
-		branch_name=HEAD ;# detached
+		branch_name=HEAD
 	fi
 	orig_head=$(git rev-parse --verify HEAD) || exit
 	;;
-- 
2.15.1-554-g7ec1e7e2b9

