From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v2 5/6] remote: read $GIT_DIR/branches/* with strbuf_getline()
Date: Mon, 22 Feb 2016 02:22:27 +0100
Message-ID: <56CA62D3.7060808@moritzneeb.de>
References: <56CA5DBB.8040006@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 02:24:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXfEL-00062t-3D
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 02:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbcBVBX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 20:23:58 -0500
Received: from moritzneeb.de ([78.47.1.106]:55745 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587AbcBVBXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 20:23:55 -0500
Received: from [192.168.1.3] (x55b377aa.dyn.telefonica.de [85.179.119.170])
	by moritzneeb.de (Postfix) with ESMTPSA id 445BA1C0F6;
	Mon, 22 Feb 2016 02:23:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456104234;
	bh=Zgkqi3KfT237PaMkORsV5+SI4nj0DDberz101GjUiG4=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=v5wGcWzq1tt40hp62DDEznYsS1TXLRo2g6sz/FlTHlxkMRuBZSeIConf8+hPUBHP/
	 ye3mlKgyhw177XtigulG/c4FsRS7LqLBVQepqP6zFvka5nK7m0aoj+OYA6rk5mSqbH
	 5pZqVw4k0I72NSPK8afZblkKXe1UaySJp/GLTlF8=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56CA5DBB.8040006@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286862>

The line read from the branch file is directly trimmed after reading with
strbuf_trim(). There is thus no logic expecting CR, so strbuf_getline_lf()
can be replaced by its CRLF counterpart.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
To be honest, I did not yet fully understand the purpose of this branches/ file.
What I'd expect is that it is some intermediary file while fetching?
Or is it edited directly by the user and thus it's necessary to strip spaces
that could be added accidentally?

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
2.7.1.345.gc14003e
