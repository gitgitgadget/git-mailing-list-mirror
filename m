Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A1E1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeFEUsM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:48:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33625 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeFEUsL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:48:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so19252607wma.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2g0U3Hy2s9u3JwHkbHbft0Ia5JjCcZcqfouLOM4ZZmg=;
        b=ZjYNEFbGNp0on3xGxvkSqPZStE56lWy2ykNLY27jdG9xADlgLCALaneC018d0GlxDR
         0gQeDxUaan82aNCXTegp2qG3qGXYRCA058CUwvpN0/RHshwSsnsoSwlWeeiGlW5GCXR8
         hBkrCUbS1Ij2w4fBrAFpaNXIpoGuy/4HJ6amHw2e7+FSdvTyQVfd6RlnhtGs7l0AlD9N
         V4yOR7IQjiFfl0+9XXYuWHUQ6EAzv9UWAAdf3rpFHZhrwrCFuiTv3xIrkYN/BKxqEuxP
         RaB//ryMb/zAjUgpzBqyDolNHAX6y8AT9SoiwgfrU29yIrQTes/tJ68YmPC0N1Gb0rOH
         juZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2g0U3Hy2s9u3JwHkbHbft0Ia5JjCcZcqfouLOM4ZZmg=;
        b=OIS/THoJataKnNsi/aYC6HycL70SOhT20isAozUqd42J2F1KgkXgWYTSK1NgKHEgEW
         gH6FZ8PyeV01+OfomHWOzCLeP+BSN5pWejAlJyaEsrwkZERrSsjzC7nm8U9ckTpxZNCh
         IQ3TRisOeS1EjSq4I6XDjxxYpIP8mcF6zqyarr0kzEiRmGYtMaF+vh/AkTMqNsqyrSIl
         iJdVDy8/eeIMONPdgYdsPaIKdk7WQP6G0l1iu5q2qzZ+RT4Jee0KLl1Y4mMVUtarw6ex
         utLAoredQxUQRTaz0w6RGeEs4Ebxx7ecPSd00n07HWP+svtuDRWPhW9Jb7byEkiiNAPT
         E6Zw==
X-Gm-Message-State: APt69E0R8oJeaDUj3y6Aa3qENf0cURH9DQsAz/eJbxcxHrFbL6Vjj+3C
        U/J2+fjN8ukIq/wg4CnZ4kJC8UJU
X-Google-Smtp-Source: ADUXVKIG1snHTXD/q9519/zfqF8D3PsHHTpNr36FCmossA4oXDO5LlxNcpK62mXqcF5GVFEGrKwWHg==
X-Received: by 2002:a1c:ce:: with SMTP id 197-v6mr406469wma.118.1528231689767;
        Tue, 05 Jun 2018 13:48:09 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id d90-v6sm2767422wmi.26.2018.06.05.13.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:48:08 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 09/10] rerere: teach rerere to handle nested conflicts
Date:   Tue,  5 Jun 2018 22:52:18 +0100
Message-Id: <20180605215219.28783-10-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.17.0.410.g65aef3a6c4
In-Reply-To: <20180605215219.28783-1-t.gummerer@gmail.com>
References: <20180520211210.1248-1-t.gummerer@gmail.com>
 <20180605215219.28783-1-t.gummerer@gmail.com>
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

I couldn't actually get the conflict markers the right way just using
merge-recursive.  But I think that would be fixed either way by
d694a17986 ("ll-merge: use a longer conflict marker for internal
merge", 2016-04-14), if I read that correctly.

Either way I still think this can be an improvement for when the user
commits merge conflicts (even though they shouldn't do that in the
first place), and for possible other edge cases that I'm not able to
produce right now, but I may just not be creative enough for those.

 Documentation/technical/rerere.txt | 40 ++++++++++++++++++++++++++++++
 rerere.c                           | 14 ++++++++---
 t/t4200-rerere.sh                  | 38 ++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index 2c517fe0fc..7077ab4a08 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -140,3 +140,43 @@ SHA1('B<NUL>C<NUL>').
 If there are multiple conflicts in one file, the sha1 is calculated
 the same way with all hunks appended to each other, in the order in
 which they appear in the file, separated by a <NUL> character.
+
+Nested conflicts
+~~~~~~~~~~~~~~~~
+
+Nested conflicts are handled very similarly to "simple" conflicts.
+Same as before, labels on conflict markers and diff3 output is
+stripped, and the conflict hunks are sorted, for both the outer and
+the inner conflict.
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
+After stripping out the labels of the conflict markers, the conflict
+would look as follows:
+
+    <<<<<<<
+    1
+    =======
+    <<<<<<<
+    3
+    =======
+    2
+    >>>>>>>
+    >>>>>>>
+
+and finally the conflict ID would be calculated as:
+`sha1('1<NUL><<<<<<<\n3\n=======\n2\n>>>>>>><NUL>')`
diff --git a/rerere.c b/rerere.c
index fac90663b0..f611db7873 100644
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
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 5ce411b70d..f433848ccb 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -602,4 +602,42 @@ test_expect_success 'rerere with unexpected conflict markers does not crash' '
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
+
 test_done
-- 
2.17.0.410.g65aef3a6c4

