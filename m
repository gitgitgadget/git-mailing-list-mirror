Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E4AC1F406
	for <e@80x24.org>; Mon, 25 Dec 2017 17:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbdLYRrL (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 12:47:11 -0500
Received: from mout.web.de ([212.227.17.12]:56398 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752881AbdLYRrK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 12:47:10 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lk8t4-1f5bgB3I1S-00cDRo; Mon, 25
 Dec 2017 18:47:05 +0100
Subject: [PATCH v2 7/9] checkout: avoid using the rev_info flag leak_pending
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fe63ddf2-0b6b-bb26-3550-efdb65968e46@web.de>
Date:   Mon, 25 Dec 2017 18:47:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yxgBogwTdy44dXtJRgxvKY0iQ74J8nwxxbnGGhrQruWMlIf0l8q
 jYSJMxXMFIBQ9vs/yjSQn6QyOcz4hHHgibjmBj0gMTRi5Ch+RvetjN8pievg+1xxFFO9eNb
 1fVh8AEqyIrgKnldo03ZeVbnsjADlSFY0CjJOi3GV6EpokY87jl7xhjWJpujFlk2ZM1i1Wx
 hAX4FTG3OMl/84bYkNWSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mr0N3NGztI4=:3sV6PHu9MxKHSqWMEyFqIE
 VAdRVhoS2ZNyFQDm4nZSYkehJUV4/l0saHH3XuAwNLWV6YHMoY3WcKz1Bj2ytcdgktQE+vOHI
 uCS/xKdZ9yheIAcT8dzqUps8j7YGdS4wEI28YKo4bUxc4pJ4m7O9VNFCYXceO5+rgQM0NXPnx
 IICsm6uZoBw32DKr2H4p98EWDTs2umUU4FsQO9j1Cg4SNoG0rSpY04/4haH1nExSOfxF0CYj2
 paNUtZt0Z+b685Dn0xk6g+qtXRY9IgHcy8sYqSujVLTr80XEc+kcbdM9rgPfN+u3BkycurJD9
 aOxrbA5PlhFMR3rqGt9SB9vUKq40tYzSA2qglr6h2ja10AW+kg11FLTlgZQpyemCMzcAFAYlH
 TdQ29L4KNEksSv8cKZ2Y2wGSIsoENszeDv+UpxmdoJBuAuWV7aia3L04ufpdcTKgOnq8GqCqr
 ODoI10w29QMlGIxqk85nsjIimBO7OI4sIkbUDRJXVYJb2iF7+F93j1/1pC/y4QWP8t4Msmbwp
 HlUwdx35KoHVa77Ji9xeSWlNmFJ/qIZAWlMAuk8VOsbe8DYKP4VtbVsxvSRmE5JMpicYclfLd
 7cjKHm9CN4LOrv7nbgiFGrqRtYQumRhXsl/s4KEIUrlgpulz0iqwThK2ukPIoxjDImOvptEMC
 /l9Pgs2Us6QS3PA/dyoQJUUdaLdzN+AI4MsrDYA/zeqSQyisIJsrP1HUxK0+3CbjMOEEjur6/
 CYiacylbo6Mf5kbsVzlgTiMjD88JNRberjk7b93CZs+V7bVYq3veiU70gU3ioTsDkRPBSr5cO
 87lFPd8hjIcs7yY0zr2xpG7OKpeRQon8aJ0hNgfK56YnlZ6qsGzFZ0xNTG6UHDMyvGF2gFl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The leak_pending flag is so awkward to use that multiple comments had to
be added around each occurrence.  We only use it for remembering the
commits whose marks we have to clear after checking if the old HEAD is
detached.  This is easy, though: We need to do that for the old commit,
the new one -- and for all refs.

Don't bother tracking exactly which commits need their flags cleared,
just nuke all we have in-core.  This change is safe because refs can
point at anything, so other program parts can't depend on any kept flags
anyway.  And since all refs are loaded we have to basically deal with
all commits anyway, so performance should not be negatively impacted.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/checkout.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9f3797e11..afb225ca79 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -790,37 +790,26 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 static void orphaned_commit_warning(struct commit *old, struct commit *new)
 {
 	struct rev_info revs;
 	struct object *object = &old->object;
-	struct object_array refs;
 
 	init_revisions(&revs, NULL);
 	setup_revisions(0, NULL, &revs, NULL);
 
 	object->flags &= ~UNINTERESTING;
 	add_pending_object(&revs, object, oid_to_hex(&object->oid));
 
 	for_each_ref(add_pending_uninteresting_ref, &revs);
 	add_pending_oid(&revs, "HEAD", &new->object.oid, UNINTERESTING);
 
-	/* Save pending objects, so they can be cleaned up later. */
-	refs = revs.pending;
-	revs.leak_pending = 1;
-
-	/*
-	 * prepare_revision_walk (together with .leak_pending = 1) makes us
-	 * the sole owner of the list of pending objects.
-	 */
 	if (prepare_revision_walk(&revs))
 		die(_("internal error in revision walk"));
 	if (!(old->object.flags & UNINTERESTING))
 		suggest_reattach(old, &revs);
 	else
 		describe_detached_head(_("Previous HEAD position was"), old);
 
 	/* Clean up objects used, as they will be reused. */
-	clear_commit_marks_for_object_array(&refs, ALL_REV_FLAGS);
-
-	object_array_clear(&refs);
+	clear_commit_marks_all(ALL_REV_FLAGS);
 }
 
 static int switch_branches(const struct checkout_opts *opts,
-- 
2.15.1
