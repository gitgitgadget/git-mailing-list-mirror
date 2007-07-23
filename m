From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS
 keyword expansion
Date: Mon, 23 Jul 2007 21:11:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231933030.14781@racer.site>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com> 
 <Pine.LNX.4.64.0707221959100.14781@racer.site> 
 <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com> 
 <Pine.LNX.4.64.0707222013200.14781@racer.site> 
 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com> 
 <Pine.LNX.4.64.0707222238180.14781@racer.site> 
 <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com> 
 <Pine.LNX.4.64.0707230048570.14781@racer.site> 
 <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com> 
 <Pine.LNX.4.64.0707230136360.14781@racer.site>
 <9e4733910707230744u2d3a0a31t9f65d5c9e68c9805@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 22:11:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID4Fm-0006Cy-MK
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 22:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765509AbXGWULe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 16:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757545AbXGWULe
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 16:11:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:51146 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761974AbXGWULd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 16:11:33 -0400
Received: (qmail invoked by alias); 23 Jul 2007 20:11:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 23 Jul 2007 22:11:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19E2Vw7LrRE5RjkZVZ39uh7chmLsxkPNmQmi5QVkI
	DIJHohiZONlnsM
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910707230744u2d3a0a31t9f65d5c9e68c9805@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53468>

Hi,

On Mon, 23 Jul 2007, Jon Smirl wrote:

