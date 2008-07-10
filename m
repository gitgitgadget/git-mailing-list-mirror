From: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>
Subject: [PATCH] git-mailinfo: Fix getting the subject from the body
Date: Thu, 10 Jul 2008 23:41:33 +0200
Message-ID: <4876820D.4070806@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?THVrYXMgU2FuZHN0csO2bQ==?= <lukass@etek.chalmers.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 23:42:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH3uM-0001UW-Eo
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 23:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbYGJVlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2008 17:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYGJVlf
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 17:41:35 -0400
Received: from atum.ita.chalmers.se ([129.16.4.148]:59664 "EHLO
	atum.ita.chalmers.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbYGJVlf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 17:41:35 -0400
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	(Authenticated sender: lukass)
	by atum.ita.chalmers.se (Postfix) with ESMTP id CA88F11C6C;
	Thu, 10 Jul 2008 23:41:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.14) Gecko/20080504 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88014>

"Subject: " isn't in the static array "header", and thus
memcmp("Subject: ", header[i], 7) will never match.

Signed-off-by: Lukas Sandstr=C3=B6m <lukass@etek.chalmers.se>
---

This has been broken since 2007-03-12, with commit
87ab799234639c26ea10de74782fa511cb3ca606
so it might not be very important.

 builtin-mailinfo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 962aa34..2d1520f 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -334,7 +334,7 @@ static int check_header(char *line, unsigned linesi=
ze, char **hdr_data, int over
 		return 1;
 	if (!memcmp("[PATCH]", line, 7) && isspace(line[7])) {
 		for (i =3D 0; header[i]; i++) {
-			if (!memcmp("Subject: ", header[i], 9)) {
+			if (!memcmp("Subject", header[i], 7)) {
 				if (! handle_header(line, hdr_data[i], 0)) {
 					return 1;
 				}
--=20
1.5.4.5
