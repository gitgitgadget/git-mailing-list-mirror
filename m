From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 04 Aug 2008 18:35:15 -0700
Message-ID: <4897AE53.4030107@zytor.com>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <20080804144824.GB27666@spearce.org> <4897A6E4.3070508@zytor.com> <20080805012459.GC32543@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 03:36:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQBTR-0000eE-Sl
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 03:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757708AbYHEBfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 21:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbYHEBfY
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 21:35:24 -0400
Received: from terminus.zytor.com ([198.137.202.10]:52630 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbYHEBfX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 21:35:23 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m751ZHUY010779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2008 18:35:17 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m751ZHi1013292;
	Mon, 4 Aug 2008 18:35:17 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m751ZFg8008368;
	Mon, 4 Aug 2008 18:35:16 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080805012459.GC32543@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/7941/Mon Aug  4 15:44:27 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91401>

Shawn O. Pearce wrote:
> 
>> I'm not sure if "emulating a dumb server" is desirable at all; it seems  
>> like it would at least in part defeat the purpose of minimizing the  
>> transaction count and otherwise be as much of a "smart" server as the  
>> medium permits.
> 
> I think it is a really good idea.  Then clients don't have to worry
> about which HTTP URL is the "correct" one for them to be using.
> End users will just magically get the smart git+http variant if
> both sides support it and they need to use HTTP due to firewalls.
> Clients will fall back onto the dumb protocol if the server doesn't
> support smart clones.  Older clients (pre git+http) will still be
> able to talk to a smart server, just slower.  This is nice for the
> end user.  No thinking is required.
> 
> Never ask a human to do what a machine can do in less time.
> 
> I think its just 1 extra HTTP hit per fetch/push done against
> a dumb server.  On a smart server that first hit will also give
> us what we need to begin the conversation (the info/refs data).
> On a dumb server its a wasted hit, but a dumb server is already
> doing to suck.  One extra HTTP request against a dumb server is a
> drop in the bucket.  Its also a pretty small request (an empty POST).
> 

Not arguing that URL compatibility isn't a good thing, but there are 
other ways to accomplish it, too.  After detecting either a smart or 
dumb server, we can use a redirect to point them to a different URL, as 
appropriate.

Furthermore, in the case of round-robin sites like kernel.org, this is 
actually *mandatory* in the case of a stateful server (we need a 
redirect to a server-specific URL), and highly recommended in the case 
of a stateless server (because of potential skew.)

	-hpa
