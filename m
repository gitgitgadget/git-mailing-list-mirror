From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Sun, 15 Nov 2009 18:07:13 +0100
Message-ID: <200911151807.15726.trast@student.ethz.ch>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm> <1258055164-11876-2-git-send-email-rocketraman@fastmail.fm> <20091114071946.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>, <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Sun Nov 15 18:08:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9iaS-0007Eg-WD
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 18:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbZKORIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 12:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752413AbZKORIQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 12:08:16 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:31033 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbZKORIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 12:08:16 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 18:08:22 +0100
Received: from thomas.localnet (129.132.210.10) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 18:07:58 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <20091114071946.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132945>

Nanako Shiraishi wrote:
> Quoting rocketraman@fastmail.fm
> > Add a basic introduction to the branch management undertaken during a
> > git.git release
[...]
> Here are some corrections that can be applied on top of your change.

At the bottom there are some more corrections on top of your combined
patches.  At this point I would prefer to squash everything into a
single patch, but if you want to keep them separate I can come up with
a commit message.

All but the last change are just intended to "sound nicer".  Since I'm
not a native speaker either (I'm not sure any have commented in the
threads so far), it would probably be nice to get some additional
comments.

As for the last hunk, I felt it was misleading to state 'pu' uses the
same process as 'next' immediately after mentioning the "next will be
rewound shortly" messages that Junio sends out.  Such a message is
never required for 'pu' because (as is already explained in the
manpage) the "contract" is that the maintainer may rewind it anytime
he likes.

Apart from that, I'm not entirely happy with the way the "release" and
"maint, after a feature release" sections are tangled yet.  There are
several forward and backward references between them.  I see that you
are trying to drive home the point that maint needs to be contained in
master.  Can't we just deal with that in the "feature release"
section?

-- 8< --
diff --git i/Documentation/gitworkflows.txt w/Documentation/gitworkflows.txt
index 2a9329f..490346c 100644
--- i/Documentation/gitworkflows.txt
+++ w/Documentation/gitworkflows.txt
@@ -225,8 +225,8 @@ should first make sure that condition holds.
 git log master..maint
 =====================================
 
-There should be no commit listed from this command (otherwise, check
-out 'master' and merge 'maint' into it).
+This command should not list any commits.  Otherwise, check out
+'master' and merge 'maint' into it.
 
 Then you can tag the tip of
 'master' with a tag indicating the release version.
@@ -241,15 +241,15 @@ Similarly, for a maintenance release, 'maint' is tracking the commits
 to be released. Therefore, simply replace 'master' above with
 'maint'.
 
-You need to push the new tag to a public git server,
-at the same time you push the updated 'master' or 'maint',
-if you are making a maintenance release. (see
-"DISTRIBUTED WORKFLOWS" below). This push makes the tag available to
+You need to push the new tag to a public git server
+when you push the updated 'master' (or 'maint',
+if you are making a maintenance release).  See
+"DISTRIBUTED WORKFLOWS" below. This makes the tag available to
 others tracking your project. The push could also trigger a
 post-update hook to perform release-related items such as building
 release tarballs and preformatted documentation pages.  You may want
-to wait this push-out before you update your 'maint' branch (see the
-next section).
+to defer the push until after you have updated your 'maint' branch
+(see the next section).
 
 
 Maintenance branch management after a feature release
@@ -319,8 +319,6 @@ so.
 If you do this, then you should make a public announcement indicating
 that 'next' was rewound and rebuilt.
 
-The same process may be followed for 'pu'.
-
 
 DISTRIBUTED WORKFLOWS
 ---------------------
