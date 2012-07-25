From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH v2] t3300-*.sh: Fix a TAP parse error
Date: Wed, 25 Jul 2012 20:46:53 +0100
Message-ID: <50104D2D.70109@ramsay1.demon.co.uk>
References: <500EEDF4.7050007@ramsay1.demon.co.uk> <20120724191707.GA5210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 21:49:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su7Zw-0005sH-Ev
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 21:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab2GYTs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 15:48:57 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:43404 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752404Ab2GYTs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 15:48:56 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 929CAA0C081;
	Wed, 25 Jul 2012 20:48:55 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id BB98BA0C07F;	Wed, 25 Jul 2012 20:48:54 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Wed, 25 Jul 2012 20:48:53 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120724191707.GA5210@burratino>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202190>

Jonathan Nieder wrote:
>> This version of the patch only moves code to determine the test
>> prerequisite to the outer level, while leaving the 'setup' aspects
>> of the first test in place.
> 
> I guess I don't see the point.

You don't see the point of fixing the TAP Parse error? :-D

>                                The current convention of "don't do
> anything complicated outside test assertions" is easy to explain.
> What new convention are you suggesting to replace it?

Hmm, well I guess I'm not going to suggest anything!

However, what is "anything complicated"?

At the end of test-lib.sh we find:

    # test whether the filesystem supports symbolic links
    ln -s x y 2>/dev/null && test -h y 2>/dev/null && test_set_prereq SYMLINKS
    rm -f y

    # When the tests are run as root, permission tests will report that
    # things are writable when they shouldn't be.
    test -w / || test_set_prereq SANITY

Is this too complicated? If not, why not? If yes, should it be added to
a test assertion?

Would it be acceptable for me to add some code, here at the end of
test-lib.sh, to set the TABS_IN_FILENAME test prerequisite and use it
in tests t3300-funny-names.sh, t3902-quoted.sh, t3600-rm.sh,
t4016-diff-quote.sh and t4135-apply-weird-filenames.sh?

How about some of the test "library" files:

diff-lib.sh              lib-git-p4.sh            lib-read-tree.sh
gitweb-lib.sh            lib-git-svn.sh           lib-rebase.sh
lib-bash.sh              lib-gpg.sh*              lib-t6000.sh
lib-credential.sh*       lib-httpd.sh             lib-terminal.sh
lib-cvs.sh               lib-pager.sh             test-lib-functions.sh
lib-diff-alternative.sh  lib-patch-mode.sh        test-lib.sh
lib-gettext.sh           lib-prereq-FILEMODE.sh
lib-git-daemon.sh        lib-read-tree-m-3way.sh

Several of these files contain executable code (rather than just a
library of functions). For example, look at lib-cvs.sh, lib-httpd.sh,
and lib-prereq-FILEMODE.sh. Is this code too complicated?

Would it be acceptable for me to create an lib-prereq-TABSINFILE.sh
file so that I could source it only in the test files that require
the TABS_IN_FILENAME prerequisite?

ATB,
Ramsay Jones
