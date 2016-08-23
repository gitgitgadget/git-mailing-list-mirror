Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AED31FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753543AbcHWQJC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:09:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:61158 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753364AbcHWQI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:08:58 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M7Y9j-1bG0Lw1vnT-00xO3V; Tue, 23 Aug 2016 18:07:51
 +0200
Date:   Tue, 23 Aug 2016 18:07:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 13/15] sequencer: lib'ify sequencer_pick_revisions()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <f9a888ca68915f5e407331c3bea94e2b09651412.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OgRu9CddmmG0oePNJHGWlGxLNW8qxnvGTZgTVZu7ElKiclZibLi
 am1xsnavXpJVzf4tXah6aygmjJKDLFM/fk1JBD1vn7brd3gGk9eil2Vg1LvDsQM9xiniAKx
 mNHatfcy1bikpDVexmJKziy1TntqY0C2WouQfN1ZeBihfV2DrxuqPz23bQudAH21zaClDA5
 z3Ykk+h3pgd58Y1X5gCfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CN42qTt7X1Y=:stg7LSzTc5oBc9HX1J6t2+
 mnMOLGIOfMtSZPnd377tA4nsA4mkNw/VIng7o2OBGLnUNVm2KViRACJnilEtbfsXpeERWAEyW
 fVKxA4zz+Z81CUjqaNgNLShZkVKGHhb5nP3zC0a4ani9YV99eTeITHD+rIQZLuASpOsnzxDHo
 C0Xc2Dcg1M9S6SGdr51/Gw5suRzlNT75S9LpPh+4LVu+8IdQNnSJG2qUzkTjIHbEMihDJ2VJQ
 MDmPt6cz1AOJJOeBedO9Sjo7RT7RQKdlXf4WMUTI03VoXDrhGZfze1EZMVmi34/8FmBLIxBwz
 zdklP26Lsps5uaAl27MjtBBNhyL0/EG43aUu4JuZr4vttkUucDLVhnUXVUgLAGgX97ikDESwi
 nvL0gaHJ34mztACXccbiEGf8bIW0nrfzjOuWKDg6XqZpmq7DcbZK6bMHcpwhLx/e0Mm3ZirL8
 akYekjkoZi4AFE5cX4/uSBBgIczFH9AVmooTtAFbld7sKRD2aOo+Eg4PJ5vuV70nu1g3pngBB
 KOYI2WxjmtIek0CT24CHfBS4KM57046wlIuRZMqwATFppeAXgihYxVfDXJ+QMao/JPv1O8vPC
 Ewph/4KFD4JtiNMyNyd/jpkZAbeSPU2DjZqsGNy69wU02CoNe/CBDaeHStFmSgxO/bgWxknsZ
 qtV9vVJ1J8cyq5TmgVqWcSI1j8oeeUg2WLfS91jZx/maeqbC0nmZIulj+WcuvwUpsjlNQKLa9
 yrfKT1DgiiuPjZv/sYAWWgcror2+T7+vn+/d9DDIWUr+kVufYw4/3wvZ2N0GU7D/VJnpN6xnR
 sf1jshq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bac32ea..324463f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1093,10 +1093,11 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		if (!get_sha1(name, sha1)) {
 			if (!lookup_commit_reference_gently(sha1, 1)) {
 				enum object_type type = sha1_object_info(sha1, NULL);
-				die(_("%s: can't cherry-pick a %s"), name, typename(type));
+				return error(_("%s: can't cherry-pick a %s"),
+					name, typename(type));
 			}
 		} else
-			die(_("%s: bad revision"), name);
+			return error(_("%s: bad revision"), name);
 	}
 
 	/*
@@ -1112,10 +1113,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	    !opts->revs->cmdline.rev->flags) {
 		struct commit *cmit;
 		if (prepare_revision_walk(opts->revs))
-			die(_("revision walk setup failed"));
+			return error(_("revision walk setup failed"));
 		cmit = get_revision(opts->revs);
 		if (!cmit || get_revision(opts->revs))
-			die("BUG: expected exactly one commit from walk");
+			return error("BUG: expected exactly one commit from walk");
 		return single_pick(cmit, opts);
 	}
 
-- 
2.10.0.rc1.99.gcd66998


