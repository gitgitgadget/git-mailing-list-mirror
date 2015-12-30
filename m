From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: ./t3310-notes-merge-manual-resolve.sh broken on pu under Mac OS ?
Date: Wed, 30 Dec 2015 14:20:04 +0100
Message-ID: <5683DA04.6000007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 14:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEGfk-0003Xm-NG
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 14:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbbL3NUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 08:20:09 -0500
Received: from mout.web.de ([212.227.17.12]:58323 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950AbbL3NUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 08:20:07 -0500
Received: from [192.168.2.107] ([79.223.108.227]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0M1X9B-1ZyNgK1JhR-00tVx4 for <git@vger.kernel.org>;
 Wed, 30 Dec 2015 14:20:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.0
X-Provags-ID: V03:K0:orvumDvY6tkFGJDnCfH+axkPPdw3H9uk9W1unGhElJXaxjNQLEm
 0xPJyv5y7sEWtPDTrjaCN4f6Q/r0K+9bI+FoWRRFoG5GmrgurznlM0EUoppO9w3HzvkECHi
 4+y1iVtVBJnSwnCiF+QROVhFpuzudl2MJsNtWo7j1uqL5w6UTwwjJYFeIGJPjfcQPRfOoYc
 hGwgTIRA7hApu08NJLgLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:synI0+ye46Y=:Q/YraKnBI9JSs1ItGAXUbn
 h/oO388U+/xrhOyqAY6sg5sGFtd9Mt2kuAJfYnNDvOWSKF/wndxfgn/IMxscsXz1FcpkhNMwY
 l0CLIOEvzLflArCjftpYT428PmpZrIKCmhpytC8lVZP8qC7rTCQx+RUgiIVYuVCTEI8J9rr5V
 sTSzRE0daUndcDJyUUnJyZc96Al1si4SKInLPLnrpfJvR0BmvGkW/i2BHjw5RDOJYr6JLmyGZ
 RdQ9rzYDUC9RhUvM77KD5z1XD2of096ojxGBKr/fyr6U1qUQ+auSOuMH10C+FW4ol2Sh90b0W
 SwY18OAZedOtsFazhAoUDwBr5gJTgiTS+AQZ/1agPUMChY0cdKNbK03xF83jV3FmmneCT9L/A
 iij2qY9tNxzcwCCb3GsC6dz9B/jxdIqDXmLPiVVjNAr+HE1mTkL6j3zel1gn/EDJXObSqp5aQ
 ylkZQYmzPRbgxAe0j94HI3VF2dIXbRhszrq6GA+Qgm1RPTmYXzuMbXzM7ydAhLg5dxEjqzfQv
 gwX7FDH47jNMKdlEdEFXIRyHP0Zo7LLustHY2RrSJMPjVDVy/BpYamHP5xZ0WdKJNha+qtGsn
 /WAStIemJOdCyN3zSRfNeoNdkn7hiHhxW8roXlRuNEKkhs+cQYqqXYG6KRVrLo3IwHsw0rnND
 Ui0bomGfJbsUp+D7dDLnq3B+qM6QOn2p93BGiEJ1Xu+o1uAkwLpDe5ODBrXxHcg4szEZVkNY8
 4cSH43PPxRJtAKD7HYMBUQvRz9vusgjwTH1rEVt0UpiF7GtADhUbS0xyUbGJ905IiNaYjsxz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283182>

I got 2 failures on pu under Mac OS, (Linux is OK)
I did some very basic debugging, it seems as if grep doesn't find
a needed string.
Does anybody have an idea here ?


--------------------
Failure 1:
Add some debug code:
git diff

-       grep -q refs/notes/z merge_commit_msg &&
+       echo >&2 before grep &&
+       echo >&2 before cat &&
+       cat >&2 merge_commit_msg &&
+       echo >&2 after cat &&
+       grep  refs/notes/z merge_commit_msg >&2 &&
        # Merge commit mentions conflicting notes
+       echo >&2 after grep &&

------ run the test:
debug=t verbose=t   ./t3310-notes-merge-manual-resolve.sh 2>&1 | less
-------- get this output:
before grep
before cat
Merged notes from z into refs/notes/m

Conflicts:
        04ed9a0bbe0285f41c913e2002cb09ef8449d4a6
        0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
        7a4ca6ee52a974a66cbaa78e33214535dff1d691
        d07d62e5208f22eb5695e7eb47667dc8b9860290

after cat
not ok 13 - finalize conflicting merge (z => m)


-----------------------
Failure 2:
index d557212..92fabf0 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -472,6 +472,9 @@ EOF
        test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
        # Merge commit mentions the notes refs merged
        git log -1 --format=%B refs/notes/m > merge_commit_msg &&
+       echo >&2 before cat &&
+       cat merge_commit_msg >&2 &&
+       echo >&2 after cat &&

not ok 17 - add + remove notes in finalized merge (z => m)
---------- gives this:
before cat
Merged notes from z into refs/notes/m

Conflicts:
        04ed9a0bbe0285f41c913e2002cb09ef8449d4a6
        0f7aa3ec6325aeb88b910453bb3eb37c49d75c11
        7a4ca6ee52a974a66cbaa78e33214535dff1d691
        d07d62e5208f22eb5695e7eb47667dc8b9860290

after cat
