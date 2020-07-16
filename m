Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1CFC433E2
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A87120787
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEf6u9oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgGPMUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgGPMT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 08:19:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86B0C061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 05:19:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so11403526wmf.5
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 05:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Zg2UiL1Ak6FSljSAmukkuuTIGXOWEdFSYWYhmR/sXo=;
        b=iEf6u9oeLfxdAtshAx4MN2X9Fl45eBmUUa0IY0W0s5M7/l6HuA8e91oEfPRTIS8QO6
         yG5mCDQrMIQNrAENrPc0pMqz0uRNBejpsH9ADDIJYSHlGsXOwQ+ey6RFDUmL8UlOT+mq
         oFDVs2wJM7k4MZHIZUw7HpnBwPtYGLqISbzjhsoL/lHXxfdr7GsagmSsWub+4Cpd/N/P
         vYBHLWATd/Li541/0kxdfAUOhlabQldtLjIKnUPX09dznszL+MMl3Ggrrc3+z/6s1wwK
         wpLJuTMbetNdWG1OzHGhGAcBcLeRcVXMsCBI3ty9USWtsD+Sk5czgvwr505c2qbIgtq2
         SK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Zg2UiL1Ak6FSljSAmukkuuTIGXOWEdFSYWYhmR/sXo=;
        b=E4G1rB1ZtzHDTotR3lcl8IzQIWY0hHgGcdYch60f/BGV3zDPLLSTlRkOKMWOeq4MVS
         OUPS9ERKcG7XUT7dfSEYjU7W8USQbWZS9jyofDfjJC00A3Ef6reu25nqdJ/nJHx1kswx
         5u0kbwEEvcvh0l0k4RNTHDfUE3JpH/RijWWSlOY3JILgWNZGIrhng5TlPzIutM/VEqBZ
         3dJnjuqGXKeUpNrKrhWoXQU6xhtv7P64Ww2BIiQFLU/+GSLCs+0d9s55fnsRt++qVGQ/
         3P+8uFzdGjpa7oroIS3cL31LP4md1++Xud16jAPGXNZH/wImn9/nmdp7+KIcRdFjGuQu
         a+cw==
X-Gm-Message-State: AOAM533gRlrOh5P/SYqZVnFijbiJIcW4B9LK09RLvvD81mhUpJQsG2/U
        nJzXxZwaUnJ6MVoytc6xh6fYm36Ky5U=
X-Google-Smtp-Source: ABdhPJykBIySHmjkRcNbzM/5ieOUHH4kp4peL3lwDFEoKoK2VuIqE4s48UzbMZZLvCVxi83ZYcQsVQ==
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr4361822wmt.26.1594901997104;
        Thu, 16 Jul 2020 05:19:57 -0700 (PDT)
Received: from localhost.localdomain ([193.56.245.81])
        by smtp.gmail.com with ESMTPSA id p4sm8725714wrx.63.2020.07.16.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 05:19:56 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 3/3] ref-filter: add support for %(contents:size)
Date:   Thu, 16 Jul 2020 14:19:40 +0200
Message-Id: <20200716121940.21041-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.227.g757ac19d14.dirty
In-Reply-To: <20200716121940.21041-1-chriscool@tuxfamily.org>
References: <20200710164739.6616-1-chriscool@tuxfamily.org>
 <20200716121940.21041-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's useful and efficient to be able to get the size of the
contents directly without having to pipe through `wc -c`.

Also the result of the following:

`git for-each-ref --format='%(contents)' refs/heads/my-branch | wc -c`

is off by one as `git for-each-ref` appends a newline character
after the contents, which can be seen by comparing its output
with the output from `git cat-file`.

As with %(contents), %(contents:size) is silently ignored, if a
ref points to something other than a commit or a tag:

```
$ git update-ref refs/mytrees/first HEAD^{tree}
$ git for-each-ref --format='%(contents)' refs/mytrees/first

$ git for-each-ref --format='%(contents:size)' refs/mytrees/first

```

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       |  7 ++++++-
 t/t6300-for-each-ref.sh            | 19 +++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index b739412c30..2ea71c5f6c 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -235,6 +235,9 @@ and `date` to extract the named component.
 The message in a commit or a tag object is `contents`, from which
 `contents:<part>` can be used to extract various parts out of:
 
+contents:size::
+	The size in bytes of the commit or tag message.
+
 contents:subject::
 	The first paragraph of the message, which typically is a
 	single line, is taken as the "subject" of the commit or the
diff --git a/ref-filter.c b/ref-filter.c
index 8447cb09be..73d8bfa86d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -127,7 +127,8 @@ static struct used_atom {
 			unsigned int nobracket : 1, push : 1, push_remote : 1;
 		} remote_ref;
 		struct {
-			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH,
+			       C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
 			struct process_trailer_options trailer_opts;
 			unsigned int nlines;
 		} contents;
@@ -338,6 +339,8 @@ static int contents_atom_parser(const struct ref_format *format, struct used_ato
 		atom->u.contents.option = C_BARE;
 	else if (!strcmp(arg, "body"))
 		atom->u.contents.option = C_BODY;
+	else if (!strcmp(arg, "size"))
+		atom->u.contents.option = C_LENGTH;
 	else if (!strcmp(arg, "signature"))
 		atom->u.contents.option = C_SIG;
 	else if (!strcmp(arg, "subject"))
@@ -1253,6 +1256,8 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 			v->s = copy_subject(subpos, sublen);
 		else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
+		else if (atom->u.contents.option == C_LENGTH)
+			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
 		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index e9f468d360..ea9bb6dade 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -52,6 +52,25 @@ test_atom() {
 		sanitize_pgp <actual >actual.clean &&
 		test_cmp expected actual.clean
 	"
+	# Automatically test "contents:size" atom after testing "contents"
+	if test "$2" = "contents"
+	then
+		case $(git cat-file -t "$ref") in
+		tag)
+			# We cannot use $3 as it expects sanitize_pgp to run
+			expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
+		tree | blob)
+			expect='' ;;
+		commit)
+			expect=$(printf '%s' "$3" | wc -c) ;;
+		esac
+		# Leave $expect unquoted to lose possible leading whitespaces
+		echo $expect >expected
+		test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
+			git for-each-ref --format="%(contents:size)" "$ref" >actual &&
+			test_cmp expect actual
+		'
+	fi
 }
 
 hexlen=$(test_oid hexsz)
-- 
2.27.0.227.g757ac19d14.dirty

