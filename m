From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-push: forced update of tag shows unabbreviated SHA1
Date: Thu, 31 Jan 2008 01:37:53 -0800
Message-ID: <7vsl0ecp3i.fsf@gitster.siamese.dyndns.org>
References: <47A1948F.6080308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 10:38:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKVsU-0003ya-RQ
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 10:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbYAaJiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 04:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754457AbYAaJiE
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 04:38:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929AbYAaJiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 04:38:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D37332E4D;
	Thu, 31 Jan 2008 04:37:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 49F462E4C;
	Thu, 31 Jan 2008 04:37:55 -0500 (EST)
In-Reply-To: <47A1948F.6080308@viscovery.net> (Johannes Sixt's message of
	"Thu, 31 Jan 2008 10:27:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72114>

Johannes Sixt <j.sixt@viscovery.net> writes:

> This is just a cosmetical flaw:
> ...
> To file:///home/jsixt/tmp/foo/B/../A
>  + 639669ce44f84417f30842c622064827dda01461...475e55f T -> T (forced update)
>
> Notice that the original SHA1 is not abbreviated.

I suspect that is because you do not _have_ the original object,
so there is no uniquely usable abbreviation to name the object
in your repository.

This obviously is not tested at all (not even compile tested),
but I think it would show you what is going on.

---
 builtin-send-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8afb1d0..9c558ee 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -265,7 +265,7 @@ static const char *status_abbrev(unsigned char sha1[20])
 {
 	const char *abbrev;
 	abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
-	return abbrev ? abbrev : sha1_to_hex(sha1);
+	return abbrev ? abbrev : "<you do not have it>";
 }
 
 static void print_ok_ref_status(struct ref *ref)
