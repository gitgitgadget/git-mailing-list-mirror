From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Show URL in the "Getting <foo> list" http-fetch messages
Date: Mon, 14 Nov 2005 11:02:26 -0800
Message-ID: <20051114190225.GA3793@reactrix.com>
References: <20051112004958.21857.95728.stgit@machine.or.cz> <20051112005803.GZ30496@pasky.or.cz> <7vwtjeis09.fsf@assigned-by-dhcp.cox.net> <20051112172201.GF4051@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 20:05:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbjbQ-0005w8-8X
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 20:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVKNTCt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 14:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKNTCs
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 14:02:48 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:22198 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751233AbVKNTCs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 14:02:48 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAEJ2QEr006772;
	Mon, 14 Nov 2005 11:02:26 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAEJ2QDP006770;
	Mon, 14 Nov 2005 11:02:26 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20051112172201.GF4051@reactrix.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11837>

On Sat, Nov 12, 2005 at 09:22:02AM -0800, Nick Hengeveld wrote:

> This should not be an issue with index requests because they are only
> initiated from fetch().  The previous patch to load alternates on demand
> added alternate handling to process_curl_messages() so that a 404 for an
> object can be handled immediately rather than waiting for the fetch()
> call for that object to notice.

Seems like it might make sense to handle pack downloads immediately when
an object is unavailable rather than waiting for the fetch() call.  It
could prevent attempts to download any other objects inside that pack,
although queued requests that activate while a pack is downloading
would have to wait to see whether the download is successful.  If such
an object also exists loose it would prevent a redundant download and if
not it would at least prevent an unnecessary check and 404.

Thoughts?

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
