Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C51C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhLMGcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhLMGcP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:15 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EE8C061201
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:08 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id v13so789342ilm.8
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7bsOSnyGX0H/4cgERmdUVUrE6yzLyDfJPjeeswTetlo=;
        b=cYm3yhCHTAZ+Tg0UkZl0adfYBViqxNtsWov9xWwD/9DIPDTt+HsCeIrPPHX0ZUp2vI
         hyAJIDDaso7OIrkGHbEQwGSzE2VbM0W9gbRZdw1oZWEEn4duW7xBpabiGs0Ud2kvzvbk
         hVD18gSQ3fdc0m09uCQTqZU9FyB2jbA5IKJ4YoVlrdOt7Fap3wH7jKL9HsDFmOwNMqlx
         efrUekQLfdPXU2shswvEFnPsHos2OvpKDr2hGfeu5Yq7x8WOiEWCApAA1OfbwnFeVhfK
         Vr0Mb25hDIZiMmQ2ElRUQgZg/2jVXGruEzxUnbxeOGOpHIR2qsKZ69j70lSXBQ1O25GT
         k0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7bsOSnyGX0H/4cgERmdUVUrE6yzLyDfJPjeeswTetlo=;
        b=najR7E+c3q7K2vkfCZI7drovzlP1LBnQ7sdzkLxFgovf3ztSX0wDhDelG1d8F1miOZ
         SJaVYbPHgzurRPN83rnAwO+HaC0XUdxDS+K8GWAeFfJQIYy290ku9w/Tv4Q6tPrehHCq
         dzQ31PU9WU1WQGQkN9nLg/Hou1B1XDSnkErkh/tRjiyuWKw9Kwyh7w4Xf0WIB/aRmTfg
         g4AlThGDtaxQ3l9h7RR9kfMNun0yNQuYnEUjr94rpjWJvWwBHPk39pIIUWpWbkgeWRYa
         iZyCAObVsxX5VzE47qJ2Ue9Dv/cdVbohKhWm8ap+hFpy3P1+0dT1lkoxdVfateMpopX3
         6Cwg==
X-Gm-Message-State: AOAM53148tn068Wb4F1VI2e7wSj9KNg/amRrKNSxbjPrrB+1ClkwYw8R
        F7OYY+PPpP0cbwi5C/8rgdI0Rq70vlPXdA==
X-Google-Smtp-Source: ABdhPJzREDr1lzrBtavlKnq5ziQ/8PP8j6TVPKowzC9+zfm1XfPF/ivMX+Tqy5SQxZH4iPqHFl2cuw==
X-Received: by 2002:a05:6e02:16cd:: with SMTP id 13mr3812371ilx.136.1639377127845;
        Sun, 12 Dec 2021 22:32:07 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.32.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:07 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 13/15] chainlint.sed: stop throwing away here-doc tags
Date:   Mon, 13 Dec 2021 01:30:57 -0500
Message-Id: <20211213063059.19424-14-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of chainlint is to highlight problems it finds in test code
by inserting annotations at the location of each problem. Arbitrarily
eliding bits of the code it is checking is not helpful, yet this is
exactly what chainlint.sed does by cavalierly and unnecessarily dropping
the here-doc operator and tag; i.e. `cat <<TAG` becomes simply `cat` in
the output. This behavior can make it more difficult for the test writer
to align the annotated output of chainlint.sed with the original test
code. Address this by retaining here-doc tags.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                               | 24 ++++++++++++-------
 t/chainlint/for-loop.expect                   |  2 +-
 t/chainlint/here-doc-close-subshell.expect    |  2 +-
 .../here-doc-multi-line-command-subst.expect  |  2 +-
 t/chainlint/here-doc-multi-line-string.expect |  2 +-
 t/chainlint/here-doc.expect                   |  8 +++----
 t/chainlint/if-then-else.expect               |  2 +-
 t/chainlint/nested-here-doc.expect            |  6 ++---
 t/chainlint/subshell-here-doc.expect          | 10 ++++----
 t/chainlint/t7900-subtree.expect              |  4 ++--
 t/chainlint/while-loop.expect                 |  2 +-
 11 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index 2f786f890d..0e575c0c62 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -62,20 +62,20 @@
 # receives similar treatment.
 #
 # Swallowing here-docs with arbitrary tags requires a bit of finesse. When a
