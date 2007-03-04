From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/6] Fix some "printf format" warnings.
Date: Sun, 04 Mar 2007 17:08:49 +0000
Message-ID: <45EAFD21.6010002@ramsay1.demon.co.uk>
References: <45E9BE46.1020801@ramsay1.demon.co.uk> <7v4pp29eok.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 04 19:54:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNvqu-0000iZ-Sn
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 19:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbXCDSya (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 13:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbXCDSy3
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 13:54:29 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:2919 "EHLO
	anchor-post-32.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752411AbXCDSy2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2007 13:54:28 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.42)
	id 1HNvqf-000PaZ-9T; Sun, 04 Mar 2007 18:54:22 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v4pp29eok.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41365>

Hi Junio,

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>> diff --git a/builtin-ls-files.c b/builtin-ls-files.c
>> index ac89eb2..5c990a5 100644
>> --- a/builtin-ls-files.c
>> +++ b/builtin-ls-files.c
>> @@ -193,7 +193,7 @@ static void show_ce_entry(const char *tag, struct cache_entry *ce)
>>  		putchar(line_terminator);
>>  	}
>>  	else {
>> -		printf("%s%06o %s %d\t",
>> +		printf("%s%06lo %s %d\t",
>>  		       tag,
>>  		       ntohl(ce->ce_mode),
>>  		       abbrev ? find_unique_abbrev(ce->sha1,abbrev)
> 
> I think the issue is ntohl() returns uint32_t, and this did not
> surface as an issue so far only because that type happens to be
> defined as 'unsigned int' on many systems.  Changing %o to %lo
> is shifting the breakage to other systems, isn't it?
> 
> I think we should do this instead:
> 
> 	printf("%s%06o %s %d\t", tag, (unsigned) ntohl(ce->ce_mode), ...
> 
> 

Oops, yes you are right.
(cygwin typedef's uint32_t as unsigned long.)

However, I would hate to add all those casts! Casts are not always evil, but
should be avoided if possible. Having said that, I don't see another solution ...
Hmmm, I dunno, your call ;-)

All the best,

Ramsay Jones
