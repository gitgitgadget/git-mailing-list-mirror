From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] Allow the built-in exec path to be relative to the
 command invocation path
Date: Wed, 23 Jul 2008 11:31:03 -0700
Message-ID: <7vfxq0e9lk.fsf@gitster.siamese.dyndns.org>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-3-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-4-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-5-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-6-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:32:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLj8F-0003zq-6O
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbYGWSbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 14:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYGWSbL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:31:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbYGWSbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 14:31:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E265370AC;
	Wed, 23 Jul 2008 14:31:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BAFEB370AB; Wed, 23 Jul 2008 14:31:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8484D720-58E5-11DD-A0B3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89730>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> If $(gitexecdir) is relative, it is interpreted relative to the command's
> invocation path, which usually is $(bindir).
>
> The Makefile rules were written with the assumption that $(gitexecdir) is
> an absolute path. We introduce a separate variable that names the
> (absolute) installation directory.
>  ... 
> +ifeq ($(firstword $(subst /, ,$(gitexecdir))),..)
> +gitexec_instdir = $(bindir)/$(gitexecdir)
> +else

Can we please have a brief comment in the Makefile near we define mandir,
infodir, gitexecdir and friends about this "relative to $(bindir)"
business?

Perhaps like:

 Makefile |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 23f2185..8fa8f9a 100644
--- a/Makefile
+++ b/Makefile
@@ -171,6 +171,12 @@ ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
 prefix = $(HOME)
+
+# Among these variables, gitexecdir and/or template_dir can be
+# specified as a relative path ../some/where/else; this is interpreted
+# as relative to $(bindir) and "git" at runtime figures out where they
+# are based on the path to the executable.  This can help installing the
+# suite in a relocatable way.
 bindir = $(prefix)/bin
 mandir = $(prefix)/share/man
 infodir = $(prefix)/share/info

Note that I just listed two variables out of thin air without studying;
you might be making other variables capable of relative path, in which
case they should also be listed there.
