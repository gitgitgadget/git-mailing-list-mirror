From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 1/2] refs.c: change do_one_ref to not discard any of base
Date: Wed, 25 Apr 2007 23:25:10 +0100
Message-ID: <20070425225021.15383.87006.julian@quantumfyre.co.uk>
References: <200704252004.45112.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
	<200704252142.33756.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
Cc: Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 00:51:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgqKk-0004CW-Q6
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 00:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423398AbXDYWvb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 18:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423400AbXDYWva
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 18:51:30 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:42114 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423398AbXDYWv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2007 18:51:29 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id E85BDC6447
	for <git@vger.kernel.org>; Wed, 25 Apr 2007 23:51:27 +0100 (BST)
Received: (qmail 16207 invoked by uid 103); 25 Apr 2007 23:50:26 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90.2/3159. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.025536 secs); 25 Apr 2007 22:50:26 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 25 Apr 2007 23:50:25 +0100
X-git-sha1: c0efe33e5fa1b40ad470b4f68548131e59915f0b 
X-Mailer: git-mail-commits v0.1
In-Reply-To: <Pine.LNX.4.64.0704252332170.18446@beast.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45589>

do_one_ref only compared trim characters of base with the actual ref
name, which basically meant that passing in more than trim characters
in base was pointless.  So use prefixcmp instead, so that all of base
is compared.

This allows for_each_ref to trim only part of the string provided as
base (for example).

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 89876bf..a771975 100644
--- a/refs.c
+++ b/refs.c
@@ -467,7 +467,7 @@ int read_ref(const char *ref, unsigned char *sha1)
 static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		      void *cb_data, struct ref_list *entry)
 {
-	if (strncmp(base, entry->name, trim))
+	if (prefixcmp(entry->name, base))
 		return 0;
 	if (is_null_sha1(entry->sha1))
 		return 0;
-- 
1.5.1.2
