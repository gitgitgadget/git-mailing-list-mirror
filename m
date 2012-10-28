From: rh <richard_hubbe11@lavabit.com>
Subject: gitweb
Date: Sun, 28 Oct 2012 16:56:47 -0700
Message-ID: <20121028165647.b79fe3fcb6784c4ae547439e@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 29 01:00:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TScm2-00020B-TA
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 01:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739Ab2J1X76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 19:59:58 -0400
Received: from plane.gmane.org ([80.91.229.3]:51929 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755033Ab2J1X75 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 19:59:57 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TSclv-0001rb-Rr
	for git@vger.kernel.org; Mon, 29 Oct 2012 01:00:03 +0100
Received: from ip68-6-43-149.sb.sd.cox.net ([68.6.43.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 01:00:03 +0100
Received: from richard_hubbe11 by ip68-6-43-149.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 01:00:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-6-43-149.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Received: from slem by 1.1 with local
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208578>

I'm not using gitweb I was thinking about using it and was looking at the 
cgi and saw this in this file:
https://github.com/git/git/blob/master/gitweb/gitweb.perl

I think I understand the intention but the outcome is wrong.

our %highlight_ext = (
	# main extensions, defining name of syntax;
	# see files in /usr/share/highlight/langDefs/ directory
	map { $_ => $_ }
	qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql make),
	# alternate extensions, see /etc/highlight/filetypes.conf
	'h' => 'c',
	map { $_ => 'sh' } qw(bash zsh ksh),
	map { $_ => 'cpp' } qw(cxx c++ cc),
	map { $_ => 'php' } qw(php3 php4 php5 phps),
	map { $_ => 'pl' } qw(perl pm), # perhaps also 'cgi'
	map { $_ => 'make'} qw(mak mk),
	map { $_ => 'xml' } qw(xhtml html htm),
);

I think the intent is better met with this, (the print is for show)

our %he = ();
$he{'h'} = 'c';
$he{$_} = $_     for (qw(py c cpp rb java css php sh pl js tex bib xml awk bat ini spec tcl sql make));
$he{$_} = 'cpp'  for (qw(cxx c++ cc));
$he{$_} = 'php'  for (qw(php3 php4 php5 phps));
$he{$_} = 'pl'   for (qw(cgi perl pm));
$he{$_} = 'make' for (qw(mak mk));
$he{$_} = 'xml'  for (qw(xhtml html htm));
$he{$_} = 'sh'   for (qw(bash zsh ksh));

print "$he{$_} $_\n" for(sort {$he{$a} cmp $he{$b}} keys %he);

But then again maybe I misunderstood the intent.  And maybe everyone's happy
with it as-is.
