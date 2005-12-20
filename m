From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [PATCH] Fix unconditional early exit in cg-fetch
Date: Tue, 20 Dec 2005 16:25:07 +0100
Message-ID: <200512201625.09767.blaisorblade@yahoo.it>
References: <20051219161736.18245.98591.stgit@zion.home.lan> <7vpsnso9g8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 16:29:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EojMy-000433-2e
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 16:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbVLTPZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 10:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVLTPZg
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 10:25:36 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:19882 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751094AbVLTPZg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 10:25:36 -0500
Received: (qmail 26113 invoked from network); 20 Dec 2005 15:25:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Z39KdenCQe+EbGKgvQuGChkIy6U/vQp9p8xkMPvy8HJHgVWmIgIXE5eVt60fksVtArAL3UzWuAaYSf+iqpGNhK1LJMLAWgJB609A9vQlcILu4oMj66V8uET8gV78HYx7TJAS4l00K1MpZrPt5/QE7a6DxxoegGuvsWF72QGzy7Y=  ;
Received: from unknown (HELO zion.home.lan) (blaisorblade@82.55.100.234 with login)
  by smtp005.mail.ukl.yahoo.com with SMTP; 20 Dec 2005 15:25:24 -0000
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.3
In-Reply-To: <7vpsnso9g8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13849>

On Tuesday 20 December 2005 02:15, Junio C Hamano wrote:
> Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> writes:
> >  	if [ "$get" = "get_rsync" ]; then
> >  		$get -i -s -u -d "$uri/refs/tags" "$_git/refs/tags" ||
> > -			echo "unable to get tags list (non-fatal)" >&2
> > -		exit $?
> > +			(echo "unable to get tags list (non-fatal)" >&2;
> > +			exit $?)
> >  	fi

> Why would you want a subshell that exits with a non-zero status
> when nobody is checking that status anyway?

Argh, I should have used a proper conditional statement... I always forget 
bash is not Perl.

> I suspect removing "exit $?" would suffice, if that condition is
> non-fatal as the message says...

Likely you need to skip git-ls-remote (not sure however, but it's an 
exceptional condition).

return $? would be IMHO also fine - the caller is then free to ignore the 
return code.

I'm then resending the patch done the second way - feel free to merge any 
version.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
