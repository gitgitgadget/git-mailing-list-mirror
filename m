From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 4 Aug 2008 18:24:59 -0700
Message-ID: <20080805012459.GC32543@spearce.org>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <20080804144824.GB27666@spearce.org> <4897A6E4.3070508@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rogan Dawes <lists@dawes.za.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 03:26:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQBJM-0006Zu-Ds
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 03:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbYHEBZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 21:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755605AbYHEBZA
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 21:25:00 -0400
Received: from george.spearce.org ([209.20.77.23]:60472 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466AbYHEBY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 21:24:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2E5D238419; Tue,  5 Aug 2008 01:24:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4897A6E4.3070508@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91399>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>>
>> Currently git-http-backend requests no caching for info/refs [...]
>
> Let's put it this way: we're not seeing a huge amount of load from git  
> protocol requests, and I'm going to assume "git+http" protocol to be  
> used only by sites behind braindamaged firewalls (everyone else would  
> use git protocol), so I'm not really all that worried about it.

Agreed.  There's another application I want git+http for, but that
may never materialize.  Or maybe it will someday.  I just have to
adopt a wait and see approach there.

> I'm not sure if "emulating a dumb server" is desirable at all; it seems  
> like it would at least in part defeat the purpose of minimizing the  
> transaction count and otherwise be as much of a "smart" server as the  
> medium permits.

I think it is a really good idea.  Then clients don't have to worry
about which HTTP URL is the "correct" one for them to be using.
End users will just magically get the smart git+http variant if
both sides support it and they need to use HTTP due to firewalls.
Clients will fall back onto the dumb protocol if the server doesn't
support smart clones.  Older clients (pre git+http) will still be
able to talk to a smart server, just slower.  This is nice for the
end user.  No thinking is required.

Never ask a human to do what a machine can do in less time.

I think its just 1 extra HTTP hit per fetch/push done against
a dumb server.  On a smart server that first hit will also give
us what we need to begin the conversation (the info/refs data).
On a dumb server its a wasted hit, but a dumb server is already
doing to suck.  One extra HTTP request against a dumb server is a
drop in the bucket.  Its also a pretty small request (an empty POST).

-- 
Shawn.
