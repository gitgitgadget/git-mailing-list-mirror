From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 17/21] cat-file: read batch stream with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:32 -0800
Message-ID: <1452815916-6447-18-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnT-0003Xm-4Q
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbcANX7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754112AbcANX7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:59:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F48E3CD9F;
	Thu, 14 Jan 2016 18:59:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bI/a
	xK4eUiVzVSdL2BYVdDv2mWo=; b=ykXNwBYOOMFF43b0F1IDZ+9hq0s97B46V8Fl
	pBpPO8jnPGq7Taplm73fJfXLo6DXALmPJwa6RGb0wft7iSNthLXP4EBOBo2Ezv97
	GfIrB5cAqaR10WT4uH8wX8vIen5sghMSho7OAh80cyeDwydbtRwPSSJDFJ2WFR2i
	nQhnnWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	U25nt8CuSmfs6quFHH/50cUf+tAihhwn4zBrDVsYSRp6tB/6is5Z7ESW2B3+g1te
	aqI7Gu7jaxLd5LBCS/4OJP8mJnmOfhldgSS9lrDFXRb7e/+v/GmJY8nMlwG7fV8b
	588uHOUybwBUven8tH26NapPf3g+bmIRHWcWwfGgruU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 769DF3CD9E;
	Thu, 14 Jan 2016 18:59:06 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ED3B33CD9B;
	Thu, 14 Jan 2016 18:59:05 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: CB591F5E-BB1A-11E5-AE29-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284114>

It is possible to prepare a text file with a DOS editor and feed it
as a batch command stream to the command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d2ebaf1..54db118 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -401,7 +401,7 @@ static int batch_objects(struct batch_options *opt)
 	save_warning = warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity = 0;
 
-	while (strbuf_getline_lf(&buf, stdin) != EOF) {
+	while (strbuf_getline(&buf, stdin) != EOF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
-- 
2.7.0-250-ge1b5ba3
