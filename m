From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Make git-diff-tree indicate when it flushes
Date: Tue, 30 May 2006 08:31:10 +1000
Message-ID: <17531.30254.890940.553395@cargo.ozlabs.ibm.com>
References: <17530.59395.5611.931858@cargo.ozlabs.ibm.com>
	<7vejyc8ymw.fsf@assigned-by-dhcp.cox.net>
	<17531.28529.215905.856397@cargo.ozlabs.ibm.com>
	<7vzmh07a9k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 00:31:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkqGg-0000kt-ST
	for gcvg-git@gmane.org; Tue, 30 May 2006 00:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWE2WbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 18:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWE2WbT
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 18:31:19 -0400
Received: from ozlabs.org ([203.10.76.45]:31645 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751440AbWE2WbS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 18:31:18 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2D3BE67A63; Tue, 30 May 2006 08:31:17 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmh07a9k.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20989>

Junio C Hamano writes:

> I am not quite sure exactly what you are trying to achieve, but
> one trivial way is not giving -s perhaps?

I'm asking git-diff-tree which of a given set of commits affect any of
a set of paths, so that gitk can highlight the ones that do.
Furthermore I want to be able to use the git-diff-tree process for
multiple sets of commit IDs.

If I don't use -s, then I will get lines starting with a ":" after the
commit IDs of the commits that do affect the set of paths I specified.
That means I get a definite indication for all except the last commit
I send.  For the last commit I still don't know whether the absence of
any ":" lines means that the commit doesn't affect the set of paths,
or that git-diff-tree is being slow.  So I still need something like
the patch I sent.

I could get the indication I want (with or without -s) if I close the
pipe going to the git-diff-tree process.  But then the process will
exit, and I want it to stay around so that I don't have to pay the
fork/exec and startup time of git-diff-tree next time (which will be
when the user scrolls the commit list window or asks to move to the
next highlighted commit).

Thus, --always (with or without -s) doesn't quite do what I need.

Paul.
