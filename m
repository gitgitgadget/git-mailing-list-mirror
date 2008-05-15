From: Jeff King <peff@peff.net>
Subject: Re: git clone broken in next
Date: Thu, 15 May 2008 00:44:02 -0400
Message-ID: <20080515044402.GA3517@sigill.intra.peff.net>
References: <BB5BF79E-ECAE-4F63-AFF1-8C13F23D3D10@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu May 15 06:45:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwVKt-0003Rr-Fp
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 06:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbYEOEoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 00:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbYEOEoJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 00:44:09 -0400
Received: from peff.net ([208.65.91.99]:4623 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbYEOEoH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 00:44:07 -0400
Received: (qmail 31659 invoked by uid 111); 15 May 2008 04:44:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 May 2008 00:44:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 May 2008 00:44:02 -0400
Content-Disposition: inline
In-Reply-To: <BB5BF79E-ECAE-4F63-AFF1-8C13F23D3D10@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82178>

On Wed, May 14, 2008 at 11:54:39PM -0400, Kevin Ballard wrote:

> Something's horribly wrong in next. I just installed the latest from next 
> and then ran
>
>   git clone git://github.com/kballard/github-gem.git
>
> The resulting repo had absolutely nothing in the workdir. `git status`  
> claims every single file is deleted but not updated. `git checkout -f  
> HEAD` fixed the workdir.

Hmm, builtin-clone does seem to be completely broken. It looks like
unpack_trees is not doing its job for some reason, but I haven't looked
further. But it surprised me that we aren't testing anything as simple
as "clone works". The test below currently fails (though I am getting
other test failures which are presumably related).

---
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index dc9d63d..593d1a3 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -23,4 +23,11 @@ test_expect_success 'clone with excess parameters' '
 
 '
 
+test_expect_success 'clone checks out files' '
+
+	git clone src dst &&
+	test -f dst/file
+
+'
+
 test_done
