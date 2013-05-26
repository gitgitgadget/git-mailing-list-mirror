From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/6] send-email: fix suppress-cc=self on cccmd
Date: Sun, 26 May 2013 17:40:59 +0300
Message-ID: <1369579187-27573-3-git-send-email-mst@redhat.com>
References: <1369579187-27573-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 16:40:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugc7m-0000e9-Bn
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 16:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742Ab3EZOkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 10:40:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43855 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295Ab3EZOkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 10:40:36 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4QEeaXL031285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:36 -0400
Received: from redhat.com (vpn-202-184.tlv.redhat.com [10.35.202.184])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id r4QEeYPY008722
	for <git@vger.kernel.org>; Sun, 26 May 2013 10:40:35 -0400
Content-Disposition: inline
In-Reply-To: <1369579187-27573-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225546>

When cccmd is used, old-style suppress-from filter
is applied by the newer suppress-cc=self isn't.
Fix this up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index bd13cc8..a138615 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1462,7 +1462,7 @@ sub recipients_cmd {
 		$address =~ s/^\s*//g;
 		$address =~ s/\s*$//g;
 		$address = sanitize_address($address);
-		next if ($address eq $sanitized_sender and $suppress_from);
+		next if ($address eq $sender and $suppress_cc{'self'});
 		push @addresses, $address;
 		printf("($prefix) Adding %s: %s from: '%s'\n",
 		       $what, $address, $cmd) unless $quiet;
-- 
MST
