From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/12] attr.c: use strchrnul() to scan for one line
Date: Mon, 16 May 2016 14:05:35 -0700
Message-ID: <20160516210545.6591-3-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:06:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2PiE-0001E6-NS
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbcEPVFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:05:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751095AbcEPVFx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:05:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AD021C72A;
	Mon, 16 May 2016 17:05:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Eg5Y
	jmUSrMMLDiDFJ5lRmCT02nM=; b=sYkA4cS15f2I25kr7aeIUYQOoadZ6FD7K3Kt
	53QUFy5ehuQ7jZB6mUkU8eGwLwbegGD8LIA09kI+HNrxHEgcMaWJOwfnRmfQFglQ
	sQ16zZZQ1s1XaiM/SQeHMWIkfnIEsT8c6CJ8uUO6bMXO8uhnJptwa9Ve2xCLWGLK
	uFOm7No=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=sH2jxd
	yPg814kR7THb5hTGBprrNrC9vTUjJVtx9/4JHyxaoB31+HVz6VcsH39N21Y0vZ2k
	tEEAVh5AsJnqFweErChffeglCuVoy2lCen5Yc2PCenMvokHa9FMCXwSPyWIWPrtL
	ABTTqI0GGw1bZERZTaLeomVST1S10UpJCSa7M=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81E0C1C729;
	Mon, 16 May 2016 17:05:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA5AC1C727;
	Mon, 16 May 2016 17:05:51 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: F8D7ECF4-1BA9-11E6-B8C2-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294788>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index eec5d7d..45aec1b 100644
--- a/attr.c
+++ b/attr.c
@@ -402,8 +402,8 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	for (sp = buf; *sp; ) {
 		char *ep;
 		int more;
-		for (ep = sp; *ep && *ep != '\n'; ep++)
-			;
+
+		ep = strchrnul(sp, '\n');
 		more = (*ep == '\n');
 		*ep = '\0';
 		handle_attr_line(res, sp, path, ++lineno, macro_ok);
-- 
2.8.2-748-gfb85f76
