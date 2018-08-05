Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2505A1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 17:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeHET0T (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:26:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55021 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeHET0S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:26:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so11444520wmb.4
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9+Sawdlpv6gxkouYu4961ziHw/8RtZewc7WEvh2qTU=;
        b=ARxQp6RUss2oYigk+x9bEJbPDpZQANxFFtUpcsfF7VV7qhwTMvWQ9402XFB0ePSFe1
         LfGM5m993nEA0m7wCwJdgAM6EPxBg26f+GONgRvtDMP8sEvcoPqDKzXRuBkPpTemy00S
         Fcfew2ityzWoVGhIPb+QOUidVlferej5et2808umSS82rGA1M9iXwR7HC+QaXjEeJ2JQ
         NEN6Uf1wOqagOxxv/tdJYFdorcTguIsAPOHPahYpxRs496g8uZt9U1/pgl63h5OQPTdR
         rrwc+I3ZfuGqQN4AWXJVveVMnQuh0qB1aPykQhiX20I5ZkJ+COqOx8yTyL/x7WCpI9dc
         amag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9+Sawdlpv6gxkouYu4961ziHw/8RtZewc7WEvh2qTU=;
        b=FcIk4iQM5jyj5dFstBAytkmaKyOSplGdORwc0QApOdQBL+DhiCxxyJFTbTBkg15XYX
         8tOJuIclXe8kieFRfzwh6RgtZweM8PDgpZbpkYWov05fMl/FP5ZiMIKOCo/iARc03DE5
         lgoJMeElR/ejKfpQ5iV3cnOTz2DhcA/5aa36bP4/X68B0+bhHBVlaqRmrajyeKbYTdWt
         zIQX4TEr0Z/2nDVaYR4R+h8h0LtK8s5gUUrdNrs/Sv9SMfHNXL7W4CbHWgU9cIynns4r
         QIzjs0qJjcBWu/DdKX6yggRBZ19EvGAth4yvOBaBdHcLfNniuo/x5jfW/v5TsWKPqK2Z
         jJNw==
X-Gm-Message-State: AOUpUlG94fRIQN5Y55y+T5lB7XTqWfnQsHxqeTb5agT6j9KJm8GEQB7s
        9lnYcApIudhjJSPuKLSuXMzgVpl3
X-Google-Smtp-Source: AAOMgpfedGkee32NCvkh6YfHrCeS7u8qF/vPeePr/9QgaBS74PfW3cY+/hOLx4NdAZpY3SnIhmMt1A==
X-Received: by 2002:a1c:1745:: with SMTP id 66-v6mr9397103wmx.38.1533489660138;
        Sun, 05 Aug 2018 10:21:00 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id i14-v6sm10236115wmd.13.2018.08.05.10.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 10:20:59 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 10/11] rerere: teach rerere to handle nested conflicts
Date:   Sun,  5 Aug 2018 18:20:36 +0100
Message-Id: <20180805172037.12530-11-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.18.0.720.gf7a957e2e7
In-Reply-To: <20180805172037.12530-1-t.gummerer@gmail.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180805172037.12530-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently rerere can't handle nested conflicts and will error out when
it encounters such conflicts.  Do that by recursively calling the
'handle_conflict' function to normalize the conflict.

Note that a conflict like this would only be produced if a user
commits a file with conflict markers, and gets a conflict including
that in a susbsequent operation.

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

it would be recorde as follows in the preimage:

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

Stripping out vs. leaving the conflict markers in place in the inner
conflict should have no practical impact, but it simplifies the
implementation.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/technical/rerere.txt | 42 ++++++++++++++++++++++++++++++
 rerere.c                           | 10 +++++--
 t/t4200-rerere.sh                  | 37 ++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index 3d10dbfa67..e65ba9b0c6 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -138,3 +138,45 @@ SHA1('B<NUL>C<NUL>').
 If there are multiple conflicts in one file, the sha1 is calculated
 the same way with all hunks appended to each other, in the order in
 which they appear in the file, separated by a <NUL> character.
+
+Nested conflicts
+~~~~~~~~~~~~~~~~
+
+Nested conflicts are handled very similarly to "simple" conflicts.
+Similar to simple conflicts, the conflict is first normalized by
+stripping the labels from conflict markers, stripping the common ancestor
+version, and the sorting the conflict hunks, both for the outer and the
+inner conflict.  This is done recursively, so any number of nested
+conflicts can be handled.
+
+The only difference is in how the conflict ID is calculated.  For the
+inner conflict, the conflict markers themselves are not stripped out
+before calculating the sha1.
+
+Say we have the following conflict for example:
+
+    <<<<<<< HEAD
+    1
+    =======
+    <<<<<<< HEAD
+    3
+    =======
+    2
+    >>>>>>> branch-2
+    >>>>>>> branch-3~
+
+After stripping out the labels of the conflict markers, and sorting
+the hunks, the conflict would look as follows:
+
+    <<<<<<<
+    1
+    =======
+    <<<<<<<
+    2
+    =======
+    3
+    >>>>>>>
+    >>>>>>>
+
+and finally the conflict ID would be calculated as:
+`sha1('1<NUL><<<<<<<\n3\n=======\n2\n>>>>>>><NUL>')`
diff --git a/rerere.c b/rerere.c
index a35b88916c..f78bef80b1 100644
--- a/rerere.c
+++ b/rerere.c
@@ -365,12 +365,18 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
 		RR_SIDE_1 = 0, RR_SIDE_2, RR_ORIGINAL
 	} hunk = RR_SIDE_1;
 	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
-	struct strbuf buf = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT, conflict = STRBUF_INIT;
 	int has_conflicts = -1;
 
 	while (!io->getline(&buf, io)) {
 		if (is_cmarker(buf.buf, '<', marker_size)) {
-			break;
+			if (handle_conflict(&conflict, io, marker_size, NULL) < 0)
+				break;
+			if (hunk == RR_SIDE_1)
+				strbuf_addbuf(&one, &conflict);
+			else
+				strbuf_addbuf(&two, &conflict);
+			strbuf_release(&conflict);
 		} else if (is_cmarker(buf.buf, '|', marker_size)) {
 			if (hunk != RR_SIDE_1)
 				break;
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 23f9c0ca45..afaf085e42 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -601,4 +601,41 @@ test_expect_success 'rerere with unexpected conflict markers does not crash' '
 	git rerere clear
 '
 
+test_expect_success 'rerere with inner conflict markers' '
+	git reset --hard &&
+
+	git checkout -b A master &&
+	echo "bar" >test &&
+	git add test &&
+	git commit -q -m two &&
+	echo "baz" >test &&
+	git add test &&
+	git commit -q -m three &&
+
+	git reset --hard &&
+	git checkout -b B master &&
+	echo "foo" >test &&
+	git add test &&
+	git commit -q -a -m one &&
+
+	test_must_fail git merge A~ &&
+	git add test &&
+	git commit -q -m "will solve conflicts later" &&
+	test_must_fail git merge A &&
+
+	echo "resolved" >test &&
+	git add test &&
+	git commit -q -m "solved conflict" &&
+
+	echo "resolved" >expect &&
+
+	git reset --hard HEAD~~ &&
+	test_must_fail git merge A~ &&
+	git add test &&
+	git commit -q -m "will solve conflicts later" &&
+	test_must_fail git merge A &&
+	cat test >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.18.0.720.gf7a957e2e7

