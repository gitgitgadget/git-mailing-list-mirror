From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reteach builtin-ls-remote to understand remotes
Date: Tue, 06 Nov 2007 22:24:11 -0800
Message-ID: <7vtznyefp0.fsf@gitster.siamese.dyndns.org>
References: <20071107012920.GA9961@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 07:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpeL2-0003Ef-Ce
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 07:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbXKGGYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 01:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbXKGGYR
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 01:24:17 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58364 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254AbXKGGYR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 01:24:17 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 21F6F2FB;
	Wed,  7 Nov 2007 01:24:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 93171900A4;
	Wed,  7 Nov 2007 01:24:35 -0500 (EST)
In-Reply-To: <20071107012920.GA9961@spearce.org> (Shawn O. Pearce's message of
	"Tue, 6 Nov 2007 20:29:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63772>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Prior to being made a builtin git-ls-remote understood that when
> it was given a remote name we wanted it to resolve that to the
> pre-configured URL and connect to that location.  That changed when
> it was converted to a builtin and many of my automation tools broke.

Thanks.  I will squash this in.

---
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
new file mode 100755
index 0000000..6ec5f7c
--- /dev/null
+++ b/t/t5512-ls-remote.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='git ls-remote'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	>file &&
+	git add file &&
+	test_tick &&
+	git commit -m initial &&
+	git tag mark &&
+	git show-ref --tags -d | sed -e "s/ /	/" >expected.tag &&
+	(
+		echo "$(git rev-parse HEAD)	HEAD"
+		git show-ref -d	| sed -e "s/ /	/"
+	) >expected.all &&
+
+	git remote add self $(pwd)/.git
+
+'
+
+test_expect_success 'ls-remote --tags .git' '
+
+	git ls-remote --tags .git >actual &&
+	diff -u expected.tag actual
+
+'
+
+test_expect_success 'ls-remote .git' '
+
+	git ls-remote .git >actual &&
+	diff -u expected.all actual
+
+'
+
+test_expect_success 'ls-remote --tags self' '
+
+	git ls-remote --tags self >actual &&
+	diff -u expected.tag actual
+
+'
+
+test_expect_success 'ls-remote self' '
+
+	git ls-remote self >actual &&
+	diff -u expected.all actual
+
+'
+
+test_done
