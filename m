Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034A7C2D0EF
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 12:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11A221D95
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 12:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8BiTg0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgDQMyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729034AbgDQMyT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 08:54:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41611C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 05:54:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so2940386wrp.3
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 05:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MqEQHhGVt7hrWN5kkxCwfn+LXo35Bkdsm43SsAC0/OA=;
        b=Z8BiTg0/TZEceP6a6roFwiZdaXfFtKzX+2SiZCASqih8JGBJuHuk5zL/8df3hkUun1
         w5EVIKw0df/YyIH47ooQ2In6oAIVyZh13/a+VSmhRhXv63Gp18E45qXBMnqALyCvTAUa
         16f+UBttZbeUCjitg3Mc8S2BAJxlvYtq43n90vW4OD8nGVAgPsRSzpcnI79gYSLa4WPd
         KbPlWQbGn3lMIt4CvU/dl8dOIZBAdV88AZpy3ccNjQAY2ed+EFuE2Smh56qYbazsjAvF
         UeK/XuSy5SGa4KuzNGaOIoSGpFs3E69uihWsBpjfFQ1qXd/9Ea9AA1f5btc9FF+xiZMK
         C27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MqEQHhGVt7hrWN5kkxCwfn+LXo35Bkdsm43SsAC0/OA=;
        b=KdqZEAjfNKWLChlfHDoDGw9sREinhI5WhGlbMQhsBfwwjdOG4rPSvDehEHE0w6yqNP
         XNNHA9Abbg7XVf8Aly2R2HKscPQexRADmBF7Be6vvyBBKs1hl2YjOXuuODfjsp9z8xFw
         1c1GtpTGaMz+l1+3QDMnCp0MJq92/PvQWpVcGc0qoFbNjAp5ojxi5V7UdrMHWtA5ino8
         6mtutNMvIkL+4QJ6Agn7BzISqa57Oe1HawIBcj8WGA9xx7Wmy+XOshZLoVEEQ8cNzSgR
         7aFhSg+iO+DKqtheZObXEIDiY2nqE//bDXZPGIyu3dCUBTTdYI1foNdh90Poh3SVyq8J
         KOZg==
X-Gm-Message-State: AGi0PuYc0zz5cWD3JetINEkEq4k2x7CbzvHwbtLBR5pUu94Hy0wUZRPU
        vZEKZM/ERaXqbo+mW6OTF+a0JltU+Ts=
X-Google-Smtp-Source: APiQypLeW2V4OVTw44LVRJEhTwIv+2PhJ81st/kN5ueVFxWBTYG7fOToUGAMR8njzZybrBLL4tQ8iw==
X-Received: by 2002:a5d:5085:: with SMTP id a5mr4092387wrt.394.1587128057750;
        Fri, 17 Apr 2020 05:54:17 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id t17sm2374693wro.2.2020.04.17.05.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 05:54:17 -0700 (PDT)
Date:   Fri, 17 Apr 2020 14:54:15 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
Message-ID: <20200417125415.6o5avmae3cyvq4fy@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Fri, 17 Apr 2020 14:45:18 +0200
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
 <20200416211208.xqnnrkvcl2jw3ejr@doriath>
 <20200416213009.GA1721147@coredump.intra.peff.net>
 <xmqqh7xjxeew.fsf@gitster.c.googlers.com>
 <20200416224708.zr4dlrz4hpaqsz2s@doriath>
 <20200416230554.bhk2yfycjwjpxggy@doriath>
 <xmqq4ktjxawx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4ktjxawx.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Junio C Hamano, Thu 16 Apr 2020 at 16:34:22 (-0700) :
> > Here were the two reasons for the RFC of this patch e3165570dfca690ea1a71518799153f6350777ae
> > ...
> > This means that I get the fallback of 'origin' if no remote is specified.
> > So if I set a pushRemote="foobar" but no remote, then remote.c will
> > consider we are in a triangular workflow but git push will not.
 
> OK, so in short, what is queued in 'next' is quite borked X-<.  I
> don't mind reverting the merge then.

Yes sorry, I never meant for this patch version to be queued up, hence its rfc
status :/

The reason I sent it as is, as outlined by my cover letter, was that I
found it quite surprising that a pushRemote without remote was not
considered by 'git push' as a triangular workflow. Technically a triangular
workflow is when the push remote is different from the fetch remote, and we
could argue when there is no fetch remote it is indeed the case (I know
that was what I was expecting). So I was wondering if we should not change
this logic in git push instead.

I'll let you decide if you prefer reverting this merge, or applying the
following fixup on top of next instead.

--- 8< ---
From 2f9268e2fb6ee280137fb928180882619eb9c3e5 Mon Sep 17 00:00:00 2001
From: Damien Robert <damien.olivier.robert+git@gmail.com>
Date: Fri, 17 Apr 2020 14:41:02 +0200
Subject: [PATCH 1/1] remote.c: fix detection of triangular workflow

When a branch has a pushRemote but no remote, then git push does not
consider this as a triangular workflow.

In remote.c, since is_workflow_triangular does not check for the *explicit
value, it considers that such a branch is in a triangular workflow
(except when 'pushRemote=origin' since the default non explicit value of
fetch_remote is 'origin').

Fix that by checking the values of explicit in remote_for_branch and
pushremote_for_branch, and add tests.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 remote.c                |  9 ++++++---
 t/t6300-for-each-ref.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index 7c99469598..18a190198a 100644
--- a/remote.c
+++ b/remote.c
@@ -1636,9 +1636,12 @@ static const char *tracking_for_push_dest(struct remote *remote,
 
 static int is_workflow_triangular(struct branch *branch)
 {
-	struct remote *fetch_remote = remote_get(remote_for_branch(branch, NULL));
-	struct remote *push_remote = remote_get(pushremote_for_branch(branch, NULL));
-	return (fetch_remote && push_remote && fetch_remote != push_remote);
+	int explicit;
+	struct remote *fetch_remote = remote_get(remote_for_branch(branch, &explicit));
+	if (!explicit || !fetch_remote)
+		return 0;
+	struct remote *push_remote = remote_get(pushremote_for_branch(branch, &explicit));
+	return (explicit && push_remote && fetch_remote != push_remote);
 }
 
 /**
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8e59ab2567..4c01d4406f 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -945,6 +945,38 @@ test_expect_success '%(push) and %(push:remoteref)' '
 			--format="%(push:remotename),%(push:remoteref),%(push)" \
 			refs/heads/master)" &&
 		test to,refs/heads/master,refs/remotes/to/master = "$actual" &&
+		actual="$(git -c push.default=nothing for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,, = "$actual" &&
+		git config --unset branch.master.remote &&
+		git config --unset branch.master.merge &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,, = "$actual" &&
+		git config branch.master.merge refs/heads/master &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,, = "$actual" &&
+		git config branch.master.merge refs/heads/other &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,, = "$actual" &&
+		actual="$(git -c push.default=upstream for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,, = "$actual" &&
+		actual="$(git -c push.default=current for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,refs/heads/master,refs/remotes/to/master = "$actual" &&
+		actual="$(git -c push.default=matching for-each-ref \
+			--format="%(push:remotename),%(push:remoteref),%(push)" \
+			refs/heads/master)" &&
+		test to,refs/heads/master,refs/remotes/to/master = "$actual" &&
 		actual="$(git -c push.default=nothing for-each-ref \
 			--format="%(push:remotename),%(push:remoteref),%(push)" \
 			refs/heads/master)" &&
-- 
Patched on top of v2.26.1-301-g55bc3eb7cb (git version 2.26.0)
