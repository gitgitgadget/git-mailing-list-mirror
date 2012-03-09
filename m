From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Use PWD if it exists on Mac OS X.
Date: Fri, 09 Mar 2012 15:37:06 -0800
Message-ID: <7vty1x2vod.fsf@alter.siamese.dyndns.org>
References: <1331335042-25509-1-git-send-email-mk@acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marcus Karlsson <mk@acc.umu.se>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 00:37:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S69N9-0003L8-Ap
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 00:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab2CIXhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 18:37:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39766 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab2CIXhK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 18:37:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6131A502E;
	Fri,  9 Mar 2012 18:37:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DmEP724UcJxOXTNWHP6ZipFLmSs=; b=bgnS9z
	pA10SfA3U+oa2eRNrRiAruLJQqkuNKdDjMOmha9y6cTV0bBsDjoXJlu40X10zJMZ
	W4yuQ/KveMAYvww+Wnyi4GBFZKE8Wp3dsOtaYla0ajsfSh0ZOhaCvgO/RepcA7Aw
	IMTTAJ8irN1444KPNhTLqhBNoR0gzTKxnRcaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v27rlPzyXN2XGP4fWIKS9YbQrH5PQZWR
	SQwR0MTNcpqCYNQOZ56TfF1X8EuTJSdLOsUteWi/7eblb5wHQTbA5VIezRB3WaU3
	uAZudYKE9McVQlXENBgfyMT1jLiUdRAUJ3T887vM7NQWtjCuKC55aEZTzJmoRluj
	tX91tgpRC74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55AB1502D;
	Fri,  9 Mar 2012 18:37:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8291E502C; Fri,  9 Mar 2012
 18:37:08 -0500 (EST)
In-Reply-To: <1331335042-25509-1-git-send-email-mk@acc.umu.se> (Marcus
 Karlsson's message of "Sat, 10 Mar 2012 00:17:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C94BAC7E-6A40-11E1-A444-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192759>

Thanks, Marcus.

Just forwarding to the current maintainer; please note that my
sign-off does not mean anything more than what D-C-O says it means;
I rarely if ever use git-gui myself and do not have a Macintosh.

-- >8 --
From: Marcus Karlsson <mk@acc.umu.se>
Subject: [PATCH] git-gui: Use PWD if it exists on Mac OS X
Date: Sat, 10 Mar 2012 00:17:22 +0100

The current working directory is set to / when git-gui is invoked
using the Git Gui.app bundle on Mac OS X. This means that if it is
launched from a directory which contains a repository then git-gui
won't automatically find it unless the repository happens to be
located in /.

The PWD environment variable is however preserved if the bundle is
invoked using open(1). If git-gui would check for PWD then a user
could for example type open -a 'Git Gui' on a command line in order to
launch the program and it would automatically find the repository.

Teach git-gui to use the PWD environment variable on Mac OS X.

Signed-off-by: Marcus Karlsson <mk@acc.umu.se>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-gui/macosx/AppMain.tcl |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-gui/macosx/AppMain.tcl b/git-gui/macosx/AppMain.tcl
index ddbe633..738bdd0 100644
--- a/git-gui/macosx/AppMain.tcl
+++ b/git-gui/macosx/AppMain.tcl
@@ -12,7 +12,9 @@ if {[file tail [lindex $argv 0]] eq {gitk}} {
 } else {
 	set argv0 [file join $gitexecdir [file tail [lindex $argv 0]]]
 	set AppMain_source [file join $gitguilib git-gui.tcl]
-	if {[pwd] eq {/}} {
+	if {[info exists env(PWD)]} {
+		cd $env(PWD)
+	} elseif {[pwd] eq {/}} {
 		cd $env(HOME)
 	}
 }
-- 
1.7.10.rc0.17.g36a9f
