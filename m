From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/6] send-email: fix suppress-cc=self on cccmd
Date: Thu, 30 May 2013 10:11:15 +0300
Message-ID: <1369897638-27299-3-git-send-email-mst@redhat.com>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 09:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhx0j-000399-Vn
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 09:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967761Ab3E3HKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 03:10:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5107 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967670Ab3E3HKt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 03:10:49 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4U7AlYG026896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 30 May 2013 03:10:47 -0400
Received: from redhat.com (vpn-203-5.tlv.redhat.com [10.35.203.5])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4U7Aj5b017209;
	Thu, 30 May 2013 03:10:45 -0400
Content-Disposition: inline
In-Reply-To: <1369897638-27299-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225939>

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
