From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v2 1/6] quote: remove leading space in sq_dequote_step
Date: Mon, 22 Feb 2016 02:15:04 +0100
Message-ID: <56CA6118.2060407@moritzneeb.de>
References: <56CA5DBB.8040006@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 02:24:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXfEW-0006Nn-4i
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 02:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbcBVBYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 20:24:10 -0500
Received: from moritzneeb.de ([78.47.1.106]:55733 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419AbcBVBXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 20:23:49 -0500
Received: from [192.168.1.3] (x55b377aa.dyn.telefonica.de [85.179.119.170])
	by moritzneeb.de (Postfix) with ESMTPSA id 61D4E1C05B;
	Mon, 22 Feb 2016 02:23:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456104228;
	bh=un5KF1oKytkOp3EvY1xQ1C9XQBJnpnHZHF8aq7zQ6sg=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=cNIwVy/ddU+2jYKaI8iExXKxHbuSF0H0RMYV8JwyP9CyFwh3EER3LwEzbzr1Fyf+O
	 Gl/CLY48u6OvD65MNX6NyGScaGflK48LtO3TUndNOj5WPb1i/6rnF0RYm4WcqWhEb+
	 Sy8zr/fCNSKlSXyeN3nuinGoSnfitq4FlcViMPWI=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56CA5DBB.8040006@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286859>

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
2.7.1.345.gc14003e
