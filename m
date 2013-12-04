From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC/WIP PATCH 0/4] less ignorance of submodules for ignore=all
Date: Wed, 4 Dec 2013 23:16:59 +0100
Message-ID: <20131204221659.GA7326@sandbox-ub>
References: <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
 <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
 <20131122220953.GI4212@google.com>
 <52910BC4.1030800@web.de>
 <20131124005256.GA3500@sandbox-ub>
 <52922962.3090407@web.de>
 <CAErtv2729o-xf=49xY06aVL1ZJzJpeH+cc_Pd1cAP52r32Ss_g@mail.gmail.com>
 <20131125174945.GA3847@sandbox-ub>
 <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 23:17:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoKkw-0006Ah-Jv
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 23:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab3LDWRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 17:17:13 -0500
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:59389 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3LDWRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 17:17:13 -0500
Received: from [77.21.76.49] (helo=sandbox-ub)
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VoKkk-00023X-EN; Wed, 04 Dec 2013 23:17:06 +0100
Content-Disposition: inline
In-Reply-To: <CAErtv259jxCtvbJYZHgQZv-VJ9U+JwNzWo0tn007SDTCCBScrA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238816>

This is my current work in progress. Sergey it would be awesome if you
could test these and tell me whether the behaviour is what you would
expect. Once that is settled I will add some tests and possibly clean up
some code.

Since nobody spoke against this change of behavior I assume that we
agree on the general approach I am taking here. If not please speak up
now so we can work something out and save me implementation time ;-)

Whats still missing is:

 * it seems reset does not care at all about the ignore settings. It
   still shows a

   M	submodule

   line even when the submodule in question was not in the index and is
   marked as ignored. Have not looked at the code yet.

 * The git diff $commit question Junio mentioned here[1] it does not yet
   show diffs of ignore=all submodules.

For testing convenience you can also find all patches applied to Junio's
current master here:

https://github.com/hvoigt/git/commits/hv/fix_ignore_all_submodules

Cheers Heiko

Heiko Voigt (4):
  disable complete ignorance of submodules for index <-> HEAD diff
  fix 'git add' to skip submodules configured as ignored
  teach add -f option for ignored submodules
  always show committed submodules in summary after commit

 builtin/add.c             | 55 ++++++++++++++++++++++++++++++++++++-----------
 builtin/commit.c          |  1 +
 builtin/diff.c            |  2 ++
 diff-lib.c                |  3 +++
 diff.h                    |  2 +-
 submodule.c               | 26 ++++++++++++++++++++--
 submodule.h               |  2 ++
 t/t4027-diff-submodule.sh | 12 ++++++++---
 t/t7508-status.sh         |  6 +++++-
 9 files changed, 90 insertions(+), 19 deletions(-)

-- 
1.8.5.1.43.gf00fb86
