From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9 v2] Allow the built-in exec path to be relative to
 the command invocation path
Date: Wed, 23 Jul 2008 21:21:48 -0700
Message-ID: <7vd4l37vz7.fsf@gitster.siamese.dyndns.org>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-6-git-send-email-johannes.sixt@telecom.at>
 <7vfxq0e9lk.fsf@gitster.siamese.dyndns.org>
 <200807232112.18352.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Jul 24 06:23:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLsLz-0002pz-H2
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 06:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbYGXEV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 00:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbYGXEV4
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 00:21:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbYGXEV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 00:21:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 832A43912F;
	Thu, 24 Jul 2008 00:21:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 818333912D; Thu, 24 Jul 2008 00:21:51 -0400 (EDT)
In-Reply-To: <200807232112.18352.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Wed, 23 Jul 2008 21:12:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0BFED8DE-5938-11DD-B0E0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89833>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> It also fixes 'make install' of git-gui as well (sigh!) by not exporting
> gitexecdir - assuming that Shawn applies the git-gui patch.

Yeah, this seems to break the install quite badly without git-gui patch.

If your PATH does not include the bindir you are installing the freshly
built git, then the Makefile in git-gui runs:

	ifndef gitexecdir
		gitexecdir := $(shell git --exec-path)
	endif

and miserably fails.  We can assume that somebody who builds and installs
git-gui as a standalone project already *has* an installed, working git on
$PATH, so the above ifndef is Ok, but when git-gui is built as part of
git.git tree, we really should avoid triggering that codepath.
