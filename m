Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1210BC43217
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 22:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiKAW5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiKAW5k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 18:57:40 -0400
Received: from smtp-out-4.talktalk.net (smtp-out-4.talktalk.net [62.24.135.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB010549
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 15:57:36 -0700 (PDT)
Received: from localhost.localdomain ([88.110.102.84])
        by smtp.talktalk.net with SMTP
        id q0CLor5HjjvYDq0CLoNy5X; Tue, 01 Nov 2022 22:57:34 +0000
X-Originating-IP: [88.110.102.84]
X-Spam: 0
X-OAuthority: v=2.3 cv=N89X6F1B c=1 sm=1 tr=0 a=f4UhoLCnUTRb1HgAgoWw0g==:117
 a=f4UhoLCnUTRb1HgAgoWw0g==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=3nsOOYR-AAAA:8
 a=ybZZDoGAAAAA:8 a=HHGDD-5mAAAA:8 a=KTtj4AJ7g_FhsF5v8b8A:9
 a=AjGcO6oz07-iQ99wixmX:22 a=X8_4EP2Luv2hi8NvPz5g:22 a=0RhZnL1DYvcuLYC8JZ5M:22
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.email>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Subject: [PATCH v2 0/1] extend the truncating pretty formats
Date:   Tue,  1 Nov 2022 22:57:23 +0000
Message-Id: <20221101225724.2165-1-philipoakley@iee.email>
X-Mailer: git-send-email 2.38.1.windows.1
In-Reply-To: <20221030185614.3842-1-philipoakley@iee.email>
References: <20221030185614.3842-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKKM5Gls9FiTa5ZTXrD2tQtXPyjwD7IBRJCMOVGTbaE56jV7VA50S2bZhdC8NRAk99HCWyopyicY8tg0WBlRENk0P8G/qNE9J7s2FvwH2xbLZy0s9JYw
 xq69O7PFnuUXDopiunKgBKC4nPP3lGuDGfCwBLPPO9AoU6QnT6Dd2694+WeIDgIYrqMjqiU/RPzQ/KBEoZQlgFTEVGOvOx81q98sYDmQmagmEWZ+2dRHlinR
 4TM7p1kYP5+l/yq8pYUjx3UmKS5++rpd0JOl/UnlggjxVeSdCffqKlCY1L7BJ1LzOf1RWFzralxHuZ0hd9/Suw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since V1.

Added tests for the [L]Trunc in both t/t4205-log-pretty-formats and
t/t6006-rev-list-format matching the existing tests, which I'd missed
before. Thanks to Taylor for point out my error.

Use NULL rather than the empty string "" const which strbuf_utf8_replace
accepts. Also remove unnecessary brackets.

Added suggestive examples for which end of the string are left and right
when truncating, along with middle.

Aside: no attempt at clarifying the potential man page confusion over
`<` in the '%<(<N>[,..` placeholder character sequence and subsequent
entries.

[V1] <20221030185614.3842-1-philipoakley@iee.email> 
A recent enquiry on the Git-Users list asked for horizontal log graphs
similar to those used in the manual ASCII art graphs. These use single
or double character short strings for commits.

The existing pretty pretty-formats are unable to truncate to single or
double characters because of their use of ellipsis `..`. As a starter,
let's add left and right hard truncation options to the existing
options as a preparatory step for potential `--horizontal` graphs.

It is noted that the  truncation options do not have any tests yet.

Also cc'ing Nsengiyumva who has proposed to look at unifying the 
ref-filter and --pretty formats [1]

--
Philip

To: Git List <git@vger.kernel.org>
Cc: NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>


[1] https://lore.kernel.org/git/CA+PPyiE=baAoVkrghE5GQMt984AcaL=XBAQRsVRbN8w7jQA+ig@mail.gmail.com/

Philip Oakley (1):
  pretty-formats: add hard truncation, without ellipsis, options

 Documentation/pretty-formats.txt | 11 +++---
 pretty.c                         | 18 ++++++++-
 t/t4205-log-pretty-formats.sh    | 67 ++++++++++++++++++++++++++++++++
 t/t6006-rev-list-format.sh       | 45 +++++++++++++++++++++
 4 files changed, 135 insertions(+), 6 deletions(-)

1:  0f3a12c66c ! 1:  35f83cac94 pretty-formats: add hard truncation, without ellipsis, options
    @@ Documentation/pretty-formats.txt: The placeholders are:
      				  least N columns, padding spaces on
      				  the right if necessary.  Optionally
     -				  truncate at the beginning (ltrunc),
    -+				  truncate (with ellipsis '..') at the beginning (ltrunc),
    - 				  the middle (mtrunc) or the end
    - 				  (trunc) if the output is longer than
    +-				  the middle (mtrunc) or the end
    +-				  (trunc) if the output is longer than
     -				  N columns.  Note that truncating
    ++				  truncate (with ellipsis '..') at the beginning (ltrunc) `..ft`,
    ++				  the middle (mtrunc) `mi..le` or the end
    ++				  (trunc) `rig..` if the output is longer than
     +				  N columns.  Note that truncating with ellipsis
      				  only works correctly with N >= 2.
     +				  Use (Trunc|Ltrunc) for hard truncation without ellipsis.
    @@ pretty.c: static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
      			break;
     +		case trunc_left_hard:
     +			strbuf_utf8_replace(&local_sb,
    -+					    0, len - (padding),
    -+					    "");
    ++					    0, len - padding,
    ++					    NULL);
     +			break;
     +		case trunc_right_hard:
     +			strbuf_utf8_replace(&local_sb,
    -+					    padding, len - (padding),
    -+					    "");
    ++					    padding, len - padding,
    ++					    NULL);
     +			break;
      		case trunc_none:
      			break;
      		}
    +
    + ## t/t4205-log-pretty-formats.sh ##
    +@@ t/t4205-log-pretty-formats.sh: test_expect_success 'left alignment formatting with trunc' '
    + 	test_cmp expected actual
    + '
    + 
    ++test_expect_success 'left alignment formatting with Trunc' '
    ++	git log --pretty="tformat:%<(10,Trunc)%s" >actual &&
    ++	qz_to_tab_space <<-\EOF >expected &&
    ++	message tw
    ++	message on
    ++	add bar  Z
    ++	initial. a
    ++	EOF
    ++	test_cmp expected actual
    ++'
    ++
    + test_expect_success 'left alignment formatting with trunc. i18n.logOutputEncoding' '
    + 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,trunc)%s" >actual &&
    + 	qz_to_tab_space <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
    +@@ t/t4205-log-pretty-formats.sh: test_expect_success 'left alignment formatting with trunc. i18n.logOutputEncodin
    + 	test_cmp expected actual
    + '
    + 
    ++test_expect_success 'left alignment formatting with Trunc. i18n.logOutputEncoding' '
    ++	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,Trunc)%s" >actual &&
    ++	qz_to_tab_space <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
    ++	message tw
    ++	message on
    ++	add bar  Z
    ++	initial. a
    ++	EOF
    ++	test_cmp expected actual
    ++'
    ++
    + test_expect_success 'left alignment formatting with ltrunc' '
    + 	git log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
    + 	qz_to_tab_space <<-EOF >expected &&
    +@@ t/t4205-log-pretty-formats.sh: test_expect_success 'left alignment formatting with ltrunc' '
    + 	test_cmp expected actual
    + '
    + 
    ++test_expect_success 'left alignment formatting with Ltrunc' '
    ++	git log --pretty="tformat:%<(10,Ltrunc)%s" >actual &&
    ++	qz_to_tab_space <<-EOF >expected &&
    ++	essage two
    ++	essage one
    ++	add bar  Z
    ++	an${sample_utf8_part}lich
    ++	EOF
    ++	test_cmp expected actual
    ++'
    ++
    ++
    + test_expect_success 'left alignment formatting with ltrunc. i18n.logOutputEncoding' '
    + 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
    + 	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
    +@@ t/t4205-log-pretty-formats.sh: test_expect_success 'left alignment formatting with ltrunc. i18n.logOutputEncodi
    + 	test_cmp expected actual
    + '
    + 
    ++test_expect_success 'left alignment formatting with Ltrunc. i18n.logOutputEncoding' '
    ++	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,Ltrunc)%s" >actual &&
    ++	qz_to_tab_space <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
    ++	essage two
    ++	essage one
    ++	add bar  Z
    ++	an${sample_utf8_part}lich
    ++	EOF
    ++	test_cmp expected actual
    ++'
    + test_expect_success 'left alignment formatting with mtrunc' '
    + 	git log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
    + 	qz_to_tab_space <<-\EOF >expected &&
    +@@ t/t4205-log-pretty-formats.sh: test_expect_success 'left/right alignment formatting with stealing' '
    + 	EOF
    + 	test_cmp expected actual
    + '
    ++
    ++test_expect_success 'left/right hard alignment formatting with stealing' '
    ++	git commit --amend -m short --author "long long long <long@me.com>" &&
    ++	git log --pretty="tformat:%<(10,Trunc)%s%>>(10,Ltrunc)% an" >actual &&
    ++	cat <<-\EOF >expected &&
    ++	short long  long long
    ++	message on   A U Thor
    ++	add bar      A U Thor
    ++	initial. a   A U Thor
    ++	EOF
    ++	test_cmp expected actual
    ++'
    ++
    + test_expect_success 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
    + 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
    + 	cat <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
    +@@ t/t4205-log-pretty-formats.sh: test_expect_success 'left/right alignment formatting with stealing. i18n.logOutp
    + 	EOF
    + 	test_cmp expected actual
    + '
    ++test_expect_success 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
    ++	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(10,Trunc)%s%>>(10,Ltrunc)% an" >actual &&
    ++	cat <<-\EOF | iconv -f utf-8 -t $test_encoding >expected &&
    ++	short long  long long
    ++	message on   A U Thor
    ++	add bar      A U Thor
    ++	initial. a   A U Thor
    ++	EOF
    ++	test_cmp expected actual
    ++'
    + 
    + test_expect_success 'strbuf_utf8_replace() not producing NUL' '
    + 	git log --color --pretty="tformat:%<(10,trunc)%s%>>(10,ltrunc)%C(auto)%d" |
    +
    + ## t/t6006-rev-list-format.sh ##
    +@@ t/t6006-rev-list-format.sh: commit $head1
    + added (hinzugef${added_utf8_part}gt..
    + EOF
    + 
    ++# ZZZ for a space?
    ++test_format subject-truncated "%<($truncate_count,Trunc)%s" qz_to_tab_space <<EOF
    ++commit $head2
    ++changed (ge${changed_utf8_part}ndert) f
    ++commit $head1
    ++added (hinzugef${added_utf8_part}gt)Z
    ++EOF
    ++
    + test_format body %b <<EOF
    + commit $head2
    + commit $head1
    +@@ t/t6006-rev-list-format.sh: commit $head1
    + added (hinzugef${added_utf8_part_iso88591}gt..
    + EOF
    + 
    ++# need qz qz_to_tab_space
    ++test_format complex-subject-Trunc "%<($truncate_count,Trunc)%s" qz_to_tab_space <<EOF
    ++commit $head3
    ++Test printing of com
    ++commit $head2
    ++changed (ge${changed_utf8_part_iso88591}ndert) f
    ++commit $head1
    ++added (hinzugef${added_utf8_part_iso88591}gt)Z
    ++EOF
    ++
    + test_format complex-subject-mtrunc "%<($truncate_count,mtrunc)%s" <<EOF
    + commit $head3
    + Test prin..ex bodies
    +@@ t/t6006-rev-list-format.sh: commit $head1
    + .. (hinzugef${added_utf8_part_iso88591}gt) foo
    + EOF
    + 
    ++test_format complex-subject-Ltrunc "%<($truncate_count,Ltrunc)%s" <<EOF
    ++commit $head3
    ++ng of complex bodies
    ++commit $head2
    ++anged (ge${changed_utf8_part_iso88591}ndert) foo
    ++commit $head1
    ++ed (hinzugef${added_utf8_part_iso88591}gt) foo
    ++EOF
    + test_expect_success 'setup expected messages (for test %b)' '
    + 	cat <<-EOF >expected.utf-8 &&
    + 	commit $head3
    +@@ t/t6006-rev-list-format.sh: commit $head1
    + added (hinzugef${added_utf8_part}gt..
    + EOF
    + 
    ++# need qz_to_tab_space
    ++test_format complex-subject-commitencoding-unset-Trunc "%<($truncate_count,Trunc)%s" qz_to_tab_space <<EOF
    ++commit $head3
    ++Test printing of com
    ++commit $head2
    ++changed (ge${changed_utf8_part}ndert) f
    ++commit $head1
    ++added (hinzugef${added_utf8_part}gt)Z
    ++EOF
    ++
    + test_format complex-subject-commitencoding-unset-mtrunc "%<($truncate_count,mtrunc)%s" <<EOF
    + commit $head3
    + Test prin..ex bodies
    +@@ t/t6006-rev-list-format.sh: commit $head1
    + .. (hinzugef${added_utf8_part}gt) foo
    + EOF
    + 
    ++test_format complex-subject-commitencoding-unset-Ltrunc "%<($truncate_count,Ltrunc)%s" <<EOF
    ++commit $head3
    ++ng of complex bodies
    ++commit $head2
    ++anged (ge${changed_utf8_part}ndert) foo
    ++commit $head1
    ++ed (hinzugef${added_utf8_part}gt) foo
    ++EOF
    ++
    + test_format complex-body-commitencoding-unset %b <expected.utf-8
    + 
    + test_expect_success '%x00 shows NUL' '

-- 
2.38.1.windows.1