-# line such as "cat <<EOF >out" is seen, the here-doc tag is moved to the front
-# of the line enclosed in angle brackets as a sentinel, giving "<EOF>cat >out".
+# line such as "cat <<EOF" is seen, the here-doc tag is copied to the front of
+# the line enclosed in angle brackets as a sentinel, giving "<EOF>cat <<EOF".
 # As each subsequent line is read, it is appended to the target line and a
 # (whitespace-loose) back-reference match /^<(.*)>\n\1$/ is attempted to see if
 # the content inside "<...>" matches the entirety of the newly-read line. For
 # instance, if the next line read is "some data", when concatenated with the
-# target line, it becomes "<EOF>cat >out\nsome data", and a match is attempted
+# target line, it becomes "<EOF>cat <<EOF\nsome data", and a match is attempted
 # to see if "EOF" matches "some data". Since it doesn't, the next line is
 # attempted. When a line consisting of only "EOF" (and possible whitespace) is
-# encountered, it is appended to the target line giving "<EOF>cat >out\nEOF",
+# encountered, it is appended to the target line giving "<EOF>cat <<EOF\nEOF",
 # in which case the "EOF" inside "<...>" does match the text following the
 # newline, thus the closing here-doc tag has been found. The closing tag line
 # and the "<...>" prefix on the target line are then discarded, leaving just
-# the target line "cat >out".
+# the target line "cat <<EOF".
 #------------------------------------------------------------------------------
 
 # incomplete line -- slurp up next line
