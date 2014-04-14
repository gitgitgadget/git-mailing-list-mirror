From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 12/25] write_packed_entry_fn(): convert cb_data into a (const int *)
Date: Mon, 14 Apr 2014 15:54:42 +0200
Message-ID: <1397483695-10888-13-git-send-email-mhagger@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 15:57:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZhNZ-0002Lx-5c
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 15:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755205AbaDNN4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2014 09:56:54 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49829 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755177AbaDNNz1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 09:55:27 -0400
X-AuditID: 1207440c-f79656d000003eba-e8-534be8cef8a9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 79.47.16058.EC8EB435; Mon, 14 Apr 2014 09:55:26 -0400 (EDT)
Received: from michael.fritz.box (p4FC96FF6.dip0.t-ipconnect.de [79.201.111.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3EDt09C010903
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 14 Apr 2014 09:55:25 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqHvuhXewweW7GhZdV7qZLBp6rzBb
	rPxZY3F7xXxmi1+Hn7Bb/GjpYbY486aR0aKz4yujA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh6L
	H3h5fN4k53H3/04mj9vPtrEEcERx2yQllpQFZ6bn6dslcGe0b/nGXHCNtWL23T7mBsaTLF2M
	HBwSAiYSZ08UdTFyApliEhfurWfrYuTiEBK4zCixbfZcdgjnJJPErNMNbCBVbAK6Eot6mplA
	bBEBNYmJbYdYQIqYBdqZJA7t6GUCmSosEC6xpikfpIZFQFXizNUDzCA2r4CrxN77T5ghtslJ
	nDw2mRWknBMovvBDFkhYSMBF4u6XKawTGHkXMDKsYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI1
	1MvNLNFLTSndxAgJRJ4djN/WyRxiFOBgVOLh7ZjjHSzEmlhWXJl7iFGSg0lJlDfjBlCILyk/
	pTIjsTgjvqg0J7X4EKMEB7OSCK/rVqAcb0piZVVqUT5MSpqDRUmcV3WJup+QQHpiSWp2ampB
	ahFMVoaDQ0mC99tzoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UFzEFwMjAyTF
	A7Q3CaSdt7ggMRcoCtF6ilFRSpy3BCQhAJLIKM2DGwtLL68YxYG+FOa9D1LFA0xNcN2vgAYz
	AQ1maQcbXJKIkJJqYFz6cvbc1tvB/20ONR2S83gVuLL8837llSviIpvXi1xsNliqdCYt4DKj
	7nwX74Vyb+6vi2xXUa7ryN5+4OrSSYVGwjNmcrpu8NSbrsUn69D5v6Jgg4Ce1f4k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246239>

This makes it obvious that we have no plans to change the integer
pointed to, which is actually the fd field from a struct lock_file.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 20c483b..cb2f825 100644
--- a/refs.c
+++ b/refs.c
@@ -2177,7 +2177,7 @@ static void write_packed_entry(int fd, char *refname, unsigned char *sha1,
  */
 static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 {
-	int *fd = cb_data;
+	const int *fd = cb_data;
 	enum peel_status peel_status = peel_entry(entry, 0);
 
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
-- 
1.9.1
