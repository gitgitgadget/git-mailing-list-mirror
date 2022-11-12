Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AAEC4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 14:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiKLOgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 09:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiKLOgb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 09:36:31 -0500
Received: from smtp-out-4.talktalk.net (smtp-out-4.talktalk.net [62.24.135.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4471A82E
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 06:36:28 -0800 (PST)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id trcQoB0MfjvYDtrcQoRX92; Sat, 12 Nov 2022 14:36:26 +0000
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=N89X6F1B c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=VwQbUJbxAAAA:8 a=3nsOOYR-AAAA:8 a=ybZZDoGAAAAA:8
 a=pGLkceISAAAA:8 a=HHGDD-5mAAAA:8 a=mHSIRNLK8b0pkggmAOYA:9 a=SJQDp48iGlkA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=X8_4EP2Luv2hi8NvPz5g:22 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: [PATCH v4] pretty-formats: add hard truncation, without ellipsis, options
Date:   Sat, 12 Nov 2022 14:36:16 +0000
Message-Id: <20221112143616.1429-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.281.g83ef3ded8d
In-Reply-To: <20221102120853.2013-1-philipoakley@iee.email>
References: <20221102120853.2013-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBigoYy/xJxR8MrbKZRps87A3knfCEbMuBBDlrLxvNYRzfhhtKmfLmebZZkPD3pgkBMj2EwrPLhB8MRT/U7kxNyYjSd0TD6YDGCKIpxrXAViq0HwxNqW
 gSoEIcEgDUXHHVvCMveR9RonQUS4D8YJSLpl6v0iJeAcGXQQDAHoNsGJw6+Xq/hFmbr/misqclnS7x1b/Vg4OHKtmjSmwqzpwGU7FiZc6v0VZrlaqGLnBUt+
 +nMOtZg8CZlYAuVxAsbBT23AnK3crRQNNpEiL29AHL+yOKzqNTv5CWX/zi8cIYSCP8G18isAM1NYera1kvrD2Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of replacing with "..", replace with the empty string,
implied by passing NULL, and adjust the padding length calculation.

Extend the existing tests for these pretty formats to include
`Trunc` and Ltrunc` options matching the `trunc` and `ltrunc`
tests.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---

Removed left over comments from locations that had needed QZ 'space'
conversion in the here-docs.

To: GitList <git@vger.kernel.org>
Cc: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
In-reply-to: <20221102120853.2013-1-philipoakley@iee.email> 

This should complete the patch (cf. [1] <Y2rPAGp96IwrLS1T@nand.local>)
Note: latest What's Cooking <Y2riRSL+NprJt278@nand.local> hadn't been updated. Tests are included.

A final review would be welcomed.

Range-diff against v3:
1:  498439f0375 ! 1:  d26dabc5271 pretty-formats: add hard truncation, without ellipsis, options
    @@ t/t6006-rev-list-format.sh: commit $head1
      added (hinzugef${added_utf8_part}gt..
      EOF
      
    -+# ZZZ for a space?
     +test_format subject-truncated "%<($truncate_count,Trunc)%s" qz_to_tab_space <<EOF
     +commit $head2
     +changed (ge${changed_utf8_part}ndert) f
    @@ t/t6006-rev-list-format.sh: commit $head1
      added (hinzugef${added_utf8_part_iso88591}gt..
      EOF
      
    -+# need qz qz_to_tab_space
     +test_format complex-subject-Trunc "%<($truncate_count,Trunc)%s" qz_to_tab_space <<EOF
     +commit $head3
     +Test printing of com
    @@ t/t6006-rev-list-format.sh: commit $head1
      added (hinzugef${added_utf8_part}gt..
      EOF
      
    -+# need qz_to_tab_space
     +test_format complex-subject-commitencoding-unset-Trunc "%<($truncate_count,Trunc)%s" qz_to_tab_space <<EOF
     +commit $head3
     +Test printing of com

 Documentation/pretty-formats.txt | 11 +++---
 pretty.c                         | 18 ++++++++-
 t/t4205-log-pretty-formats.sh    | 67 ++++++++++++++++++++++++++++++++
 t/t6006-rev-list-format.sh       | 42 ++++++++++++++++++++
 4 files changed, 132 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 0b4c1c8d98a..0bd339db333 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -146,14 +146,15 @@ The placeholders are:
 '%m':: left (`<`), right (`>`) or boundary (`-`) mark
 '%w([<w>[,<i1>[,<i2>]]])':: switch line wrapping, like the -w option of
 			    linkgit:git-shortlog[1].
-'%<(<N>[,trunc|ltrunc|mtrunc])':: make the next placeholder take at
+'%<(<N>[,trunc|ltrunc|mtrunc|Trunc|Ltrunc])':: make the next placeholder take at
 				  least N columns, padding spaces on
 				  the right if necessary.  Optionally
-				  truncate at the beginning (ltrunc),
-				  the middle (mtrunc) or the end
-				  (trunc) if the output is longer than
-				  N columns.  Note that truncating
+				  truncate (with ellipsis '..') at the beginning (ltrunc) `..ft`,
+				  the middle (mtrunc) `mi..le` or the end
+				  (trunc) `rig..` if the output is longer than
+				  N columns.  Note that truncating with ellipsis
 				  only works correctly with N >= 2.
+				  Use (Trunc|Ltrunc) for hard truncation without ellipsis.
 '%<|(<N>)':: make the next placeholder take at least until Nth
 	     columns, padding spaces on the right if necessary
 '%>(<N>)', '%>|(<N>)':: similar to '%<(<N>)', '%<|(<N>)' respectively,
diff --git a/pretty.c b/pretty.c
index 6cb363ae1c9..1e873d3f41a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -857,7 +857,9 @@ enum trunc_type {
 	trunc_none,
 	trunc_left,
 	trunc_middle,
-	trunc_right
+	trunc_right,
+	trunc_left_hard,
+	trunc_right_hard
 };
 
 struct format_commit_context {
@@ -1145,6 +1147,10 @@ static size_t parse_padding_placeholder(const char *placeholder,
 				c->truncate = trunc_left;
 			else if (starts_with(start, "mtrunc)"))
 				c->truncate = trunc_middle;
+			else if (starts_with(start, "Ltrunc)"))
+				c->truncate = trunc_left_hard;
+			else if (starts_with(start, "Trunc)"))
+				c->truncate = trunc_right_hard;
 			else
 				return 0;
 		} else
@@ -1743,6 +1749,16 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 					    padding - 2, len - (padding - 2),
 					    "..");
 			break;
+		case trunc_left_hard:
+			strbuf_utf8_replace(&local_sb,
+					    0, len - padding,
+					    NULL);
+			break;
+		case trunc_right_hard:
+			strbuf_utf8_replace(&local_sb,
+					    padding, len - padding,
+					    NULL);
+			break;
 		case trunc_none:
 			break;
 		}
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e448ef2928a..55dca307983 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -261,6 +261,17 @@ test_expect_success 'left alignment formatting with trunc' '
 	test_cmp expected actual
 '
 
+test_expect_success 'left alignment formatting with Trunc' '
+	git log --pretty="tformat:%<(10,Trunc)%s" >actual &&
+	qz_to_tab_space <<-\EOF >expected &&
+	message tw
+	message on
+	add bar  Z
+	initial. a
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with trunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,trunc)%s" >actual &&
 	qz_to_tab_space <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
@@ -272,6 +283,17 @@ test_expect_success 'left alignment formatting with trunc. i18n.logOutputEncodin
 	test_cmp expected actual
 '
 
+test_expect_success 'left alignment formatting with Trunc. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,Trunc)%s" >actual &&
+	qz_to_tab_space <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	message tw
+	message on
+	add bar  Z
+	initial. a
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left alignment formatting with ltrunc' '
 	git log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
@@ -283,6 +305,18 @@ test_expect_success 'left alignment formatting with ltrunc' '
 	test_cmp expected actual
 '
 
+test_expect_success 'left alignment formatting with Ltrunc' '
+	git log --pretty="tformat:%<(10,Ltrunc)%s" >actual &&
+	qz_to_tab_space <<-EOF >expected &&
+	essage two
+	essage one
+	add bar  Z
+	an${sample_utf8_part}lich
+	EOF
+	test_cmp expected actual
+'
+
+
 test_expect_success 'left alignment formatting with ltrunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
@@ -294,6 +328,16 @@ test_expect_success 'left alignment formatting with ltrunc. i18n.logOutputEncodi
 	test_cmp expected actual
 '
 
+test_expect_success 'left alignment formatting with Ltrunc. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,Ltrunc)%s" >actual &&
+	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	essage two
+	essage one
+	add bar  Z
+	an${sample_utf8_part}lich
+	EOF
+	test_cmp expected actual
+'
 test_expect_success 'left alignment formatting with mtrunc' '
 	git log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
 	qz_to_tab_space <<-\EOF >expected &&
@@ -507,6 +551,19 @@ test_expect_success 'left/right alignment formatting with stealing' '
 	EOF
 	test_cmp expected actual
 '
+
+test_expect_success 'left/right hard alignment formatting with stealing' '
+	git commit --amend -m short --author "long long long <long@me.com>" &&
+	git log --pretty="tformat:%<(10,Trunc)%s%>>(10,Ltrunc)% an" >actual &&
+	cat <<-\EOF >expected &&
+	short long  long long
+	message on   A U Thor
+	add bar      A U Thor
+	initial. a   A U Thor
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
 	cat <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
@@ -517,6 +574,16 @@ test_expect_success 'left/right alignment formatting with stealing. i18n.logOutp
 	EOF
 	test_cmp expected actual
 '
+test_expect_success 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,Trunc)%s%>>(10,Ltrunc)% an" >actual &&
+	cat <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	short long  long long
+	message on   A U Thor
+	add bar      A U Thor
+	initial. a   A U Thor
+	EOF
+	test_cmp expected actual
+'
 
 test_expect_success 'strbuf_utf8_replace() not producing NUL' '
 	git log --color --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)%C(auto)%d" |
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 41d0ca00b1c..c44935b0ab4 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -218,6 +218,13 @@ commit $head1
 added (hinzugef${added_utf8_part}gt..
 EOF
 
+test_format subject-truncated "%<($truncate_count,Trunc)%s" qz_to_tab_space <<EOF
+commit $head2
+changed (ge${changed_utf8_part}ndert) f
+commit $head1
+added (hinzugef${added_utf8_part}gt)Z
+EOF
+
 test_format body %b <<EOF
 commit $head2
 commit $head1
@@ -400,6 +407,15 @@ commit $head1
 added (hinzugef${added_utf8_part_iso88591}gt..
 EOF
 
+test_format complex-subject-Trunc "%<($truncate_count,Trunc)%s" qz_to_tab_space <<EOF
+commit $head3
+Test printing of com
+commit $head2
+changed (ge${changed_utf8_part_iso88591}ndert) f
+commit $head1
+added (hinzugef${added_utf8_part_iso88591}gt)Z
+EOF
+
 test_format complex-subject-mtrunc "%<($truncate_count,mtrunc)%s" <<EOF
 commit $head3
 Test prin..ex bodies
@@ -418,6 +434,14 @@ commit $head1
 .. (hinzugef${added_utf8_part_iso88591}gt) foo
 EOF
 
+test_format complex-subject-Ltrunc "%<($truncate_count,Ltrunc)%s" <<EOF
+commit $head3
+ng of complex bodies
+commit $head2
+anged (ge${changed_utf8_part_iso88591}ndert) foo
+commit $head1
+ed (hinzugef${added_utf8_part_iso88591}gt) foo
+EOF
 test_expect_success 'setup expected messages (for test %b)' '
 	cat <<-EOF >expected.utf-8 &&
 	commit $head3
@@ -455,6 +479,15 @@ commit $head1
 added (hinzugef${added_utf8_part}gt..
 EOF
 
+test_format complex-subject-commitencoding-unset-Trunc "%<($truncate_count,Trunc)%s" qz_to_tab_space <<EOF
+commit $head3
+Test printing of com
+commit $head2
+changed (ge${changed_utf8_part}ndert) f
+commit $head1
+added (hinzugef${added_utf8_part}gt)Z
+EOF
+
 test_format complex-subject-commitencoding-unset-mtrunc "%<($truncate_count,mtrunc)%s" <<EOF
 commit $head3
 Test prin..ex bodies
@@ -473,6 +506,15 @@ commit $head1
 .. (hinzugef${added_utf8_part}gt) foo
 EOF
 
+test_format complex-subject-commitencoding-unset-Ltrunc "%<($truncate_count,Ltrunc)%s" <<EOF
+commit $head3
+ng of complex bodies
+commit $head2
+anged (ge${changed_utf8_part}ndert) foo
+commit $head1
+ed (hinzugef${added_utf8_part}gt) foo
+EOF
+
 test_format complex-body-commitencoding-unset %b <expected.utf-8
 
 test_expect_success '%x00 shows NUL' '
-- 
2.38.1.windows.1

