From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speed up history generation
Date: Fri, 30 Jun 2006 18:04:33 -0700
Message-ID: <7v7j2ygmou.fsf@assigned-by-dhcp.cox.net>
References: <20060701005924.7726.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 03:04:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwTuY-0004fy-9Q
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 03:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWGABEf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 21:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWGABEf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 21:04:35 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2474 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932237AbWGABEf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 21:04:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060701010434.WVAQ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 21:04:34 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060701005924.7726.qmail@web31812.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 30 Jun 2006 17:59:24 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23025>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Speed up history generation as suggested by Linus.
> @@ -2295,16 +2295,12 @@ sub git_history {
>  	      "</div>\n";
>  	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
>  
> -	open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin --
> \'$file_name\'";
> -	my $commit;
> +	open my $fd, "-|", "$gitbin/git-rev-list $hash -- \'$file_name\'";

This would speed things up but at the same time it changes the
semantics because it involves merge simplification, no?

At least that should be noted in the commit log.
