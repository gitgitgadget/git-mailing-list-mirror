From: Stephan Peijnik <stephan@peijnik.at>
Subject: Re: git smart protocol via WebSockets - feedback wanted
Date: Tue, 05 Jun 2012 21:28:31 +0200
Message-ID: <jqlml0$83h$1@dough.gmane.org>
References: <jqlim2$6vt$1@dough.gmane.org> <7vpq9dobjo.fsf@alter.siamese.dyndns.org> <jqljtk$h6d$1@dough.gmane.org> <CAJo=hJue20kwo-jo8x8dC7AUVs3oP=ZC9aCq_ncq3+MWr9VmgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 21:29:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbzR9-0005Gq-5G
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 21:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232Ab2FET2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 15:28:48 -0400
Received: from plane.gmane.org ([80.91.229.3]:45326 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab2FET2s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 15:28:48 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SbzQq-0004UT-Oz
	for git@vger.kernel.org; Tue, 05 Jun 2012 21:28:44 +0200
Received: from 178-190-4-245.adsl.highway.telekom.at ([178.190.4.245])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 21:28:44 +0200
Received: from stephan by 178-190-4-245.adsl.highway.telekom.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 21:28:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 178-190-4-245.adsl.highway.telekom.at
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <CAJo=hJue20kwo-jo8x8dC7AUVs3oP=ZC9aCq_ncq3+MWr9VmgQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199282>

On 06/05/2012 08:54 PM, Shawn Pearce wrote:
> On Tue, Jun 5, 2012 at 11:41 AM, Stephan Peijnik<stephan@peijnik.at>  wrote:
>> To be honest, I didn't know smart-http support yet. Is that the approach
>> introduced with git 1.6.6?
>
> Yes. So its been around for a while now. Like 2 years.

I have just read-up on that. My fault.

>> If so, that approach uses multiple POST requests, meaning multiple TCP and
>> HTTP connections need to be established, multiple requests processed, etc.
>
> Its actually only one TCP connection... assuming the servers in
> between the client and the Git endpoint correctly support HTTP
> keep-alive semantics.

With keep-alive that is true, but a quick check on the actual data 
exchange tells me that multiple HTTP requests are still needed. But I 
guess the overhead caused by a second HTTP requests can be ignored.

> How does this fair going through crappy proxy servers that perform
> man-in-the-middle attacks on SSL connections? Just last week I was
> trying to help someone whose local proxy server was MITM the SSL
> session behind Git's back, and their IT department forgot to install
> the proxy server's certificate into the system certificate directory.
> They only installed it into the browser. That proxy also doesn't
> correctly grok HTTP 1.1 keep-alive with chunked transfer encodings.
> Let alone something as new as web sockets.

Proxy servers could be an issue, yes. For proxy servers not acting as 
MITM and which are supporting CONNECT this shouldn't be an issue though.
Also, given the current HTML5 hype things should get better in the 
future, but you are correct about potential current issues with the 
approach.

>> So in comparison there is possibly a lot less overhead and, in theory, the
>> performance should be comparable to running the smart protocol over ssh.
>> Personally I'd say the WebSocket approach is cleaner than the HTTP-POST
>> approach.
>
> This may be true. But its also a lot more complex to implement. I
> noticed you reused Python code to help make this work.

The only reason I used Python is that I wanted to quickly come up with a 
prototype. I am also aware of the fact that a proper implementation 
should possibly be done in C.

> Let me know when there is a GPLv2 client library that implements sufficient
> semantics for WebSockets that Git can bundle it out of the box.

As for the WebSocket client library that is GPLv2 compatible: there is 
at least libwebsockets [0], which is licensed under the terms of the 
LGPL v2.1, and as such GPLv2 only compatible.
What do you think about using this as basis for a proper implementation?

> And let me know when most corporate IT proxy servers correctly grok
> WebSockets. I suspect it will be many more years given that they still
> can't even grok chunked transfer encoding.

As stated above, this could be a problem, yes.
The question is whether one only wants to provide an alternative 
approach when it is usable for everyone.
My intention never was to have the current http implementation, be it 
the dumb or http-backend one, replaced. The idea here was to provide an 
additional option that makes use of a fairly new technology, with all 
benefits and drawbacks of using something new.

Thanks for your feedback.

-- Stephan

[0] http://git.warmcat.com/cgi-bin/cgit/libwebsockets/
