From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb chokes on recursive symlink
Date: Sat, 28 Jul 2007 00:57:21 +0200
Message-ID: <200707280057.22311.jnareb@gmail.com>
References: <7v8x922r2w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 00:57:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEYkT-0002XG-ET
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 00:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937432AbXG0W50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 18:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763560AbXG0W50
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 18:57:26 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:43778 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937342AbXG0W5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 18:57:25 -0400
Received: by ik-out-1112.google.com with SMTP id b32so767496ika
        for <git@vger.kernel.org>; Fri, 27 Jul 2007 15:57:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dsT51/T4yk1BGmcENJ06aB7m1Hx3EnJwfoIbshBkPjGiwnOuvxlbMwzkJxl7zCt+ZB9z9dy91xiANA30sXNQSZ3u1G2wdneMJz2zl1y68z+mam4X85U//+k2u9c0Cnw1hqvlXRtnov/7BkCTzqMpPkYbncdPz3jOiNSX8PRKxQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gYjDMPygXchgeErDv4for8Ys1W3RVrpCA1M5obpHlGQBcptGIYFivXnYCnvZIoLztu8TJn6IuStzWVnVXM/0U2WtTOSs5NwPr8DyOM9v4CmuoyHopIS3weBERKoM1N/lJWo+cunjy+EL7pnjM2tHiqIMrMVPSrUtTP9zpwMKfjs=
Received: by 10.86.4.2 with SMTP id 2mr2314515fgd.1185577043764;
        Fri, 27 Jul 2007 15:57:23 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id g8sm945870muf.2007.07.27.15.57.21
        (version=SSLv3 cipher=OTHER);
        Fri, 27 Jul 2007 15:57:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8x922r2w.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53973>

Junio C Hamano wrote:

[cut explanation about why one would want something like below]
 
> 	ln -s /pub /pub/pub
[...]
> However, gitweb chokes if there is such a symlink (File::Find
> barfs with "/pub/pub is a recursive symbolic link" --- I think
> this is because you use "follow_fast => 1").
> 
> As I happen to think using a symlink that goes up for backward
> compatible URL support is a rather common practice, I think we
> should do something about it.  My gut feeling is that we could
> simply ignore such symlinks.
> 
> What do you think about this issue?
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index b381692..c8ad84e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1492,6 +1492,7 @@ sub git_get_projects_list {
>  
>  		File::Find::find({
>  			follow_fast => 1, # follow symbolic links
> +			follow_skip => 2, # ignore duplicates
>  			dangling_symlinks => 0, # ignore dangling symlinks, silently
>  			wanted => sub {
>  				# skip project-list toplevel, if we get it.
> 

I guess that is a good solution, but I'm not Perl expert...

-- 
Jakub Narebski
Poland
