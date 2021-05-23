Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AC0C47081
	for <git@archiver.kernel.org>; Sun, 23 May 2021 09:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D8961261
	for <git@archiver.kernel.org>; Sun, 23 May 2021 09:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhEWJzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 05:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhEWJzD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 05:55:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C0C06138A
        for <git@vger.kernel.org>; Sun, 23 May 2021 02:53:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y14so23293311wrm.13
        for <git@vger.kernel.org>; Sun, 23 May 2021 02:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=JP3dKfFKWIBEJNALK1erdKj0qmgmsiYiD2kyiP2X2xo=;
        b=bxGezo6FJdW0DANu2gXTISJliC3iWH07NPpEZO+PDmYBOwMqxC5BFdmDCpAqIqE3UH
         7OUD0oIoVWK7Pt2vwqqkA1UlC3ojDEtlWh7+om7BBDQYqdgtWNBrfFleVNTUl1e883CE
         2qhgsTq9R5SsAzJ4l0vlMD4U2eYSDMceqAAnpxgSXj/KODOdeONSgdRoW56FgN1K9Q/i
         PJAY/IJD8V09jt1fiqfwaCfORNyWl9e1KPal6bQVwlwpqRowGCB4VeA8Udz6QBdT182G
         xLg1Cwq1fm0vUk4weQNKbmooGMbTmy9zefjF7GME2POY5o4Q0IzXqm+TpD8U8lgcbomu
         K9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=JP3dKfFKWIBEJNALK1erdKj0qmgmsiYiD2kyiP2X2xo=;
        b=NnIyP3UUZAwG8qtzBb2BAopttmqdoWQ4y4s7hBYQdoc+vlJiaR9hsCdNmAMnFylx+i
         +QDosnjGrR44quZQe3Y/nGGeSSDwx0rbUj1rm0KeHDVqAHYKiyuwvuiotag2xQX7UTCS
         7K9DEWlt55pbJOGSgHjBDNhjMgp9dqUrcssJMtF5qeaBUTG7mwabE+9BnSTx2UXtmKyH
         wnQYKSJSl+PSnUCoGk26+CRtk91Pevb76d9+sclyULBFqCJTTU+1AjiLESEuhnNlGd/b
         h3qaCbTOpQHLXwOB5j+NWscroerpHwY8OWEQ8taFoB4//ITilqNximQJXu9Pc21uKYpy
         rKXg==
X-Gm-Message-State: AOAM533BMvoFHBut5jw1TIS0wKZoG9K1M7stF5pPHGnsHb3X0Ss8Y2Lj
        mrgIP08e+CvEtOlyaDp5QQAEDY+Pu2M=
X-Google-Smtp-Source: ABdhPJxmbaHocKO8fG63A9Vo+0jMqhLJ9v5+hF1v3VzRWGPeoLghpKjUUbrSlS6U8h7xt1QJ4gUO7g==
X-Received: by 2002:a5d:64cf:: with SMTP id f15mr16658541wri.327.1621763615736;
        Sun, 23 May 2021 02:53:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm4638946wmh.35.2021.05.23.02.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 02:53:35 -0700 (PDT)
Message-Id: <320037a8b98dc8bf21a8636a58e04c8f8a23f80a.1621763612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.959.git.1621763612.gitgitgadget@gmail.com>
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 23 May 2021 09:53:32 +0000
Subject: [PATCH 3/3] [GSOC] ref-filter: add contents:raw atom
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add new formatting option `%(contents:raw)`, which will
print all the object contents without any changes.
For blob and tree, it priont all object data, its output
is equivalent to `%(contents)`; For commit and tag,
it not only print objects’ messages (as `%(contents)` does),
but also print objects headers, like the "tree XXX",
"parent YYY", etc lines in commits, and the "object OOO",
"type TTT", etc lines in tags.

It will help further to migrate all cat-file formatting
logic from cat-file to ref-filter.

E.g.

git for-each-ref --format=%(contents:raw) refs/heads/foo

It will have similar output to:

git rev-parse refs/heads/foo | git cat-file --batch

Based-on-patch-by: Olga Telezhnaya <olyatelezhnaya@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 Documentation/git-for-each-ref.txt | 10 ++++++-
 ref-filter.c                       | 11 +++++--
 t/t6300-for-each-ref.sh            | 48 ++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 30b93d2e5178..de77a7454434 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -260,7 +260,15 @@ contents:signature::
 contents:lines=N::
 	The first `N` lines of the message of the commit or tag message.
 
-Note: blob and tree objects only support `%(contents)` and `%(contents:size)`.
+contents:raw::
+	The raw data of the object. For blob and tree, it priont all object data,
+	its output is equivalent to `%(contents)`; For commit and tag, it not only
+	print objects’ messages (as `%(contents)` does), but also print objects
+	headers, like the "tree XXX", "parent YYY", etc lines in commits, and the
+	"object OOO", "type TTT", etc lines in tags.
+
+Note: blob and tree objects only support `%(contents)`, `%(contents:raw)` and
+`%(contents:size)`.
 
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
 are obtained as `trailers[:options]` (or by using the historical alias
diff --git a/ref-filter.c b/ref-filter.c
index e59907188e79..17ef39fe7454 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -134,7 +134,7 @@ static struct used_atom {
 		} remote_ref;
 		struct {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH, C_LINES,
-			       C_SIG, C_SUB, C_SUB_SANITIZE, C_TRAILERS } option;
+			       C_RAW, C_SIG, C_SUB, C_SUB_SANITIZE, C_TRAILERS } option;
 			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
