From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v4 1/7] quote: remove leading space in sq_dequote_step
Date: Mon, 29 Feb 2016 09:36:17 +0100
Message-ID: <56D40301.8020007@moritzneeb.de>
References: <56D401C2.8020100@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 09:38:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaJLa-0003pn-RR
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 09:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbcB2IiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 03:38:23 -0500
Received: from moritzneeb.de ([78.47.1.106]:39555 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbcB2IiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 03:38:22 -0500
Received: from [192.168.1.3] (x4db4d1fb.dyn.telefonica.de [77.180.209.251])
	by moritzneeb.de (Postfix) with ESMTPSA id 855B71C0F7;
	Mon, 29 Feb 2016 09:38:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456735099;
	bh=P/PZmbT7kW7xvA8J1ZJE2iND+z5Weym0xgenzdY8YwA=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=uW3Y/D/9o1yXItyVf0NJhh647qnkDpWKMgDOT6PeRTlGhKQAkgS6MBAnmGGTPewRd
	 T3y4qtIb5LDEa1CK2TbHgVNKEgaPtRhlCxaSR30q0GjoPrd9HAwQgTxNdf5Qf5cQMj
	 MCvwLJwos2eNzb3eHS3S+2ev7m2MiP4++J6fqTRI=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D401C2.8020100@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287808>

Because sq_quote_argv adds a leading space (which is expected in trace.c),
sq_dequote_step should remove this space again, such that the operations
of quoting and dequoting are inverse of each other.

This patch is preparing the way to remove some excessive trimming
operation in bisect in the following commit.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 quote.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/quote.c b/quote.c
index fe884d2..2714f27 100644
--- a/quote.c
+++ b/quote.c
@@ -63,6 +63,8 @@ static char *sq_dequote_step(char *arg, char **next)
 	char *src = arg;
 	char c;
 
+	if (*src == ' ')
+		src++;
 	if (*src != '\'')
 		return NULL;
 	for (;;) {
-- 
2.4.3
