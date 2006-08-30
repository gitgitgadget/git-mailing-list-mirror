From: Junio C Hamano <junkio@cox.net>
Subject: Re: problem with git-cvsserver
Date: Wed, 30 Aug 2006 12:24:57 -0700
Message-ID: <7vlkp6gh6e.fsf@assigned-by-dhcp.cox.net>
References: <44F5B2A7.8070501@gmail.com>
	<Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	<44F5D6F8.50307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 30 21:24:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIVfU-0006bu-4B
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 21:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWH3TYE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 15:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWH3TYE
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 15:24:04 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:6125 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751359AbWH3TYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 15:24:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060830192401.BGSR6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Wed, 30 Aug 2006 15:24:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GKPx1V00L1kojtg0000000
	Wed, 30 Aug 2006 15:23:57 -0400
To: aonghus <thecolourblue@gmail.com>
In-Reply-To: <44F5D6F8.50307@gmail.com> (thecolourblue@gmail.com's message of
	"Wed, 30 Aug 2006 19:20:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26231>

aonghus <thecolourblue@gmail.com> writes:

> I don't know much about the perl SQLite package, but it seems that
> git-cvsserver is not loading the correct module. The line 'use DBI;'
> seems to load only this module:
>
>    'DBI.pm' => '1.51 from /usr/lib/perl5/DBI.pm'
>
> Does it need something else to load the SQLite module?

When things are properly installed, it should be enough to say
'use DBI' upfront and then 'DBI->connect("dbi:Foo:...")' should
be enough to use DBD::Foo backend of the DBI interface.

I am on Debian etch plus some from testing and have these:

        perl (5.8.8-6.1)
        perl-base (5.8.8-6.1)
        libdbi-perl (1.51-2)
        libsqlite3-0 (3.3.7-1)
        libdbd-sqlite3-perl (1.12-1)

Does this work for you?

-- >8 -- cut here -- >8 --
#!/usr/bin/perl -w
use DBI;
my $dsn = 'dbi:SQLite:dbname=foo';
my $dbh = DBI->connect($dsn, '', '');
-- 8< -- cut here -- 8< --

If not, does it work for you if you substitute $dsn with
'dbi:mysql:dbname=test'?  The error message you showed us in
your earlier message said mysql was one of the backend your DBI
knows about while SQLite is not.

This did not work for me before installing libdbd-sqlite3-perl
and gave a very similar error message as you had.

What's puzzling is that you said you have these:

   $ dpkg -S SQLite
   libdbd-sqlite3-perl: /usr/share/man/man3/DBD::SQLite.3pm.gz
   libdbd-sqlite3-perl: /usr/share/perl5/DBD/SQLite.pm
   libdbd-sqlite3-perl: /usr/lib/perl5/auto/DBD/SQLite
   libdbd-sqlite3-perl: /usr/lib/perl5/auto/DBD/SQLite/SQLite.bs
   libdbd-sqlite3-perl: /usr/lib/perl5/auto/DBD/SQLite/SQLite.so

but that is exactly what I am seeing _after_ installing
libdbd-sqlite3-perl.
