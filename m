From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix bunch of fd leaks in http-fetch
Date: Sat, 12 Nov 2005 20:55:13 +0100
Message-ID: <20051112195513.GF30496@pasky.or.cz>
References: <dd9dee136a573d72fc7332373cfd8ac1@freescale.com> <20051111235516.GY30496@pasky.or.cz> <7vk6feiflx.fsf@assigned-by-dhcp.cox.net> <20051112173828.GG4051@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 20:56:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb1T6-0008Bb-RH
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 20:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVKLTzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 14:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVKLTzR
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 14:55:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:24284 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932486AbVKLTzQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 14:55:16 -0500
Received: (qmail 9896 invoked by uid 2001); 12 Nov 2005 20:55:13 +0100
To: Nick Hengeveld <nickh@reactrix.com>
Content-Disposition: inline
In-Reply-To: <20051112173828.GG4051@reactrix.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11701>

Dear diary, on Sat, Nov 12, 2005 at 06:38:28PM CET, I got a letter
where Nick Hengeveld <nickh@reactrix.com> said that...
> On Fri, Nov 11, 2005 at 09:45:30PM -0800, Junio C Hamano wrote:
> 
> > It strikes me somewhat odd that these close() are not tied to
> > the lifetime rule of the transfer_request structure.  When the
> > program falls back from an individual object to alternates, the
> > same request structure is reused, but in that case ->local stays
> > the same.  Otherwise, the original request structure is released
> > so I wonder if would make things cleaner to close ->local inside
> > request_release()...
> 
> That is the intent of the fd close in finish_request() - but that isn't
> called if the server returns a 404 and there are no alternates left to
> try.
> 
> The following patch should fix it.

What about the rest of the leaks?

Specifically, the one around release_request(), and the one caused by
re-open()ing local in start_request() when re-calling it on existing
request.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
