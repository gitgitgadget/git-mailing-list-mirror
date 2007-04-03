From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] gitweb: Few doublequoted strings cleanups
Date: Tue, 03 Apr 2007 13:20:33 -0700
Message-ID: <7vlkh9w6pa.fsf@assigned-by-dhcp.cox.net>
References: <200704012221.01676.jnareb@gmail.com>
	<200704012223.00087.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:20:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYpUg-0004B2-13
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbXDCUUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbXDCUUg
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:20:36 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36403 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422696AbXDCUUf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:20:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403202034.TJMM25613.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 16:20:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ikLZ1W00e1kojtg0000000; Tue, 03 Apr 2007 16:20:34 -0400
In-Reply-To: <200704012223.00087.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 1 Apr 2007 22:22:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43652>

Jakub Narebski <jnareb@gmail.com> writes:

> Replace a few doublequoted strings by theirs singlequoted equivalent,
> lose doublequotes around variable in string containing only
> of a variable name, use '' consistently as an empty string (and not
> sometimes as "").

Why?  I do not in particular like a micro-cleanup like this (it
seems more of personal taste than cleanup).

> -	} elsif ($char eq "\\") {
> +	} elsif ($char eq '\\') {
>  		$diff_class = " incomplete";
>  	}

Especially this makes a shell scripter think twice before
realizing that this is Perl and a backslash expands inside
single quotes.  In other words, I find that the former is easier
to read.

> @@ -1052,7 +1052,7 @@ sub git_get_projects_list {
>  		my $dir = $projects_list . ($filter ? "/$filter" : '');
>  		# remove the trailing "/"
>  		$dir =~ s!/+$!!;
> -		my $pfxlen = length("$dir");
> +		my $pfxlen = length($dir);

On the other hand, I think this makes the code easier to read.

> @@ -1261,7 +1261,7 @@ sub parse_tag {
>  		} elsif ($line =~ m/--BEGIN/) {
>  			push @comment, $line;
>  			last;

One thing I noticed is that we seem to have needless 'm' as in
the above m/--BEGIN/ in some places.  My preferences are (this
falls within "personal taste" category):

 * Unless the pattern has slashes, drop 'm' for match, always
   use '|' as the delimiter for substitution s/A/B;

 * If the pattern has slashes, consistently use the same
   alternate letter as the delimiter (gitweb seems to use '!').


> @@ -3616,7 +3616,7 @@ sub git_snapshot {
>  
>  	print $cgi->header(
>  		-type => "application/$ctype",
> -		-content_disposition => 'inline; filename="' . "$filename" . '"',
> +		-content_disposition => 'inline; filename="' . $filename . '"',
>  		-status => '200 OK');
>  

Wouldn't it be easier to read if we did

	"inline; filename=\"$filename\""

instead?
