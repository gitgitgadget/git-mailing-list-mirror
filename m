Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36D21F915
	for <e@80x24.org>; Sat, 14 Jul 2018 21:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbeGNWFc (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 18:05:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55847 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbeGNWFb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jul 2018 18:05:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id v128-v6so11634216wme.5
        for <git@vger.kernel.org>; Sat, 14 Jul 2018 14:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e6M8jOOFOETxgzidW4apzQwKpwWf/UuH8ddp49xlTn8=;
        b=W+cSErj1m49N3GDzQjMMBf8GNCsjDBTiKXWkvBFbNVwJTrw0WJ3AUT9Py3HXgK0k2S
         68N3KMfhWopo+hDWOikUFdmModI6rd/idQFh6k7nSXVx668NBSkh+Eg897xtODVbtwv7
         fpklu70+NeT5nRHb/IqOngourzl+czgyeJnvXpkslHCyCl1fEp4U98RoHYgRn0LEsKv3
         3HZhvhR1IziqTIr0IjJCgAc8jylLQOpa72YTGXMTQ/Izt/Yto5asDtH5AvN7Sz9pyMt4
         ugW6HUUmvH0RPW132lzsPes+S9gi54L607Lj6QRYPkdwetNexG+3/gXLBjUmSlwcpaw4
         N2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e6M8jOOFOETxgzidW4apzQwKpwWf/UuH8ddp49xlTn8=;
        b=NZ9cX5IkhiqX0OWx/RDgWLWhtf8l0Y+0+ZeU7HWnXDcZGTQIX0PSE0g4ITBTBmmFNT
         mH/b+B9CZtXPzyCT8H284VNMr85b7hGl0ZO/J0rLl6fJVSYJsGrH2jJGFjJkRRcTTFOm
         wDbd6c/WNLDyOqmHjwQRz13/RTTDEsLbi93DKK7HWaeUAAf27c6TlpjsjfmvJ2YZhpZE
         UYfmVX+m+ZeX2zfwkvSWpwSAAdcZLxN/aK2WQIpwwciSISSx9XK4wplwPEG+6nGxqUki
         Yynk3dMYepBS87Jf7Sk+RKsgqKibNMJSzIt/fEiCU7LrhGEwveNY2+LLlgqe0kPtBkZB
         /8wQ==
X-Gm-Message-State: AOUpUlFAgrfCViycbh7Sv+pQZuqqh7ppMh5E+11aEyXReGG5XqAJgNNk
        uYeehGs/N09wjpmXlpNaqT0if6da
X-Google-Smtp-Source: AAOMgpcp7Mb4RNziYD2JwfcV9u9qN7Sitqh1ie06cl8KTmUmN9mmjxT2PmAYnw0qGnZsUXnQY3CRoQ==
X-Received: by 2002:a1c:2208:: with SMTP id i8-v6mr6286753wmi.105.1531604704255;
        Sat, 14 Jul 2018 14:45:04 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id 125-v6sm16385782wmw.9.2018.07.14.14.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Jul 2018 14:45:03 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 10/11] rerere: teach rerere to handle nested conflicts
Date:   Sat, 14 Jul 2018 22:44:42 +0100
Message-Id: <20180714214443.7184-11-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180714214443.7184-1-t.gummerer@gmail.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
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
index 4102cce7aa..60d48dc4fe 100644
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
+stripping the labels from conflict markers, stripping the diff3
+output, and the sorting the conflict hunks, both for the outer and the
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
index 34f0518a5e..d63fe2b33b 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -602,4 +602,41 @@ test_expect_success 'rerere with unexpected conflict markers does not crash' '
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
2.17.0.410.g65aef3a6c4

