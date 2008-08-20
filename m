From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git for-each-ref crashes for %(body) with tags
Date: Wed, 20 Aug 2008 12:12:53 -0700
Message-ID: <7vhc9fqz4a.fsf@gitster.siamese.dyndns.org>
References: <f329bf540808201128r2d21c40cr37eb63a6706ac0aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Aug 20 21:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVt8F-0000Zf-4I
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 21:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754118AbYHTTNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 15:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbYHTTNF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 15:13:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbYHTTNE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 15:13:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7DCC35B787;
	Wed, 20 Aug 2008 15:13:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DD9975B786; Wed, 20 Aug 2008 15:13:00 -0400 (EDT)
In-Reply-To: <f329bf540808201128r2d21c40cr37eb63a6706ac0aa@mail.gmail.com>
 (Han-Wen Nienhuys's message of "Wed, 20 Aug 2008 15:28:41 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 032419BC-6EEC-11DD-96D9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93016>

"Han-Wen Nienhuys" <hanwenn@gmail.com> writes:

> see gdb trace below.   Unfortunately, I don't have a repo that I can
> readily share to demonstrate this.

You have a tag that has a single incomplete line as its payload.  The
attached patch should fix it, but I wonder how you created such an unusual
(I would not say "broken") tag to begin with?


diff --git i/builtin-for-each-ref.c w/builtin-for-each-ref.c
index 445039e..4d25ec5 100644
--- i/builtin-for-each-ref.c
+++ w/builtin-for-each-ref.c
@@ -459,8 +459,10 @@ static void find_subpos(const char *buf, unsigned long sz, const char **sub, con
 		return;
 	*sub = buf; /* first non-empty line */
 	buf = strchr(buf, '\n');
-	if (!buf)
+	if (!buf) {
+		*body = "";
 		return; /* no body */
+	}
 	while (*buf == '\n')
 		buf++; /* skip blank between subject and body */
 	*body = buf;
