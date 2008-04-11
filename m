From: david@lang.hm
Subject: Re: Corporate firewall braindamage
Date: Fri, 11 Apr 2008 01:25:08 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0804110123030.4615@asgard>
References: <47FE8277.8070503@zytor.com> <7v7if5wbdd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	ftpadmin <ftpadmin@kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 10:21:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkEVd-0007cE-JP
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 10:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbYDKIUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 04:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbYDKIUd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 04:20:33 -0400
Received: from mail.lang.hm ([64.81.33.126]:36677 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbYDKIUb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 04:20:31 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m3B8KE8j021391;
	Fri, 11 Apr 2008 01:20:14 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <7v7if5wbdd.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79268>

On Thu, 10 Apr 2008, Junio C Hamano wrote:

> "H. Peter Anvin" <hpa@zytor.com> writes:
>
>> 1. git protocol via CONNECT http proxy
>>
>>    Connect to http proxy, and use a CONNECT method to establish a link
>>    to the git server, using the normal git protocol.
>>
>>    Minor change to TCP connection setup, but no other changes needed.
>>    No changes on the server side.
>
> Many firewalls will detect that CONNECT will not going to 443 and block
> you, and even if you run git:// daemon on 443, they will detect that you
> are not talking SSL initial exchange and shut you off.
>
>> 2. git protocol over SSL via CONNECT http proxy
>>
>>    Same as #1, but encapsulate the data stream in an SSL connection.
>>    If the git server is run on port 443, then the fact that the data
>>    on the SSL connection isn't actually HTTP should be invisible to the
>>    proxy, and thus this *should* work anywhere which allows https://
>>    traffic.
>>
>>    Requires the git server to speak SSL.
>
> Yes, perhaps putting it behind an independent ssl relay would give you a
> solution without any code change.

in more pananoid locations they are putting client certs on desktops and 
giving those to the IDS systems so that they can decrypt the SSL traffic, 
so if it doesn't look like HTTP inside the SSL they will block it.

this isn't very common now, but the firewalls that are blocking #1 weren't 
very common a year or so ago either.

>> 3. git protocol encapsulated in HTTP POST transaction
>>
>>    git protocol is already fundamentally a RPC protocol, where the
>>    client sends a query and the server responds.  Furthermore, it
>>    tries to minimize the number of round trips (RPC calls), which is
>>    of course desirable.
>>
>>    Each such RPC transaction could be formulated as an HTTP POST
>>    transaction.
>>
>>    This requires modifications to both the client and the server;
>>    furthermore, the server can no longer rely on the invariant "one TCP
>>    connection == one session"; a proxy might break a single session
>>    into arbitrarily many TCP connections.
>
> It would probably be a one-CS/EE-student-half-a-summer sized project to
> create such a server-side support with a specialized client.

this is probably the best long-term option.

David Lang
