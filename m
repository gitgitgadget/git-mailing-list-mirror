From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 14/18] gitweb: add print_transient_header() function for
 central header printing
Date: Thu, 09 Dec 2010 22:18:24 -0800
Message-ID: <4D01C630.30400@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>	<1291931844-28454-15-git-send-email-warthog9@eaglescrag.net> <m34oam1n3t.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 07:19:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQwKB-0005lM-2r
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 07:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab0LJGQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 01:16:40 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:43663 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0LJGQj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 01:16:39 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA6GauF007076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 22:16:37 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m34oam1n3t.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 22:16:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163391>

>> +sub print_transient_header {
>> +	print $::cgi->header(
> 
> Why you use $::cgi->header() instead of equivalent $cgi->header()?
> Note that $::cgi->header() is $main::cgi->header(), and is not
> CGI::header().

Because $main::cgi already was setup.  Since I'm not redefining $cgi
anywhere they evaluate to the same thing since cgi is already a global
variable coming from gitweb itself.

The way I have it now is it's more explicit to being the parent (main).
 It doesn't really matter either way, but I can change it if you like.

>> +				-type=>'text/html',
>> +				-charset => 'utf-8',
>> +				-status=> 200,
>> +				-expires => 'now',
>> +				# HTTP/1.0
>> +				-Pragma => 'no-cache',
>> +				# HTTP/1.1
>> +				-Cache_Control => join(
>> +							', ',
>> +							qw(
>> +								private
>> +								no-cache
>> +								no-store
>> +								must-revalidate
>> +								max-age=0
>> +								pre-check=0
>> +								post-check=0
>> +							)
>> +						)
>> +				);
>> +	return;
>> +}
> 
> Why not use
> 
> 	our %no_cache = (
> 		# HTTP/1.0
> 		-Pragma => 'no-cache',
> 		# HTTP/1.1
> 		-Cache_Control => join(', ', qw(private no-cache no-store must-revalidate
> 		                                max-age=0 pre-check=0 post-check=0)),
> 	);
> 
> (or something like that).  This way you can reuse it even if content
> type is different (e.g. 'text/plain').
> 
> But that is just a proposal.

Finer grained control, though they have the same basic setup.  Probably
will add that, though it's not that big of a deal.

- John 'Warthog9' Hawley
