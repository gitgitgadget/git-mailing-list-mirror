From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/4] Fix gc failure when a remote HEAD goes stale
Date: Thu, 24 Sep 2015 11:13:24 +0200
Organization: gmx
Message-ID: <cover.1443085919.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 24 11:13:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zf2ay-0003vx-OA
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 11:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbbIXJNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 05:13:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:49197 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbbIXJNf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 05:13:35 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MYg42-1a9IuN0EoU-00VTzZ; Thu, 24 Sep 2015 11:13:25
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:Py2LbFrITD7kiLrmrcj7V3HTs9giEu1Iffif/5idlWKcw4VtZTl
 Vui8ZS68YYkVIYuo9PIdkCI20bx28j44f8eCd8SU/jnTDkQrK4/VsmELTNr0u8SBTjkgpMS
 +DOMzmpl85c8Iv+ejKJsqi6xNWxIaBs8gFR4TDMZSENGTPuuD5RtqwkwnMNirQ5Sy/xgkMe
 8tQpTv1NLMZlpYlHTomsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S1CcGH8nnVY=:M58VAYQRsqC5YGk7Z3wsEH
 RuWI8qBrF2YR7O6oBhNNlVZ63O448RwGU1nqkkbbZKCRj78pGzszc/IZThHyiFzidUsXTX1vE
 HWHpmOHyyLVTCBXNx3vkEG7OCmZWNPZ1xj/6ijXHXdl/542PaJm450ohxkNm3tiMZ2mkUlJmh
 BFlQmSVG9GPxVZsezwE45kjhtA6NxSsbUfWwBHZsQigu90lEybsflS2kJaC8Bo0wdnf/05FRm
 0jBcwgVZyTNwT2jaq0Y54Cq9L2d9lI5mQS/bDx0Xg9t24Pf1ktF4GFYnA00kAD7apk7xyJR6h
 /aRXpoinByu5TgOZDgBSJNHMP7WqBf9MTbXmn1PWhOTo+iNavuam5M5di1Q2gSt2q7Yhqm3eL
 vNv7HaDyrXvHhswCLUsXjmHBHrptNwg1EP76+HjVfD10dbqvSCDIBkkiGhL5GjsQ4EE36WbY9
 TO0RGlz1S8G+tGOP2dJQO4qBTAd57bXa1uCpcmOxhHTUEQ+uf+gPPbeA9LJwFfnorqVkfKA+u
 ++SHWaMlzRfq6Ma2KLGYuCoEgrtbPbfwREbiko/k6oeKON19G1abnGV/0L/2cRixcLzXyeIww
 1lkRPBHfg+tNEfEGVy1hXYVaQ9M/8CkhK6Yya3hgOOhoKbOqRuaMem9K48LfwlD0hEcPl/biK
 RnXOqZmkSVqPqTq0NlYzDjZEf+KoPRA2lMf3zhtf/+f+OPZT6LXZ4Y40bsQpVQCSc9PA3Beci
 ShsmPrKI+hyAfjAtybbHR4ai4VKVCn50MYuyXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278538>

There has been a report in the Git for Windows project that gc fails
sometimes: https://github.com/git-for-windows/git/issues/423

It turns out that there are cases when a remote HEAD can go stale and
it is not the user's fault at all. It can happen, for example, if the
active branch in the remote repository gets renamed.

Git's garbage collector should handle this gracefully. The best this
developer could come up with, is to simply ignore and delete the
now-broken refs.


Johannes Schindelin (4):
  gc: demonstrate failure with stale remote HEAD
  pack-objects: do not get distracted by stale refs
  mark_reachable_objects(): optionally collect broken refs
  gc: remove broken refs

 builtin/pack-objects.c |  1 +
 builtin/prune.c        | 12 +++++++++++-
 builtin/reflog.c       |  2 +-
 reachable.c            | 26 ++++++++++++++++++++------
 reachable.h            |  3 ++-
 t/t6500-gc.sh          | 15 +++++++++++++++
 6 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.5.2.windows.2
