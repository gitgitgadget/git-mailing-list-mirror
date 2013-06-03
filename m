From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: t4015 broken on pu
Date: Mon, 03 Jun 2013 21:01:45 +0200
Message-ID: <51ACE819.3010704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 21:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uja5n-0000We-Dx
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 21:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab3FCTGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 15:06:52 -0400
Received: from mout.web.de ([212.227.17.12]:60612 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239Ab3FCTGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 15:06:50 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MKrLo-1Uja0n3m1Q-0009sE; Mon, 03 Jun 2013 21:01:46
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
X-Provags-ID: V02:K0:/kFRWxzg5cN7Ma6zMdlU+Zgsp24ntkmEFzOJpMZCmqM
 4zZcCmIdoLdziADeKMdsgc29iQiTlFTco3Ik4lwwr8BDnJvnRV
 QOcpAHqykDl7J2MDTxAHc3vWLdOO+GIIZKErLdm2utqPo4ayqR
 +hxs3rGwqCNJsnqj6AqZAN4judpvCexUDETzJHByOQU6qjqkPi
 HN412UzuXTbIJM0TsbtMQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226267>

The new 4015 does not pass under Mac OS:

a) The seq command, does not exits (we can use printf)
b) One sed expression is not understood, sed exporst needed ;-)




 git diff
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index b3c4fcc..f00d20b 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -143,18 +143,18 @@ git diff --ignore-space-at-eol > out
 test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect out'
 
 test_expect_success 'ignore-blank-lines: only new lines' '
-       seq 5 >x &&
+       printf "1\n2\n3\n4\n5\n" >x &&
        git update-index x &&
-       seq 5 | sed "/3/i \\\\" >x &&
+       printf "1\n2\n3\n4\n5\n" | sed "/3/i \\\\" >x &&
        git diff --ignore-blank-lines >out &&
        printf "" >expect &&
        test_cmp out expect
 '
 
 test_expect_success 'ignore-blank-lines: only new lines with space' '
-       seq 5 >x &&
+       printf "1\n2\n3\n4\n5\n" >x &&
        git update-index x &&
-       seq 5 | sed "/3/i \ " >x &&
+       printf "1\n2\n3\n4\n5\n" | sed "/3/i \ " >x &&
        git diff -w --ignore-blank-lines >out &&
        printf "" >expect &&
        test_cmp out expect
@@ -162,7 +162,7 @@ test_expect_success 'ignore-blank-lines: only new lines with space' '
 
 
 test_expect_success 'ignore-blank-lines: with changes' '
-       seq 11 >x &&
+       printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n" >x &&
        git update-index x &&
        cat <<-\EOF >x &&

================================
After that, TC 12 fails:
================================
ok 11 - another test, with --ignore-space-at-eol

expecting success: 
        printf "1\n2\n3\n4\n5\n" >x &&
        git update-index x &&
        printf "1\n2\n3\n4\n5\n" | sed "/3/i \\\\" >x &&
        git diff --ignore-blank-lines >out &&
        printf "" >expect &&
        test_cmp out expect

sed: 1: "/3/i \\": extra characters after \ at the end of i command
not ok 12 - ignore-blank-lines: only new lines