@@ -347,6 +347,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 {
 	if (!arg)
 		atom->u.contents.option = C_BARE;
+	else if (!strcmp(arg,"raw"))
+		atom->u.contents.option = C_RAW;
 	else if (!strcmp(arg, "body"))
 		atom->u.contents.option = C_BODY;
 	else if (!strcmp(arg, "size"))
@@ -1387,11 +1389,16 @@ static void grab_contents(struct atom_value *val, int deref, void *buf,
 				v->s = strbuf_detach(&s, NULL);
 			} else if (atom->u.contents.option == C_BARE)
 				v->s = xstrdup(subpos);
+			else if (atom->u.contents.option == C_RAW) {
+				v->s_size = buf_size;
+				v->s = xmemdupz(buf, buf_size);
+			}
 			break;
 		}
 		case OBJ_BLOB:
 		case OBJ_TREE: {
-			if (atom->u.contents.option == C_BARE) {
+			if (atom->u.contents.option == C_BARE ||
+			    atom->u.contents.option == C_RAW) {
 				v->s_size = buf_size;
 				v->s = xmemdupz(buf, buf_size);
 			} else if (atom->u.contents.option == C_LENGTH)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 4754ec639797..d2a7e1f4384e 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -159,6 +159,8 @@ test_atom head subject 'Initial'
 test_atom head subject:sanitize 'Initial'
 test_atom head contents:subject 'Initial'
 test_atom head body ''
+test_atom head contents:raw "$(git cat-file commit refs/heads/main)
+"
 test_atom head contents:body ''
 test_atom head contents:signature ''
 test_atom head contents 'Initial
@@ -688,6 +690,18 @@ test_atom refs/tags/signed-empty contents:body ''
 test_atom refs/tags/signed-empty contents:signature "$sig"
 test_atom refs/tags/signed-empty contents "$sig"
 
+test_expect_success 'basic atom: refs/tags/signed-empty contents:raw' '
+	git cat-file tag refs/tags/signed-empty >expected &&
+	git for-each-ref --format="%(contents:raw)" refs/tags/signed-empty >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	echo "" >>expected.clean &&
+	test_cmp expected.clean actual.clean
+'
+
+test_atom refs/tags/signed-empty '*contents:raw' "$(git cat-file commit HEAD)
+"
+
 test_atom refs/tags/signed-short subject 'subject line'
 test_atom refs/tags/signed-short subject:sanitize 'subject-line'
 test_atom refs/tags/signed-short contents:subject 'subject line'
@@ -697,6 +711,15 @@ test_atom refs/tags/signed-short contents:signature "$sig"
 test_atom refs/tags/signed-short contents "subject line
 $sig"
 
+test_expect_success 'basic atom: refs/tags/signed-short contents:raw' '
+	git cat-file tag refs/tags/signed-short >expected &&
+	git for-each-ref --format="%(contents:raw)" refs/tags/signed-short >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	echo "" >>expected.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_atom refs/tags/signed-long subject 'subject line'
 test_atom refs/tags/signed-long subject:sanitize 'subject-line'
 test_atom refs/tags/signed-long contents:subject 'subject line'
@@ -710,6 +733,15 @@ test_atom refs/tags/signed-long contents "subject line
 body contents
 $sig"
 
+test_expect_success 'basic atom: refs/tags/signed-long contents:raw' '
+	git cat-file tag refs/tags/signed-long >expected &&
+	git for-each-ref --format="%(contents:raw)" refs/tags/signed-long >actual &&
+	sanitize_pgp <expected >expected.clean &&
+	sanitize_pgp <actual >actual.clean &&
+	echo "" >>expected.clean &&
+	test_cmp expected.clean actual.clean
+'
+
 test_expect_success 'set up refs pointing to tree and blob' '
 	git update-ref refs/mytrees/first refs/heads/main^{tree} &&
 	git update-ref refs/myblobs/first refs/heads/main:one
@@ -731,6 +763,14 @@ test_expect_success 'basic atom: refs/mytrees/first contents' '
 	test_cmp size_expected actual
 '
 
+test_expect_success 'basic atom: refs/mytrees/first contents:raw' '
+	git cat-file tree refs/mytrees/first >expected &&
+	cat expected | wc -c >size_expected &&
+	echo "" >>expected &&
+	git for-each-ref --format="%(contents:raw)" refs/mytrees/first >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'basic atom: refs/mytrees/first contents with --python' '
 	cat >expected <<-\EOF &&
 	0000000 030447 030060 032066 020064 067157 000145 157155 153143
@@ -803,6 +843,14 @@ test_expect_success 'basic atom: refs/myblobs/first contents' '
 	test_cmp size_expected actual
 '
 
+test_expect_success 'basic atom: refs/myblobs/first contents:raw' '
+	git cat-file blob refs/myblobs/first >expected &&
+	cat expected | wc -c >size_expected &&
+	echo "" >>expected &&
+	git for-each-ref --format="%(contents:raw)" refs/myblobs/first >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'set up refs pointing to binary blob' '
 	printf "%b" "a\0b\0c" >blob1 &&
 	printf "%b" "a\0c\0b" >blob2 &&
-- 
gitgitgadget
