From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 09/26] parse_cmd_verify(): Copy old_sha1 instead of evaluating <oldvalue> twice
Date: Mon, 10 Mar 2014 13:46:26 +0100
Message-ID: <1394455603-2968-10-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:48:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzd6-0000CV-B5
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbaCJMrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:14 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57594 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524AbaCJMrI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:08 -0400
X-AuditID: 1207440d-f79d86d0000043db-46-531db44a8557
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D8.47.17371.A44BD135; Mon, 10 Mar 2014 08:47:06 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwX025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:05 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqOu1RTbYYNFuY4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8b9J4sYC6ayVSyd28HawDidtYuRk0NCwERi8vHZ
	LBC2mMSFe+vZuhi5OIQELjNKtG06zgaSEBI4wSSxpY8RxGYT0JVY1NPMBGKLCKhJTGw7xALS
	wCxwhVHi89df7CAJYYF4iVXP+8BsFgFVicmXfwAN4uDgFXCRePBABWKZnMSU3wvASjiBwtOv
	PGCH2OUs8XJPM+sERt4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3SN9HIzS/RSU0o3MUIC
	j3cH4/91MocYBTgYlXh4D7yVCRZiTSwrrsw9xCjJwaQkyjtxrWywEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRHezMVAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBK/v
	ZqBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBkxBcDYwMkxQO01wGknbe4IDEX
	KArReopRUUqcdw5IQgAkkVGaBzcWlk5eMYoDfSnM6wJSxQNMRXDdr4AGMwENbj4uBTK4JBEh
	JdXAOH9DQVCUg8D+rp29vw5cnzLN8sntJy9/Far9va0Tv1fqUkOwxoGvl/rqHBepZp4oShNx
	kizLm+calKm+cHroMfNbd1/ruMkZTktks9wTlLS9SexVx4PJp/2DtnD95CvlPsUh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243751>

Aside from avoiding work, this makes it transparently obvious that
old_sha1 and new_sha1 are identical.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 5f197fe..51adf2d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -249,7 +249,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 
 	if (!parse_next_arg(input, &next, &value)) {
 		update_store_old_sha1(update, value.buf);
-		update_store_new_sha1(update, value.buf);
+		hashcpy(update->new_sha1, update->old_sha1);
 	} else if (!line_termination)
 		die("verify %s missing [<oldvalue>] NUL", ref.buf);
 
-- 
1.9.0
