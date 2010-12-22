From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] convert filter: supply path to external driver
Date: Wed, 22 Dec 2010 10:10:55 -0800
Message-ID: <7v4oa565lc.fsf@alter.siamese.dyndns.org>
References: <20101218223822.GA18902@arf.padd.com>
 <20101219212925.GA7393@arf.padd.com>
 <7vzks1e84p.fsf@alter.siamese.dyndns.org>
 <20101220160911.GA32136@honk.padd.com>
 <7v8vzkcol8.fsf@alter.siamese.dyndns.org>
 <20101221134403.GA10401@honk.padd.com> <20101221181924.GB25812@burratino>
 <20101221203322.GA13868@honk.padd.com>
 <7vzkry7rb4.fsf@alter.siamese.dyndns.org>
 <20101222144013.GA22089@honk.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 19:11:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVT9i-0006Q6-3P
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 19:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab0LVSLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 13:11:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab0LVSLM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 13:11:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 51637382A;
	Wed, 22 Dec 2010 13:11:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5cyJi0JZ5mo+KPYvKZA4Hb+jwuI=; b=qPFQXv
	QEEJ4yrEkcTFiNsCV+BvcTGlAkaqe9Ta4boPx5pgIBUxScqJFzoUb59ASiIj6eQx
	N7mh7cH5kkwrycuy9+EytuWo9VgpoVe37bygywghRHdFOmH0/n9LMv/lL8VQmR5L
	iWAlUwS294TcZIP+8WZtbUTMIm6VZVvPH+1lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C3WOXCoqh+6V+rHTg+OO+/9vbXKuqIwU
	PrtXYjDTRjpBPPS38oTSZUXYU0A+NG+C1HgvusUjTsk5nQiTP9N8d1vB4+xZCJuN
	8+LXULKYWmN/V9eq+4nq1E6Kt1WO3vaab+mVbo8bzwyR9nxZSj+O5NhnBpuq4wR5
	FU79cRMDKZI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF10E3826;
	Wed, 22 Dec 2010 13:11:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5863E381F; Wed, 22 Dec 2010
 13:11:27 -0500 (EST)
In-Reply-To: <20101222144013.GA22089@honk.padd.com> (Pete Wyckoff's message
 of "Wed\, 22 Dec 2010 06\:40\:13 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E8C3D15A-0DF6-11E0-8E92-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164091>

Just FYI.

As I build stuff with -Werror to be on the safe side, I had to fix this up
a bit before queueing the patch.

 convert.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 0b24790..d5aebed 100644
--- a/convert.c
+++ b/convert.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "attr.h"
 #include "run-command.h"
+#include "quote.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -335,8 +336,8 @@ static int filter_buffer(int in, int out, void *data)
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf_expand_dict_entry dict[] = {
-	    "f", NULL,
-	    NULL, NULL,
+		{ "f", NULL, },
+		{ NULL, NULL, },
 	};
 
 	/* quote the path to preserve spaces, etc. */
