From: Junio C Hamano <junkio@cox.net>
Subject: Re: HTTP questions
Date: Thu, 01 Jun 2006 23:38:57 -0700
Message-ID: <7vhd34dptq.fsf@assigned-by-dhcp.cox.net>
References: <20060601232437.GD12261@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 08:39:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm3JG-0004Bo-12
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 08:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWFBGi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 02:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWFBGi7
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 02:38:59 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34020 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751202AbWFBGi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 02:38:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060602063858.VKYV11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 02:38:58 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060601232437.GD12261@reactrix.com> (Nick Hengeveld's message
	of "Thu, 1 Jun 2006 16:24:37 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21149>

Nick Hengeveld <nickh@reactrix.com> writes:

> - "git push" seems to pass --thin by default to http-push, which
>   subsequently barfs because that's not a valid http-push option.
>   Should it be?  Should it be silently ignored?  Should git-push not
>   default to --thin when pushing with HTTP transport?

The way I understand http-push works is that it does not use
packed transfer, so I presume even if we give --thin as a hint
it cannot even take advantage of it.  Probably we should stop
passing --thin to http transport (git native one uses it as a
cue that it can generate baseless deltas in the resulting pack).

> - when I clone, http-fetch outputs a whole bunch of 
>   "error: Could not read ..." messages - is that expected?

The clone over http seems to be severely broken in "next" right
now.  The one in "master" seems to be OK.  bisecting suggests
the breakage is coming from the tree parser rewrite.

bisect points at 136f2e548a34f1f504b0f062f87ddf33e8d6e83b.
