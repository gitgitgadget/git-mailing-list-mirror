From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Convert Content-Disposition filenames into qtext
Date: Sat, 07 Oct 2006 03:34:02 -0700
Message-ID: <7vvemwqusl.fsf@assigned-by-dhcp.cox.net>
References: <20061006192006.GW20017@pasky.or.cz>
	<20061006193059.21334.qmail@web31807.mail.mud.yahoo.com>
	<7vk63ctq47.fsf@assigned-by-dhcp.cox.net> <eg7u5n$mt9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Sat Oct 07 12:34:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW9VT-0004XO-4K
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 12:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWJGKeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 06:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWJGKeF
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 06:34:05 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37374 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750807AbWJGKeD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 06:34:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007103402.UFKX22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 06:34:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XNa51V00A1kojtg0000000
	Sat, 07 Oct 2006 06:34:05 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eg7u5n$mt9$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	07 Oct 2006 12:06:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28472>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Luben Tuikov <ltuikov@yahoo.com> writes:
>> 
>>>>> +# Convert a string (e.g. a filename) into qtext as defined
>>>>> +# in RFC 822, from RFC 2183.  To be used by Content-Disposition.
>>>>> +sub to_qtext {
>>>>> +  my $str = shift;
>>>>> +  $str =~ s/\\/\\\\/g;
>>>>> +  $str =~ s/\"/\\\"/g;
>
> Here probably it could be
>         $str =~ s/"/\\"/g;
>
>>>>> +  $str =~ s/\r/\\r/g;
>>>> 
>>>> \r? Not \n?
>>>
>>> Yes, \r, not \n.
>> 
>> \r to \\r? Not to \\\r?
>
> We want "\r" in suggested filename, not "\
> " I think, so it is "\\r".

Is that what you guys are attempting to achieve?

If we are trying to suggest a filename that is safe by avoiding
certain characters, I suspect leaving a backslash and dq as-is
is just as bad as leaving a CR in.  So if that is the goal here,
I think it might be better and a lot simpler to just replace
each run of bytes not in Portable Filename Character Set with an
underscore '_'.
