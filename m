Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73B31F51C
	for <e@80x24.org>; Sun, 20 May 2018 21:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeETVM3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 17:12:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39126 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751725AbeETVMU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 17:12:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id f8-v6so23364591wmc.4
        for <git@vger.kernel.org>; Sun, 20 May 2018 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/2ppHCgf4u2Tr41ksT6NidWdbgBcjDjCHQ9N6dX6xJY=;
        b=VRUXe0UqDhPwI6inzdOY7uzmRVXcZ9XwQBFXi8wXcDOR+8lbRzFLmtOxDJ+zIn+S4A
         v9+XgH0bQNFMRLl+atCl5juQ1ihNQEXBFebY4XVCsXdW/xDKdfUN1+qB9ywD/OKo/9HY
         HI5fzS4U/iiv1LwPlAw5RCSxgSzrHIUjNqWaXvDEwDVluUoYkA2StqCPBZwqGTjjylRy
         AND516/dZa+PszhNOQAzG0XVy9b+goyn9s4kY+zKKiCuZacYaH3/1a2uOie5pAn8SiqW
         oSydOuu81ZocZEGJF0rlSMYIRGSspbkoTQGWG/9ykFoxltgIWpXweHtBP3oXvjn4iRw6
         a/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/2ppHCgf4u2Tr41ksT6NidWdbgBcjDjCHQ9N6dX6xJY=;
        b=UaQBG4w0Km/03fubo5XtFtADsc6/PerRDONDBQ2YpCEwalmjmlunX4PpyzHgi4+6cw
         6MfCKb2imOiU66QNfFjrRpFcdlUS9Fe//v4LQURVA+PSaB0bXY4/tMfKhgDrO8AQaUbZ
         y9TmG/0PRNCXHYE6fKUDcebKusABAqwd9iep+W4d7z0qZXUvUCzaKNPj/z7ZowxSQqLJ
         K1WIbs7bMgT/p0nr2xsloH+F37ipD5S/5ihZxGKK02NWXp8ERy9N4DyUxRCLMMc4twqy
         YO3PewDvjmDlaN93xkaGfdYNmlJXm9qx/8KzzWzKHdjO/10Yv8femvBY8biecNwW1CmV
         sSMg==
X-Gm-Message-State: ALKqPwdK4wiUvXKFwZm893OseTPxQz87f67nZeuVoeOLkZzm4w4txnI2
        QuS0DgLCFkjDDAhhNnaDwIiN0rOx
X-Google-Smtp-Source: AB8JxZoGmtSJM2RPpXMgIAnADb6vosQP4DxWPxeEGEn+WRcyP2DMPtmf7od5X+S+cm/vJ+cNLJ7gvQ==
X-Received: by 2002:a1c:58ce:: with SMTP id m197-v6mr8561306wmb.110.1526850738628;
        Sun, 20 May 2018 14:12:18 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id t198-v6sm12977096wmt.23.2018.05.20.14.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 14:12:17 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC/PATCH 7/7] rerere: teach rerere to handle nested conflicts
Date:   Sun, 20 May 2018 22:12:10 +0100
Message-Id: <20180520211210.1248-8-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.588.g4d217cdf8e.dirty
In-Reply-To: <20180520211210.1248-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently rerere can't handle nested conflicts and will error out when
it encounters such conflicts.  Do that by recursively calling the
'handle_conflict' function to normalize the conflict.

The conflict ID calculation here deserves some explanation:

As we are using the same handle_conflict function, the nested conflict
is normalized the same way as for non-nested conflicts, which means
the ancestor in the diff3 case is stripped out, and the parts of the
conflict are ordered alphabetically.

The conflict ID is however is only calculated in the top level
handle_conflict call, so it will include the markers that 'rerere'
adds to the output.  e.g. say there's the following conflict:

    <<<<<<< HEAD
    1
    =======
    <<<<<<< HEAD
    3
    =======
    2
    >>>>>>> branch-2
    >>>>>>> branch-3~

it would be reordered as follows in the preimage:

    <<<<<<<
    1
    =======
    <<<<<<<
    2
    =======
    3
    >>>>>>>
    >>>>>>>

and the conflict ID would be calculated as

    sha1(1<NUL><<<<<<<
    2
    =======
    3
    >>>>>>><NUL>)

Stripping out vs. leaving the conflict markers in place should have no
practical impact, but it simplifies the implementation.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

No automated test for this yet.  As mentioned in the cover letter as
well, I'm not sure if this is common enough for us to actually
consider this use case.  I don't know how nested conflicts could
actually be created apart from committing a file with conflict
markers, but maybe I'm just lacking imagination, so if someone has an
example for that I would be very grateful :)  If we decide to do this,
it probably also merits a mention in
Documentation/technical/rerere.txt.

 rerere.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/rerere.c b/rerere.c
index f3cfd1c09b..45e2bd6ff1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -365,12 +365,18 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
 		RR_SIDE_1 = 0, RR_SIDE_2, RR_ORIGINAL
 	} hunk = RR_SIDE_1;
 	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT, conflict = STRBUF_INIT;
 	int has_conflicts = 1;
 	while (!io->getline(&buf, io)) {
-		if (is_cmarker(buf.buf, '<', marker_size))
-			goto bad;
-		else if (is_cmarker(buf.buf, '|', marker_size)) {
+		if (is_cmarker(buf.buf, '<', marker_size)) {
+			if (handle_conflict(&conflict, io, marker_size, NULL) < 0)
+				goto bad;
+			if (hunk == RR_SIDE_1)
+				strbuf_addbuf(&one, &conflict);
+			else
+				strbuf_addbuf(&two, &conflict);
+			strbuf_release(&conflict);
+		} else if (is_cmarker(buf.buf, '|', marker_size)) {
 			if (hunk != RR_SIDE_1)
 				goto bad;
 			hunk = RR_ORIGINAL;
-- 
2.17.0.588.g4d217cdf8e.dirty

