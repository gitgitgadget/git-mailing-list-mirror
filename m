From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] t7508: test git status -v
Date: Wed, 04 Mar 2015 13:27:46 -0800
Message-ID: <xmqqk2yw78rx.fsf@gitster.dls.corp.google.com>
References: <54B8C82E.8000707@drmicha.warpmail.net>
	<4979bf9de04197c1cd0d4a6af1348b45d4b0894c.1425390756.git.git@drmicha.warpmail.net>
	<xmqqr3t5aicu.fsf@gitster.dls.corp.google.com>
	<xmqqioehafb2.fsf@gitster.dls.corp.google.com>
	<54F6E716.5050808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 22:27:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGpf-0003Xj-A0
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbbCDV1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:27:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751283AbbCDV1t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:27:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 330DC3C559;
	Wed,  4 Mar 2015 16:27:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PNsm+RduUDrX1s8fHnag1ezQHeg=; b=U42PBF
	+w4iR+tumAsX+Ow0KfT5FfYPESZT6DjgrEYSyBvH3QqviiNXlkAmJMHHXA+gAU8l
	ghgsaKB8DP9daOPXJFJpKM1GyH5Fz8khYl4y1k1ZzpjVuWpR0Tgn0khogjqmwYn8
	MLMrutt/rs7dtGEZeyTjDKAXy6WuC/8sUKIDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bvu9al/KUNLeuQGGtWJiE9TkOP775PeD
	U9I3SEj7mSyw4oniSZaS7kCcX417EhWu/RP04Xx8ggLSGdlPCHXj/eW5RkkBt0NR
	/5Qv8I9NzL7b5qOGYkF0ejQEXswGtdiwdIY8irlx/gUxO97VbCRl4q6qm5e2qYvD
	hXISqoWF3uE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B3FE3C557;
	Wed,  4 Mar 2015 16:27:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 899513C549;
	Wed,  4 Mar 2015 16:27:47 -0500 (EST)
In-Reply-To: <54F6E716.5050808@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 04 Mar 2015 12:05:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4DA97CD8-C2B5-11E4-9325-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264779>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Ahh, OK.  The way the existing tests prepare 'expect' is "by hand".
>> 
>> So I think what is wrong with this new test is not that relies on
>> the current contents of 'expect', but that it modifies it (imagine
>> being a merge/patch monkey who has to accept this change while a
>> change from somebody else that wants to add another test that relies
>> on the original 'expect' intact and then have to scratch his or her
>> head when the two topics are merged, wondering why the latter test
>> starts failing).
>> 
>> Perhaps
>> 
>> 	( cat expect && git diff --cached ) >expect-with-v &&
>>         git status -v >actual &&
>>         test_cmp expect-with-v actual
>> 
>> or something?
>
> That's what I had first, but the new file shows up as untracked file in
> the status output...

If we step back and wonder why it is not a problem for the test
to create 'expect' and 'output' that are not untracked, what would
we find?

It seems that there are two ways to do this:

 - Spell these out in 'expect' as untracked; or
 - Throw them in .gitignore to be ignored by 'status'.

As some other tests want to see how untracked files appear in the
output, I wonder if throwing expect and output that are already used
in the test, together with the new "expect-with-v" and friends, to a
.gitignore file might not be a better direction to go.

Perhaps such a clean-up effort might begin with something like this
patch?

-- >8 --
t7508: .gitignore 'expect' and 'output' files

These files are used to observe the behaviour of the 'status'
command and if there weren't any such observer, the expected
output from 'status' wouldn't even mention them.

Place them in .gitignore to unclutter the output expected by the
tests.  An added benefit is that future tests can add such files
that are purely for use by the observer, i.e. the tests themselves,
by naming them as expect-foo and/or output-bar.


---

 t/t7508-status.sh | 62 +++++--------------------------------------------------
 1 file changed, 5 insertions(+), 57 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 8ed5788..9d944a3 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -320,7 +320,11 @@ EOF
 	test_i18ncmp expect output
 '
 
