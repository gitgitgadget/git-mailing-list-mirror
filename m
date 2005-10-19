From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Timeouts on HTTP requests
Date: Tue, 18 Oct 2005 23:02:14 -0700
Message-ID: <7voe5mgi3d.fsf@assigned-by-dhcp.cox.net>
References: <20051018235104.GO5509@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 08:04:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES73F-0007oQ-5v
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 08:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbVJSGCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 02:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbVJSGCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 02:02:16 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62126 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751534AbVJSGCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 02:02:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019060204.GAYS16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 02:02:04 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051018235104.GO5509@reactrix.com> (Nick Hengeveld's message of
	"Tue, 18 Oct 2005 16:51:04 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10265>

Nick Hengeveld <nickh@reactrix.com> writes:

> Our QA department today checked what would happen if the network connection
> went away completely in the middle of an HTTP transfer.  It looks as though
> the answer is that git-http-fetch sits there forever waiting for CURL to
> return something.

Ouch.

> I'm thinking of taking advantage of CURL's capability of aborting a request
> if the transfer rate drops below a threshold for a specified length of time
> using a new pair of environment variables and/or config file settings:
>
> GIT_HTTP_LOW_SPEED_LIMIT/http.lowspeedlimit
> GIT_HTTP_LOW_SPEED_TIME/http.lowspeedtime
>
> Does this make sense, and if so should there be defaults if nothing is
> specified?

I suspect these would be quite different between DSL and
localnet, so I doubt if there is a reasonable default value to
quick give-up.

On the other hand, having _no_ activity for say 30 seconds would
indicate a dead link on either modem or localnet.

BTW, I've been thinking about giving defaults by shipping
templates/config (i.e. no compile-time defaults).  One trick I
found cute is to have "clone.keeppack = 1" in the templates to
be applied for any newly built repository, especially now
kernel.org has git-daemon enabled.
