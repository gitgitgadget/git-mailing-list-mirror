From: Amos Waterland <apw@us.ibm.com>
Subject: Re: [PATCH] Do not ignore errors during make check
Date: Wed, 14 Dec 2005 16:44:24 -0500
Message-ID: <20051214214424.GA3730@kvasir.watson.ibm.com>
References: <20051214210932.GA2642@kvasir.watson.ibm.com> <7v1x0fxt7b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 22:45:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmeQN-0001R1-Dt
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 22:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVLNVoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 16:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbVLNVoc
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 16:44:32 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:50647 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932335AbVLNVoc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 16:44:32 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id jBELiV4c025242
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 16:44:31 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id jBELkBGC106686
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 14:46:11 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id jBELiU0M006490
	for <git@vger.kernel.org>; Wed, 14 Dec 2005 14:44:30 -0700
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id jBELiUh9006237;
	Wed, 14 Dec 2005 14:44:30 -0700
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1EmeQC-000108-Fw; Wed, 14 Dec 2005 16:44:24 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1x0fxt7b.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13647>

On Wed, Dec 14, 2005 at 01:30:16PM -0800, Junio C Hamano wrote:
> Good point but "|| exit" would be more appropriate.  With the
> above patch, I suspect "make check" merely stops at the first
> error but resulting return code would still be zero, wouldn't
> it?

Yes, here is a patch that uses exit instead of break.

---

Do not let errors pass by unnoticed when running `make check'.

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

bc721e2d99487c0240514a848ac1cb84c086e008
diff --git a/Makefile b/Makefile
index 01b6643..d494ad4 100644
--- a/Makefile
+++ b/Makefile
@@ -449,7 +449,7 @@ test-delta$X: test-delta.c diff-delta.o 
 	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $^
 
 check:
-	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i; done
+	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
 
 
 
-- 
0.99.9.GIT
