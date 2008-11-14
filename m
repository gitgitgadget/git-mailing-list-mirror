From: Andreas Ericsson <ae@op5.se>
Subject: git to libgit2 code relicensing
Date: Fri, 14 Nov 2008 21:59:56 +0100
Message-ID: <491DE6CC.6060201@op5.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040100020904040705030602"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 22:01:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L15nM-0006cq-Uw
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 22:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbYKNVAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 16:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbYKNVAV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 16:00:21 -0500
Received: from mail.op5.se ([193.201.96.20]:57011 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbYKNVAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 16:00:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7A2D51B80092;
	Fri, 14 Nov 2008 21:54:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tf8Z6-hOoFKe; Fri, 14 Nov 2008 21:54:39 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id DBAF91B80090;
	Fri, 14 Nov 2008 21:54:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101015>

This is a multi-part message in MIME format.
--------------040100020904040705030602
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

I've been working quite a lot on git -> libgit2 code moving,
but the licensing stuff is a bit depressing, as I can't know
if the work I'm doing is for nothing or not.

The license decided for libgit2 is "GPL with gcc exception".
Those who are OK with relicensing their contributions under
that license for the purpose of libgit2, can you please say
so?

I'm planning on writing a tool for this that will have "ok",
"not ok" and "ask-each-patch" as options.

The list of people whose position I know is rather short.
Please correct me if you're on it and would like not to be.
Junio C. Hamano		ask
Johannes Schindelin	ok
Shawn O. Pearce		ok
Andreas Ericsson	ok
Pierre Habouzit		ok
Brian Gernhardt		ok


I've put everyone who "owns" more than 500 lines of code
on the bcc list, figuring your permission is important
but that you don't want the hundreds (well, one can hope)
of emails from people saying "ok". The list of major owners
was generated with "git showners *.c" in a worktree from
the next branch of git.git.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

--------------040100020904040705030602
Content-Type: text/plain;
 name="git-showners"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-showners"

#!/bin/sh

test "$#" -gt 0 || { echo "Usage: $0 <file>"; exit 1; }
combined=t
while test "$#" -gt 0
do
	case "$1" in
	-c|--combined)
		combined=t
	;;
	-i|--individual)
		combined=
	;;
	--)
		shift
		break
	;;
	*)
		break
	;;
	esac
	shift
done

sort_enumerate ()
{
	sed -e 's/[^(]*(\([^0-9]*\).*/\1/' -e 's/[\t ]*$//' \
		| sort | uniq -c | sort -nr
}

show_owners ()
{
	for f in "$@"; do
		test -d "$f" && { show_owners "$f"/*; continue; }

		git blame -C -C -M "$f"
	done
}

if test "$combined" = t; then
	echo "$@"
	show_owners "$@" | sort_enumerate
else
	echo "Showing one-at-a-time ownership"
	for f in "$@"; do
		echo "$f"
		show_owners "$f" | sort_enumerate
	done
fi

--------------040100020904040705030602--
