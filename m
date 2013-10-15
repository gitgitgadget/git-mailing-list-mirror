From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] http.c: Spell the null pointer as NULL
Date: Tue, 15 Oct 2013 22:55:02 +0100
Message-ID: <525DB9B6.8040701@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 23:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWCa9-0006Fe-Rn
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 23:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759846Ab3JOVzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 17:55:08 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:56444 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759828Ab3JOVzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 17:55:07 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id A43C7A0C08B;
	Tue, 15 Oct 2013 22:55:05 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 6D8B8A0C085;
	Tue, 15 Oct 2013 22:55:05 +0100 (BST)
Received: from [192.168.254.9] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Tue, 15 Oct 2013 22:55:04 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236201>


Commit 1bbcc224 ("http: refactor options to http_get_*", 28-09-2013)
changed the type of final 'options' argument of the http_get_file()
function from an int to an 'struct http_get_options' pointer.
However, it neglected to update the (single) call site. Since this
call was passing '0' to that argument, it was (correctly) being
interpreted as a null pointer. Change to argument to NULL.

Noticed by sparse. ("Using plain integer as NULL pointer")

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jonathan, Junio,

I'm a little puzzled by not having noticed this until this evening! ;-)
Also, I note that maint@kernel.org != maint@repo.or.cz/jrn

ATB,
Ramsay Jones

 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 96d7578..b133ffd 100644
--- a/http.c
+++ b/http.c
@@ -1045,7 +1045,7 @@ static char *fetch_pack_index(unsigned char *sha1, const char *base_url)
 	strbuf_addf(&buf, "%s.temp", sha1_pack_index_name(sha1));
 	tmp = strbuf_detach(&buf, NULL);
 
-	if (http_get_file(url, tmp, 0) != HTTP_OK) {
+	if (http_get_file(url, tmp, NULL) != HTTP_OK) {
 		error("Unable to get pack index %s", url);
 		free(tmp);
 		tmp = NULL;
-- 
1.8.4
