From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 01/11] builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()
Date: Mon, 03 Mar 2014 11:19:36 +0400
Message-ID: <53142D08.4060108@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:20:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNAj-0000BT-2k
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753700AbaCCHUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:20:14 -0500
Received: from forward14.mail.yandex.net ([95.108.130.92]:32995 "EHLO
	forward14.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbaCCHUN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:20:13 -0500
Received: from smtp12.mail.yandex.net (smtp12.mail.yandex.net [95.108.131.191])
	by forward14.mail.yandex.net (Yandex) with ESMTP id 89B811980938
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:20:11 +0400 (MSK)
Received: from smtp12.mail.yandex.net (localhost [127.0.0.1])
	by smtp12.mail.yandex.net (Yandex) with ESMTP id 64D1516A00DE
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:20:11 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp12.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id pBNo8uvcRl-KASeJPV8;
	Mon,  3 Mar 2014 11:20:10 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 8519029f-4d98-4627-8b8b-525dcffdc833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831211;
	bh=nvlmi2Af0B7EXnODjIc2jUQRm9WsGD/VR+fSLAieHgI=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=fEesl9J/R5dSj7/XUAx0PPt739EkGxL2nn0T6TAPtPAkfKYuigPvKBCECMEpwusyr
	 +f7TsRuPuPqk8Ru0APJSeQGr/dlP5vX7xJ35YDskphLos9V+WpMQd+Ke8Ij40t4xit
	 ITe/z58H5GXpQMHHL7YWc+yqTj7XiLnnqbjaX7WQ=
Authentication-Results: smtp12.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243180>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 builtin/pack-objects.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..0ffad6f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1213,12 +1213,9 @@ static int check_pbase_path(unsigned hash)
 	if (0 <= pos)
 		return 1;
 	pos = -pos - 1;
-	if (done_pbase_paths_alloc <= done_pbase_paths_num) {
-		done_pbase_paths_alloc = alloc_nr(done_pbase_paths_alloc);
-		done_pbase_paths = xrealloc(done_pbase_paths,
-					    done_pbase_paths_alloc *
-					    sizeof(unsigned));
-	}
+	ALLOC_GROW(done_pbase_paths,
+		   done_pbase_paths_num + 1,
+		   done_pbase_paths_alloc);
 	done_pbase_paths_num++;
 	if (pos < done_pbase_paths_num)
 		memmove(done_pbase_paths + pos + 1,
-- 
1.8.5.3
