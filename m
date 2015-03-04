From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] Documentation/config.txt: have a separate "Values" section
Date: Wed,  4 Mar 2015 13:33:20 -0800
Message-ID: <1425504803-16039-5-git-send-email-gitster@pobox.com>
References: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
 <1425504803-16039-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 22:33:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGvI-0007Ex-E3
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbbCDVdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:33:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753053AbbCDVdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:33:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F7F13C779;
	Wed,  4 Mar 2015 16:33:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bZ5e
	Go86e3AJZ3nyKK9Uu3vVVAo=; b=RUt/zeTau3jv+tccQ17fPYqH9sHFO7wVOdWq
	lfPE0Pt4wgyuMzral64OS4085VHvM0+7M13O7/Fk6jMnm/cgx/zPPjpq3wQoPhXZ
	tlPGmT9mVV9gZX725F+JEJtCRDODdXcJSUeqDYSFT7ZtFjD42N/+XkS2OcYDWvFF
	2QmnK8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HdmtsD
	zYOCNEIa0PrsbrsbLpnnJSsY2a//ayTVc+Sc0p+kZbhnA5sgC99/OgMc1a6vBQ71
	cPWyGAKFY9Ocgp3GOfWkog9yRexEr1c7zW6uV6L6thEUEnj8k8CVCwmYmXdRb3+E
	I0PL+VURDPNK7TxDOXrQDaiOTUM2CDwWLeLcE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4659D3C778;
	Wed,  4 Mar 2015 16:33:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C07483C774;
	Wed,  4 Mar 2015 16:33:34 -0500 (EST)
X-Mailer: git-send-email 2.3.1-318-g5233f23
In-Reply-To: <1425504803-16039-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1C9F4338-C2B6-11E4-A2CB-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264785>

The various types of values set to the configuration variables
deserve more than a brief footnote mention in the syntax section,
and it will be more so after the later steps of this clean up
effort.

Move the mention of booleans from the syntax section to this new
section, and describe how human-readble integers can be spelled with
scaling there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1444614..7be608b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -75,14 +75,6 @@ The following escape sequences (beside `\"` and `\\`) are recognized:
 and `\b` for backspace (BS).  No other char escape sequence, nor octal
 char sequences are valid.
 
-The values following the equals sign in variable assign are all either
-a string, an integer, or a boolean.  Boolean values may be given as yes/no,
-1/0, true/false or on/off.  Case is not significant in boolean values, when
-converting value to the canonical form using '--bool' type specifier;
-'git config' will ensure that the output is "true" or "false".
-
-Some variables may require a special value format.
-
 
 Includes
 ~~~~~~~~
@@ -124,6 +116,37 @@ Example
 		path = foo ; expand "foo" relative to the current file
 		path = ~/foo ; expand "foo" in your $HOME directory
 
+
+Values
+~~~~~~
+
+Values of many variables are treated as a simple string, but there
+are variables that take values of specific types and there are rules
+as to how to spell them.
+
+boolean::
+
+       When a variable is said to take a boolean value, many
+       synonyms are accepted for 'true' and 'false'; these are all
+       case-insensitive.
+
+       true;; Boolean true can be spelled as `yes`, `on`, `true`,
+		or `1`.  Also, a variable defined without `= <value>`
+		is taken as true.
+
+       false;; Boolean false can be spelled as `no`, `off`,
+		`false`, or `0`.
++
+When converting value to the canonical form using '--bool' type
+specifier; 'git config' will ensure that the output is "true" or
+"false" (spelled in lowercase).
+
+integer::
+       The value for many variables that specify various sizes can
+       be suffixed with `k`, `M`,... to mean "scale the number by
+       1024", "by 1024x1024", etc.
+
+
 Variables
 ~~~~~~~~~
 
-- 
2.3.1-316-g7c93423
