From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Mon, 09 Oct 2006 23:54:25 -0700
Message-ID: <7vy7ro64pq.fsf@assigned-by-dhcp.cox.net>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	<eft8u4$un0$2@sea.gmane.org> <20061003095250.GJ2871@admingilde.org>
	<7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
	<7v64et9fjq.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610091851i593f3e53v5d5fef891edb6d48@mail.gmail.com>
	<7v1wpgapew.fsf@assigned-by-dhcp.cox.net>
	<7viris9a6g.fsf@assigned-by-dhcp.cox.net>
	<4b3406f0610092336v5ab58134i280f64223a272b0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 08:54:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXBVo-0000CU-14
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 08:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWJJGy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 02:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbWJJGy1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 02:54:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:6874 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965044AbWJJGy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 02:54:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010065426.JFAD21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 02:54:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YWuU1V00T1kojtg0000000
	Tue, 10 Oct 2006 02:54:29 -0400
To: "Dongsheng Song" <dongsheng.song@gmail.com>
In-Reply-To: <4b3406f0610092336v5ab58134i280f64223a272b0b@mail.gmail.com>
	(Dongsheng Song's message of "Tue, 10 Oct 2006 14:36:04 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28611>

"Dongsheng Song" <dongsheng.song@gmail.com> writes:

> There is the result:
>
> www-data@ab:/home/repository/git/gcc$ for blob in \
>>          a34d77e47bf1561db1ade4f6b247598b880f80d5 \
>>          7625c494df01d4745e67bd4423e2fdbe9fc43799 \
>>          b207fe30a5430f97d27d398d89c974b068694c7a \
>>          57b07ace4bb6352416bbf9436b9f2642b3273257
>>          do
>>                git cat-file -t $blob || echo $blob does not exist
>>          done
> blob
> blob
> blob
> blob
> www-data@ab:/home/repository/git/gcc$ git cat-file commit
> c977ee1b2e54d67bb379ce476f784431c32136d7 |
>>          grep 'parent '
> parent b693aceaba66f741cd6735d4ecd16fe59394a2cf
> www-data@ab:/home/repository/git/gcc$ git diff-tree -p
> c977ee1b2e54d67bb379ce476f784431c32136d7 | wc
>     37     137    1179
> ...
> I have the SAME problem with ALL commits,  ONLY the 2.4.x machine, but
> git-core/cg tools is OK. All git/cg/gitweb is good for other 2.6.x
> machines.

That's mildly interesting.  I do not know the difference between
your 2.4 and 2.6 machines (nor how many of each you have).  I am
guessing that either these machines are sharing one repository
over NFS, or they have their own copies and none of them is
corrupt (i.e. you got these reasonable results you pasted above
from all of them).

At this point I have to say that this sounds like a problem that
reproduces only for you on that particular machine.  Maybe
comparing the apache logs from a good machine and a bad one
would tell you what's different between them?

I am not sure what version of gitweb your distribution packages,
but it used to be that commitdiff page wanted to create
temporary file somewhere on the filesystem (the variable was
$git_temp and by default it was set to "/tmp/gitweb", I think).
Your other pages such as commit and log page seem to be working,
so perhaps your gitweb has trouble writing there only on that
machine?
