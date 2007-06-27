From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Failure in t5516, tests 15 and 16
Date: Tue, 26 Jun 2007 18:44:45 -0700
Message-ID: <7v4pkuuq5u.fsf@assigned-by-dhcp.pobox.com>
References: <4FAE3A62-A0D1-4C88-8413-88F1D75A2730@silverinsanity.com>
	<CFDE3792-403B-4582-B7FB-BC142B79AE63@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 03:44:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3MaP-0005QR-0p
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 03:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbXF0Bor (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 21:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752508AbXF0Bor
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 21:44:47 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:65482 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbXF0Boq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 21:44:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627014445.PKK3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 21:44:45 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GRkl1X00N1kojtg0000000; Tue, 26 Jun 2007 21:44:46 -0400
In-Reply-To: <CFDE3792-403B-4582-B7FB-BC142B79AE63@silverinsanity.com> (Brian
	Gernhardt's message of "Tue, 26 Jun 2007 21:29:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50998>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On Jun 22, 2007, at 10:50 AM, Brian Gernhardt wrote:
>
>> Tests 15 and 16 in script "t5516-fetch-push.sh" fails with "notice:
>> HEAD points to an unborn branch (master)".  Is this just bad tests
>> or an actual failure?  This is with current master
>> (45fd8bd32dd68ce6b14a406d0abbd6f56490131c) on OS X.

Can you check "cd t && sh -x t5516-fetch-push.sh -i -v"?

I am suspecting that

                test "$( cd testrepo && git show-ref | wc -l )" = 1

may have an interesting effect when "wc -l" emits extra
whitespaces.  Does this fix it for you?



diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 08d58e1..c0fa2ba 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -226,7 +226,7 @@ test_expect_success 'push with colon-less refspec (3)' '
 	git branch -f frotz master &&
 	git push testrepo frotz &&
 	check_push_result $the_commit heads/frotz &&
-	test "$( cd testrepo && git show-ref | wc -l )" = 1
+	test 1 = $(cd testrepo && git show-ref | wc -l)
 '
 
 test_expect_success 'push with colon-less refspec (4)' '
@@ -239,7 +239,7 @@ test_expect_success 'push with colon-less refspec (4)' '
 	git tag -f frotz &&
 	git push testrepo frotz &&
 	check_push_result $the_commit tags/frotz &&
-	test "$( cd testrepo && git show-ref | wc -l )" = 1
+	test 1 = $(cd testrepo && git show-ref | wc -l)
 
 '
 
