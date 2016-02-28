From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v3 6/7] remote: read $GIT_DIR/branches/* with strbuf_getline()
Date: Sun, 28 Feb 2016 06:14:07 +0100
Message-ID: <56D2821F.4010806@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 06:15:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZthn-00036z-VO
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 06:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbcB1FPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 00:15:40 -0500
Received: from moritzneeb.de ([78.47.1.106]:37009 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbcB1FPf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 00:15:35 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id 2A4E71C002;
	Sun, 28 Feb 2016 06:15:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456636534;
	bh=240Kf4iHQT8w1sHsRkxcej4YL0sBOUQZemZuylqNepw=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=j5qooLLfpVkK7VXpHVKRdthpMs/hC5AK58u//lM/lLzarMj7jZG6qMuz9uG9pGlke
	 +yxfIoptnWExYDbA8CicGOuED1F4//fV/gi9kUBoYI+cgUY4zE3ggf54SBAg3d2MhS
	 cuBKG+AAoglCChj6QEzrVSHjE151Goxba06T9AMY=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D28092.9090209@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287743>

The line read from the branch file is directly trimmed after reading with
strbuf_trim(). There is thus no logic expecting CR, so strbuf_getline_lf()
can be replaced by its CRLF counterpart.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 02e698a..aaff6aa 100644
--- a/remote.c
+++ b/remote.c
@@ -281,7 +281,7 @@ static void read_branches_file(struct remote *remote)
 	if (!f)
 		return;
 
-	strbuf_getline_lf(&buf, f);
+	strbuf_getline(&buf, f);
 	fclose(f);
 	strbuf_trim(&buf);
 	if (!buf.len) {
-- 
2.4.3
