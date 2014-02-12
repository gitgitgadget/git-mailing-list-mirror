From: David Kastrup <dak@gnu.org>
Subject: Turning a test script into something usable in t/perf
Date: Wed, 12 Feb 2014 17:26:42 +0100
Message-ID: <877g909u0t.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 12 17:27:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDceI-00034A-Fv
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 17:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbaBLQ0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 11:26:54 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:53459 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbaBLQ0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 11:26:53 -0500
Received: from localhost ([127.0.0.1]:52502 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDceC-0004GU-It
	for git@vger.kernel.org; Wed, 12 Feb 2014 11:26:52 -0500
Received: by lola (Postfix, from userid 1000)
	id 7BBA5E047A; Wed, 12 Feb 2014 17:26:42 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241996>

--=-=-=
Content-Type: text/plain


Hi,

I find that I have little clue about how to convert the following brief
test script into some test to place in t/perf:


--=-=-=
Content-Type: text/x-sh
Content-Disposition: inline; filename=blame-catastrophe.sh

#!/bin/sh
rm -rf /tmp/git-test
mkdir /tmp/git-test
cd /tmp/git-test
git init
LIMIT=200000
yes a|head -$LIMIT >data
yes b|head -$LIMIT >data2
git add data data2
git commit -m "split"
git rm data2
yes 'a
b' | head -$(($LIMIT*2)) >data
git add data
git commit -m "combined"
time git blame data >/dev/null

--=-=-=
Content-Type: text/plain


The variable LIMIT is the deciding factor for determining performance
which, with the code in current master, is rather measurably O(LIMIT^2).
I think that the current test takes about 15 minutes to complete on my
computer.

Obviously, that's sort of excessive: there is little point in choosing
sizes that show off more than two orders of magnitude in improvement.

Now the pathological cases are lots of small but attributable fragments
in the blamed source files.  One real-world project that is hit rather
hard is an alphabetically sorted large list of words that tends to get
insertions/deletions of few scattered lines at a time.

Should one aim for an actually pathological case like in this script?
Should one try benchmarking with one of the stock repositories instead
that don't really demonstrate well just how bad the behavior might
become and which code passages are dominant regarding the quadratic
behavior?

-- 
David Kastrup

--=-=-=--
