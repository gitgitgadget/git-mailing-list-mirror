From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH][RFC] Add git-archive-tree
Date: Sun, 17 Sep 2006 13:54:13 +0200
Message-ID: <450D3765.9090303@lsrfire.ath.cx>
References: <44F977C0.4060901@lsrfire.ath.cx>	<7vwt8mx8lb.fsf@assigned-by-dhcp.cox.net>	<44FF0DDE.7030700@lsrfire.ath.cx> <7v4pvk7jmn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 17 13:54:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOvE4-0002Ro-C2
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 13:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbWIQLyO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 17 Sep 2006 07:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWIQLyO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 07:54:14 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:59604
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S964947AbWIQLyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 07:54:13 -0400
Received: from [10.0.1.3] (p508E4E70.dip.t-dialin.net [80.142.78.112])
	by neapel230.server4you.de (Postfix) with ESMTP id BFF813601E;
	Sun, 17 Sep 2006 13:54:11 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pvk7jmn.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27188>

Junio C Hamano schrieb:
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> I then let the two chew away on the kernel repository.  And as=20
>> kcachegrind impressively shows, all we do with our trees and=20
>> objects is dwarfed by inflate().
>=20
> The diff output codepath has a logic that says "if the blob we are=20
> dealing with has the same object name as the corresponding blob in=20
> the index, and if the index entry is clean (i.e. it is known that the
>  file sitting in the working tree matches the blob), then do not=20
> inflate() but use data from that file instead".

Nice idea.  The tree traverser would need to provide the filenames
relative to the current working directory in addition to the
filenames as they are written to the archive.  I guess your para-walk
tree walker could be useful here.  I sadly haven't found the time to
look at it, yet, and now it even vanished from the pu branch.

A read is an order of magnitude faster than a deflate of the same data,
at least that's what I guess from comparing the runtimes of git-tar-tre=
e
and tar.  _However_, this doesn't account for I/O costs (in my tests th=
e
repo and all checked-out files were cache hot) and for any compression
that would certainly be applied to the resulting archive.  So the full
runtime of archive creation wouldn't be that much shorter.

Ren=E9
