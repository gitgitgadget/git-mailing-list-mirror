From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] deprecate core.statinfo at Git 2.0 boundary
Date: Mon, 06 May 2013 23:38:08 -0700
Message-ID: <7vsj1zmh0v.fsf@alter.siamese.dyndns.org>
References: <7v4niblhr6.fsf@alter.siamese.dyndns.org>
	<1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
	<20130506232242.GA27393@sigill.intra.peff.net>
	<7va9o7o0dl.fsf@alter.siamese.dyndns.org>
	<7v1u9jnyox.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 07 08:38:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZbXV-0001dE-4w
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 08:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991Ab3EGGiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 02:38:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63174 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253Ab3EGGiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 02:38:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D063C18B07;
	Tue,  7 May 2013 06:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r4atlwG0jy8h5QYDvqQwRIZLkK4=; b=nPCm3/
	PeCunARugcTexNQmIowLqjG660qVI3LtWZblSAvuPBxupGqpZieJgDlG3c1DM6c8
	T9V2NsDNCXioMWA/9X6vxdGkqjB010qe/8TURVq24jL65Qjw/sMUMg8FcUaOJl8S
	KW+kr/JqCmlRgY28YG6QxxaLWZwR09MuOI0lE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n2wtOMbhx8nDPiSsbp0YtMh6W/WL40Yg
	BiBywHd9dZge5usc+NBVgLu9hXLeRIC1rz4s5a1EwVOh2ERnzuW9jFT1HEnI1BfQ
	czDPDSos2fbI9YRWbMzgI9kZ3C0gY+VOFha/MAwcslYHGuA6JE+SZT+mVd8xlt24
	3jnVED7KKGw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6C5F18B06;
	Tue,  7 May 2013 06:38:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4873018B04;
	Tue,  7 May 2013 06:38:10 +0000 (UTC)
In-Reply-To: <7v1u9jnyox.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 06 May 2013 22:31:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF36C826-B6E0-11E2-B0C5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223555>

Junio C Hamano <gitster@pobox.com> writes:

> For now, add core.checkstat, and warn people who have core.statinfo
> in their configuration file that we will remove it in Git 2.0.

And an obvious follow-up for the 2.0 looks like this.

-- >8 --
Subject: [PATCH] core.statinfo: remove as promised in Git 2.0

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/config.c b/config.c
index 7c55d05..1f2cc90 100644
--- a/config.c
+++ b/config.c
@@ -566,20 +566,7 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_ctime = git_config_bool(var, value);
 		return 0;
 	}
-	if (!strcmp(var, "core.statinfo") ||
-	    !strcmp(var, "core.checkstat")) {
-		/*
-		 * NEEDSWORK: statinfo was a typo in v1.8.2 that has
-		 * never been advertised.  we will remove it at Git
-		 * 2.0 boundary.
-		 */
-		if (!strcmp(var, "core.statinfo")) {
-			static int warned;
-			if (!warned++) {
-				warning("'core.statinfo' will be removed in Git 2.0; "
-					"use 'core.checkstat' instead.");
-			}
-		}
+	if (!strcmp(var, "core.checkstat")) {
 		if (!strcasecmp(value, "default"))
 			check_stat = 1;
 		else if (!strcasecmp(value, "minimal"))
-- 
1.8.3-rc1-154-g10dfae1
