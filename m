From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intermittent failures in t9119
Date: Sun, 05 Dec 2010 12:39:38 -0800
Message-ID: <7vy684t0mt.fsf@alter.siamese.dyndns.org>
References: <7vmxoml1p7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sun Dec 05 21:40:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPLNS-0001MD-4p
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 21:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756165Ab0LEUju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 15:39:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108Ab0LEUjs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 15:39:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8BEC738D6;
	Sun,  5 Dec 2010 15:40:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1g2CxodbLTIXkBsnx3sQdTWKw2Y=; b=NnpHG+
	qpfKkziEc5EAbmBnpt8ZXdWzA5BWdm8aQDdSCnMivBH+iLEwaIP5ykOcvj9JkhbD
	8sBlHVfH4zZGR5gCg5bt02nbyhCjhuTp3lxyFpuVMwsH8moCbe9DH1Z53mNvTjcM
	mKx3l7tofPaLW/YVwaDhECAn8D2cDpPfKvdu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XEj4fqzgGSQ3wPVfsSimpJJnARtHAtbP
	s6JDZP/r2v4exsNQCWZlD8YRAo21RTmidA9qgxe4YbUc2LqYH+B9k58Vg5Hgnslm
	WYz2rmtmeGNS3g0XPMcYUpVABTsN00sQ3bSHUxusLwHHHCn8nofGKpw7AiDZp3ZC
	4CvjE8V9Vsg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 59DCB38D5;
	Sun,  5 Dec 2010 15:40:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1267638D4; Sun,  5 Dec 2010
 15:40:00 -0500 (EST)
In-Reply-To: <7vmxoml1p7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 03 Dec 2010 18\:19\:16 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7585F7A-00AF-11E0-94AD-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162961>

Junio C Hamano <gitster@pobox.com> writes:

> Sorry for bringing up an old story, but since you added "git svn info"
> with e6fefa9 (git-svn info: implement info command, 2007-11-21),...
>
> I am seeing breakages from the said test:
>
>     not ok - 6 info file
>     #
>     #               (cd svnwc; svn info file) > expected.info-file &&
>     #               (cd gitwc; git svn info file) > actual.info-file &&
>     #               test_cmp expected.info-file actual.info-file
>
>     : trash directory.t9119-git-svn-info/master; diff *.info-file
>     12c12
>     < Text Last Updated: 2010-12-04 00:34:58 +0000 (Sat, 04 Dec 2010)
>     ---
>     > Text Last Updated: 2010-12-04 00:34:57 +0000 (Sat, 04 Dec 2010)
>
> I do not know if we should expect output from "svn info" to match exactly
> like the above.  Is "Text Last Updated" supposed to show the stat
> timestamp of the working tree (I see "(stat $path)[9]" there)?
> ...
>
> I _think_ "svn info file" actually gives the timestamp of the revision
> that touched the file the last (in their linear worldview of the history),
> so perhaps this is demonstrating the real bug, but only when the test runs
> very slowly?

I think we should not expect "git svn info" to match "svn info" at least
at the "Text Last Updated" line.  The former seems to want to report the
timestamp of the working tree, but "svn info" does not seem to look at the
file in the working tree.

    $ mkdir svntest
    $ cd svntest
    $ mkdir repo
    $ svnadmin create repo
    $ svn checkout file://$(pwd)/repo work
    Checked out revision 0.
    $ cd work
    $ echo hello >world; svn add world; svn commit -m initial
    A         world
    Adding         world
    Transmitting file data .
    Committed revision 1.
    $ svn info world | grep 'Text Last'
    Text Last Updated: 2010-12-05 12:24:52 -0800 (Sun, 05 Dec 2010)
    $ touch world
    $ svn info world | grep 'Text Last'
    Text Last Updated: 2010-12-05 12:24:52 -0800 (Sun, 05 Dec 2010)
    $ ls -l world
    -rw-rw-r-- 1 junio junio 6 2010-12-05 12:25 world
    $ rm world
    $ svn info world | grep 'Text Last'
    Text Last Updated: 2010-12-05 12:24:52 -0800 (Sun, 05 Dec 2010)

I have these suspicions:

 (1) Somebody may have liked if "git svn info" exactly matched "svn info"
     in that it would give the timestamp of the commit object that touched
     the path the last in the current history.  The current implementation
     in that sense is buggy;

 (2) Nobody uses the value from "Text Last Updated" field in practice, so
     that bug has been unnoticed so far;

 (3) And it is not worth fixing it ;-)

For now, I would suggest fixing the failing test to ignore the "Text Last
Updated" field while comparing, and if somebody is inclined to, we would
update the code to match what "svn info" does.

Thoughts?
