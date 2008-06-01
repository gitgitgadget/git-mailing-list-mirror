From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] test-lib.sh: set PERL5LIB instead of GITPERLLIB
Date: Mon,  2 Jun 2008 00:16:27 +0200
Message-ID: <1212358587-15948-1-git-send-email-LeWiemann@gmail.com>
References: <7vy75oalh7.fsf@gitster.siamese.dyndns.org>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 00:17:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2vrp-0008Rq-Up
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 00:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbYFAWQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 18:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbYFAWQd
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 18:16:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:53091 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbYFAWQd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 18:16:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so588207fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        bh=1nLMF8aBpNxY/DfTg7bRkeQi1FueWyqgNjPI30IPmKs=;
        b=N+Zj+lSg7lWx77HlRG7RqIccqz06lU70Omlwf6+RTV3k3qqDDDsslKrOd6Xxeue9NlXOjBF15HNdnxYSfU5tR7vbmIsGQ6pP4BUsDx2Sdlj7vE10rDQczO25wegq1FJkgS3sOkKovgGq/itSh2t4BLFLL7Kk6B1IX5x9ReKOyNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=ragYLB+qo+p6YJG05KTRUgvDsdU87aHJcNpBe7Yxb5RvQWzDHt+nUkcOrKrcaI6yERdwsPfUzXTFVheXTa6yPdCCyp57vnGpwe0nwmwCmAHipRdJHucmqzcvZSaB7TFkQMBhdqAPTLTVVccrugpBa5dsZthzg+DowqxgoQCVW2w=
Received: by 10.86.77.5 with SMTP id z5mr2005665fga.47.1212358591067;
        Sun, 01 Jun 2008 15:16:31 -0700 (PDT)
Received: from fly ( [91.33.205.25])
        by mx.google.com with ESMTPS id e11sm2812051fga.4.2008.06.01.15.16.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 15:16:30 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2vql-00049m-JQ; Mon, 02 Jun 2008 00:16:27 +0200
X-Mailer: git-send-email 1.5.5.GIT
In-Reply-To: <7vy75oalh7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83473>

By setting PERL5LIB for the tests, we enable Perl test scripts to just
say "use Git;" without adding the GITPERLLIB paths to @INC beforehand.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Junio C Hamano wrote:
> Lea Wiemann <lewiemann@gmail.com> writes:
>> How about [setting PERL5LIB in] test-lib.sh?
> 
> Sure, I think that would be sensible.

Actually, GITPERLLIB becomes redundant in that case, so I've simply
replaced it with PERL5LIB in test-lib.sh.

I've tested the patch: all scripts pick up the right Git.pm, and all
tests still pass.  It also preserves existing PERL5LIB variables
correctly.

Btw, I'm assuming that it's OK to post small patches (like this one)
as replies.  If you or anyone else would prefer independent patches to
always start a new thread, please let me know.

-- Lea

 t/test-lib.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 99b63da..2f86831 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -454,8 +454,9 @@ GIT_CONFIG_NOSYSTEM=1
 GIT_CONFIG_NOGLOBAL=1
 export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
 
-GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
-export GITPERLLIB
+test -n "$PERL5LIB" && PERL5LIB=":$PERL5LIB"
+PERL5LIB="$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git$PERL5LIB"
+export PERL5LIB
 test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
-- 
1.5.5.GIT
