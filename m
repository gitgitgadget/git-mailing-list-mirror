From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Tue, 06 Dec 2011 23:30:57 -0800
Message-ID: <4EDF1631.5090906@pcharlan.com>
References: <4EDBF4D5.6030908@pcharlan.com> <7vbormn8vk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 08:36:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYC2x-0005YG-Jh
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 08:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab1LGHgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 02:36:01 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:59784 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab1LGHgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 02:36:01 -0500
Received: from homiemail-a83.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 5A1E1186B82
	for <git@vger.kernel.org>; Tue,  6 Dec 2011 23:31:38 -0800 (PST)
Received: from homiemail-a83.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a83.g.dreamhost.com (Postfix) with ESMTP id 9EAA65E06A;
	Tue,  6 Dec 2011 23:30:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=doPySmCH+pcTAR3wNy6ZszHNT9pJED3sMPR3wlTGdua8JlY/W7aRIA5D6FiDf
	OlQjo86Hc3Fx7r11YKmktuvdFKsDSYbGwKRGmZn23ZXLhIJNLvbG4ke7LoV/wvq9
	aEQFkcuQcHzuylIZS9Yyf2UKBqEpCCDtfrB4cRPnn8jU9I=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=tBzd
	aLSmLe0EwYcHSIk15fOvWeQ=; b=k0EK0SX7ZXVfPgYVavwvMptaYXH1f39w095x
	UR79gJFSLHzBUCp3vpE8BtEN9o/oG4QuHfjM/ox52SYOx90GmiZck5u0Mmmraa5Q
	uN1FIOMoC5ZBa6VdBs9lhR9lKzw6QnyyJWpD1o+fvzt9Te0CmgdMnz3gxBFK3QDi
	R/15t1I=
Received: from [192.168.0.102] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pgit@pcharlan.com)
	by homiemail-a83.g.dreamhost.com (Postfix) with ESMTPSA id 7EB1F5E063;
	Tue,  6 Dec 2011 23:30:58 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111124 Thunderbird/8.0
In-Reply-To: <7vbormn8vk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186435>

On 12/05/2011 10:58 AM, Junio C Hamano wrote:
> Pete Harlan <pgit@pcharlan.com> writes:
> 
>> But this only works if there's a base version; if foo.c was added in
>> each branch, we get:
>>
>>    error: path 'foo.c' does not have all three versions
>>
>> Git didn't need all three versions to create the original conflicted
>> file, so why would it need them to recreate it?
> 
> Because the original "merge" was a bit more carefully written but
> "checkout -m" was written without worrying too much about "both sides
> added differently" corner case and still being defensive about not doing
> random thing upon getting an unexpected input state.
> 
> IOW, being lazy ;-)
> 
> How does this look?

Wow, thanks for the quick response! That does indeed let me checkout
the file as expected.

I wrote a test (below) to be folded in with your patch, but the test
fails because it expects the restored file to be the same as the
originally-conflicted file, but the conflict-line labels change from
"HEAD" and "master":

  <<<<<<< HEAD
  in_topic
  =======
  in_master
  >>>>>>> master

to "ours" and "theirs".  (The same thing happens in the 3-way merge
case.)

If the label change is expected then I can rewrite the test to ignore
labels, or to expect "ours" and "theirs", whichever you think is best.
If the label change is unexpected, then I guess the test is good :)

--Pete

-- >8 --
Test 'checkout -m -- path' when path is a 2-way merge

Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---
 t/t2023-checkout-m-twoway.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100755 t/t2023-checkout-m-twoway.sh

diff --git a/t/t2023-checkout-m-twoway.sh b/t/t2023-checkout-m-twoway.sh
new file mode 100755
index 0000000..5b50360
--- /dev/null
+++ b/t/t2023-checkout-m-twoway.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='checkout -m -- conflicted/path/with/2-way/merge
+
+Ensures that checkout -m on a resolved file restores the conflicted file
+when it conflicted with a 2-way merge.'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_tick &&
+	test_commit initial_commit &&
+	git branch topic &&
+	test_commit added_in_master file.txt in_master &&
+	git checkout topic &&
+	test_commit added_in_topic file.txt in_topic
+'
+
+test_must_fail git merge master
+
+test_expect_success '-m restores 2-way conflicted+resolved file' '
+	cp file.txt file.txt.conflicted &&
+	echo resolved >file.txt &&
+	git add file.txt &&
+	git checkout -m -- file.txt &&
+	test_cmp file.txt.conflicted file.txt
+'
+
+test_done
