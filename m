From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set TAR in t/Makefile and in t4116-apply-reverse.sh
Date: Fri, 25 Jul 2008 11:18:52 -0700
Message-ID: <7vvdytsu7n.fsf@gitster.siamese.dyndns.org>
References: <TE3N1FoSy-vEEv0qsAyvBwBMMq2RuJCWYw7DNLBC7mEh6PxM1LCsOw@cipher.nrlssc.navy.mil> <1217003860-10609-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 25 20:20:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMRtY-00067p-OO
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 20:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbYGYSTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 14:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbYGYSTA
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 14:19:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbYGYSS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 14:18:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E4B813BA35;
	Fri, 25 Jul 2008 14:18:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7940E3BA34; Fri, 25 Jul 2008 14:18:54 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 267BD704-5A76-11DD-9E03-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90082>

Actually, 455a7f3 (More portability., 2005-09-30) introduced $TAR and it
is also used in t5000.  cb34882 (fix t5000-tar-tree.sh when $TAR isn't
set, 2005-11-08) did the same fix you are adding, but I think both of
these fixes are in a wrong place.

I think we should do this instead.  That's how SHELL_PATH is passed around
from build to all the test scripts already.

---
 Makefile            |    1 +
 t/t5000-tar-tree.sh |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index b003e3e..1d14209 100644
--- a/Makefile
+++ b/Makefile
@@ -1212,6 +1212,7 @@ GIT-CFLAGS: .FORCE-GIT-CFLAGS
 
 GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo SHELL_PATH=\''$(SHELL_PATH_SQ)'\' >$@
+	@echo TAR=\''$(subst ','\'',$(TAR))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 9b0baac..5eb119e 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -25,7 +25,6 @@ commit id embedding:
 '
 
 . ./test-lib.sh
-TAR=${TAR:-tar}
 UNZIP=${UNZIP:-unzip}
 
 SUBSTFORMAT=%H%n
