From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/2] test results for v1.7.12-rc0 on cygwin
Date: Sat, 28 Jul 2012 19:46:17 +0100
Message-ID: <50143379.8050500@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 20:54:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvC9N-0004QO-67
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 20:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946Ab2G1Sxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 14:53:52 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:48641 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751533Ab2G1Sxu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 14:53:50 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 2D402A0C080;
	Sat, 28 Jul 2012 19:53:50 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 79B43A0C07F;	Sat, 28 Jul 2012 19:53:49 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Sat, 28 Jul 2012 19:53:48 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202454>

Hi Junio,

I actually tested v1.7.12-rc0-22-gcdd159b, thus:

    $ time $(GIT_SKIP_TESTS='t0061.3 t0070.3 t9010 t9300' make test >
    test-outp1 2>&1)

    real    137m11.901s
    user    118m55.071s
    sys     59m50.695s
    $

the result, ignoring the explicity skipped tests (nothing new there), was
three additional failures:

    t1100.5, t7502.21 and t7810.59

I will be sending a patch to fix t1100.5 (patch #1).

The failure in t7502-commit.sh seems to be the result of commit 8c5b1ae1
("ident: reject bogus email addresses with IDENT_STRICT", 24-05-2012)
being more strict with non fully qualified hostnames. I get the "tell me
who you are" message and the error:

    fatal: unable to auto-detect email address (got 'ramsay@toshiba.(none)')

However, I *think* I saw that Jeff has submitted a fix for this already.

Unfortunately, I was unable to reproduce the final failure in t7810-grep.sh.
I tried, among other things, to provoke a failure thus:

    $ for i in $(seq 100); do
    > if ! ./t7810-grep.sh -i -v; then
    >     break;
    > fi
    > done
    $

but, apart from chewing on the cpu for about 50 minutes, it didn't result
in a failure. :(

However, after looking at test 59, it seems to me to be a stale (redundant)
test. So, patch #2 removes that test! :-D [I wish I could reproduce the
failure because I don't like not knowing why it failed, but ...]

ATB,
Ramsay Jones
