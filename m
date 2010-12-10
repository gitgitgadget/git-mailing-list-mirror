From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 12/18] gitweb: Change file handles (in caching) to lexical
 variables as opposed to globs
Date: Thu, 09 Dec 2010 21:56:51 -0800
Message-ID: <4D01C123.9050806@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <1291931844-28454-13-git-send-email-warthog9@eaglescrag.net> <m3d3pa1o0j.fsf@localhost.localdomain> <7vwrnieac8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 06:55:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQvx0-0006l1-HJ
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 06:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab0LJFzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 00:55:10 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:36155 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016Ab0LJFzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 00:55:09 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA5t3Fh005148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 21:55:04 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <7vwrnieac8.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 21:55:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163389>

On 12/09/2010 04:32 PM, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>> +# Global declarations
>>> +our $cacheFile;
>>> +our $cacheFileBG;
>>> +our $cacheFileBinWT;
>>> +our $cacheFileBin;
>>
>> You are trading globs for global (well, package) variables.  They are
>> not lexical filehandles... though I'm not sure if it would be possible
>> without restructuring code; note that if variable holding filehandle
>> falls out of scope, then file would be automatically closed.
> 
> Hmm. why is it a bad idea, when you need to access these from practically
> everywhere, to use global variables to begin with?  To a certain degree,
> it sounds like an unnecessary burden without much gain to me.

This was why I used globs in the first place.

To answer Jakub's question first: yes, some of those are holding locks
open while things are happening.  Since there's locks open, through a
lot of functions, it's

Generally speaking I'm pretty good about opening and closing the files
when it's needed.  I *THINK* they can be made local variables, as I
don't think anything is kept open (within the caching engine) across
functions.

I've made a couple of changes, I'm going to have to test them, this
might be fixed in v9.

- John 'Warthog9' Hawley
