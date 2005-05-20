From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: gitweb wishlist
Date: Fri, 20 May 2005 23:16:34 +0200
Message-ID: <20050520211634.GA20003@cip.informatik.uni-erlangen.de>
References: <1116384951.5094.83.camel@dhcp-188.off.vrfy.org> <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org> <1116611932.12975.22.camel@dhcp-188> <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org> <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org> <1116615600.12975.33.camel@dhcp-188> <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com> <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org> <428E4D8C.3020606@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5I6of5zJg18YgZEa"
X-From: git-owner@vger.kernel.org Fri May 20 23:17:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZEqo-00085s-Mk
	for gcvg-git@gmane.org; Fri, 20 May 2005 23:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVETVRF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 17:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVETVRF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 17:17:05 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:4812 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261279AbVETVQg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 17:16:36 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4KLGYS8023432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 20 May 2005 21:16:34 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4KLGY83023431
	for git@vger.kernel.org; Fri, 20 May 2005 23:16:34 +0200 (CEST)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <428E4D8C.3020606@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
I imported the mutt-cvs for the 1.5 branch into GIT using the following
script. But it is a hack. I also think that I will use something like
that to build a CVS->GIT vendortracking.

cvsps -x -z 10 -b HEAD -g -p ../../patches/

And using the attached script to import the patches in GIT. It works
quiet well.

See also msgid: 1115080139.21105.18.camel@localhost.localdomain there
are the scripts which he used to convert the CVS to GIT for HPA. My
scripts are based on his work.

	Thomas

--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cvsps-import.pl"

#!/usr/bin/perl

use strict;
use warnings;
use File::Temp qw/ tempfile tempdir /;

# ---------------------
# PatchSet 1 
# Date: 2002/07/23 07:41:30
# Author: hpa
# Branch: HEAD
# Tag: (none) 
# Log:
# Initial revision
# 
# Members: 
# 	klibc.cvsroot/snprintf.c:INITIAL->1.1 
# 	klibc.cvsroot/vsnprintf.c:INITIAL->1.1 
# 	klibc.cvsroot/klibc/Makefile:INITIAL->1.1 
# 	klibc.cvsroot/klibc/snprintf.c:INITIAL->1.1 
# 	klibc.cvsroot/klibc/vsnprintf.c:INITIAL->1.1 
# 
# --- /dev/null	2005-04-30 18:00:24.840397008 +0200
# +++ klibc/klibc.cvsroot/snprintf.c	2005-05-02 19:57:42.879913000 +0200
# @@ -0,0 +1,19 @@
# +/*

my $patch = $ARGV[0];

my %committer = (
	brendan  => [ 'Brendan Cully',   'brendan@kublai.com' ],
	me       => [ 'Michael Elkins',  'me@sigpipe.org' ],
	roessler => [ 'Thomas Roessler', 'roessler@does-not-exist.org' ]
);

my @log = ();

$ENV{GIT_AUTHOR_EMAIL} = "";
$ENV{GIT_COMMITTER_EMAIL} = "";

open (my $fd, $patch);
while (my $line = <$fd>) {
	if ($line =~ m/^Date: (.*)/) {
		$ENV{GIT_AUTHOR_DATE} = $1;

	} elsif ($line =~ m/^Author: (.*)/) {
		if (defined($committer{$1})) {
			$ENV{GIT_COMMITTER_NAME}  = @{$committer{$1}}[0];
			$ENV{GIT_COMMITTER_EMAIL} = @{$committer{$1}}[1];
			$ENV{GIT_AUTHOR_NAME}         = @{$committer{$1}}[0];
			$ENV{GIT_AUTHOR_EMAIL}        = @{$committer{$1}}[1];
		} else {
			$ENV{GIT_COMMITTER_NAME} = $1;
			$ENV{GIT_AUTHOR_NAME}        = $1;
		}

	} elsif ($line =~ m/^Log:/) {
		while (my $line = <$fd>) {
			if ($line =~ m/^Members: $/) {
				pop(@log);
				last;
			} elsif ($line =~ /^From: (.+) <([^>]+@[^>]+)>$/) {
				$ENV{GIT_AUTHOR_NAME}  = $1;
				$ENV{GIT_AUTHOR_EMAIL} = $2;
			}
			push @log, $line;
		}
	}
}

close($fd);

my ($fh, $logfile) = tempfile(CLEANUP => 1);
print $fh @log;
system("git patch $patch < $logfile");
close($fh);

--5I6of5zJg18YgZEa--
