From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v5 0/2] submodule update: add --remote for submodule's upstream
 changes
Date: Wed, 28 Nov 2012 14:30:27 -0500
Message-ID: <cover.1354130656.git.wking@tremily.us>
References: <20121128165334.GA20483@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:31:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdnLi-0004qU-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 20:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706Ab2K1Ta4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 14:30:56 -0500
Received: from vms173021pub.verizon.net ([206.46.173.21]:11261 "EHLO
	vms173021pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755991Ab2K1Tav (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 14:30:51 -0500
Received: from odin.tremily.us ([unknown] [72.68.95.13])
 by vms173021.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME700MXVQ72LTN0@vms173021.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Nov 2012 13:30:39 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 26DA16E19EA; Wed,
 28 Nov 2012 14:30:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354131038; bh=DsyjeUQlynN6L/oF6D5aJG65nFG27nl5BggYx2sRqII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pTjb4iBumRo+U5obGoS7+GLdGn8bQtUsKfojzls91sjofuTX78nXPFR6HUBY4VaZi
 fn5/P/Y6nZS52jhhyP7Ob8rcLqGkmwhMjxz0ZBxm7JSszZlVv/qE0cymgQBwYiWD24
 FzdO/0hijWztvd/y92eraE3h+u7Y1FYE7iliR9Mk=
X-Mailer: git-send-email 1.7.8.6
In-reply-to: <20121128165334.GA20483@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210764>

From: "W. Trevor King" <wking@tremily.us>

On Wed, Nov 28, 2012 at 11:53:34AM -0500, W. Trevor King wrote:
> I thought of a better idea on the train.  How about adding `--remote`
> to `submodule update` that overrides the gitlinked SHA-1 with the
> SHA-1 for origin/$branch?  All of the other checkout/merge/rebase
> functionality is untouched.  The only thing that changes is where we
> look for the update.  I'm working up the patch now, and will submit v5
> shortly.

Here it is.

Changes since v4:

* Remove `update --branch` in favor of the new `update --remote` logic
  as mentioned above.
* Optional config overrides for submodule.<name>.branch (as suggested
  by Jens)
* Save --branch as submodule.<name>.branch instead of requiring
  --local-branch.
* Restructure doc edits.

I'm a lot happier with this two-patch proposal.  The first patch
implements --remote and documents submodule.<name>.branch.  The second
patch just gives you a convenient way to set it.  I haven't heard from
anyone other than Heiko recently about the --branch/--remote-branch
choice, so I returned to the simpler --branch side effect storage from
v1.  I'd be happy to submit v6 with explicit --remote-branch recording
if desired.

W. Trevor King (2):
  submodule update: add --remote for submodule's upstream changes
  submodule add: If --branch is given, record it in .gitmodules

 Documentation/config.txt        |  9 +++++----
 Documentation/git-submodule.txt | 26 +++++++++++++++++++++++++-
 Documentation/gitmodules.txt    |  5 +++++
 git-submodule.sh                | 30 +++++++++++++++++++++++++++++-
 t/t7400-submodule-basic.sh      |  1 +
 t/t7406-submodule-update.sh     | 31 +++++++++++++++++++++++++++++++
 6 files changed, 96 insertions(+), 6 deletions(-)

-- 
1.8.0.2.gad10246.dirty
