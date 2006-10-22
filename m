From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (2)
Date: Sun, 22 Oct 2006 13:22:53 -0700
Message-ID: <7v3b9g5cde.fsf@assigned-by-dhcp.cox.net>
References: <200610211750.49188.jnareb@gmail.com>
	<200610211752.19891.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 22:23:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbjqU-00086V-8U
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 22:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWJVUWz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 16:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWJVUWz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 16:22:55 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62118 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751417AbWJVUWy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 16:22:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061022202254.CVGQ6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Oct 2006 16:22:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dYNx1V00Q1kojtg0000000
	Sun, 22 Oct 2006 16:22:58 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610211752.19891.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 21 Oct 2006 17:52:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29784>

Jakub Narebski <jnareb@gmail.com> writes:

> Code should be aligned the same way, regardless of tab size.
> Use tabs for indent, but spaces for align.

I do not necessarily agree with that policy; the result of
applying this patch is still inconsistent in some places, and I
think that is primarily because the policy itself is flawed.

For example, a part of sub format_paging_nav looks like this:

        sub format_paging_nav {
        >>>>>>>>my ($action, $hash, $head, $page, $nrevs) = @_;
        ...
        >>>>>>>>if ($page > 0) {
        >>>>>>>>>>>>>>>>$paging_nav .= " &sdot; " .
        >>>>>>>>>>>>>>>>>>>>>>>>$cgi->a({-href => href(action=>$a
        >>>>>>>>>>>>>>>>>>>>>>>>         -accesskey => "p", -titl
        >>>>>>>>} else {
        ...

If your policy is to indent continuation lines (which is why you
have a TAB before "$cgi->a"), not having a TAB before the
continued parameter list for the $cgi->a() call look inconsistent.

If on the other hand your policy is to align parameters to an
operator that are spread over multiple lines, " &sdot; " and
"$cgi-a(..." are left and right parameters to the string
concatenation operator "." in between them, so "$cgi->a" should
be pushed back with a run of SP starting at the column that
begins $paging_nav and aligned with the DQ at the beginning of
the " &sdot; " string.

By the way, is there a handy way to view something like the
above with "cat" (like "cat -e" is an easy way to find trailing
whitespace problems)?  I usually end up running this but I feel
that there ought to be a canned command.

#!/usr/bin/perl

my $monochrome = 0;
my $tab = 8;
my $tab_color = "\033[44m";
my $reset_color = "\033[0m";
my $tab_padchar = ' ';

if ($monochrome) {
	$tab_color = $reset_color = '';
	$tab_padchar = '>';
}

while (<>) {
	chomp;
	my (@frag) = split(/\t/, $_);
	my $pos = 0;
	for (my $i = 0; $i < @frag; $i++) {
		if ($i) {
			my $len = 8 - $pos % 8;
			print $tab_color;
			print $tab_padchar x $len;
			print $reset_color;
			$pos += $len;
		}
		print $frag[$i];
		$pos += length($frag[$i]);

	}
	print "\n";
}
