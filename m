From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn failure when symlink added in svn
Date: Sun, 29 Apr 2007 15:21:36 -0700
Message-ID: <20070429222136.GA1800@untitled>
References: <loom.20070427T005115-751@post.gmane.org> <alpine.LFD.0.98.0704271100321.9964@woody.linux-foundation.org> <loom.20070428T144858-521@post.gmane.org> <7virbgjthr.fsf@assigned-by-dhcp.cox.net> <m2odl8fjv1.fsf@ziti.fhcrc.org> <7v7irwjql6.fsf@assigned-by-dhcp.cox.net> <m2k5vwfbf6.fsf@ziti.fhcrc.org> <7vwszwi0h2.fsf@assigned-by-dhcp.cox.net> <20070429183136.GE12375@untitled> <7vr6q2dhex.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Falcon <sethfalcon@gmail.com>,
	Alexander Klink <ak-git@cynops.de>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 30 00:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiHmA-0003MO-Ub
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 00:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161513AbXD2WVr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 18:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161519AbXD2WVq
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 18:21:46 -0400
Received: from hand.yhbt.net ([66.150.188.102]:35436 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161513AbXD2WVp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 18:21:45 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 5A7907DC0A0;
	Sun, 29 Apr 2007 15:21:43 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 29 Apr 2007 15:21:36 -0700
Content-Disposition: inline
In-Reply-To: <7vr6q2dhex.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45845>

Junio C Hamano <junkio@cox.net> wrote:
> diff --git a/git-svn.perl b/git-svn.perl
> index 4be8576..cef6697 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -2464,15 +2464,15 @@ sub close_file {
>  	my $hash;
>  	my $path = $self->git_path($fb->{path});
>  	if (my $fh = $fb->{fh}) {
> -		seek($fh, 0, 0) or croak $!;
> +		sysseek($fh, 0, 0) or croak $!;
>  		my $md5 = Digest::MD5->new;
>  		$md5->addfile($fh);

We may want to keep the plain seek() here and do both seek and sysseek,
I'm not sure if $md5->addfile() uses read or sysread internally.

-- 
Eric Wong
