From: Junio C Hamano <junkio@cox.net>
Subject: Re: git send-email woes
Date: Mon, 25 Sep 2006 21:11:30 -0700
Message-ID: <7vvenbuv0t.fsf@assigned-by-dhcp.cox.net>
References: <20060924224316.GA28051@uranus.ravnborg.org>
	<20060925183221.GE2490@uranus.ravnborg.org>
	<7v7izrzpk2.fsf@assigned-by-dhcp.cox.net>
	<20060925215127.GA3965@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 06:12:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS4IS-000673-Qg
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 06:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWIZELg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 00:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWIZELg
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 00:11:36 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32444 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750847AbWIZELc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 00:11:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926041131.BUBN6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 00:11:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SsBV1V0021kojtg0000000
	Tue, 26 Sep 2006 00:11:29 -0400
To: Sam Ravnborg <sam@ravnborg.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27764>

Sam Ravnborg <sam@ravnborg.org> writes:

>> @@ -431,6 +431,11 @@ sub send_message
>>  	    $gitversion =~ s/^.* //;
>>  	}
>>  
>> +	my ($author_name) = ($from =~ /^(.*?)\s+</);
>> +	if ($author_name =~ /\./ && $author_name !~ /^".*"$/) {
>> +		my ($name, $addr) = ($from =~ /^(.*?)(\s+<.*)/);
>> +		$from = "\"$name\"$addr";
>> +	}
>>  	my $header = "From: $from
>>  To: $to
>>  Cc: $cc
>> 
> I would assume we had to do the same for all mail addresses?
> In this case also for $to and $cc and $reply_to.

I do not think so, although I admit I only had a cursory look at
the code.  In this part of the code, $to and $cc are coming from
return value of unique_email_list sub, which cleanses each
address with extract_valid_address sub.  This sub does:

	A U Thor <foo@bar.baz> => foo@bar.baz

In other words, I think it is only "$from" that needs it.

I think $to and $cc should not strip out the human-readable name,
but in this case it saved us extra trouble.   Sigh...
