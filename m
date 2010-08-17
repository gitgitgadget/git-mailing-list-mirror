From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/24] t6200 (fmt-merge-msg): style nitpicks
Date: Tue, 17 Aug 2010 01:57:40 -0500
Message-ID: <20100817065740.GG22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 08:59:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlG8n-0006vI-Vm
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 08:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab0HQG7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 02:59:16 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55608 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab0HQG7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 02:59:16 -0400
Received: by ywh1 with SMTP id 1so2269127ywh.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 23:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=GWSlKVRtDq56lv1RES8EeMWQhhuIc8xY4Exjq+MnGzM=;
        b=JmlqBUrhGRzn1KnXpVsyG4Tdm6h0KM6IRC09bMWcce5fJ/WBOts3YBnTaZEjKXyVDo
         Rm9p4+iPuJZVqDZtjr6NrFbGuw3HvHhJirm5oT8rH9jgbEoUwWvmWG4trhh3694Bzola
         uW5hYPbUZRGwaWKHaFc7YprfKqWe77n/MrJ4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IUZm6o4zxgOtzgpvt1GMyboWAelbzB7FJGRop13fDLgDbrc4yHyyElkXVPDLSzWC1L
         9Qh5USMaMlL8VonSyM+qysqCUZbY7LtVW5i5snp6mCG8ilIgy4/Zro/Q0dv8Hm5bgZzp
         y2LwlACCPEkGDE30kIjXxOHChBf6rbhYSCxeo=
Received: by 10.101.107.8 with SMTP id j8mr7102852anm.166.1282028355325;
        Mon, 16 Aug 2010 23:59:15 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a12sm11751294and.16.2010.08.16.23.59.14
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 23:59:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153710>

Guard setup with test_expect_success.  Use test_might_fail
instead of ignoring the exit code from git config --unset.
Point out setup commands that are shared by multiple tests,
to make it easy to write GIT_SKIP_TESTS specifications that
work.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6200-fmt-merge-msg.sh |  278 ++++++++++++++++++++--------------------------
 1 files changed, 119 insertions(+), 159 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 42f8ece..5553dff 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -70,14 +70,13 @@ test_expect_success setup '
 		i=$(($i+1))
 	done &&
 
-	git show-branch
+	git show-branch &&
+
+	apos="'\''"
 '
 
-cat >expected <<\EOF
-Merge branch 'left'
-EOF
-
-test_expect_success 'merge-msg test #1' '
+test_expect_success 'message for merging local branch' '
+	echo "Merge branch ${apos}left${apos}" >expected &&
 
 	git checkout master &&
 	git fetch . left &&
@@ -86,11 +85,8 @@ test_expect_success 'merge-msg test #1' '
 	test_cmp expected actual
 '
 
-cat >expected <<EOF
-Merge branch 'left' of $(pwd)
-EOF
-
-test_expect_success 'merge-msg test #2' '
+test_expect_success 'message for merging external branch' '
+	echo "Merge branch ${apos}left${apos} of $(pwd)" >expected &&
 
 	git checkout master &&
 	git fetch "$(pwd)" left &&
@@ -99,139 +95,108 @@ test_expect_success 'merge-msg test #2' '
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-Merge branch 'left'
+test_expect_success '[merge] summary/log configuration' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
 
-* left:
-  Left #5
-  Left #4
-  Left #3
-  Common #2
-  Common #1
-EOF
-
-test_expect_success 'merge-msg test #3-1' '
-
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
 	git config merge.log true &&
+	test_might_fail git config --unset-all merge.summary &&
 
 	git checkout master &&
 	test_tick &&
 	git fetch . left &&
 
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	test_cmp expected actual
-'
+	git fmt-merge-msg <.git/FETCH_HEAD >actual1 &&
 
-test_expect_success 'merge-msg test #3-2' '
-
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
+	test_might_fail git config --unset-all merge.log &&
 	git config merge.summary true &&
 
 	git checkout master &&
 	test_tick &&
 	git fetch . left &&
 
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	test_cmp expected actual
-'
+	git fmt-merge-msg <.git/FETCH_HEAD >actual2 &&
 
-cat >expected <<\EOF
-Merge branches 'left' and 'right'
-
-* left:
-  Left #5
-  Left #4
-  Left #3
-  Common #2
-  Common #1
-
-* right:
-  Right #5
-  Right #4
-  Right #3
-  Common #2
-  Common #1
-EOF
+	test_cmp expected actual1 &&
+	test_cmp expected actual2
+'
 
-test_expect_success 'merge-msg test #4-1' '
+test_expect_success 'setup: expected shortlog for two branches' '
+	cat >expected <<-EOF
+	Merge branches ${apos}left${apos} and ${apos}right${apos}
+
+	* left:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+
+	* right:
+	  Right #5
+	  Right #4
+	  Right #3
+	  Common #2
+	  Common #1
+	EOF
+'
 
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
+test_expect_success 'shortlog for two branches' '
 	git config merge.log true &&
