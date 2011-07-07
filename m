From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] test overlapping ignore patterns
Date: Thu, 7 Jul 2011 11:12:52 -0700 (PDT)
Message-ID: <1310062372893-6559395.post@n2.nabble.com>
References: <21043430.post@talk.nabble.com> <alpine.LFD.2.00.0812161450010.14014@localhost.localdomain> <7viqpjra57.fsf@gitster.siamese.dyndns.org> <1229620278-25152-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 20:13:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qet4N-0003EG-EC
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 20:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab1GGSMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 14:12:54 -0400
Received: from sam.nabble.com ([216.139.236.26]:52868 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752850Ab1GGSMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 14:12:53 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <stephen@exigencecorp.com>)
	id 1Qet4G-0008Dg-Tc
	for git@vger.kernel.org; Thu, 07 Jul 2011 11:12:52 -0700
In-Reply-To: <1229620278-25152-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176765>


> Add a test which checks that negated patterns such as "!foo.html" can 
> override previous patterns such as "*.html". This is documented 
> behaviour but had not been tested so far. 

Negated excludes with a pattern does not seem to work with sub directories,
e.g. the following test fails for me.

The file /one/two/a.1 exists, and is initially excluded by *, but not
re-included by "!*.1" (where as /a.1 is re-included).

diff --git i/t/t3001-ls-files-others-exclude.sh
w/t/t3001-ls-files-others-exclude.sh
index c8fe978..e6c86ff 100755
--- i/t/t3001-ls-files-others-exclude.sh
+++ w/t/t3001-ls-files-others-exclude.sh
@@ -175,6 +175,12 @@ test_expect_success 'negated exclude matches can
override previous ones' '
  grep "^a.1" output
 '
 
+test_expect_success 'negated exclude matches can override previous ones 2'
'
+
+ git ls-files --others --exclude="*" --exclude="!*.1" >output &&
+ grep "^one/two/a.1" output
+'
+

(Replying to this old thread via nabble; hopefully it works.)

- Stephen


--
View this message in context: http://git.661346.n2.nabble.com/git-ignore-tp1665336p6559395.html
Sent from the git mailing list archive at Nabble.com.
