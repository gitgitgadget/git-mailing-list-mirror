Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209971F453
	for <e@80x24.org>; Mon, 18 Feb 2019 18:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfBRSl5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 13:41:57 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58416 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbfBRSl4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 13:41:56 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IIcrwD013104;
        Mon, 18 Feb 2019 10:41:51 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2qph8ra814-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 18 Feb 2019 10:41:51 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 Feb 2019 10:41:47 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 18 Feb 2019 10:41:47 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 20B0D2215C18;
        Mon, 18 Feb 2019 10:41:49 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Elijah Newren <newren@gmail.com>
Subject: 
Date:   Mon, 18 Feb 2019 10:41:47 -0800
Message-ID: <20190218184147.7563-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.264.g6c9e06a32d
In-Reply-To: <5C481202020000A10002F4AE@gwsmtp1.uni-regensburg.de>
References: <5C481202020000A10002F4AE@gwsmtp1.uni-regensburg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_14:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ulrich,

Sorry for the late reply...

On Tue, Jan 22, 2019 at 11:04 PM Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de> wrote:
> >>> Elijah Newren <newren@gmail.com> schrieb am 22.01.2019 um 22:29 in
> Nachricht
> > On Tue, Jan 22, 2019 at 1:05 PM Ulrich Windl
> > <Ulrich.Windl@rz.uni-regensburg.de> wrote:
> >>
> >> Using git version 2.16.4 on OpenSUSE Leap 15.0, it seems that "--no-commit"
> >> no
> >> longer does what it did before (AFAIR, but I mostly did --no-ff merges in
> >> SLES11):
> >>
> >> > git merge --no-commit local/f-linux-firefox
> >> Aktualisiere 520aaae..c11e3da
> >> Fast-forward
....
> > Indeed; the changes were committed before you ran "git merge"; they
> > were all part of the local/f-linux-firefox branch.
>
> Actually no: The changes were on a different local "remote" branch; otherwise
> I wouldn't need the merge, I guess

Yes, they were on a different branch, but since the commits already exist they don't need to be created again.  The current branch can just be updated from the current commit to the commit on the end of the other branch.  No merge is needed because the histories of the two branches have not diverged, so the merge short-circuits itself (doing what is sometimes called a "fast-forward merge" instead and avoiding almost all the normal merge logic).

> >> Reading
> >> https://stackoverflow.com/questions/8640887/git-merge-without-auto-commit
> it
> >> seems that without "--no-ff" this ioption is effectively ignored.
>
> Note: If you see the number of upvotes to the answer there, it seems I'm not
> the only one who got confused. ;-)

Indeed, and looking at that stackoverflow post, it makes it clear that the manpage is actually misleading.  I'll post a patch to correct it.

> Is moving commits from one branch to to another done without any new commit?
> Just updating the refs, or what? I didn't know that.

If the two branches have not diverged at all, and only one side has some commits that the other doesn't, then indeed there is no need for creating any new commits.  If the histories have diverged, then you need to create a merge commit and have a real merge.

> > If you want the branch to not get updated, then yes you'd need both
> > --no-ff and --no-commit in some cases.  But that's always been true.
> > It's possible in the past that you just didn't run into those cases.
>
> So it seems a commit is something other than I'd expected: To me anything that
> changes what "git log" outputs is a commit ;-) Or anything that chenges the
> reflog...

A commit is an object that records its parents (most commits have exactly one parent), its author, its committer, a commit message, and the tree involved.  Creating a new commit is a common reason to change the reflog and would cause git log to have more output for subsequent invocations.  Most merges will of necessity create a merge commit, to reflect that diverging histories have been merged (and such a commit will have more than one parent, one for each branch being merged).  But, as noted above, if histories haven't diverged then we don't need a new multi-parent commit; we can just short-circuit the merge logic and use the existing commits on the other branch.

> > Alternatively, we could update the documentation to point out this
> > special case under --no-commit to point out that when an ff-update
> > occurs no commit creation is involved and thus --no-commit has no
> > effect.  Would that help?
>
> Maybe (I'm unsure where the concepts are described best to check the current
> version(s)) try to explain the concepts of "commit" and "fast forward" in some
> greater detail. Maybe I was just expecting the wrong things to happen behind
> the scenes. Maybe add a statement like "fast-forwards never create a new
> commit, so --no-commit doesn't make sense when fast-forwarding."
>
> Thanks for the explanations.

Hopefully the patch below answers what you originally needed to know and prevents others from running into similar problems.

Thanks,
Elijah

-- 8< --
Subject: [PATCH] merge-options.txt: correct wording of --no-commit option

The former wording implied that --no-commit would always cause the
merge operation to abort and allow the user to make further changes
and/or provide a special commit message for the merge commit.  This
is not the case for fast-forward merges, as there is no merge commit
to create.  Without a merge commit, there is no place where it makes
sense to "stop the merge and allow the user to tweak changes"; doing
that would require a full rebase of some sort.

Modify the wording to correctly address fast-forward cases as well,
and suggest using --no-ff with --no-commit if the point is to ensure
that the merge aborts.

Reported-by: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-options.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index c2a263ba74..d1061b8cf7 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -3,9 +3,15 @@
 	Perform the merge and commit the result. This option can
 	be used to override --no-commit.
 +
-With --no-commit perform the merge but pretend the merge
-failed and do not autocommit, to give the user a chance to
-inspect and further tweak the merge result before committing.
+With --no-commit perform the merge and stop just before creating
+a merge commit, to give the user a chance to inspect and further
+tweak the merge result before committing.
++
+Note that fast-forward updates do not need to create a merge
+commit and therefore there is no way to stop those merges with
+--no-commit.  Thus, if you want to ensure your branch is not
+changed or updated by the merge command, use --no-ff with
+--no-commit.
 
 --edit::
 -e::
-- 
2.21.0.rc1.264.g6c9e06a32d

