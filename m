From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read refs V3
Date: Wed, 20 Sep 2006 09:55:50 -0700
Message-ID: <7vodtaiijt.fsf@assigned-by-dhcp.cox.net>
References: <45116888.4050806@shadowen.org>
	<20060920163704.GA27407@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:57:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5MY-0004m9-Tt
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWITQzx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWITQzx
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:55:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6357 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751810AbWITQzw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:55:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920165551.JSPE13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 12:55:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qgvd1V00N1kojtg0000000
	Wed, 20 Sep 2006 12:55:37 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20060920163704.GA27407@shadowen.org> (Andy Whitcroft's message
	of "Wed, 20 Sep 2006 17:37:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27378>

Andy Whitcroft <apw@shadowen.org> writes:

> +	my $fmt = '($ref, $author) = (%(refname), %(author));';
> +	open(H, "git-for-each-ref --perl --format='$fmt'|") or
> +		die "Cannot run git-for-each-ref: $!\n";
> +	while(defined(my $entry = <H>)) {
> +		my ($ref, $author);
> +		eval($entry) || die "cannot eval refs list: $@";
> +
> +		next if ($ref !~ m@^refs/heads/(.*)$@);
> +		my ($head) = ($1);
> +		$author =~ /^.*\s(\d+)\s[-+]\d{4}$/;
> +		$branch_date{$head} = $1;
>  	}
> -	closedir(D);
> +	close(H);
>  }

for-each-ref let's you limit the refs by leading path, so I do
not think "next if" inside the loop is needed if you say

	for-each-ref --perl --format=$fmt refs/heads

Any reason you did not like my version that allows you to get
rid of the while() loop altogether?  (hint: replace eval in my
example with "print" and see what you are evaling)
