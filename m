From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] diff: add --no-diff-deleted to make -p more pleasant
Date: Mon, 30 Jan 2006 12:08:46 -0600
Message-ID: <1138644525.24410.18.camel@cashmere.sps.mot.com>
References: <20060129142403.GA15482@Muzzle>
	 <7vy80ykd3j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 30 19:09:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3dSQ-0004hU-1t
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 19:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWA3SIu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 13:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWA3SIt
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 13:08:49 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:25255 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S964849AbWA3SIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 13:08:48 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id k0UIODD2001214
	for <git@vger.kernel.org>; Mon, 30 Jan 2006 11:24:13 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k0UIHKul009865
	for <git@vger.kernel.org>; Mon, 30 Jan 2006 12:17:21 -0600 (CST)
To: Git List <git@vger.kernel.org>
In-Reply-To: <7vy80ykd3j.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15285>

On Sun, 2006-01-29 at 14:12, Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > This is a feature I've stol^Wborrowed from svn that I find very
> > useful since I usually don't care to see what I've deleted.
> 
> There is a thing called --diff-filter, and 
> 
> 	git diff -p --no-diff-deleted
> 
> is equivalent to
> 
> 	git diff -p --diff-filter=AM
> 
> when you are not using rename/copy detection (and a byte
> shorter).

Hmmm.... I think this may be the problem:

    % grep -r diff-filter Documentation/
    Documentation/git-diff.txt:$ git diff --diff-filter=MRC <1>

And that is:

    Limiting the diff output::
    +
    ------------
    $ git diff --diff-filter=MRC <1>
    $ git diff --name-status -r <2>
    $ git diff arch/i386 include/asm-i386 <3>
 
    <1> show only modification, rename and copy, but not addition
    nor deletion.
    <2> show only names and the nature of change, but not actual
    diff output.  --name-status disables usual patch generation
    which in turn also disables recursive behaviour, so without -r
    you would only see the directory name if there is a change in a
    file in a subdirectory.
    <3> limit diff output to named subtrees.

That's pretty thin documentation there.
Unless someone beats me to it, I'll try to find
a spare documentation cycle...

jdl
