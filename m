From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] describe: fall back to 'HEAD' if no appropriate tag exists
Date: Thu, 21 Sep 2006 08:43:46 +0100
Message-ID: <451242B2.7090508@shadowen.org>
References: <Pine.LNX.4.63.0609202324210.19042@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xkef97b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 09:44:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQJEM-0003tt-Cf
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 09:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWIUHoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 03:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbWIUHoM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 03:44:12 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:4114 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1750919AbWIUHoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 03:44:10 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GQJDi-0001Bv-0D; Thu, 21 Sep 2006 08:43:42 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xkef97b.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27463>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Now, if no tag exists to say something like '<tag>-gfffffff', say
>> 'HEAD-gfffffff' instead of erroring out.
>>
>> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> ---
>>  describe.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/describe.c b/describe.c
>> index ab192f8..8b08a3f 100644
>> --- a/describe.c
>> +++ b/describe.c
>> @@ -136,7 +136,7 @@ static void describe(const char *arg, in
>>  			return;
>>  		}
>>  	}
>> -	die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
>> +	printf("HEAD-g%s\n", find_unique_abbrev(cmit->object.sha1, abbrev));
>>  }
> 
> Hmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm.
> 
> At least with tags, the user can assume NAME-gREV means commit
> whose abbrev is REV that is descendant of NAME.  HEAD is not
> necessarily so.
> 
> Having said that, in order to avoid barfing, we have to have
> something there, and HEAD is already special in many aspects
> anyway (e.g. by only saying HEAD you cannot tell which branch's
> tip you are talking about), it might be good enough.
> 
> I am just wondering if there is some other obvious substitute
> that is better than HEAD.  "GIT-g%s" is not it ("g" already
> stands for GIT).
> 
> Another possibility is just to do
> 
>         puts(sha1_to_hex(cmit->object.sha1))
> 
> in this case.  I tend to like that better somehow; it makes
> things more explicit.

Heh, we've just been putting together 'versioner' for some software and
when git-describe fails we substitute in the complete sha1 at that
point.  Based mostly on the "who'd release something versioned without
tagging anyhow".  I think either the full sha1 or _just_ the gNNNNN
without prefix would be fine.

-apw