@@ -90,8 +90,7 @@
 # command to which it was attached)
 /<<-*[ 	]*[\\'"]*[A-Za-z0-9_]/ {
 	/"[^"]*<<[^"]*"/bnotdoc
-	s/^\(.*\)<<-*[ 	]*[\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
-	s/[ 	]*<<//
+	s/^\(.*<<-*[ 	]*\)[\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1\2/
 	:hered
 	N
 	/^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
@@ -238,6 +237,7 @@ s/.*\n//
 :cont
 # retrieve and print previous line
 x
+s/?!HERE?!/<</g
 n
 bslurp
 
@@ -278,8 +278,7 @@ bfolded
 # found here-doc -- swallow it to avoid false hits within its body (but keep
 # the command to which it was attached)
 :heredoc
-s/^\(.*\)<<-*[ 	]*[\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
-s/[ 	]*<<//
+s/^\(.*\)<<\(-*[ 	]*\)[\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\3>\1?!HERE?!\2\3/
 :hdocsub
 N
 /^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
@@ -293,6 +292,7 @@ bfolded
 # found "case ... in" -- pass through untouched
 :case
 x
+s/?!HERE?!/<</g
 n
 /^[ 	]*esac/bslurp
 bcase
@@ -320,6 +320,7 @@ bchkchn
 :nest
 x
 :nstslrp
+s/?!HERE?!/<</g
 n
 # closing ")" on own line -- stop nested slurp
 /^[ 	]*)/bnstcl
@@ -342,6 +343,7 @@ bchkchn
 # found multi-line "{...\n...}" block -- pass through untouched
 :block
 x
+s/?!HERE?!/<</g
 n
 # closing "}" -- stop block slurp
 /}/bchkchn
@@ -352,13 +354,17 @@ bblock
 :clssolo
 x
 s/\( ?!AMP?!\)* ?!AMP?!$//
+s/?!HERE?!/<</g
 p
 x
+s/?!HERE?!/<</g
 b
 
 # found closing "...)" -- exit subshell loop
 :close
 x
+s/?!HERE?!/<</g
 p
 x
+s/?!HERE?!/<</g
 b
diff --git a/t/chainlint/for-loop.expect b/t/chainlint/for-loop.expect
index b74df064c5..6671b8cd84 100644
--- a/t/chainlint/for-loop.expect
+++ b/t/chainlint/for-loop.expect
@@ -2,7 +2,7 @@
 	for i in a b c
 	do
 		echo $i ?!AMP?!
-		cat
+		cat <<-EOF
 	done ?!AMP?!
 	for i in a b c; do
 		echo $i &&
diff --git a/t/chainlint/here-doc-close-subshell.expect b/t/chainlint/here-doc-close-subshell.expect
index e748526570..2af9ced71c 100644
--- a/t/chainlint/here-doc-close-subshell.expect
+++ b/t/chainlint/here-doc-close-subshell.expect
@@ -1,2 +1,2 @@
 (
-	cat)
+	cat <<-INPUT)
diff --git a/t/chainlint/here-doc-multi-line-command-subst.expect b/t/chainlint/here-doc-multi-line-command-subst.expect
index f1248f8ade..f8b3aa73c4 100644
--- a/t/chainlint/here-doc-multi-line-command-subst.expect
+++ b/t/chainlint/here-doc-multi-line-command-subst.expect
@@ -1,5 +1,5 @@
 (
-	x=$(bobble &&
+	x=$(bobble <<-END &&
 		wiffle) ?!AMP?!
 	echo $x
 )
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
index 7e883b252e..2578191ca8 100644
--- a/t/chainlint/here-doc-multi-line-string.expect
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -1,4 +1,4 @@
 (
-	cat && echo "multi-line	string" ?!AMP?!
+	cat <<-TXT && echo "multi-line	string" ?!AMP?!
 	bap
 )
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
index 8449eb2e02..110059ba58 100644
--- a/t/chainlint/here-doc.expect
+++ b/t/chainlint/here-doc.expect
@@ -1,7 +1,7 @@
-boodle wobba        gorgo snoot        wafta snurb &&
+boodle wobba        gorgo snoot        wafta snurb <<EOF &&
 
-cat >foo &&
+cat <<-Arbitrary_Tag_42 >foo &&
 
-cat >boo &&
+cat <<zump >boo &&
 
-horticulture
+horticulture <<EOF
diff --git a/t/chainlint/if-then-else.expect b/t/chainlint/if-then-else.expect
index debcf7b756..44d86c3597 100644
--- a/t/chainlint/if-then-else.expect
+++ b/t/chainlint/if-then-else.expect
@@ -8,7 +8,7 @@
 		echo foo
 	else
 		echo foo &&
-		cat
+		cat <<-EOF
 	fi ?!AMP?!
 	echo poodle
 ) &&
diff --git a/t/chainlint/nested-here-doc.expect b/t/chainlint/nested-here-doc.expect
index 2a51205d32..e3bef63f75 100644
--- a/t/chainlint/nested-here-doc.expect
+++ b/t/chainlint/nested-here-doc.expect
@@ -1,7 +1,7 @@
-cat >foop &&
+cat <<ARBITRARY >foop &&
 
 (
-	cat &&
-	cat ?!AMP?!
+	cat <<-INPUT_END &&
+	cat <<-EOT ?!AMP?!
 	foobar
 )
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
index b7250ca753..029d129299 100644
--- a/t/chainlint/subshell-here-doc.expect
+++ b/t/chainlint/subshell-here-doc.expect
@@ -1,10 +1,10 @@
 (
-	echo wobba 	       gorgo snoot 	       wafta snurb &&
-	cat >bip ?!AMP?!
-	echo >bop
+	echo wobba 	       gorgo snoot 	       wafta snurb <<-EOF &&
+	cat <<EOF >bip ?!AMP?!
+	echo <<-EOF >bop
 ) &&
 (
-	cat >bup &&
-	cat >bup3 &&
+	cat <<-ARBITRARY >bup &&
+	cat <<-ARBITRARY3 >bup3 &&
 	meep
 )
diff --git a/t/chainlint/t7900-subtree.expect b/t/chainlint/t7900-subtree.expect
index 215aca01c2..1cccc7bf7e 100644
--- a/t/chainlint/t7900-subtree.expect
+++ b/t/chainlint/t7900-subtree.expect
@@ -1,9 +1,9 @@
 (
 	chks="sub1sub2sub3sub4" &&
-	chks_sub=$(cat | sed "s,^,sub dir/,"
+	chks_sub=$(cat <<TXT | sed "s,^,sub dir/,"
 ) &&
 	chkms="main-sub1main-sub2main-sub3main-sub4" &&
-	chkms_sub=$(cat | sed "s,^,sub dir/,"
+	chkms_sub=$(cat <<TXT | sed "s,^,sub dir/,"
 ) &&
 	subfiles=$(git ls-files) &&
 	check_equal "$subfiles" "$chkms$chks"
diff --git a/t/chainlint/while-loop.expect b/t/chainlint/while-loop.expect
index e2813b378e..0d3a9b3d12 100644
--- a/t/chainlint/while-loop.expect
+++ b/t/chainlint/while-loop.expect
@@ -2,7 +2,7 @@
 	while true
 	do
 		echo foo ?!AMP?!
-		cat
+		cat <<-EOF
 	done ?!AMP?!
 	while true; do
 		echo foo &&
-- 
2.34.1.397.gfae76fe5da

