From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 13/18] gitweb: Add commented url & url hash to page footer
Date: Thu, 09 Dec 2010 22:10:05 -0800
Message-ID: <4D01C43D.6070803@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>	<1291931844-28454-14-git-send-email-warthog9@eaglescrag.net> <m38vzy1nkl.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 07:08:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQw9b-00025o-1q
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 07:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143Ab0LJGIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 01:08:21 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:42609 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab0LJGIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 01:08:21 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA68Ibx006370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 22:08:18 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m38vzy1nkl.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 22:08:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163390>

>> <!--
>> 	Full URL: |http://localhost/gitweb-caching/gitweb.cgi?p=/project.git;a=summary|
>> 	URL Hash: |7a31cfb8a43f5643679eec88aa9d7981|
>> -->
> 
> Nice idea.  It helps with debugging and doesn't introduce information
> leakage.

That was the plan, and I've already got a scenario where it would be useful.

>> The first bit tells you what the url that generated the page actually was, the second is
>> the hash used to store the file with the first two characters being used as the directory:
>>
>> <cachedir>/7a/31cfb8a43f5643679eec88aa9d7981
> 
> Isn't it
> 
>   <cachedir>/7a/7a31cfb8a43f5643679eec88aa9d7981
> 
> in your series?

Nope

	our $fullhashdir = "$cachedir/". substr( $urlhash, 0, 2) ."/";

and then a couple of lines later:

	$fullhashpath = "$fullhashdir/". substr( $urlhash, 2 );

right at the top of cache_fetch()

>> Also useful for greping through the existing cache and finding files with unique paths that
>> you may want to explicitly flush.
> 
> Though probably better 'cache_admin' page would be ultimately best
> solution, see proof of concept in

The biggest problem with the cache admin page you've got there, is that
gitweb itself doesn't have a framework for user administration,
privileges, etc.  Limiting it to the local machine is also useless,
there are very few people who are going to have access, from 127.0.0.1
to their web server, and this also breaks anything even remotely
resembling virtual hosts.

The fact that it's unusable from virtual hosts makes this pretty much DOA.

Like I've said in the past, we need to at least look at web frameworks
for gitweb, and if we want to provide things like the admin page than we
need to consider that we are going to need user management.  That, in
particular, starts drifting towards needing a database to store things
in and I for one am *NOT* in favor of that.

I like the idea of a framework helping deal with things like page
layout, separating data access from content, etc.  I do not like the
idea of gitweb having a full blown setup with a database and all behind it.

- John 'Warthog9' Hawley
