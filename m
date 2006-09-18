From: Junio C Hamano <junkio@cox.net>
Subject: Re: Patch for http-fetch.c and older curl releases
Date: Mon, 18 Sep 2006 16:06:45 -0700
Message-ID: <7v4pv4pyey.fsf@assigned-by-dhcp.cox.net>
References: <20060918225445.GF1261@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 01:07:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPSCV-0003SQ-Vz
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 01:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWIRXGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 19:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWIRXGr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 19:06:47 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45299 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751240AbWIRXGq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 19:06:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060918230645.TFKL12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Mon, 18 Sep 2006 19:06:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Pz6n1V00J1kojtg0000000
	Mon, 18 Sep 2006 19:06:47 -0400
To: "Art Haas" <ahaas@airmail.net>
In-Reply-To: <20060918225445.GF1261@artsapartment.org> (Art Haas's message of
	"Mon, 18 Sep 2006 17:54:45 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27261>

"Art Haas" <ahaas@airmail.net> writes:

> Older curl releases do not define CURLE_HTTP_RETURNED_ERROR, they
> use CURLE_HTTP_NOT_FOUND instead. The trivial patch below fixes
> the build error. Newer curl releases keep the CURLE_HTTP_NOT_FOUND
> definition but using a -DCURL_NO_OLDIES preprocessor flag
> the old name will not be present in the 'curl.h' header. The
> comments in 'curl.h' have more info about the name change.
>
> Signed-off-by:  Art Haas <ahaas@airmail.net>

The patch to use older name in a recent program feels going
backwards.  The header is only trying to be nice so you can
compile old programs written for older interface that use older
names. If the new way is the primary way with the new interface,
and if we are writing a new program, I think we should write for
the new interface.

Can we have the main code to target the more recent version,
while working around problems with older versions with backward
compatibility macros?

In other words, if the macro HTTP_RETURNED_ERROR is not defined
in the header (i.e. older version), you define it to be the same
as HTTP_NOT_FOUND.
