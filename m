From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Mon, 25 Aug 2008 21:14:56 -0700
Message-ID: <48B38340.8050504@zytor.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826034544.GA32334@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 06:16:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXpyU-0001jd-RU
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 06:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbYHZEO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 00:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbYHZEO7
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 00:14:59 -0400
Received: from terminus.zytor.com ([198.137.202.10]:37780 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbYHZEO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 00:14:58 -0400
Received: from [172.27.2.85] (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7Q4EuZ0024037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Aug 2008 21:14:57 -0700
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080826034544.GA32334@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/8089/Mon Aug 25 17:28:51 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93706>

Shawn O. Pearce wrote:
> 
> So I think the cost may actually break even with a stateful protocol
> if we imagine that the server is actually a farm of systems and
> simple round-robin load-balancing is being done in front of the
> Git-aware server.
> 
> I'd really like to keep the protocol stateless on the server side, as
> this makes it easier to embed into certain commerical server farms.
> 

Indeed.  It was a question, not a statement of any sort.  I was curious 
about the answer.

I really like the new draft, with the one consideration below.

> 
> HTTP Transport
> --------------
> 
> All requests are encoded as HTTP POST requests to the smart service
> URL, "$url/backend.git-http/$service".
> 
> All responses are encoded as 200 Ok responses, even if the server
> side has "failed" the request.  Service specific success/failure
> codes are embedded in the content.
> 

I still would like to have an indirection step at the start, in order to 
keep a single client on a server in the case of skew.  I suggest simply 
do it as HTTP POST $url/backend.git-http, empty body, and return a URL 
prefix to use for the remainder of the session.  That way a server who 
wants a stateful setup can return a URL which contains a session cookie; 
others can return a URL containing a target server, and finally others 
can simply return the requesting URL.

	-hpa
