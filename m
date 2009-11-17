From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 15:59:53 -0800
Message-ID: <4B0338F9.9000608@eaglescrag.net>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com> <7vhbssewm7.fsf@alter.siamese.dyndns.org> <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com> <7vd43gerak.fsf@alter.siamese.dyndns.org> <4B032AC8.4@eaglescrag.net> <7vskccaf4q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sylvain Rabot <sylvain@abstraction.fr>, git <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 01:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAXyB-0007Qp-DN
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 01:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbZKRAAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 19:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZKRAAI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 19:00:08 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:54764 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbZKRAAH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 19:00:07 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nAHNxsj4013821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 17 Nov 2009 16:00:04 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <7vskccaf4q.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10030/Mon Nov 16 18:38:41 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Tue, 17 Nov 2009 16:00:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133113>

Junio C Hamano wrote:
> "J.H." <warthog19@eaglescrag.net> writes:
> 
>> For starters I think overriding the /~<user> (specifically the ~ here)
>> is going to be a bad idea no matter what you do and gives the wrong
>> impression about what / how the request is being responded to.  You
>> might want to try and pick a different delimiter or re-work the rule
>> so that you could have something like:
>>
>> 	http://git.kernel.org/<gitweb urls>
>> 	http://git.kernel.org/user/<gitweb urls>
> 
> I am not objecting but showing my ignorance, but why is it a bad idea to
> allow
> 
> 	http://git.kernel.org/~junio/git.git
> 
> to map to /home/junio/pubilic_git/git.git when
> 
> 	http://www.kernel.org/~junio/index.html
> 
> maps to /home/junio/public_html/index.html already?

I'm not objecting to the mapping, I'm objecting to the use of the ~ 
specifically, since that's the default for mod_userdir - it's more or 
less a race condition waiting to happen with respect to does mod_rewrite 
get to and process it first or does mod_userdir.

Case in point should:

assuming that www.example.com (to get away from the specifics of 
kernel.org) is running gitweb but you also wanted to allow users to show 
their ~/public_html directories then

	http://www.example.org/~junio/

could be ambiguous as to what should / is servicing the url.

Now in reality it should work because of how apache is setup, but I 
would argue it's a bad practice to overload the '~' designator like that 
for use in gitweb specifically.

If you have mod_userdir disabled / not available this isn't an issue, 
but making that assumption might be a bad idea.

- John 'Warthog9' Hawley
