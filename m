From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] "log --stdin" updates
Date: Fri, 20 Nov 2009 03:25:12 -0800
Message-ID: <1258716315-2213-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 12:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBRcN-0004Rj-CJ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 12:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbZKTLZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 06:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbZKTLZQ
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 06:25:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbZKTLZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 06:25:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 69D51811CF
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=THGvivEGNSOJ1pC/jBuX5uyxr/g
	=; b=s5jMXBnW/4JG0XC/azm1JP0XjM/7cUDSka9lqoOcnUXTwurXxaGZQNk7OnE
	ae1hmMNdt/t5qg78r1E29hUU+lf1war62AI+klhuyNmFt2tVmIFGUzIekiKWNWqV
	n/SMEJOEUE2SgL1DupsRFz2ZJM83uRPEI8qar2SEIoQJgBqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=RvgnZWsHl6EDKQPIW80jS0PS0CnIj
	t1DNfNhIy3GoDnjc0s3nOimWIAdP/BJmsA8x+tm6tXnN5FQ8v1NTwVvKFWgl5DE2
	b1tEXGodfKrSoBtjjrZ+sHty52TXb8aS5WuqMbTNL5vphF2AkvznAK0Oq1scCSv8
	PPv9a3caJWizlY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 656A5811CE
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9851811CD for
 <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:16 -0500 (EST)
X-Mailer: git-send-email 1.6.5.3.342.g14bb9
X-Pobox-Relay-ID: 61362E44-D5C7-11DE-8B16-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133333>

These three come on top of 61ab67a (Teach --stdin option to "log" family,
2009-11-03), which gave "--stdin" to the log family of commands (e.g. log,
rev-list).  The earlier patch allowed you to feed only the revs (which was
what gitk originally wanted), but after zero or more revs (one rev per
line), you can now feed a line that consists of "--" and then pathspecs
(one path per line).

The whole series probably need to be updated to learn -z option to read
NUL terminated input.

Junio C Hamano (3):
  read_revision_from_stdin(): use strbuf
  setup_revisions(): do not call get_pathspec() too early
  Make --stdin option to "log" family read also pathspecs

 revision.c |   95 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 82 insertions(+), 13 deletions(-)
