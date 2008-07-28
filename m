From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] Makefile: Do not install a copy of 'git' in
 $(gitexecdir)
Date: Sun, 27 Jul 2008 23:39:50 -0700
Message-ID: <7v63qqv7ex.fsf@gitster.siamese.dyndns.org>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
 <488D104F.8080005@gmail.com> <7vabg2v83o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 28 08:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNMPo-0003kf-Bk
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbYG1GkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 02:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYG1GkD
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:40:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbYG1GkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 02:40:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D14683F547;
	Mon, 28 Jul 2008 02:39:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B0C253F546; Mon, 28 Jul 2008 02:39:52 -0400 (EDT)
In-Reply-To: <7vabg2v83o.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 27 Jul 2008 23:24:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FEE41E30-5C6F-11DD-9E1C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90420>

Junio C Hamano <gitster@pobox.com> writes:

>> This new action needs to be in a conditional to keep it from removing
>> the ONLY git executable when bindir and execdir are the same dir.
>
> Heh, I love bug reports that come immediately after I tag the tip of
> 'master' as -rc1.

This should do, but to be very honest, I really hate the output from the
foreach that precedes this section.

 Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 798a2f2..92df61c 100644
--- a/Makefile
+++ b/Makefile
@@ -1362,7 +1362,10 @@ endif
 		cp "$$bindir/git$X" "$$execdir/git$X"; \
 	fi && \
 	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git$X" "$$execdir/$p" ;) } && \
-	$(RM) "$$execdir/git$X" && \
+	if test "z$$bindir" != "z$$execdir"; \
+	then \
+		$(RM) "$$execdir/git$X"; \
+	fi && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-doc:
