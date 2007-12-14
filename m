From: Junio C Hamano <gitster@pobox.com>
Subject: Re: testsuite failures in mainline...
Date: Fri, 14 Dec 2007 15:18:02 -0800
Message-ID: <7v7ijgq311.fsf@gitster.siamese.dyndns.org>
References: <7vfxy5rsui.fsf@gitster.siamese.dyndns.org>
	<20071214.111736.258936000.davem@davemloft.net>
	<20071214214533.GA4943@steel.home>
	<20071214.142448.52660507.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: raa.lkml@gmail.com, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 00:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Jni-00036H-5M
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 00:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765327AbXLNXSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 18:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764321AbXLNXSQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 18:18:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763379AbXLNXSO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 18:18:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 00DDA5B10;
	Fri, 14 Dec 2007 18:18:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 587415B0E;
	Fri, 14 Dec 2007 18:18:04 -0500 (EST)
In-Reply-To: <20071214.142448.52660507.davem@davemloft.net> (David Miller's
	message of "Fri, 14 Dec 2007 14:24:48 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68360>

David Miller <davem@davemloft.net> writes:

> 	if (!prefixcmp(key, "branch.")) {
> 		name = key + 7;
> 		subkey = strrchr(name, '.');
> 		branch = make_branch(name, subkey - name);
>
> What if 'subkey' is NULL?  I bet that's what happening here.

Wow, good eyes.

It makes me wonder what my C library has been returning during the
tests...

---

 remote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/remote.c b/remote.c
index 3fb0f99..0e00680 100644
--- a/remote.c
+++ b/remote.c
@@ -220,11 +220,11 @@ static int handle_config(const char *key, const char *value)
 	if (!prefixcmp(key, "branch.")) {
 		name = key + 7;
 		subkey = strrchr(name, '.');
-		branch = make_branch(name, subkey - name);
 		if (!subkey)
 			return 0;
 		if (!value)
 			return 0;
+		branch = make_branch(name, subkey - name);
 		if (!strcmp(subkey, ".remote")) {
 			branch->remote_name = xstrdup(value);
 			if (branch == current_branch)
