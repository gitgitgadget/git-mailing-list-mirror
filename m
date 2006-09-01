From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: problem with git-cvsserver
Date: Fri, 1 Sep 2006 09:05:59 +0200
Message-ID: <20060901070559.GA22015@fiberbit.xs4all.nl>
References: <44F5B2A7.8070501@gmail.com> <Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de> <44F5D6F8.50307@gmail.com> <7vlkp6gh6e.fsf@assigned-by-dhcp.cox.net> <46a038f90608301329n14df4dd2tb1563cc48662cd14@mail.gmail.com> <20060831090333.GA28445@fiberbit.xs4all.nl> <46a038f90608311600p747c8a3anbe90dbac928e9923@mail.gmail.com> <46a038f90608311707t4ab5fc2fj45e852df4b91870f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>,
	aonghus <thecolourblue@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 01 09:06:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJ36t-0003oA-Qp
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 09:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWIAHGI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 03:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWIAHGI
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 03:06:08 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:46006 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751230AbWIAHGF
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Sep 2006 03:06:05 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1GJ36F-0006DM-Vx; Fri, 01 Sep 2006 09:06:00 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90608311707t4ab5fc2fj45e852df4b91870f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26295>

On Friday September 1st 2006 at 12:07 Martin Langhoff wrote:

[warning: discussion about sqlite; no direct git serviceable parts inside!]

> >I have to say though: Ouch. Do you know if there's an upgrade path for
> >apps? Does v3 detect you've got a v2 file and do something smart
> >(upgrade in place / spit out a readable error)?

Applications for both v2 and v3 can work on the same machine at the same
time. Both versions will not corrupt a database of the other version
and will immediately stop with an error, although the error isn't very
readable (doesn't mention _which_ version it saw or needed).

They do not perform an upgrade in place.

But as sqlite or sqlite3 databases are standalone files, most of the
time just use the sqlite version that is standard for your platform
and/or version. For new development v3 is the way to go, as v2 is in
deep sleep maintenance now.

Not just the database format changed in v3, the whole API changed
incompatibly.

> Oh, grumble. See the comment at the bottom of
> http://www.sqlite.org/formatchng.html
> 
> We may need to add something in the doco pointing to this "technique",
> and perhaps the URL as later versions may do something different.
> 
> I do wonder what the debian packaging does, perhaps the v3 package
> forces an upgrade to the v2 package that renames the cli binary? I
> guess the drawback of having the DBs anywhere in the FS is that the
> packaging can't upgrade them for you as it does with Pg for instance
> :(

The commandline programs are called 'sqlite' and 'sqlite3' so there is
no "upgrade", you can have the two different versions simultaneously
installed and working on the same machine.

Unfortunately the 'sqlite3' doesn't directly read the 'sqlite' format
and neither the other way round. You can convert a database easily from
the one format to the other:

$ echo .dump | sqlite database.v2.dat > dump.v2.dat
$ sqlite3 < dump.v2.dat database.v3.dat

If you don't use the new features in sqlite3 you can even convert back
in the same way:

$ echo .dump | sqlite3 database.v3.dat > dump.v3.dat
$ sqlite < dump.v3.dat database.v2.dat

Use a non-existent file for the target database, and sqlite(3) will
create the database for you. Do check the conversion as error reporting
in the commandline tools in this "batch" mode is sometimes rather sparse
or non-existent!

Once you got it finally going I find that sqlite(3) is a fast, reliable
and quite handy database. Especially, as Johannes said, its standalone
nature makes developing and deploying very easy.
-- 
Marco Roeland
