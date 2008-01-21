From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] added #define DEFAULT_MAX_REQUESTS for USE_CURL_MULTI mode
Date: Mon, 21 Jan 2008 02:19:04 -0800
Message-ID: <7vr6gbzdk7.fsf@gitster.siamese.dyndns.org>
References: <1200756171-11696-1-git-send-email-gb@gbarbier.org>
	<1200756171-11696-2-git-send-email-gb@gbarbier.org>
	<1200756171-11696-3-git-send-email-gb@gbarbier.org>
	<1200756171-11696-4-git-send-email-gb@gbarbier.org>
	<1200756171-11696-5-git-send-email-gb@gbarbier.org>
	<7v1w8c6nnm.fsf@gitster.siamese.dyndns.org>
	<47946C95.4080607@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Gr=C3=A9goire?= Barbier <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 11:19:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGtkt-0002g0-9m
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 11:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764993AbYAUKTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 05:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765229AbYAUKTP
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 05:19:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764535AbYAUKTM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 05:19:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A47653F14;
	Mon, 21 Jan 2008 05:19:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BB033F13;
	Mon, 21 Jan 2008 05:19:06 -0500 (EST)
In-Reply-To: <47946C95.4080607@gbarbier.org> (=?utf-8?Q?Gr=C3=A9goire?=
 Barbier's message of
	"Mon, 21 Jan 2008 10:57:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71253>

Gr=C3=A9goire Barbier <gb@gbarbier.org> writes:

> Ok, please forget my patch and forgive my stupidity, I've juste
> realized why I needed to define -DUSE_CURL_MULTI by hand in the
> Makefile, I'm so stupid...

No, it is not your stupidity.

The http.h and http-*.c files assume that USE_CURL_MULTI is
internal and do not want the user to define that symbol from
outside.  It should be better documented and mistakes should be
prevented.

Perhaps we need something like like this.


diff --git a/http.h b/http.h
index aeba930..046b17f 100644
--- a/http.h
+++ b/http.h
@@ -8,6 +8,12 @@
=20
 #include "strbuf.h"
=20
+/*
+ * We detect based on the cURL version if multi-transfer is
+ * usable in this implementation and define this symbol accordingly.
+ */
+#undef USE_CURL_MULTI
+
 #if LIBCURL_VERSION_NUM >=3D 0x071000
 #define USE_CURL_MULTI
 #define DEFAULT_MAX_REQUESTS 5
