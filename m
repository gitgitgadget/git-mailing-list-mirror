From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix parallel make problem
Date: Thu, 30 Aug 2007 19:02:26 -0700
Message-ID: <7vmyw85uml.fsf@gitster.siamese.dyndns.org>
References: <20070830063810.GD16312@mellanox.co.il>
	<7v7inda5ar.fsf@gitster.siamese.dyndns.org>
	<20070830072748.GF16312@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Aug 31 04:02:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQvqU-0006wG-9i
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 04:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbXHaCCq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 22:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbXHaCCq
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 22:02:46 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:57628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbXHaCCq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 22:02:46 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E3224128CEC;
	Thu, 30 Aug 2007 22:03:04 -0400 (EDT)
In-Reply-To: <20070830072748.GF16312@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 30 Aug 2007 10:27:48 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57103>

How about this as a replacement?  I notice that after a
successful build all the test-*.o files are removed by make, and
somehow make seems to believe it is Ok not to recreate them.

---
 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 4eb4637..51af531 100644
--- a/Makefile
+++ b/Makefile
@@ -969,6 +969,8 @@ test-date$X: date.o ctype.o
 
 test-delta$X: diff-delta.o patch-delta.o
 
+.PRECIOUS: $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
+
 test-%$X: test-%.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
Warning: 1 path touched but unmodified. Consider running git-status.
