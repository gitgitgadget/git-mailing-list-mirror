From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 04 Aug 2008 17:45:59 +0200
Message-ID: <48972437.5050008@dawes.za.net>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <20080804144824.GB27666@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 17:47:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ2HD-0001Kw-77
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 17:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbYHDPqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 11:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbYHDPqN
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 11:46:13 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:35663 "EHLO
	spunkymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752844AbYHDPqM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 11:46:12 -0400
Received: from [192.168.201.100] (unknown [41.247.123.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a2.g.dreamhost.com (Postfix) with ESMTP id 851AA88038;
	Mon,  4 Aug 2008 08:46:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080804144824.GB27666@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91376>

Shawn O. Pearce wrote:
> Rogan Dawes <lists@dawes.za.net> wrote:
>> Shawn O. Pearce wrote:
>>> 	Smart Server Detection
>>> 	----------------------
>>>
>>> 	To detect a smart (Git-aware) server a client sends an
>>> 	empty POST request to info/refs; [...]
>>>
>>> 		C: POST /repository.git/info/refs HTTP/1.0
>>> 		C: Content-Length: 0
>> I don't understand why you would want to keep the commands in the URL  
>> when you are doing a POST?
> 
> Well, as Dscho pointed out this partly has to do with caching and
> the transparent dumb server functionality.  By using the command in
> the URL, and having the command match that of the dumb server file,
> its easier to emulate a dumb server and also to permit caching.
> 
> Currently git-http-backend requests no caching for info/refs, but
> I could see us tweaking that to permit several minutes of caching,
> especially on big public sites like kernel.org.  Having info/refs
> report stale by 5 minutes is not an issue when writes to there
> already have a lag due to the master-slave mirroring system in use.

Fair enough, but what about the quote from RFC2616 that I posted in 
rebuttal to Dscho?

 > 13.10 Invalidation After Updates or Deletions
 >
 > ...
 >
 > Some HTTP methods MUST cause a cache to invalidate an entity. This is
 > either the entity referred to by the Request-URI, or by the Location
 > or Content-Location headers (if present). These methods are:
 >
 >       - PUT
 >       - DELETE
 >       - POST

This doesn't seem negotiable to me.

For those resources that are expected to be cacheable, the request 
should be made using a GET.

> Because git-http-backend emulates a dumb server there is a command
> dispatch table based upon the URL submitted.  Thus we already have
> the command dispatch behavior implemented in the URL and doing it
> in the POST body would only complicate the code further.

Not by a huge amount, surely?

if (method == "GET") command = ...
else if (method == "POST") command = ...
dispatch(command);

Rogan
