From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git send-email woes
Date: Mon, 25 Sep 2006 23:51:27 +0200
Message-ID: <20060925215127.GA3965@uranus.ravnborg.org>
References: <20060924224316.GA28051@uranus.ravnborg.org> <20060925183221.GE2490@uranus.ravnborg.org> <7v7izrzpk2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 23:51:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRyMP-0007al-1B
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 23:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWIYVva (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 17:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWIYVva
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 17:51:30 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:35537 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1750851AbWIYVv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 17:51:29 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id DB534E309E8;
	Mon, 25 Sep 2006 23:51:27 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id CB6A8580D2; Mon, 25 Sep 2006 23:51:27 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7izrzpk2.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27756>

On Mon, Sep 25, 2006 at 12:58:21PM -0700, Junio C Hamano wrote:
> Sam Ravnborg <sam@ravnborg.org> writes:
> 
> > The patches in quistion did not have a "Signed-off-by: tag so
> > that mail address has been from the author instead.
> > And this mail address was still invalid as per RFC2822.
> 
> I do not think it takes Signed-off-by: as author in any case
> (and I do not think it should -- if it did so it is a bug).
> 
> Maybe something like this?
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 746c525..b4a34f4 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -431,6 +431,11 @@ sub send_message
>  	    $gitversion =~ s/^.* //;
>  	}
>  
> +	my ($author_name) = ($from =~ /^(.*?)\s+</);
> +	if ($author_name =~ /\./ && $author_name !~ /^".*"$/) {
> +		my ($name, $addr) = ($from =~ /^(.*?)(\s+<.*)/);
> +		$from = "\"$name\"$addr";
> +	}
>  	my $header = "From: $from
>  To: $to
>  Cc: $cc
> 
I would assume we had to do the same for all mail addresses?
In this case also for $to and $cc and $reply_to.

	Sam
