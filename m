From: mhagger@alum.mit.edu
Subject: [RFC 2/3] Delete reflogs for dead references to allow pruning
Date: Sat, 18 Aug 2012 19:14:45 +0200
Message-ID: <1345310086-20089-3-git-send-email-mhagger@alum.mit.edu>
References: <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 18 19:23:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2mjt-0007UQ-FX
	for gcvg-git-2@plane.gmane.org; Sat, 18 Aug 2012 19:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744Ab2HRRWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 13:22:51 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:51670 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752566Ab2HRRWa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Aug 2012 13:22:30 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Aug 2012 13:22:29 EDT
X-AuditID: 12074412-b7f216d0000008e3-de-502fcd9b5561
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 76.0B.02275.B9DCF205; Sat, 18 Aug 2012 13:15:07 -0400 (EDT)
Received: from michael.fritz.box (p57A25507.dip.t-dialin.net [87.162.85.7])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7IHEnrT001968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 18 Aug 2012 13:15:05 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsUixO6iqDv7rH6AQd8GHouFff3MFl1Xupks
	GnqvMFtMuN/AbHF7xXxmix8tPcwWK3ctZHJg9/j7/gOTx85Zd9k9nvXuYfS4eEnZY+6nRawe
	nzfJBbBFcdskJZaUBWem5+nbJXBnLF3bzlpwma3i67NVbA2MW1m7GDk5JARMJKatnskOYYtJ
	XLi3nq2LkYtDSOAyo8Tp1odQzmkmiUVft7KAVLEJSEm8bOwB6xARkJX4fngjI0gRs8BEJold
	O+cwgySEBdwkTl0/AWazCKhKPG6dBtbAK+Ai0dx0jg1inaLEj+9rwGo4BVwlXt3dCmYLAdVM
	O/GeeQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsYIUEntINx/Um5
	Q4wCHIxKPLwKa/QChFgTy4orcw8xSnIwKYnyvj+jHyDEl5SfUpmRWJwRX1Sak1p8iFGCg1lJ
	hFf3BFA5b0piZVVqUT5MSpqDRUmc9+didT8hgfTEktTs1NSC1CKYrAwHh5IE7w6QoYJFqemp
	FWmZOSUIaSYOThDBBbKBB2jDSZBC3uKCxNzizHSIolOMilLivAtBEgIgiYzSPLgBsPTwilEc
	6B9h3usgVTzA1ALX/QpoMBPQ4JUiuiCDSxIRUlINjCuOf73CIW4jrLfXI8o95ifzVI0LGxU+
	s2+dvuaz4YxZl3UtWLfMqfrPbLKm/912pVXWnCyyt9SC7FL7vt8w+Nkapu29xouLWecau9gL
	j+kvnx7W2W4e3HXnif8K0XdSaWJhjyfzbQ/ZdeT7puYHf65VVx7w/j13ruvSqpUy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203680>

From: Michael Haggerty <mhagger@alum.mit.edu>

This test is broken by "retain reflogs for deleted refs".  Explicitly
delete the reflogs in the graveyard to allow the corresponding commits
to be pruned.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Probably there should be a "git reflog" subcommand to do this.

 t/t9300-fast-import.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 266ae30..dc6c67d 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1700,6 +1700,7 @@ INPUT_END
 
 test_expect_success 'P: verbatim SHA gitlinks' '
 	git branch -D sub &&
+	rm -rf .git/logs/graveyard &&
 	git gc && git prune &&
 	git fast-import <input &&
 	test $(git rev-parse --verify subuse2) = $(git rev-parse --verify subuse1)
-- 
1.7.11.3
