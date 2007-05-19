From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Fix "Use of uninitialized value" warning in git_feed
Date: Fri, 18 May 2007 19:49:11 -0700
Message-ID: <7vps4x34uw.fsf@assigned-by-dhcp.cox.net>
References: <1179535671566-git-send-email-jnareb@gmail.com>
	<7vtzu937t6.fsf@assigned-by-dhcp.cox.net>
	<200705190408.40702.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 04:49:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpF0V-0005xV-Ek
	for gcvg-git@gmane.org; Sat, 19 May 2007 04:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbXESCtN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 22:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbXESCtN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 22:49:13 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60553 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437AbXESCtM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 22:49:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519024912.CJGH2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 22:49:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0qpB1X0051kojtg0000000; Fri, 18 May 2007 22:49:11 -0400
In-Reply-To: <200705190408.40702.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 19 May 2007 04:08:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47706>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> Initial (root) commit has no parents, and $co{'parent'} is
>>> undefined. Use '--root' for initial commit.
>>>
>>> This fixes "Use of uninitialized value in open at gitweb/gitweb.perl
>>> line 4925." warning.
> [...]
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -4923,7 +4923,8 @@ XML
>>>  
>>>  		# get list of changed files
>>>  		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
>>> -			$co{'parent'}, $co{'id'}, "--", (defined $file_name ? $file_name : ())
>>> +			$co{'parent'} || "--root",
>>> +			$co{'id'}, "--", (defined $file_name ? $file_name : ())
>>>  			or next;
>>>  		my @difftree = map { chomp; $_ } <$fd>;
>>>  		close $fd
>> 
>> I do not think you would need to make --root conditional...
>
> I need at last make $co{'parent'} conditional, i.e. at least 
> "$co{'parent'} || ()" or equivalent (e.g. like for $file_name).
> I cannot omit $co{'parent'} because parents might be rewritten;
> feeds accept now path limiting. So why not this way?

Ah, clever (buuuuuuut misleading) ;-)
