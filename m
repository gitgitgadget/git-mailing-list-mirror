From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv6 07/16] t3600 (rm): add lots of missing &&
Date: Sun, 3 Oct 2010 15:56:15 -0500
Message-ID: <20101003205615.GB22743@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-8-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:03:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ViH-000708-3g
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab0JCU7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 16:59:30 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33464 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754982Ab0JCU7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 16:59:30 -0400
Received: by qyk36 with SMTP id 36so2167169qyk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 13:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=b4tXh5FkE+rvAgJjVUsXsojjXDMzrS/lem5pap5aenM=;
        b=WKrVMgo6eC6pd8PX0Kg6EsQfgdu/xEBwU4LoF9YBe2Ibv1RrIVsDBatNKkLIzyGq9K
         bpqN+ET0w0WkL5qyHZP1k69eXbA/wxKqH5bT376zatwII96/eiXvdSwg981R4zfxSjCc
         1mYwDxSXNKD+BtN6rIt5F/rK8ELRyeJkGKQMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LIlx0pcmPgV8Fe19AVut14cIXH0gQanlVYsxfyCQS565nz5SCibK2FyjOEADunZRMZ
         DSxLfWm942h5MNpsUoKtmVpB+JTbfuHkHHC7DR4vQQCvBrN/DMHHQKQ/IYNiu38KKVmG
         AvPY12DRL9xRFlUhZRGVpjvy6jlSkqPd3j3l0=
Received: by 10.224.20.9 with SMTP id d9mr6182327qab.250.1286139569282;
        Sun, 03 Oct 2010 13:59:29 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id e6sm4472096qcr.5.2010.10.03.13.59.27
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 13:59:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286136014-7728-8-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157922>

Elijah Newren wrote:
>> On Sun, Oct 3, 2010 at 8:28 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>> Why not
>>>        -       echo content > foo
>>>        -       git add foo
>>>        -       git commit -m foo
>>>        +       echo content > foo &&
>>>        +       git add foo &&
>>>        +       git commit --allow-empty -m foo &&
>>> ?
>>
>> What advantage does using these three commands have over 'git checkout
>> HEAD -- foo'?  Perhaps I'm missing something, but I don't see it.
>> It's three commands to one, and the tests don't depend on foo starting
>> with contents of 'content'; just that foo matches HEAD to start.
>
> Is there an advantage of the three-command version I'm just missing

What if the content of foo in HEAD were "other content"?  Then the test
would not be testing what it is supposed to.

Maybe you would prefer something like this on top?  My only concern is
to make sure the test is robust (even if people add new tests before
these without paying much attention) and easy to read.

I suppose I am nitpicking excessively because I do not like to see
regressions, even in out-of-the-way code like this.
---
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 9660ae0..ae469df 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -7,6 +7,15 @@ test_description='Test of the various options to git rm.'
 
 . ./test-lib.sh
 
+prepare_foo () {
+	echo "$1" >foo &&
+	git add foo &&
+	git commit --allow-empty -m "set HEAD to $1" &&
+	echo "$2" >foo &&
+	git add foo &&
+	echo "$3" >foo
+}
+
 # Setup some files to be removed, some with funny characters
 test_expect_success \
     'Initialize test directory' \
@@ -44,27 +53,18 @@ test_expect_success \
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo &&
-     git add foo &&
-     git commit -m foo &&
-     echo "other content" > foo &&
+    'prepare_foo content content "other content" &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
-     git checkout HEAD -- foo &&
-     echo "other content" > foo &&
-     git add foo &&
-     echo "yet another content" > foo &&
+     prepare_foo content "other content" "yet another content" &&
      test_must_fail git rm --cached foo
 '
 
 test_expect_success \
     'Test that git rm --cached -f foo works in case where --cached only did not' \
-    'git checkout HEAD -- foo &&
-     echo "other content" > foo &&
-     git add foo &&
-     echo "yet another content" > foo &&
+    'prepare_foo content "other content" "yet another content" &&
      git rm --cached -f foo'
 
 test_expect_success \
-- 
