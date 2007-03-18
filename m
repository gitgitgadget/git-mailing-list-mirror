From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH] git-symbolic-ref: fix error message when ref doesn't exist
Date: Sun, 18 Mar 2007 01:53:02 +0000
Message-ID: <20070318020645.2444.75365.julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 03:19:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSkzT-0000Cv-7f
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 03:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbXCRCTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 22:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbXCRCTG
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 22:19:06 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:47300 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752905AbXCRCTF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2007 22:19:05 -0400
X-Greylist: delayed 647 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Mar 2007 22:19:05 EDT
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 23C4FC64F1
	for <git@vger.kernel.org>; Sun, 18 Mar 2007 02:08:14 +0000 (GMT)
Received: (qmail 17364 invoked by uid 103); 18 Mar 2007 02:08:14 +0000
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/2853. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.024275 secs); 18 Mar 2007 02:08:14 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 18 Mar 2007 02:08:14 +0000
X-git-sha1: 870955f3faa104ddd7255167b2a7c54ce4f3f6c7 
X-Mailer: git-mail-commits v0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42469>

When calling resolve_ref from check_symref set reading to 1, since we
do want to know if the given ref doesn't exist.  This means that
"git symbolic-ref foo" will now print "fatal: No such ref: foo" as
expected.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---

While looking at how fetch worked, I noticed that symbolic-ref was
supposed to differentiate between non-existent refs and non-symbolic refs.
Something I hadn't noticed it doing on those occasions when my fingers
had failed me ...

I also noticed that the man page says that symbolic-ref will return 1 when
the specified reference is non-symbolic.  This is only true when using -q,
but I don't know if the code or man page wants changing ...

 builtin-symbolic-ref.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index d41b406..a93c85d 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -9,7 +9,7 @@ static void check_symref(const char *HEAD, int quiet)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *refs_heads_master = resolve_ref(HEAD, sha1, 0, &flag);
+	const char *refs_heads_master = resolve_ref(HEAD, sha1, 1, &flag);
 
 	if (!refs_heads_master)
 		die("No such ref: %s", HEAD);
-- 
1.5.0.4
