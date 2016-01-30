From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH 4/5] remote: read $GIT_DIR/branches/* with strbuf_getline()
Date: Sat, 30 Jan 2016 19:05:33 +0100
Message-ID: <56ACFB6D.4040804@moritzneeb.de>
References: <56ACF82B.2030005@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 19:06:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPZuo-0007bC-WE
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 19:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933053AbcA3SFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 13:05:43 -0500
Received: from moritzneeb.de ([78.47.1.106]:48373 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932987AbcA3SFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 13:05:36 -0500
Received: from [192.168.1.11] (x4db33e5e.dyn.telefonica.de [77.179.62.94])
	by moritzneeb.de (Postfix) with ESMTPSA id 01E6B1C02A
	for <git@vger.kernel.org>; Sat, 30 Jan 2016 19:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1454177134;
	bh=ORkRHZADzQIRDQsTWzXt5yPySXls410ZWsVi+U/ppao=;
	h=From:Subject:References:To:Date:In-Reply-To:From;
	b=HT/65ro84mh/0KMxsANvM65LlTIPDHQkxKbeMya/p+BBbs7C8j4YZZ72W1h3Kj19V
	 vnsfAM9VTmR4NW9vXT6N3h4tSA3sRkWc4k3e4uV7CHsZaFS2nqW9hQf7RmN2hK9QZ+
	 871MI/Z8vlgggzoVSEXsUG/4p69HdkFB0I+Z2HPw=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56ACF82B.2030005@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285123>

    The line read from the branch file is directly trimmed after
    reading with strbuf_trim(). There is thus no logic expecting CR,
    so strbuf_getline_lf() can be replaced by its CRLF counterpart.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 7d61dab..78f97f0 100644
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
