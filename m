From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Speed up history generation
Date: Fri, 30 Jun 2006 18:20:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606301818480.12404@g5.osdl.org>
References: <20060701005924.7726.qmail@web31812.mail.mud.yahoo.com>
 <7v7j2ygmou.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: ltuikov@yahoo.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 03:20:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwU9u-0006SK-EX
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 03:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWGABU1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 21:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWGABU1
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 21:20:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932116AbWGABU0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 21:20:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k611KMnW018939
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Jun 2006 18:20:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k611KLPU005633;
	Fri, 30 Jun 2006 18:20:22 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j2ygmou.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.84 required=5 tests=HTML_MESSAGE,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23027>



On Fri, 30 Jun 2006, Junio C Hamano wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Speed up history generation as suggested by Linus.
> > @@ -2295,16 +2295,12 @@ sub git_history {
> >  	      "</div>\n";
> >  	print "<div class=\"page_path\"><b>/" . esc_html($file_name) . "</b><br/></div>\n";
> >  
> > -	open my $fd, "-|", "$gitbin/git-rev-list $hash | $gitbin/git-diff-tree -r --stdin --
> > \'$file_name\'";
> > -	my $commit;
> > +	open my $fd, "-|", "$gitbin/git-rev-list $hash -- \'$file_name\'";
> 
> This would speed things up but at the same time it changes the
> semantics because it involves merge simplification, no?

Or just add a flag or config option that enables "--full-history" on that 
git-rev-list. Perhaps it should be the default fir gitweb.

With --full-history, it should still be better to do this inside 
git-rev-list than piping things into git-diff-tree just to limit by 
pathname..

		Linus
