From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 07/16] t3600 (rm): add lots of missing &&
Date: Sun,  3 Oct 2010 14:00:05 -0600
Message-ID: <1286136014-7728-8-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:59:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uib-0002yx-Tf
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854Ab0JCT7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 15:59:00 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45640 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841Ab0JCT67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:58:59 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1157782pvg.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JB9oJbaWjXg36f2bcAei3x3e2qHxBhmpu+tDDk+EMno=;
        b=SwWwmknva5zkFQwqDsn72VJEWP5FNRUZGxatF+QpZH8aekywcVmO2JicGixTqiCDtM
         x14hNXu9pL+fRPzpArEbIfxiM8SZoOZEdHTwMa4SiUerGtdY+7lPSxsR7l3w2/7vwHDC
         RUEfKvIx4z/VQAIdq0s4KQogt6SiQKxzb3HBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MJGFCOl8V8VvlajfqIx6sl29peocGfqqVuGuffMtmjGJD64MsvTXTOl+JQUCaDObla
         XjfKIvTvbUJxFuoAtqdNFW6840Q9xuz/OGhAQMCkKinDgFsBbzxaqi20x1dpQ+zz0PeD
         /XQ3Iq4itFtsK87aRXayXtMbSsG4PDUPrscvg=
Received: by 10.114.120.6 with SMTP id s6mr9935126wac.224.1286135939342;
        Sun, 03 Oct 2010 12:58:59 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.58.56
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:58:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157909>

Also replace failing code with similar clean-up to set the appropriate
state the test needs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
May be worth considering an alternative; from
http://thread.gmane.org/gmane.comp.version-control.git/157827/focus=157896:

>On Sun, Oct 3, 2010 at 8:28 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>>  test_expect_success \
>>>      'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
>>> -     echo content > foo
>>> -     git add foo
>>> -     git commit -m foo
>>> +     git checkout HEAD -- foo &&
>> [...]
>>
>> Why not
>>        -       echo content > foo
>>        -       git add foo
>>        -       git commit -m foo
>>        +       echo content > foo &&
>>        +       git add foo &&
>>        +       git commit --allow-empty -m foo &&
>> ?
>
> What advantage does using these three commands have over 'git checkout
> HEAD -- foo'?  Perhaps I'm missing something, but I don't see it.
> It's three commands to one, and the tests don't depend on foo starting
> with contents of 'content'; just that foo matches HEAD to start.

Is there an advantage of the three-command version I'm just missing, or
do people just prefer it?

 t/t3600-rm.sh |   38 +++++++++++++++++---------------------
 1 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b26cabd..9660ae0 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -38,37 +38,33 @@ test_expect_success \
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo
-     git add foo
+    'echo content > foo &&
+     git add foo &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
+    'echo content > foo &&
+     git add foo &&
+     git commit -m foo &&
+     echo "other content" > foo &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
-     echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+     git checkout HEAD -- foo &&
+     echo "other content" > foo &&
+     git add foo &&
+     echo "yet another content" > foo &&
      test_must_fail git rm --cached foo
 '
 
 test_expect_success \
     'Test that git rm --cached -f foo works in case where --cached only did not' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+    'git checkout HEAD -- foo &&
+     echo "other content" > foo &&
+     git add foo &&
+     echo "yet another content" > foo &&
      git rm --cached -f foo'
 
 test_expect_success \
@@ -170,7 +166,7 @@ test_expect_success 'but with -f it should work.' '
 	git rm -f foo baz &&
 	test ! -f foo &&
 	test ! -f baz &&
-	test_must_fail git ls-files --error-unmatch foo
+	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch baz
 '
 
@@ -183,7 +179,7 @@ test_expect_success 'refuse to remove cached empty file with modifications' '
 
 test_expect_success 'remove intent-to-add file without --force' '
 	echo content >intent-to-add &&
-	git add -N intent-to-add
+	git add -N intent-to-add &&
 	git rm --cached intent-to-add
 '
 
@@ -201,7 +197,7 @@ test_expect_success 'Recursive without -r fails' '
 '
 
 test_expect_success 'Recursive with -r but dirty' '
-	echo qfwfq >>frotz/nitfol
+	echo qfwfq >>frotz/nitfol &&
 	test_must_fail git rm -r frotz &&
 	test -d frotz &&
 	test -f frotz/nitfol
-- 
1.7.3.1.66.gab790
