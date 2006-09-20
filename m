From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read
 refs V3
Date: Wed, 20 Sep 2006 18:00:33 +0100
Message-ID: <451173B1.4060305@shadowen.org>
References: <45116888.4050806@shadowen.org>	<20060920163704.GA27407@shadowen.org> <7vodtaiijt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 19:02:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5Rs-0006Mp-Pp
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 19:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbWITRBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 13:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWITRBA
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 13:01:00 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:21775 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751933AbWITRA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 13:00:56 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GQ5Qy-0007lC-F9; Wed, 20 Sep 2006 18:00:28 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodtaiijt.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27380>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>> +	my $fmt = '($ref, $author) = (%(refname), %(author));';
>> +	open(H, "git-for-each-ref --perl --format='$fmt'|") or
>> +		die "Cannot run git-for-each-ref: $!\n";
>> +	while(defined(my $entry = <H>)) {
>> +		my ($ref, $author);
>> +		eval($entry) || die "cannot eval refs list: $@";
>> +
>> +		next if ($ref !~ m@^refs/heads/(.*)$@);
>> +		my ($head) = ($1);
>> +		$author =~ /^.*\s(\d+)\s[-+]\d{4}$/;
>> +		$branch_date{$head} = $1;
>>  	}
>> -	closedir(D);
>> +	close(H);
>>  }
> 
> for-each-ref let's you limit the refs by leading path, so I do
> not think "next if" inside the loop is needed if you say
> 
> 	for-each-ref --perl --format=$fmt refs/heads

Stupid boy :)

> 
> Any reason you did not like my version that allows you to get
> rid of the while() loop altogether?  (hint: replace eval in my
> example with "print" and see what you are evaling)

To my mind we avoid the 'mozilla repo' issue of 1000's of heads
busting some string length limit, or requiring some _vast_ string to
hold it (as perl is likely to cope).  Given we are sifting a small
percentage of the data out of it.

Let me know which way you want it and we'll go that way :).

-apw
