From: Bruno Haible <bruno@clisp.org>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 03:02:00 +0100
Message-ID: <200702120302.00576.bruno@clisp.org>
References: <200702111252.28393.bruno@clisp.org> <200702120041.27419.bruno@clisp.org> <200702120059.17676.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 02:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGQQW-0000WM-4C
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 02:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932925AbXBLB4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 20:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932927AbXBLB4D
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 20:56:03 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:13164 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932925AbXBLB4B (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 20:56:01 -0500
Received: from linuix.haible.de (cable-137-244.iesy.net [81.210.137.244])
	by post.webmailer.de (klopstock mo32) (RZmta 4.5)
	with ESMTP id B00fd0j1BIuKc0 ; Mon, 12 Feb 2007 02:55:57 +0100 (MET)
User-Agent: KMail/1.5.4
In-Reply-To: <200702120059.17676.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY4JDyuz6KRYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39349>

Thanks for the responses.

Robin Rosenberg wrote:
> Since you know that you are not interested in the whole history, you can limit your scan.
> 
> git log COREUTILS-5_2_1..COREUTILS-6_4 src/tr.c

Thanks, that indeed does the trick: it reduces the time from 33 sec to 11 sec.

To reduce the time even more, and to allow more flexibility among the
search criteria (e.g. "I need the commits from date X to date Y, on this
file set, from anyone except me"), I would need to connect git to a database.
git cannot store all kinds of indices and reverse mappings to allow all
kinds of queries; that's really a classical database application area.

> > No, it became even worse: git-1.5.0-rc4 is twice as slow as git-1.4.4 for
> > this command:
> >   git-1.4.4: 25 seconds real time, 24 seconds of CPU time (12 user, 12 system)
> >   git-1.5.0: 50 seconds real time, 39 seconds of CPU time (20 user, 19 system)
> 
> Could the UTF-8 stuff have anything to do with this?

Actually, no. Brown paper bag on me for doing benches in different
conditions. The timing difference is an effect of the buffer cache / page
cache:

  - After the second repetition of the command (i.e. when all files are cached
    in RAM), the timings are
        25 seconds real time, 24 seconds of CPU time (13 user, 11 system)
    both in git-1.4.4 and -1.5.0-rc4.

  - After unmounting and remounting the disk containing the repository (i.e.
    when none of the files are cached in RAM), the timings are
        49 seconds real time, 38 seconds of CPU time (20 user, 18 system)

Sorry for the false alarm.

Bruno
