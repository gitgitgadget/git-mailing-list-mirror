From: SungHyun Nam <namsh@posdata.co.kr>
Subject: Re: git-remote SEGV on t5505 test.
Date: Fri, 18 Jul 2008 14:44:45 +0900
Message-ID: <48802DCD.2090704@posdata.co.kr>
References: <g5osl6$4g3$1@ger.gmane.org> <7vsku7es3n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 07:46:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJinf-0001ty-S0
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 07:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbYGRFpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 01:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbYGRFpV
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 01:45:21 -0400
Received: from main.gmane.org ([80.91.229.2]:50201 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbYGRFpU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 01:45:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KJimG-0004Sv-K2
	for git@vger.kernel.org; Fri, 18 Jul 2008 05:45:13 +0000
Received: from 203.238.196.197 ([203.238.196.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 05:45:12 +0000
Received: from namsh by 203.238.196.197 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 05:45:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 203.238.196.197
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7vsku7es3n.fsf@gitster.siamese.dyndns.org>
X-Stationery: 0.4.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88987>

Junio C Hamano wrote:
> SungHyun Nam <namsh@posdata.co.kr> writes:
> 
>> And the 'skip_prefix()' returns NULL in this case.
>> (The old skip_prefix() never returns NULL).
> 
> Thanks.  Something like this?

With this patch, 'make test' passed all the tests successfully.
I ran test with GIT_SKIP_TESTS="t90?? t91?? t92?? t94??".

Regards,
namsh

P.S I skipped svn/cvs test because I don't need them (And no
     svn/cvs installed).  But, I skipped send-email test because it
     fails.  I thought I don't need to use send-email.

     And now I check what caused fail.  The problem was this test
     script generates 'fake.sendmail' which uses '/bin/sh'.

     Is it possible that we can use 'SHELL_PATH' here?  Or could
     you apply the patch below?

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index de5b980..0320aa1 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -16,7 +16,7 @@ test_expect_success \
      '(echo "#!/bin/sh"
        echo shift
        echo output=1
-      echo "while test -f commandline\$output; do
output=\$((\$output+1)); done"
+      echo "while test -f commandline\$output; do output=\`expr
\$output + 1\`; done"
        echo for a
        echo do
        echo "  echo \"!\$a!\""
