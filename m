From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC/PATCH 0/4] Add submodule test harness
Date: Tue, 25 Mar 2014 18:03:50 +0100
Message-ID: <5331B6F6.60501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder p <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:06:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSUnd-00024D-34
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 18:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbaCYRFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 13:05:53 -0400
Received: from mout.web.de ([212.227.15.4]:56082 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754185AbaCYRFu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 13:05:50 -0400
Received: from [192.168.178.41] ([84.132.146.250]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MGzjq-1WFnAj1gAc-00Dld1; Tue, 25 Mar 2014 18:03:51
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:GzdZ0vsRLWhlEGZXB6RItxfMzlDr+JesmnG/Csl46xyv74/F4O8
 8vA568FXyvbbhdDe2pCv7LAzqSXQYxj9+ZlVuV08hIAjVrxsENRCCMTWLEii3jix3LdOPi9
 X9vNeB7ozXRSU2mZxa8wHWkPE8FynLerJD4gCS0w/r8yAxSJiQ1K2ag2xWsg+2kwgKSgU3x
 WmtdBeI3911EsonoYfbig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245048>

So here is my proposal for a single test harness for submodule updates. It is
intended to be easily applicable to all work tree manipulating commands. The
current version tests the status quo (and it documents two bugs in current
Git). This framework will be extended to cover recursive submodule update too
in a later series.

The first patch adds a simple helper function to the test lib which makes
it easier to test for an empty submodule directory.

The second patch contains the heavy lifting, it adds the test framework for
switching submodules. Currently only transitions without merge conflicts are
tested for, I intend to add others producing merge conflicts in a follow-up
series.

The third and forth patch show how to apply this framework to a simple
command (checkout) and a more complicated case where a helper function is
used to execute a preparing command (diff) which produces the input for the
then to-be-tested command (apply).

I'm currently working on adding this harness to more commands. read-tree and
reset are finished, merge and pull still show some oddities when used with
the --no-ff option, also cherry-pick and checkout-index are not working as
expected yet. And then there are am, apply, bisect, rebase, revert & stash
apply which still need to be covered.

Jens Lehmann (4):
  test-lib: add test_dir_is_empty()
  Submodules: Add the lib-submodule-update.sh test library
  checkout: call the new submodule update test framework
  apply: add t4137 for submodule updates

 t/lib-submodule-update.sh     | 627 ++++++++++++++++++++++++++++++++++++++++++
 t/t2013-checkout-submodule.sh |   5 +
 t/t4137-apply-submodule.sh    |  20 ++
 t/test-lib-functions.sh       |  11 +
 4 files changed, 663 insertions(+)
 create mode 100755 t/lib-submodule-update.sh
 create mode 100755 t/t4137-apply-submodule.sh

-- 
1.9.1.327.g3d8d896
