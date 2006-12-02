X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Test t4118 fails on Mac OS X due to dependency on GNU sed behaviour
Date: Sat, 2 Dec 2006 21:14:10 +0100
Message-ID: <20061202201410.GA6353@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Date: Sat, 2 Dec 2006 20:14:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33039>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqbFZ-0003fv-HD for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031567AbWLBUON (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031762AbWLBUON
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:14:13 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:19667 "EHLO
 fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1031567AbWLBUON (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:14:13 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.63)
 (envelope-from <marco.roeland@xs4all.nl>) id 1GqbFT-0001hU-0K for
 git@vger.kernel.org; Sat, 02 Dec 2006 21:14:11 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello list!

Recently test t4118 was added to prepare for upcoming changes in
behaviour of GNU diff.

This test fails on Mac OS X. It turns out that in the end the failure
comes from a difference in the behaviour between GNU sed and the version
that comes with OS X.

The feature that is tested works fine, but the implementation of the
examination of the result fails.

The difference is that the OS X version of sed always ends the last line
with a newline character, even if it wasn't there in the input. Strictly
speaking this is POSIX specified behaviour that was changed in the GNU
version of sed in 1997, citing from the changelog for the historically
curious minded people:

Mon Jul 28 10:50:41 PDT 1997  Ken Pizzini <ken@gnu.org>

* sed.c, sed.h, execute.c: POSIX.2, section 4.55.7, says that
        a newline must end *every* output line.  But I think
        that it is useful (when seding a binary file) to omit
        a trailing newline if the input lacks one.  Thus the addition of
        POSIXLY_CORRECT behavior.

* execute.c: however, when seding multiple files my feeling
        is that it makes sense to have each file but the last
        behave as-if it ended in a newline.  Modified read_pattern_space()
        accordingly.

A workaround on Mac OS X is easy by for example just installing the GNU
version of sed from the 'fink' archive with "sudo apt-get install sed".
Funny enough the system 'diff' is already the GNU version, so the test
t4118 itself might even be necessary for upcoming feline versions of
OS X!

Unfortunately I myself don't see an elegant and portable fix in the test
itself... [hint]
-- 
