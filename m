From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speed up history generation
Date: Fri, 30 Jun 2006 18:20:51 -0700
Message-ID: <7v3bdmglxo.fsf@assigned-by-dhcp.cox.net>
References: <7v7j2ygmou.fsf@assigned-by-dhcp.cox.net>
	<20060701011112.892.qmail@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 03:20:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwUAL-0006VV-2P
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 03:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWGABUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 21:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWGABUy
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 21:20:54 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:3262 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932492AbWGABUx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 21:20:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060701012052.XJST18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 21:20:52 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060701011112.892.qmail@web31813.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 30 Jun 2006 18:11:12 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23028>

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Junio C Hamano <junkio@cox.net> wrote:
>...
>> > @@ -2295,16 +2295,12 @@ sub git_history {
>> >  	      "</div>\n";
>> >  	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
>> >  
>> > -	open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin --
>> > \'$file_name\'";
>> > -	my $commit;
>> > +	open my $fd, "-|", "$gitbin/git-rev-list $hash -- \'$file_name\'";
>> 
>> This would speed things up but at the same time it changes the
>> semantics because it involves merge simplification, no?
>> 
>> At least that should be noted in the commit log.
>
> Ok, I guess this should be in the log.  Can you add it please when
> commiting to the master git branch?

Well, by "at least", what I meant was that it might make sense
to pass "--full-history" option to be more compatible with the
original output.  For graphical output like gitk, --full-history
makes a mess on the screen, but a list-oriented output like
gitweb it might be less confusing to show all the alternate
paths that touched the path than leaving some histories out.
