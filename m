From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: t9401 fails with OS X sed
Date: Wed, 24 Oct 2012 23:54:12 -0400
Message-ID: <609AC6E7-45CD-4472-B1DC-FBB785D6B815@gernhardtsoftware.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 06:01:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TREdC-0003Q0-Qb
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 06:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750Ab2JYEBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 00:01:05 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53167 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721Ab2JYEBE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2012 00:01:04 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2012 00:01:04 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id A945511711EA; Thu, 25 Oct 2012 03:54:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.5 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 033C811711E7
	for <git@vger.kernel.org>; Thu, 25 Oct 2012 03:54:13 +0000 (UTC)
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208336>

I seem to write these kinds of e-mails fairly regularly...

When running t9401-git-cvsserver-crlf:

expecting success: 
    check_status_options cvswork2 textfile.c "" &&
    check_status_options cvswork2 binfile.bin -kb &&
    check_status_options cvswork2 .gitattributes "" &&
    check_status_options cvswork2 mixedUp.c -kb &&
    check_status_options cvswork2 multiline.c -kb &&
    check_status_options cvswork2 multilineTxt.c "" &&
    check_status_options cvswork2/subdir withCr.bin -kb &&
    check_status_options cvswork2 subdir/withCr.bin -kb &&
    check_status_options cvswork2/subdir file.h "" &&
    check_status_options cvswork2 subdir/file.h "" &&
    check_status_options cvswork2/subdir unspecified.other "" &&
    check_status_options cvswork2/subdir newfile.bin "" &&
    check_status_options cvswork2/subdir newfile.c ""

not ok - 12 cvs status - sticky options

I have tracked it down to a sed expression that is parsing the output of cvs status:

49:    got="$(sed -n -e 's/^\s*Sticky Options:\s*//p' "${WORKDIR}/status.out")"

The problem is that cvs outputs "Sticky Options:\t\t(none)\n", but OS X's sed doesn't recognize the \s shortcut.  (According to re_format(5), \s is part of the "enhanced" regex format, which sed doesn't use.)  

It works if I change \s to [[:space:]], but I don't know how portable that is.

~~ Brian Gernhardt
