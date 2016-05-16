From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/12] attr.c: explain the lack of attr-name syntax check in parse_attr()
Date: Mon, 16 May 2016 14:05:37 -0700
Message-ID: <20160516210545.6591-5-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:06:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2PiG-0001E6-0B
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbcEPVF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:05:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184AbcEPVF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:05:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 255AE1C734;
	Mon, 16 May 2016 17:05:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=IanQ
	wGn6Vnk5IbMSByAv0gIEuHs=; b=OcoEDCdNtcpp3OdiVEAXphFaR/SCsgu49N1D
	UN72zTTu2S4SfUc3Z0y387HBlbfbMS/k80pGwDx9EgJQeZn31+PsS4FLlgHj0sZh
	jMJwr2AZygkzn5ts8HeLJx9AcJdmVarQVxrfgAnWLaDdmCprX8W5ZulpBsC3tQY7
	1AY2Lz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=to0dXs
	3WPeEwRHIJaTRl2rcKEEoEP7MET0CqLD3b/ET9jVEJCKgHa0WnnAwTo6YNM/BakP
	1eVMQW9z1DEy1KIDU6Mw0CrAZqPR8kQ+TlnpwTmpqDH5hu1JYGthfCxqIPLMEZvG
	cQeFCrFme+hzPWYQ4Nkd0HRkQ/EzbUd3PUgTg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D6871C72C;
	Mon, 16 May 2016 17:05:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 782781C72B;
	Mon, 16 May 2016 17:05:56 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: FB8BC966-1BA9-11E6-9AFD-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294787>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/attr.c b/attr.c
index 4ae7801..05db667 100644
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
