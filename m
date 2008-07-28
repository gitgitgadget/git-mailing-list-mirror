From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9 v2] Allow the built-in exec path to be relative to
 the command invocation path
Date: Sun, 27 Jul 2008 23:42:30 -0700
Message-ID: <7v1w1ev7ah.fsf@gitster.siamese.dyndns.org>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <200807232112.18352.johannes.sixt@telecom.at>
 <7vd4l37vz7.fsf@gitster.siamese.dyndns.org>
 <200807242124.14583.johannes.sixt@telecom.at>
 <7v3aly5zz3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 28 08:43:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNMSJ-0004aq-1z
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbYG1Gmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 02:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbYG1Gmi
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:42:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbYG1Gmi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 02:42:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0BB5546B37;
	Mon, 28 Jul 2008 02:42:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4B54046B36; Mon, 28 Jul 2008 02:42:33 -0400 (EDT)
In-Reply-To: <7v3aly5zz3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 24 Jul 2008 21:50:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5DC637C6-5C70-11DD-BEE6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90421>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <johannes.sixt@telecom.at> writes:
>
>> On Donnerstag, 24. Juli 2008, Junio C Hamano wrote:
>>> Johannes Sixt <johannes.sixt@telecom.at> writes:
>>> > It also fixes 'make install' of git-gui as well (sigh!) by not exporting
>>> > gitexecdir - assuming that Shawn applies the git-gui patch.
>>>
>>> Yeah, this seems to break the install quite badly without git-gui patch.
>>
>> If you squash this in, we don't need the git-gui patch.
>
> Thanks.
>
> I think this patch makes _more_ sense than the git-gui patch, actually.
>
> Within the context of git.git project, we would want to force the
> installation directory of git-gui portion to be consistent with the main
> project.

What I wanted to say with the above is that the main Makefile is what has
its own special need from git-gui/Makefile's point of view, so passing
such customization from the main Makefile makes a lot of sense.

I think this is also needed; I noticed it while trying the "build on a
machine without any git installed" exercise.

diff --git a/Makefile b/Makefile
index 798a2f2..52c67c1 100644
--- a/Makefile
+++ b/Makefile
@@ -1067,7 +1067,7 @@ endif
 
 all::
 ifndef NO_TCLTK
-	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
+	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
 	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
 endif
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
