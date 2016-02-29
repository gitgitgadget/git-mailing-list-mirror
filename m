From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v4 6/7] remote: read $GIT_DIR/branches/* with strbuf_getline()
Date: Mon, 29 Feb 2016 09:36:30 +0100
Message-ID: <56D4030E.4030301@moritzneeb.de>
References: <56D401C2.8020100@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 09:38:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaJLh-0003pn-Me
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 09:38:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbcB2Ii2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 03:38:28 -0500
Received: from moritzneeb.de ([78.47.1.106]:39558 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752574AbcB2IiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 03:38:24 -0500
Received: from [192.168.1.3] (x4db4d1fb.dyn.telefonica.de [77.180.209.251])
	by moritzneeb.de (Postfix) with ESMTPSA id 4DFB31C045;
	Mon, 29 Feb 2016 09:38:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456735103;
	bh=1qHiJpLUsMYTe4pm5fVt+EBTrl9Qptkwh6NlvvYw5r0=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=d42AUQFVwFHhb+Celi9YNJ148Twgv7+evOhliY8qE18ZnVL0ny3ILqRemIc7hFGDX
	 PhUAUCgjWZfQ9/0GGwlPABHdO7fWkWReCg0QEDiCaxfHDWYysg1cW5Gi5soXgg07u4
	 l/A5pNF/gdLJuqwFhEz2fyW8gz1sZw7z18xrzo/s=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D401C2.8020100@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287809>

The line read from the branch file is directly trimmed after reading with
strbuf_trim(). There is thus no logic expecting CR, so strbuf_getline_lf()
can be replaced by its CRLF counterpart.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index fc02698..77e011a 100644
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
