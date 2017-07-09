Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A8A202AE
	for <e@80x24.org>; Sun,  9 Jul 2017 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbdGIUZb (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 16:25:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34646 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbdGIUZa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 16:25:30 -0400
Received: by mail-wr0-f194.google.com with SMTP id k67so20537954wrc.1
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HaPNCUayMh1NvECDjCYvljv33jnAMDQtIaBAbmoDbV4=;
        b=YWWSuROBQo899snf7lM6lQb3Nak0VAXafOzqDwtSRbPg5h4ehq3yhgALNyDpAPKhN7
         3CYAYYtPG6epmVz8iWMQZShGyWX87TWqj52uAnvvpD0yV9U1MJFB9FRlivPukknEHPLG
         XpiGeTpVlCkEB0orm8hj8mc19oROZ45LdTVjNY8EIgaYp0QC72TvLPbYxsaND3WHGr72
         fM9zl1jhzDTFwIFth5Qz01tzlnZ0as6/tT1Vzc1eTEkWb6pVx6QnmO6mq+PhW8eg3+Ea
         T7LWdVnVIlyCH8Cw8vtJuUOatRbVn8pvlqvec/oMKZ8+s/sVbfMQ3gvJvno7W0akZztc
         ZHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HaPNCUayMh1NvECDjCYvljv33jnAMDQtIaBAbmoDbV4=;
        b=o+1foeyZhpXnfUKrwYkRHyImF9VtMO29UyzsikTKru05clmLfE4F/7nrfIM5an7nVi
         o0JCj8UVqfnDqBHTaKyABOJW1S1mWee7ChB6zF+2TbYGtrvzMj7RxGi//zu43muiOXwx
         GghFMDWXP3Sdagp/Bt/fY2FT29S/mzPhmoyJ71uQeh3ox41/m1hrrFlB6QEsQ75Dw96i
         IzgGBwgpZcQi0ygh9/iz2+ocnYl6ZmQYkxPLRNRrF4A5wmYtSI19m25t5mkISs/Lcag4
         3utSfN7brcSe2sAWk/refZlRinnE/vdl63rmDPJAS5Rj6SXUjy95fhqrWj7FGoolbej1
         +nxw==
X-Gm-Message-State: AIVw1110HYaj86gP+dDSlLoGGu8vnV9/jvvCjpY6/dXikwIwcdXXIR1Z
        O003PdBBGaQAS4n2
X-Received: by 10.28.148.67 with SMTP id w64mr5362144wmd.55.1499631928461;
        Sun, 09 Jul 2017 13:25:28 -0700 (PDT)
Received: from localhost.localdomain (vil93-6-82-233-248-1.fbx.proxad.net. [82.233.248.1])
        by smtp.gmail.com with ESMTPSA id z190sm7984344wmz.31.2017.07.09.13.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jul 2017 13:25:27 -0700 (PDT)
From:   William Duclot <william.duclot@gmail.com>
To:     git@vger.kernel.org
Cc:     William Duclot <william.duclot@gmail.com>
Subject: [PATCH/RFC] rebase: make resolve message clearer for inexperienced users
Date:   Sun,  9 Jul 2017 22:25:20 +0200
Message-Id: <20170709202520.21739-1-william.duclot@gmail.com>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git UI can be improved by addressing the error messages to those
they help: inexperienced and casual git users. To this intent, it is
helpful to make sure the terms used in those messages can be understood
by this segment of users, and that they guide them to resolve the
problem.

In particular, failure to apply a patch during a git rebase is a common
problem that can be very destabilizing for the inexperienced user. It is
important to lead them toward the resolution of the conflict (which is a
3-steps process, thus complex) and reassure them that they can escape a
situation they can't handle with "--abort". This commit answer those two
points by detailling the resolution process and by avoiding cryptic git
linguo.

Signed-off-by: William Duclot <william.duclot@gmail.com>
---
While I do not expect that this V1 wording will be to the liking of
everyone, I think (know?) that the heart of this patch isn't something
that I'm the only one bothered with :) I'd very much like to hear your
opinions about it

 git-rebase.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2cf73b88e..50457f687 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -55,9 +55,10 @@ LF='
 '
 ok_to_skip_pre_rebase=
 resolvemsg="
-$(gettext 'When you have resolved this problem, run "git rebase --continue".
-If you prefer to skip this patch, run "git rebase --skip" instead.
-To check out the original branch and stop rebasing, run "git rebase --abort".')
+$(gettext 'Resolve this conflict manually, mark it as resolved with "git add <conflicted_file>",
+then run "git rebase --continue".
+You can instead skip this commit: run "git rebase --skip".
+To stop the whole rebasing and get back to your pre-rebase state, run "git rebase --abort".')
 "
 unset onto
 unset restrict_revision
-- 
2.13.0