-rm -f .gitignore
+cat >.gitignore <<\EOF
+.gitignore
+expect*
+output*
+EOF
 
 cat >expect <<\EOF
 ## master
@@ -329,8 +333,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 
@@ -434,8 +436,6 @@ Untracked files:
 	dir2/modified
 	dir2/untracked
 	dir3/
-	expect
-	output
 	untracked
 
 EOF
@@ -456,8 +456,6 @@ A  dir2/added
 ?? dir2/modified
 ?? dir2/untracked
 ?? dir3/
-?? expect
-?? output
 ?? untracked
 EOF
 test_expect_success 'status -s -unormal' '
@@ -493,8 +491,6 @@ Untracked files:
 	dir2/untracked
 	dir3/untracked1
 	dir3/untracked2
-	expect
-	output
 	untracked
 
 EOF
@@ -518,8 +514,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 test_expect_success 'status -s -uall' '
@@ -554,8 +548,6 @@ Untracked files:
 	untracked
 	../dir2/modified
 	../dir2/untracked
-	../expect
-	../output
 	../untracked
 
 EOF
@@ -569,8 +561,6 @@ A  ../dir2/added
 ?? untracked
 ?? ../dir2/modified
 ?? ../dir2/untracked
-?? ../expect
-?? ../output
 ?? ../untracked
 EOF
 test_expect_success 'status -s with relative paths' '
@@ -586,8 +576,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 
@@ -625,8 +613,6 @@ Untracked files:
 	<BLUE>dir1/untracked<RESET>
 	<BLUE>dir2/modified<RESET>
 	<BLUE>dir2/untracked<RESET>
-	<BLUE>expect<RESET>
-	<BLUE>output<RESET>
 	<BLUE>untracked<RESET>
 
 EOF
@@ -647,8 +633,6 @@ cat >expect <<\EOF
 <BLUE>??<RESET> dir1/untracked
 <BLUE>??<RESET> dir2/modified
 <BLUE>??<RESET> dir2/untracked
-<BLUE>??<RESET> expect
-<BLUE>??<RESET> output
 <BLUE>??<RESET> untracked
 EOF
 
@@ -676,8 +660,6 @@ cat >expect <<\EOF
 <BLUE>??<RESET> dir1/untracked
 <BLUE>??<RESET> dir2/modified
 <BLUE>??<RESET> dir2/untracked
-<BLUE>??<RESET> expect
-<BLUE>??<RESET> output
 <BLUE>??<RESET> untracked
 EOF
 
@@ -694,8 +676,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 
@@ -755,8 +735,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -772,8 +750,6 @@ A  dir2/added
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 
@@ -798,8 +774,6 @@ Untracked files:
 
 	dir1/untracked
 	dir2/
-	expect
-	output
 	untracked
 
 EOF
@@ -848,8 +822,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -870,8 +842,6 @@ A  sm
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 test_expect_success 'status -s submodule summary is disabled by default' '
@@ -913,8 +883,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -940,8 +908,6 @@ A  sm
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 test_expect_success 'status -s submodule summary' '
@@ -964,8 +930,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -983,8 +947,6 @@ cat >expect <<EOF
 ?? dir1/untracked
 ?? dir2/modified
 ?? dir2/untracked
-?? expect
-?? output
 ?? untracked
 EOF
 test_expect_success 'status -s submodule summary (clean submodule)' '
@@ -1025,8 +987,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -1080,8 +1040,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -1192,8 +1150,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -1254,8 +1210,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
@@ -1336,8 +1290,6 @@ cat > expect << EOF
 ;	dir1/untracked
 ;	dir2/modified
 ;	dir2/untracked
-;	expect
-;	output
 ;	untracked
 ;
 EOF
@@ -1369,8 +1321,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 no changes added to commit (use "git add" and/or "git commit -a")
@@ -1400,8 +1350,6 @@ Untracked files:
 	dir1/untracked
 	dir2/modified
 	dir2/untracked
-	expect
-	output
 	untracked
 
 EOF
