From: Timur Tabi <timur@freescale.com>
Subject: Problem with send-email
Date: Fri, 08 Sep 2006 16:13:01 -0500
Organization: Freescale
Message-ID: <4501DCDD.4020403@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 08 23:29:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLnup-0006la-6E
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 23:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWIHV3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 17:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWIHV3c
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 17:29:32 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:3525 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751249AbWIHVNE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 17:13:04 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id k88LPYoU005853
	for <git@vger.kernel.org>; Fri, 8 Sep 2006 14:25:34 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k88LD2rN028652
	for <git@vger.kernel.org>; Fri, 8 Sep 2006 16:13:02 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26713>

I'm having two problems with git-send-email.

Problem #1:

I don't know Perl, but I think there's something wrong with this code:

if (!defined $from) {
	$from = $author || $committer;
         print "$from\n";
	do {
		$_ = $term->readline("Who should the emails appear to be from? ",
			$from);
	} while (!defined $_);

	$from = $_;
	print "Emails will be sent from: ", $from, "\n";
	$prompting++;
}

I don't think the call to readline() is working.  Specifically, the last parameter, $from, is being ignored.  When I call git-send-email without specifying a --from parameter, this code is executed.  But this is what I see:

Timur Tabi <timur@freescale.com>
Who should the emails appear to be from?
Emails will be sent from:

This happens when I press ENTER at the "Who should the emails appear to be from?" prompt.  I'm expecting it to assign the default value, which is displayed right above it.  But instead, $from is erased, and so my email doesn't have a From: line.

Problem #2:

I cannot use send-email to send a patch to anyone but myself.  If I do this:

git-send-email --from timur@freescale.com --to timur@freescale.com --smtp-server remotesmtp.freescale.net patchfile

Everything works.  However, if I do this:

git-send-email --from timur@freescale.com --to  --smtp-server remotesmtp.freescale.net patchfile

I get this:

(mbox) Adding cc: Timur Tabi <timur@freescale.com> from line 'From: Timur Tabi <timur@freescale.com>'
(sob) Adding cc: Timur Tabi <timur@freescale.com> from line 'Signed-off-by: Timur Tabi <timur@freescale.com>'
5.0.0 <Timur Tabi <timur@freescale.com>... Unbalanced '<'

I think that last line is a response from the SMTP server.  My guess is that there's something wrong with this line:

		print $sm "$header\n$message";

Maybe my SMTP server sees the "From: Timur Tabi <timur@freescale.com>" that's at the top of $message and gets confused?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
