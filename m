From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/9] sha1_name.c: get_describe_name() by definition groks
 only commits
Date: Mon, 18 Jun 2012 15:05:39 -0700
Message-ID: <1340057139-8311-11-git-send-email-gitster@pobox.com>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 00:06:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgk5G-0000AS-G2
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 00:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab2FRWGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jun 2012 18:06:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753373Ab2FRWF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2012 18:05:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 223359801
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=j3si
	X9zypp9q0wetSDq/fRbFWlQ=; b=GNVf8VAFs685iw0GsLMWbhXt24rVOkcf+ofv
	COoHPcPcjEVVyM0fTjOHFEZbE29cLp4EbkBNhkJWQBTDQNu3S3T3w1hDWblRHmEj
	m2ZLlBAr9HUT68ex6rx4e9SGPz+XT68mIHTUIpWyXSTFs+tWwpyyDTlajnJgKHCO
	HuFEJNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=VElK1q
	QtAMYw+WcQTm4nR1ngCaX9cyGdkpi8KRCQYYFLleSjWqOVANCoEhQk7sOwpqoogs
	rPAFVLAWpqtKjD38S9zpJSxOwOSwD/hQuDNHwqs5n0iRDIsDLa5iXIswm+yOgEro
	XStnBw999c7IvIdqUkCry+u8Fgb9w3jmfMKm8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18B9B9800
	for <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A451197FF for
 <git@vger.kernel.org>; Mon, 18 Jun 2012 18:05:58 -0400 (EDT)
X-Mailer: git-send-email 1.7.11
In-Reply-To: <1340057139-8311-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C8B97AC0-B991-11E1-B411-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200169>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4a0fefd..b09a23e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -569,6 +569,7 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 static int get_describe_name(const char *name, int len, unsigned char *sha1)
 {
 	const char *cp;
+	unsigned flags = GET_SHORT_QUIETLY | GET_SHORT_COMMIT_ONLY;
 
 	for (cp = name + len - 1; name + 2 <= cp; cp--) {
 		char ch = *cp;
@@ -579,7 +580,7 @@ static int get_describe_name(const char *name, int len, unsigned char *sha1)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_sha1(cp, len, sha1, GET_SHORT_QUIETLY);
+				return get_short_sha1(cp, len, sha1, flags);
 			}
 		}
 	}
-- 
1.7.11
