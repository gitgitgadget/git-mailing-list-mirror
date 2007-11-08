From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Drop deprecated commands from git(7) and update deprecation notices
Date: Thu, 08 Nov 2007 13:01:09 -0800
Message-ID: <7vzlxo1mga.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site>
	<7vlk998u6r.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711080041120.4362@racer.site>
	<20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se>
	<20071108160114.GB20988@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Nov 08 22:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqEVM-0002ms-Fl
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 22:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760285AbXKHVBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 16:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759866AbXKHVBT
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 16:01:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56809 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858AbXKHVBS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 16:01:18 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 37BBA2FA;
	Thu,  8 Nov 2007 16:01:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BAB4939A1;
	Thu,  8 Nov 2007 16:01:33 -0500 (EST)
In-Reply-To: <20071108160114.GB20988@diku.dk> (Jonas Fonseca's message of
	"Thu, 8 Nov 2007 17:01:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64072>

Thanks.

But lost-found is merely deprecated but not removed yet, so I
think it should be kept in the list cmd-list.perl generates.


We may want a mechanism to mark it deprecated in the list as
well, though.  Perhaps ...

---
 Documentation/cmd-list.perl |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 8d21d42..0066064 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -3,7 +3,8 @@
 use File::Compare qw(compare);
 
 sub format_one {
-	my ($out, $name) = @_;
+	my ($out, $nameattr) = @_;
+	my ($name, $attr) = @$nameattr;
 	my ($state, $description);
 	$state = 0;
 	open I, '<', "$name.txt" or die "No such file $name.txt";
@@ -26,8 +27,11 @@ sub format_one {
 		die "No description found in $name.txt";
 	}
 	if (my ($verify_name, $text) = ($description =~ /^($name) - (.*)/)) {
-		print $out "gitlink:$name\[1\]::\n";
-		print $out "\t$text.\n\n";
+		print $out "gitlink:$name\[1\]::\n\t";
+		if ($attr) {
+			print $out "($attr) ";
+		}
+		print $out "$text.\n\n";
 	}
 	else {
 		die "Description does not match $name: $description";
@@ -39,8 +43,8 @@ while (<DATA>) {
 	next if /^#/;
 
 	chomp;
-	my ($name, $cat) = /^(\S+)\s+(.*)$/;
-	push @{$cmds{$cat}}, $name;
+	my ($name, $cat, $attr) = /^(\S+)\s+(.*?)(?:\s+(.*))?$/;
+	push @{$cmds{$cat}}, [$name, $attr];
 }
 
 for my $cat (qw(ancillaryinterrogators
@@ -126,7 +130,7 @@ git-instaweb                            ancillaryinterrogators
 gitk                                    mainporcelain
 git-local-fetch                         synchingrepositories
 git-log                                 mainporcelain
-git-lost-found                          ancillarymanipulators
+git-lost-found                          ancillarymanipulators	deprecated
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
