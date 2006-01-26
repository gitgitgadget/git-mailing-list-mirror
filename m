From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: git describe fails without tags
Date: Thu, 26 Jan 2006 08:44:21 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060126074421.GA2941@informatik.uni-freiburg.de>
References: <20060125074725.GA2768@informatik.uni-freiburg.de> <7vek2wws61.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 08:44:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F21nv-0005EK-EH
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 08:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWAZHoY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 02:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWAZHoY
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 02:44:24 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:7071 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751009AbWAZHoX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 02:44:23 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1F21nq-0005eH-FL; Thu, 26 Jan 2006 08:44:22 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0Q7iMAG003379;
	Thu, 26 Jan 2006 08:44:22 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0Q7iLVO003378;
	Thu, 26 Jan 2006 08:44:21 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vek2wws61.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15150>

Hello Junio,

Junio C Hamano wrote:
> Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:
> 
> > I wonder if it would be sane to assume an implicit tag for the empty
> > repository, s.t. git describe results in 
> >
> > 	<empty>-62ac6c16
> >
> > (whatever name is choosen for <empty>).
> >
> > Any opinions?
>
> [...] If the reason you are doing "describe" is to find out an usable
> abbreviated name, you could feed the first few hexdigits to "git
> rev-parse --verify", lengthening the prefix longer by one until it
> says you have a unique prefix [*1*].
Yes, I wrote a script that automatically build git and install it to
${HOME}/usr/stow/git-`git describe HEAD` and then stow(8)s it.  Writing
a similar script for sparse cannot use git describe because there are no
tags ...
 
> In other words, not particularly interested, although it is
> trivial to implement, like this:
> 
> diff --git a/describe.c b/describe.c
> index 4866510..aeaf0fb 100644
> --- a/describe.c
> +++ b/describe.c
> @@ -137,7 +137,7 @@ static void describe(char *arg, int last
>  			return;
>  		}
>  	}
> -	die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
> +	printf("%s\n", find_unique_abbrev(cmit->object.sha1, abbrev));
>  }
>  
>  int main(int argc, char **argv)

It's a pity your not particularly interested, I like that patch's idea.
git describe dies with an error here in a situation where there is the
possibility to do something sensible.

BTW, for the sake of consistency, I'd suggest

-	die("cannot describe '%s'", sha1_to_hex(cmit->object.sha1));
+	printf("g%s\n", find_unique_abbrev(cmit->object.sha1, abbrev));

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=1+year+divided+by+3+in+seconds
