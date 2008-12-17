From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/5] make_absolute_path(): check bounds when seeing an
 overlong symlink
Date: Wed, 17 Dec 2008 12:37:48 -0800
Message-ID: <7vhc52leqr.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171044110.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 21:39:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD3Az-0001Yq-Mu
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 21:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbYLQUhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 15:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbYLQUhy
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 15:37:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYLQUhx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 15:37:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F29EE87761;
	Wed, 17 Dec 2008 15:37:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2F91B87760; Wed,
 17 Dec 2008 15:37:50 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93DD408C-CC7A-11DD-A933-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103387>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 abspath.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git i/abspath.c w/abspath.c
index 8194ce1..649f34f 100644
--- i/abspath.c
+++ w/abspath.c
@@ -64,6 +64,8 @@ const char *make_absolute_path(const char *path)
 			len = readlink(buf, next_buf, PATH_MAX);
 			if (len < 0)
 				die ("Invalid symlink: %s", buf);
+			if (PATH_MAX <= len)
+				die("symbolic link too long: %s", buf);
 			next_buf[len] = '\0';
 			buf = next_buf;
 			buf_index = 1 - buf_index;
