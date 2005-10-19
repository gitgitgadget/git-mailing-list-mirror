From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [RFC] Timeouts on HTTP requests
Date: Wed, 19 Oct 2005 08:34:05 -0700
Message-ID: <20051019153405.GP5509@reactrix.com>
References: <20051018235104.GO5509@reactrix.com> <7voe5mgi3d.fsf@assigned-by-dhcp.cox.net> <20051019110909.GO30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 17:38:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESFxb-0003ow-N0
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 17:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVJSPed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 11:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVJSPed
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 11:34:33 -0400
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:22410 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751082AbVJSPec (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 11:34:32 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9JFY71A005773;
	Wed, 19 Oct 2005 08:34:07 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9JFY5dl005770;
	Wed, 19 Oct 2005 08:34:05 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20051019110909.GO30889@pasky.or.cz>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10292>

On Wed, Oct 19, 2005 at 01:09:10PM +0200, Petr Baudis wrote:

> > On the other hand, having _no_ activity for say 30 seconds would
> > indicate a dead link on either modem or localnet.
> 
> I agree that we should definitely use timeout instead of some low speed
> limit - can't curl do that?

Curl lets you set timeouts for the connect and the overall request, but
neither of these are related to activity.  In our case, some of the files
we transfer can be quite large and need to transfer over a 56K modem line.
As long as data is moving, we're happy; but we need the transfer to abort
if the connection drops and data stops moving completely.

> But 30 seconds is too little (on bad links, I've seen TCP connections
> stalled for much longer), I would use at least 120 seconds. Or perhaps
> 30 seconds, but retry three times or so.

I've been testing with low speed limit of 1 and low speed time of 300 - if
data transfer stays below 1 byte/sec for 5 minutes, curl aborts the transfer.

I like Junio's suggestion regarding defaults though, don't compile them in
but let default config templates take care of it.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
