X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: git-PS1 bash prompt setting
Date: Thu, 16 Nov 2006 13:01:11 -0500
Message-ID: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 16 Nov 2006 18:01:56 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061116130111.921396df.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 16 Nov 2006 18:01:13.0436 (UTC) FILETIME=[344441C0:01C709A9]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GklYU-0007yy-0E for gcvg-git@gmane.org; Thu, 16 Nov
 2006 19:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422847AbWKPSBO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 13:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423165AbWKPSBO
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 13:01:14 -0500
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:18249 "EHLO
 BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1422778AbWKPSBN (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006
 13:01:13 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 16 Nov 2006 10:01:13 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gkkbv-00070l-0Y; Thu, 16 Nov 2006 12:01:11 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Ted mentioned in the wart thread that having multiple branches per repo
means that the standard bash prompt isn't as much help as it could be.

For what it's worth i'll post a little script i've been using for quite
some time that helps a little.  It's called git-PS1 and is used by
including it in your bash PS1 variable like so:

export PS1='$(git-PS1 "[\u@\h \W]\$ ")'

If you're not in a git repo, the bash prompt you pass on the git-PS1
command line is used instead.  If you are in a git repo, you'll get
the following as a prompt:

[branch!repo/relative/path]$ 

Where "repo" is the basename of the path to the root of your repo.
An example would look like this:

[master!linus-2.6/Documentation/vm]$ 

Cheers,
Sean


#!/bin/bash
BR=$(git symbolic-ref HEAD 2>/dev/null) || { echo "$@" ; exit ; }
BR=${BR#refs/heads/}
REL=$(git rev-parse --show-prefix) 
REL="${REL//%\/}"
LOC="${PWD%/$REL}"
echo "[$BR!${LOC/*\/}${REL:+/$REL}]$ "
