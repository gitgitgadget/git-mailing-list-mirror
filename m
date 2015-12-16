From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/17] cat-file: read batch stream with strbuf_getline_crlf()
Date: Wed, 16 Dec 2015 14:03:14 -0800
Message-ID: <1450303398-25900-14-git-send-email-gitster@pobox.com>
References: <1446071161-15610-1-git-send-email-gitster@pobox.com>
 <1450303398-25900-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 23:04:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9KAx-0001RV-C2
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967090AbbLPWDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:03:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62154 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966801AbbLPWDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:03:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3BC3E325E1;
	Wed, 16 Dec 2015 17:03:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=R8VG
	SoAPsBlUg25j6ZhAQZFg54A=; b=sOU+9wg6d0ualleMpgGCTn+2S6Iw9v5sGfiQ
	ih0KYmWNd4JKTpxtLiNThiIPGkYoMByFGzVG5zsaO00NWb5yiL8D9pNZGfNR5Z4X
	BXhcCZqs7ZLuvaaoUTisxUS7aCXtLPgIZPxB9oWtFesirWJesg2K8V73LI+kIMDd
	+Ikf9VA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Sb1lbO
	ND8i6m5G3wOaTfO2cnVejf2o+dygY8bktueGBkgabZ58dCPOHJUDW2iyuj2IgB0Z
	aow3ptZ6rCwqrMycY8nVWJVfd3jKoibcegyAFldnU7e7hGf2DUeunUBqATICTMvo
	DtzJ8UDH9B35qJwtOKmX7hVNz/ajJOwYbwaSc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33C8D325E0;
	Wed, 16 Dec 2015 17:03:41 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A1114325DF;
	Wed, 16 Dec 2015 17:03:40 -0500 (EST)
X-Mailer: git-send-email 2.7.0-rc1-83-ga8b6b9e
In-Reply-To: <1450303398-25900-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DD8F9FAE-A440-11E5-B24F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282610>

It is possible to prepare a text file with a DOS editor and feed it
as a batch command stream to the command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index c0fd8db..a2e75ad 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -401,7 +401,7 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+	while (strbuf_getline_crlf(&buf, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
-- 
2.7.0-rc1-83-ga8b6b9e