-
+	test_might_fail git config --unset-all merge.summary &&
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual1 &&
 
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success 'merge-msg test #4-2' '
-
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
+	test_might_fail git config --unset-all merge.log &&
 	git config merge.summary true &&
-
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual2 &&
 
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success 'merge-msg test #5-1' '
-
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
 	git config merge.log yes &&
-
+	test_might_fail git config --unset-all merge.summary &&
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual3 &&
 
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success 'merge-msg test #5-2' '
-
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
+	test_might_fail git config --unset-all merge.log &&
 	git config merge.summary yes &&
-
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
+	git fmt-merge-msg <.git/FETCH_HEAD >actual4 &&
 
-	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
-	test_cmp expected actual
+	test_cmp expected actual1 &&
+	test_cmp expected actual2 &&
+	test_cmp expected actual3 &&
+	test_cmp expected actual4
 '
 
 test_expect_success 'merge-msg -F' '
-
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
+	test_might_fail git config --unset-all merge.log &&
 	git config merge.summary yes &&
-
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
-
 	git fmt-merge-msg -F .git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'merge-msg -F in subdirectory' '
-
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
+	test_might_fail git config --unset-all merge.log &&
 	git config merge.summary yes &&
-
 	git checkout master &&
 	test_tick &&
 	git fetch . left right &&
@@ -245,11 +210,11 @@ test_expect_success 'merge-msg -F in subdirectory' '
 '
 
 test_expect_success 'merge-msg with nothing to merge' '
-
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
+	test_might_fail git config --unset-all merge.log &&
 	git config merge.summary yes &&
 
+	>empty &&
+
 	(
 		cd remote &&
 		git checkout -b unrelated &&
@@ -258,22 +223,20 @@ test_expect_success 'merge-msg with nothing to merge' '
 		git fmt-merge-msg <.git/FETCH_HEAD >../actual
 	) &&
 
-	test_cmp /dev/null actual
+	test_cmp empty actual
 '
 
-cat >expected <<\EOF
-Merge tag 'tag-r3'
-
-* tag 'tag-r3':
-  Right #3
-  Common #2
-  Common #1
-EOF
-
 test_expect_success 'merge-msg tag' '
+	cat >expected <<-EOF &&
+	Merge tag ${apos}tag-r3${apos}
 
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
+	* tag ${apos}tag-r3${apos}:
+	  Right #3
+	  Common #2
+	  Common #1
+	EOF
+
+	test_might_fail git config --unset-all merge.log &&
 	git config merge.summary yes &&
 
 	git checkout master &&
@@ -284,26 +247,24 @@ test_expect_success 'merge-msg tag' '
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-Merge tags 'tag-r3' and 'tag-l5'
-
-* tag 'tag-r3':
-  Right #3
-  Common #2
-  Common #1
-
-* tag 'tag-l5':
-  Left #5
-  Left #4
-  Left #3
-  Common #2
-  Common #1
-EOF
-
 test_expect_success 'merge-msg two tags' '
+	cat >expected <<-EOF &&
+	Merge tags ${apos}tag-r3${apos} and ${apos}tag-l5${apos}
 
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
+	* tag ${apos}tag-r3${apos}:
+	  Right #3
+	  Common #2
+	  Common #1
+
+	* tag ${apos}tag-l5${apos}:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	test_might_fail git config --unset-all merge.log &&
 	git config merge.summary yes &&
 
 	git checkout master &&
@@ -314,26 +275,24 @@ test_expect_success 'merge-msg two tags' '
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-Merge branch 'left', tag 'tag-r3'
-
-* tag 'tag-r3':
-  Right #3
-  Common #2
-  Common #1
-
-* left:
-  Left #5
-  Left #4
-  Left #3
-  Common #2
-  Common #1
-EOF
-
 test_expect_success 'merge-msg tag and branch' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}, tag ${apos}tag-r3${apos}
 
-	git config --unset-all merge.log
-	git config --unset-all merge.summary
+	* tag ${apos}tag-r3${apos}:
+	  Right #3
+	  Common #2
+	  Common #1
+
+	* left:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	test_might_fail git config --unset-all merge.log &&
 	git config merge.summary yes &&
 
 	git checkout master &&
@@ -344,26 +303,27 @@ test_expect_success 'merge-msg tag and branch' '
 	test_cmp expected actual
 '
 
-cat >expected <<\EOF
-Merge branch 'long'
-
-* long: (35 commits)
-EOF
-
 test_expect_success 'merge-msg lots of commits' '
+	{
+		cat <<-EOF &&
+		Merge branch ${apos}long${apos}
+
+		* long: (35 commits)
+		EOF
+
+		i=29 &&
+		while test $i -gt 9
+		do
+			echo "  $i" &&
+			i=$(($i-1))
+		done &&
+		echo "  ..."
+	} >expected &&
 
 	git checkout master &&
 	test_tick &&
 	git fetch . long &&
 
-	i=29 &&
-	while test $i -gt 9
-	do
-		echo "  $i" &&
-		i=$(($i-1))
-	done >>expected &&
-	echo "  ..." >>expected
-
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	test_cmp expected actual
 '
-- 
1.7.2.1.544.ga752d.dirty
