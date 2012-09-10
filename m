From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] gitcli: contrast wildcard given to shell and to git
Date: Mon, 10 Sep 2012 12:54:00 -0700
Message-ID: <1347306840-14007-2-git-send-email-gitster@pobox.com>
References: <7vhar5oemu.fsf@alter.siamese.dyndns.org>
 <1347306840-14007-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 21:54:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBA3j-0000CU-G7
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 21:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126Ab2IJTyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 15:54:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755922Ab2IJTyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 15:54:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79DB29F8B;
	Mon, 10 Sep 2012 15:54:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/MJh
	QDcvzOb8wLdhD0Miz8K/8FU=; b=VxHst1GckWedFRUtzCV0k0x1funDnkfQO7rg
	GtSoUyBPsar/80++yHZfmr1aDNZrYy+toG3Ajj7uYnyAl8qFWE0ZohYACLfSw7Os
	zQ9fxYpkmaw0xj9l5jHDfKUKLpFD8T6HUHswlxkDM11UmIUFrc9DfLIx0/IOB8Sz
	Ae+CiQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	FmcKMB4oWF3TjNdMQvgqeL0unXb8WnSncEHtMqGBRpZtp6N6ZI7BqsdpXpBWu0Lr
	sZROlASPUt+2NncJ6G1RGhnE0qRla1YUnvbwvVWnSFK40Khjva7Qc7IKXUMd+6Z2
	esEAS4KrEArAUGiGb7X8i9schXwsbp2XR74bmTblHaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 649989F8A;
	Mon, 10 Sep 2012 15:54:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68DBE9F88; Mon, 10 Sep 2012
 15:54:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.322.g2c7d289
In-Reply-To: <1347306840-14007-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4591F190-FB81-11E1-A49D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205165>

People who are not used to working with shell may intellectually
understand how the command line argument is massaged by the shell
but still have a hard time visualizing the difference between
letting the shell expand fileglobs and having Git see the fileglob
to use as a pathspec.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitcli.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index c4edf04..00b8403 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -42,6 +42,23 @@ When writing a script that is expected to handle random user-input, it is
 a good practice to make it explicit which arguments are which by placing
 disambiguating `--` at appropriate places.
 
+ * Many commands allow wildcards in paths, but you need to protect
+   them from getting globbed by the shell.  These two mean different
+   things:
++
+--------------------------------
+$ git checkout -- *.c
+$ git checkout -- \*.c
+--------------------------------
++
+The former lets your shell expand the fileglob, and you are asking
+the dot-C files in your working tree to be overwritten with the version
+in the index.  The latter passes the `*.c` to Git, and you are asking
+the paths in the index that match the pattern to be checked out to your
+working tree.  After running `git add hello.c; rm hello.c`, you will _not_
+see `hello.c` in your working tree with the former, but with the latter
+you will.
+
 Here are the rules regarding the "flags" that you should follow when you are
 scripting git:
 
-- 
1.7.12.322.g2c7d289
