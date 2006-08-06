From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff between /dev/null and blob
Date: Sun, 06 Aug 2006 14:36:51 -0700
Message-ID: <7vejvt8s24.fsf@assigned-by-dhcp.cox.net>
References: <eajl4r$b7o$1@sea.gmane.org>
	<7vmzaq9sjs.fsf@assigned-by-dhcp.cox.net> <eb5ld6$36k$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 06 23:37:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9qIp-0004kx-OQ
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 23:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWHFVgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 17:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWHFVgx
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 17:36:53 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:5349 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750727AbWHFVgw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 17:36:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060806213651.DVHF6077.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Aug 2006 17:36:51 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eb5ld6$36k$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	06 Aug 2006 23:02:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24991>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> Currently, due to artifact of git-diff argument parsing you can get diff 
>>> of two arbitrary blobs given by their sha1 id, e.g.
>>>   git diff ab8050ceb4e43522e858768cc2c02fcb91839370 fd05278808d458602587bb024a48726018d30926
>> 
>> Just FYI, it is pretty much by design not artifact to allow
>> something like this:
>> 
>>       git diff master:Makefile next:Makefile
>
> Which we could get using
>
>         git diff master next -- Makefile

Eh, that comment completely misses the point, because the
example did not show its true strength.  Arbitrary two blob sha1
lets you do something like this:

	git diff v0.99:merge-cache.c master:merge-index.c
	git diff v0.99:pull.h fetch.h

        echo extra >>Makefile && git diff :0:Makefile HEAD^^:Makefile

        H=`(cat Makefile; echo extra) | git hash-object -w --stdin`
	echo "100644 $H 2	foobar" | git update-index --add --index-info
	git diff :2:foobar :Makefile

> git-diff doesn't understand :<stage>:<filename> and :<filename> for
> accessing index version of blob (git-cat-file for example understands
> it).

You probably got this impression from a botched experiment or
something, but this statement is wrong as demonstrated above.
