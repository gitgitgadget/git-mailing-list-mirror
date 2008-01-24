From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HP-UX traditionally has no sys/select.h
Date: Thu, 24 Jan 2008 11:11:44 -0800
Message-ID: <7vd4rravin.fsf@gitster.siamese.dyndns.org>
References: <20080124175300.GI30676@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 20:12:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI7V7-0003em-PA
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 20:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbYAXTMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 14:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbYAXTMG
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 14:12:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYAXTMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 14:12:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C4CC1629C;
	Thu, 24 Jan 2008 14:12:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A46C6299;
	Thu, 24 Jan 2008 14:11:58 -0500 (EST)
In-Reply-To: <20080124175300.GI30676@schiele.dyndns.org> (Robert Schiele's
	message of "Thu, 24 Jan 2008 18:53:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71652>

Robert Schiele <rschiele@gmail.com> writes:

> The select stuff is already in sys/time.h on traditional HP-UX
> systems thus we should not include sys/select.h there because older
> releases don't have it.
> ---
>  git-compat-util.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b6ef544..77de915 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -68,7 +68,9 @@
>  #include <sys/poll.h>
>  #include <sys/socket.h>
>  #include <sys/ioctl.h>
> +#ifndef __hpux
>  #include <sys/select.h>
> +#endif
>  #include <assert.h>
>  #include <regex.h>
>  #include <netinet/in.h>
> -- 
> 1.5.2.4

We had a thread on this issue mid December.
Does this help?

>From 72a41cae180ad57c6f2daa0af9b96e284386dc1b Mon Sep 17 00:00:00 2001
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 18 Dec 2007 01:52:07 -0800
Subject: [PATCH] Do not include <sys/select.h> on pre- POSIX.1-2001 systems

For previous version of SUS, select(2) would have been declared in
<sys/time.h>, which is already included.  POSIX.1-2001 moved the
declaration to <sys/select.h>, so check _POSIX_VERSION with 200112L
and skip inclusion of <sys/select.h> if it is not the case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-compat-util.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index b6ef544..fb3b969 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -68,7 +68,9 @@
 #include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#if _POSIX_VERSION >= 200112L
 #include <sys/select.h>
+#endif
 #include <assert.h>
 #include <regex.h>
 #include <netinet/in.h>
-- 
1.5.4.rc4.23.gcab31
