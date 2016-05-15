From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attr: explain the lack of attr-name syntax check in parse_attr()
Date: Sun, 15 May 2016 15:58:40 -0700
Message-ID: <xmqqa8jr3p3z.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:58:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b24zt-000781-7E
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 00:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbcEOW6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 18:58:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50370 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751815AbcEOW6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 18:58:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0195819A54;
	Sun, 15 May 2016 18:58:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=j
	HTwc8EZljHKfsAP1gXbFafzehU=; b=SMCZn2K/3+lbLtGPezzlmtiYVjgNdYxcF
	KCB1P9HetomJLGD/3UBXX/beKb2Wt5D0orRboOom3IHH3Xl2OZJROBzG0mDhd3Jl
	Nnd27y68xI9asnKbtxI69ElQwNYaKuS2EbQUaR26iCqMioQFxYAY0GALnU+0KZK5
	6DvR4LEfhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=TaL
	qvq9ih1ijSeYepT6Nx+qzPkDVU1Luk1R+SW/F4meTckuqKFCNbeum3gDulXEuwd7
	qVWDmA4ciTsFNm8gTw4xLvfygeLj6u8n1BJ4vaNm/C5IF/yeWGimAnqWiZ+jaW00
	Hd8ejL+yvo+mT1mDi9ibeP3o33Zn0PoB9LMzFVtg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC3B819A53;
	Sun, 15 May 2016 18:58:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CCA619A51;
	Sun, 15 May 2016 18:58:42 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91F4BA76-1AF0-11E6-96B1-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294694>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/attr.c b/attr.c
index 94b27f4..aac5c8f 100644
--- a/attr.c
+++ b/attr.c
@@ -183,6 +183,12 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			return NULL;
 		}
 	} else {
+		/*
+		 * As this function is always called twice, once with
+		 * e == NULL in the first pass and then e != NULL in
+		 * the second pass, no need for invalid_attr_name()
+		 * check here.
+		 */
 		if (*cp == '-' || *cp == '!') {
 			e->setto = (*cp == '-') ? ATTR__FALSE : ATTR__UNSET;
 			cp++;
-- 
2.8.2-748-gfb85f76