> On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Okay, I did not really test thoroughly, it seems.  Sorry.  Next try.
> 
> It's working a lot better. People deal with $Id two different ways.
> One way they delete all of the $Id lines, that is the case of the
> Sonos patch. In the Phytec patch they left all of the $Id lines in
> place which caused them to get modified. In both cases you just want
> the lines with $Id to disappear in the patch.
> 
> It doesn't catch the $Id case from the Phytec patch.
> 
> diff -uarN linux-2.6.10/arch/cris/arch-v10/boot/rescue/head.S
> linux-2.6.10-lpc3180/arch/cris/arch-v10/boot/rescue/head.S
> --- linux-2.6.10/arch/cris/arch-v10/boot/rescue/head.S  2004-12-25
> 05:35:24.000000000 +0800
> +++ linux-2.6.10-lpc3180/arch/cris/arch-v10/boot/rescue/head.S
> 2006-11-20 15:49:30.000000000 +0800
> @@ -1,4 +1,5 @@
> /* $Id: head.S,v 1.6 2003/04/09 08:12:43 pkj Exp $
> +/* $Id: head.S,v 1.2 2005/02/18 13:06:31 mike Exp $
>  *
>  * Rescue code, made to reside at the beginning of the
>  * flash-memory. when it starts, it checks a partition
> 
> It's not catching all of the $Revision and $Date deltas.
> 
> The output diff shouldn't contain any CVS keywords. It is somewhat
> tricky to catch all of the cases and fix up the diffs. This filter
> should get written and debugged once and then made part of something
> like git so that it doesn't get written over and over again. Perl is
> way better for this I had 1000 lines of C in my program and it was
> still missing 10% of the cases.

Next try.  It includes documentation, skips $Source:$ and $Header:$ as 
well, and the output diff does not contain any CVS keywords.

Ah yes, and if a file was actually created, it substitutes the --- file 
name with /dev/null.  In that case, the keywords are skipped, too!  
However, when a file was deleted, they are _not_ skipped.

Strictly speaking, it is wrong to just cut out the lines containing CVS 
keywords, since it is possible that there is an important change on that 
line, but we can cross that bridge once companies play such cute games 
with us.

But at least I tested the resulting patch with your phytec3180 patch this 
time...

Ciao,
Dscho

-- snipsnap --
#!/usr/bin/perl

# This is a simple state machine.
#
# There is the state of the current file; its header is stored
# in $current_file to avoid outputting it when all hunks were
# culled.  It is only printed before the first hunk, and then
# set to "" to avoid outputting it twice.
#
# There are the states of the current hunk, stored in
# * $current_hunk (possibly modified hunk)
# * $start_minus, $start_plus (from the original)
# * $plus, $minus, $space (the current count of the respective lines)
# a hunk is only printed (in flush_hunk) if any '+' or '-' lines
# are left after filtering.
#
# For $Log..$, there is the state $skip_logs, which is set to 1
# after seeing such a line, and set to 0 when the first line
# was seen which does not begin with '+'.
#
# A particularly nasty special case is when a single "*" was
# misattributed by the diff to be _inserted before_ a $Log, instead
# of _appended after_ a $Log.
# This is the purpose of the $before_log and $after_log variables:
# if not empty, the state machine expects the next line to begin
# with '+' or '-', respectively, and followed by a $Log.  If this
# expectation is not met, the variable is output.
#
# The variable $plus_minus_adjust contains the number of lines which
# were skipped from the "+" side, so that the correct offset is shown.


# This function gets a hunk header.
#
# It initializes the state variables described above

sub init_hunk {
	$_ = $_[0];
	$current_hunk = "";
	$current_hunk_header = $_;
	($start_minus, $dummy, $start_plus, $dummy) =
		/^\@\@ -(\d+)(,\d+|) \+(\d+)(,\d+|) \@\@/;
	$plus = $minus = $space = 0;
	$skip_logs = 0;
	$before_log = '';
	$after_log = '';

	# we prefer /dev/null as original file name when a file is new
	if ($start_minus eq 0) {
		$current_file =~ s/\n--- .*\n/\n--- \/dev\/null\n/;
	} elsif ($start_plus eq 0) {
		$current_file =~ s/\n\+\+\+ .*\n/\n+++ \/dev\/null\n/;
	}
}

# This function is called whenever there is possibly a hunk to print.
# Nothing is printed if no '+' or '-' lines are left.
# Otherwise, if the file header was not yet shown, it does so now.

sub flush_hunk {
	if ($plus > 0 || $minus > 0) {
		if ($current_file ne "") {
			print $current_file;
			$current_file = "";
		}
		$minus += $space;
		$plus += $space;
		print "\@\@ -$start_minus,$minus "
			. "+" . ($start_plus - $start_plus_adjust)
			. ",$plus \@\@\n";
		print $current_hunk;
	}
}

# This adds a line to the current hunk and updates $space, $plus or $minus

sub add_line {
	my $line = $_[0];
	$current_hunk .= $line;
	if ($line =~ /^ /) {
		$space++;
	} elsif ($line =~ /^\+/) {
		$plus++;
	} elsif ($line =~ /^-/) {
		$minus++;
	} elsif ($line =~ /^\\/) {
		# do nothing
	} else {
		die "Unexpected line: $line";
	}
}

# This function splits the current hunk into the part before the current
# line, and the part after the current line.

sub skip_line {
	my $line = $_[0];

	if ($start_minus == 0) {
		# This patch adds a new file, just ignore that line
		return;
	} elsif ($start_plus == 0) {
		# This patch removes a file, so include the line nevertheless
		add_line $_;
		return;
	}

	flush_hunk;
	if ($line =~ /^-/) {
		$minus++;
	} elsif ($line =~ /^\+/) {
		$plus++;
		$start_plus_adjust++;
	}
	init_hunk "@@ -" . ($start_minus + $minus + $space)
		. " +" . ($start_plus + $plus + $space)
		. " @@\n";
}

$simple_keyword = "Id|Revision|Author|Date|Source|Header";

# This is the main loop

sub check_file {
	$_ = $_[0];
	$current_file = $_;
	$start_plus_adjust = 0;
	while (<>) {
		if (/^\@\@/) {
			last;
		}
		$current_file .= $_;
	}

	init_hunk $_;

	# check hunks
	while (<>) {
		if ($before_log) {
			if (!/\+.*\$Log.*\$/) {
				add_line $before_log;
			} else {
				skip_line $before_log;
			}
			$before_log = '';
		}

		if ($after_log) {
			if (!/-.*\$Log.*\$/) {
				add_line $after_log;
			} else {
				skip_line $after_log;
			}
			$after_log = '';
		}

		if ($skip_logs) {
			if (/^\+/) {
				skip_line $_;
				$skip_logs = 1;
			} else {
				$skip_logs = 0;
				if (/^ *\*$/) {
					$after_log = $_;
				}
			}
		} elsif (/^\+.*\$($simple_keyword).*\$/) {
			skip_line $_;
		} elsif (/^\@\@.*/) {
			flush_hunk;
			init_hunk $_;
		} elsif (/^diff/) {
			flush_hunk;
			return;
		} elsif (/^-.*\$($simple_keyword).*\$/) {
			# fake new hunk
			skip_line $_;
		} elsif (/^\+ *\*$/) {
			$before_log = $_;
		} elsif (/^([- \+]).*\$Log.*\$/) {
			skip_line $_;
			$skip_logs = 1;
		} else {
			add_line $_;
		}
	}
}

# This loop just shows everything before the first diff, and then hands
# over to check_file whenever it sees a line beginning with "diff".

while (<>) {
	if (/^diff/) {
		do {
			check_file $_;
		} while(/^diff/);
		flush_hunk;
	} else {
		printf $_;
	}
}
