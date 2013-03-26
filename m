From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v4 2/5] commit.c/GPG signature verification: Also look at
 the first GPG status line
Date: Tue, 26 Mar 2013 12:05:42 +0100
Message-ID: <51518106.6060804@physik.tu-berlin.de>
References: <7vli9bue40.fsf@alter.siamese.dyndns.org> <cover.1364295502.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 12:06:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKRhv-00020a-NC
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 12:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308Ab3CZLFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Mar 2013 07:05:46 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:8736 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753630Ab3CZLFp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 07:05:45 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-2) with esmtp 
	id 1UKRhI-00040w-He; Tue, 26 Mar 2013 12:05:44 +0100
Received: from [192.168.0.100] (cable-124-189.zeelandnet.nl [82.176.124.189])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 14CDC11406;
	Tue, 26 Mar 2013 12:05:44 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <cover.1364295502.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219153>

Signed-off-by: Sebastian G=C3=B6tte <jaseg@physik-pool.tu-berlin.de>
---
 commit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 1aeb17a..533727c 100644
--- a/commit.c
+++ b/commit.c
@@ -1027,8 +1027,8 @@ static struct {
 	char result;
 	const char *check;
 } signature_check[] =3D {
-	{ 'G', "\n[GNUPG:] GOODSIG " },
-	{ 'B', "\n[GNUPG:] BADSIG " },
+	{ 'G', "[GNUPG:] GOODSIG " },
+	{ 'B', "[GNUPG:] BADSIG " },
 };
=20
 static void parse_signature_lines(struct signature *sig)
@@ -1041,6 +1041,9 @@ static void parse_signature_lines(struct signatur=
e *sig)
 		const char *next;
 		if (!found)
 			continue;
+		if (found !=3D buf)=20
+			if (found[-1] !=3D '\n')
+				continue;
 		sig->check_result =3D signature_check[i].result;
 		found +=3D strlen(signature_check[i].check);
 		sig->key =3D xmemdupz(found, 16);
--=20
1.8.1.5
