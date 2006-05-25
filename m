From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't write directly to a make target ($@).
Date: Thu, 25 May 2006 09:28:11 -0700
Message-ID: <7vejyixe5g.fsf@assigned-by-dhcp.cox.net>
References: <87hd3e5ixw.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 18:28:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjIhO-0002SJ-1h
	for gcvg-git@gmane.org; Thu, 25 May 2006 18:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWEYQ2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 12:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030255AbWEYQ2P
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 12:28:15 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45509 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030250AbWEYQ2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 12:28:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525162812.YIXW5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 12:28:12 -0400
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87hd3e5ixw.fsf@rho.meyering.net> (Jim Meyering's message of
	"Thu, 25 May 2006 15:32:11 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20743>

Jim Meyering <jim@meyering.net> writes:

> Otherwise, if make is suspended, or killed with prejudice, or if the
> system crashes, you could be left with an up-to-date, yet corrupt,
> generated file.

Thanks.  Maybe you would want a "make clean" target for them too
if you do this.  I often use $@+ instead of t$@ so that I can
say "rm -f *+" there.

> @@ -496,37 +496,43 @@ builtin-help.o: common-cmds.h
>  	rm -f $@ && ln git$X $@
>  
>  common-cmds.h: Documentation/git-*.txt
> -	./generate-cmdlist.sh > $@
> +	./generate-cmdlist.sh > t$@
> +	mv t$@ $@
>  

IOW, like this:

common-cmds.h: Documentation/git-*.txt
	rm -f $@+ $@
        ./generate-cmdlist.sh > $@+
        mv $@+ $@

clean::
	rm -f *+
