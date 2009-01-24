From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: implement --reject option passed to git-apply
Date: Fri, 23 Jan 2009 16:59:49 -0800
Message-ID: <7v7i4lr01m.fsf@gitster.siamese.dyndns.org>
References: <1232670681-25781-1-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, penny leach <penny@mjollnir.org>
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Jan 24 02:03:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQWv0-0007Dw-Mj
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 02:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbZAXA76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 19:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753344AbZAXA75
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 19:59:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbZAXA74 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 19:59:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 664B292820;
	Fri, 23 Jan 2009 19:59:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E0DFC9281E; Fri,
 23 Jan 2009 19:59:50 -0500 (EST)
In-Reply-To: <1232670681-25781-1-git-send-email-madduck@madduck.net> (martin
 f. krafft's message of "Fri, 23 Jan 2009 11:31:21 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5071C5DE-E9B2-11DD-96B7-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106938>

"martin f. krafft" <madduck@madduck.net> writes:

> The patch does not touch t/t4252-am-options.sh (yet) because I do not really
> understand how the testing system works.

I'll squash this in, then.

Thanks.

 t/t4252-am-options.sh |   11 ++++++++++-
 t/t4252/am-test-6-1   |   21 +++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git c/t/t4252-am-options.sh i/t/t4252-am-options.sh
index 5fdd188..f603c1b 100755
--- c/t/t4252-am-options.sh
+++ i/t/t4252-am-options.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='git am not losing options'
+test_description='git am with options and not losing them'
 . ./test-lib.sh
 
 tm="$TEST_DIRECTORY/t4252"
@@ -66,4 +66,13 @@ test_expect_success 'apply to a funny path' '
 	test -f "$with_sq/file-5"
 '
 
+test_expect_success 'am --reject' '
+	rm -rf .git/rebase-apply &&
+	git reset --hard initial &&
+	test_must_fail git am --reject "$tm"/am-test-6-1 &&
+	grep "@@ -1,3 +1,3 @@" file-2.rej &&
+	test_must_fail git diff-files --exit-code --quiet file-2 &&
+	grep "[-]-reject" .git/rebase-apply/apply-opt
+'
+
 test_done
diff --git c/t/t4252/am-test-6-1 i/t/t4252/am-test-6-1
new file mode 100644
index 0000000..a8859e9
--- /dev/null
+++ i/t/t4252/am-test-6-1
@@ -0,0 +1,21 @@
+From: A U Thor <au.thor@example.com>
+Date: Thu Dec 4 16:00:00 2008 -0800
+Subject: Huh
+
+Should fail and leave rejects
+
+diff --git i/file-2 w/file-2
+index 06e567b..b6f3a16 100644
+--- i/file-2
++++ w/file-2
+@@ -1,3 +1,3 @@
+-0
++One
+ 2
+ 3
+@@ -4,4 +4,4 @@
+ 4
+ 5
+-6
++Six
+ 7
