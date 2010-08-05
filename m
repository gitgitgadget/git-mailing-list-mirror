From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/12] t6038 (merge.renormalize): style nitpicks
Date: Thu, 5 Aug 2010 06:09:33 -0500
Message-ID: <20100805110933.GC13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:11:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgyLo-0006aT-8g
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758962Ab0HELKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 07:10:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43669 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758947Ab0HELKx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:10:53 -0400
Received: by iwn33 with SMTP id 33so77468iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uXwydxbZUyrDNysHoCvRMHla8RQW/pMdJ3gx9r4zcVo=;
        b=J7ezMswElMDng1LbahnyRmzfNRoclZNooO9RZ/bJ8PHHlZj6dWToh+ApakQXH0Epue
         f5MUggRBTbMpQPHcxjkjo/JfuZSK0birBhLaC+pRitjcArW1+SAVy8erzQIDjvCrbaR0
         rm00IRdxWsRcAnFo09Kc1e3ZGGx7zyVuraf9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sItnOfOjX+Nq9hDNnyRmkI/Myyue7TuCMMZlt+2PgYLGIYoWo1Byam1gduwXHli4zJ
         HYNxoNPSfS/AMIFkZzW09pBGhHpMsNmAlMu33GL4TdstvWEvSX88HwFdf0bOkfsvFYbJ
         lcrwpmWPDNXovKjpDKNmqHl8DhJMX5pY5nAfc=
Received: by 10.231.177.40 with SMTP id bg40mr11963193ibb.150.1281006652258;
        Thu, 05 Aug 2010 04:10:52 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm48184ibb.2.2010.08.05.04.10.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:10:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152633>

Some tweaks to simplify adding and running tests.

 - Use test_tick for predictable, sort of realistic commit dates;

 - Use test_cmp as "test_cmp expected actual" --- some crazy
   content that was not expected should cause the test to fail;

 - Remove and re-add all files at the start of each test so the
   worktree is easier to think about;

 - Avoid using cat where not necessary for clarity.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6038-merge-text-auto.sh |   52 +++++++++++++++++++++++++++++++++++++------
 1 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index d1ab86e..e21b5d2 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -1,58 +1,94 @@
 #!/bin/sh
 
-test_description='CRLF merge conflict across text=auto change'
+test_description='CRLF merge conflict across text=auto change
+
+* [master] remove .gitattributes
+ ! [side] add line from b
+--
+ + [side] add line from b
+*  [master] remove .gitattributes
+*  [master^] add line from a
+*  [master~2] normalize file
+*+ [side^] Initial
+'
 
 . ./test-lib.sh
 
 test_expect_success setup '
 	git config merge.renormalize true &&
 	git config core.autocrlf false &&
+
 	echo first line | append_cr >file &&
 	echo first line >control_file &&
 	echo only line >inert_file &&
+
 	git add file control_file inert_file &&
+	test_tick &&
 	git commit -m "Initial" &&
 	git tag initial &&
 	git branch side &&
+
 	echo "* text=auto" >.gitattributes &&
 	touch file &&
 	git add .gitattributes file &&
+	test_tick &&
 	git commit -m "normalize file" &&
+
 	echo same line | append_cr >>file &&
 	echo same line >>control_file &&
 	git add file control_file &&
+	test_tick &&
 	git commit -m "add line from a" &&
 	git tag a &&
+
 	git rm .gitattributes &&
 	rm file &&
 	git checkout file &&
+	test_tick &&
 	git commit -m "remove .gitattributes" &&
 	git tag c &&
+
 	git checkout side &&
 	echo same line | append_cr >>file &&
 	echo same line >>control_file &&
 	git add file control_file &&
+	test_tick &&
 	git commit -m "add line from b" &&
 	git tag b &&
+
 	git checkout master
 '
 
-test_expect_success 'Check merging after setting text=auto' '
+test_expect_success 'Merge after setting text=auto' '
+	cat <<-\EOF >expected &&
+	first line
+	same line
+	EOF
+
+	git rm -fr . &&
+	rm -f .gitattributes &&
 	git reset --hard a &&
 	git merge b &&
-	cat file | remove_cr >file.temp &&
-	test_cmp file file.temp
+	test_cmp expected file
 '
 
-test_expect_success 'Check merging addition of text=auto' '
+test_expect_success 'Merge addition of text=auto' '
+	cat <<-\EOF >expected &&
+	first line
+	same line
+	EOF
+
+	git rm -fr . &&
+	rm -f .gitattributes &&
 	git reset --hard b &&
 	git merge a &&
-	cat file | remove_cr >file.temp &&
-	test_cmp file file.temp
+	test_cmp expected file
 '
 
 test_expect_success 'Test delete/normalize conflict' '
-	git checkout side &&
+	git checkout -f side &&
+	git rm -fr . &&
+	rm -f .gitattributes &&
 	git reset --hard initial &&
 	git rm file &&
 	git commit -m "remove file" &&
-- 
1.7.2.1.544.ga752d.dirty
