From: andreas.koenig.7os6VVqR@franz.ak.mind.de (Andreas J. Koenig)
Subject: [BUG] Git bisect not finding the right commit
Date: Thu, 19 Jan 2012 04:29:49 +0100
Message-ID: <87r4yw8j4i.fsf@franz.ak.mind.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 04:40:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnirt-0004Lg-4b
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 04:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086Ab2ASDk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 22:40:28 -0500
Received: from rz1.akoenig.de ([83.223.90.65]:41552 "EHLO rz1.akoenig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab2ASDk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 22:40:28 -0500
X-Greylist: delayed 631 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jan 2012 22:40:27 EST
Received: from franz.ak.mind.de (p4FC974BB.dip.t-dialin.net [79.201.116.187])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "franz.ak.mind.de", Issuer "franz.ak.mind.de" (not verified))
	by rz1.akoenig.de (Postfix) with ESMTPS id 72DC220034
	for <git@vger.kernel.org>; Thu, 19 Jan 2012 04:10:25 +0100 (CET)
Received: from k75.linux.bogus (localhost.localdomain [127.0.0.1])
	by k75.linux.bogus (8.14.3/8.14.3/Debian-9.4) with ESMTP id q0J3TokS006531
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 19 Jan 2012 04:29:50 +0100
Received: (from k@localhost)
	by k75.linux.bogus (8.14.3/8.14.3/Submit) id q0J3Tn4u006530;
	Thu, 19 Jan 2012 04:29:49 +0100
X-Authentication-Warning: k75.linux.bogus: k set sender to andreas.koenig.7os6VVqR@franz.ak.mind.de using -f
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188789>

My git versions
---------------
1.7.9.rc2 and 1.7.8.3 and 1.7.2.5

The example output below was produced with 1.7.8.3 as provided by debian
"git/unstable uptodate 1:1.7.8.3-1"

The result looks the same on all three versions. I did not do a
byte-by-byte comparison, but the outcome is the same.

The repository
--------------
http://perl5.git.perl.org/perl.git

Problem description
-------------------
After v5.15.5-20-gfd76d40 a merge happened and v5.15.4-110-g27b29ec
through v5.15.4-169-g3582575 were inserted. The code was developed
before v5.15.5 but merged after v5.15.5.

	- A -> B      ->     C - D ->
	         \         /
	          - E - F -

A v5.15.5
B v5.15.5-20-gfd76d40
C v5.15.5-81-gcfe287a
D v5.15.5-159-ga71d67b
E v5.15.4-110-g27b29ec
F v5.15.4-169-g3582575

The change in perl I tried to locate was v5.15.5-13-gff0cf12, between A
and B. Bisect did not find it, it returned me E instead. Here the wrong
bisect output:

% git bisect start v5.15.5-159-ga71d67b v5.15.5
Already on 'blead'
Bisecting: 77 revisions left to test after this (roughly 6 steps)
[cfe287a06b2ed98c25aebb477f6b400409f1fc85] Merge remote-tracking branch 'p5p/smoke-me/gsoc-pod' into blead
% git describe
v5.15.5-81-gcfe287a
% git bisect bad
Bisecting: 40 revisions left to test after this (roughly 5 steps)
[baf7658bacfa659cdab08050470b20ebd5973384] Update htmlview.t for new Pod::Html
% git describe
v5.15.4-149-gbaf7658
% git bisect bad
Bisecting: 19 revisions left to test after this (roughly 4 steps)
[fbf24e084f7e43d3caa066f3520b4c32ebbb2e3a] Start modifying test cases to suit new Pod::Html
% git describe
v5.15.4-129-gfbf24e0
% git bisect bad
Bisecting: 9 revisions left to test after this (roughly 3 steps)
[9949917516c8bca1036187e3e878ed8869558a65] Finish skeleton version of Pod::Html
% git describe
v5.15.4-119-g9949917
% git bisect bad
Bisecting: 4 revisions left to test after this (roughly 2 steps)
[953c3c52c300d440cb8e0811a812e78c12d45695] Remove spurious code after start of parser switch
% git describe
v5.15.4-114-g953c3c5
% git bisect bad
Bisecting: 2 revisions left to test after this (roughly 1 step)
[2618a74b5307cde59d3b3111031637fbe4bfe0cf] Remove cache feature for simplicity
% git describe
v5.15.4-111-g2618a74
% git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[27b29ec338b08496d21538c0db7377d446529f8b] Remove deprecated --netscape flag
% git describe
v5.15.4-110-g27b29ec
% git bisect bad
27b29ec338b08496d21538c0db7377d446529f8b is the first bad commit
commit 27b29ec338b08496d21538c0db7377d446529f8b
Author: Marc Green <marcgreen@cpan.org>
Date:   Mon May 16 23:46:07 2011 -0400

 deprecated --netscape flag

:040000 040000 6759c516ef91450c73a01c5695051f31b787171e 080d58438a5c00aaaa6464f4c3a42c2ffd5f7ee0 M      ext
% git version
git version 1.7.8.3


What I expected
---------------
The above result is wrong, git should have found v5.15.5-13-gff0cf12.
Git seemingly did not consider the revisions between v5.15.5 and
v5.15.5-20-gfd76d40.

Let me know if you need further informations. (I'm not subscribed to the
mailing list.)

Thanks && Regards,
-- 
andreas
