From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/33] do_for_each_ref_in_dirs(): remove dead code
Date: Sun, 14 Apr 2013 14:54:21 +0200
Message-ID: <1365944088-10588-7-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMU7-0005OY-Ou
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab3DNMzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:33 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:60506 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751869Ab3DNMzZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:25 -0400
X-AuditID: 12074414-b7fb86d000000905-03-516aa73d27e8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E4.A8.02309.D37AA615; Sun, 14 Apr 2013 08:55:25 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAk3007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:24 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqGu7PCvQYNk/MYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M7oWXqStWA1a8Wv6ctYGxjbWLoYOTkkBEwkbk7bzgphi0lcuLeerYuRi0NI4DKjxMed
	31ggnLNMEp9/r2IGqWIT0JVY1NPM1MXIwSEikC2xe608SJhZwEFi8+dGRhBbWMBJ4sGE1+wg
	NouAqsTNw7/BFvAKuEgcnHWHHWKZgsTx7dvA6jkFXCWmPz8GFhcCqpm1eTbrBEbeBYwMqxjl
	EnNKc3VzEzNzilOTdYuTE/PyUot0LfRyM0v0UlNKNzFCQkpkB+ORk3KHGAU4GJV4eB1YsgKF
	WBPLiitzDzFKcjApifIqLgMK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuF1bAXK8aYkVlalFuXD
	pKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8GqADBUsSk1PrUjLzClBSDNxcIIILpAN
	PEAb3i4F2VBckJhbnJkOUXSKUVFKnPcjSEIAJJFRmgc3ABb9rxjFgf4R5n0KUsUDTBxw3a+A
	BjMBDfbZmw4yuCQRISXVwKhvs5BRgrczWPPk2ySxy28bgt7fu9syoVpx+93d9jtkG3USTwp1
	3r3T5rv5N6/lnXqBtIlfJopynjz2Kkxi2vae6dWdq5Q8Z4o/D6pjmuPY4tvMvbv74UEpw4U9
	vw46bj4xx+jbAeE7nvpN63v+HdXtm/PgyfEmnSUWvUdd7vdf3F/zbJ7ZVF0lluKM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221124>

There is no way to drop out of the while loop.  This code has been
dead since 432ad41e.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/refs.c b/refs.c
index 7cbf228..9f508dd 100644
--- a/refs.c
+++ b/refs.c
@@ -666,13 +666,6 @@ static int do_for_each_ref_in_dirs(struct ref_dir *dir1,
 		if (retval)
 			return retval;
 	}
-	if (i1 < dir1->nr)
-		return do_for_each_ref_in_dir(dir1, i1,
-					      base, fn, trim, flags, cb_data);
-	if (i2 < dir2->nr)
-		return do_for_each_ref_in_dir(dir2, i2,
-					      base, fn, trim, flags, cb_data);
-	return 0;
 }
 
 /*
-- 
1.8.2.1
