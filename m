From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/2] Revert "Fix commit id in egit test
	T0001_ConnectProviderOperationTest"
Date: Wed, 17 Dec 2008 08:09:33 -0800
Message-ID: <20081217160933.GD32487@spearce.org>
References: <1229472439-24104-1-git-send-email-robin.rosenberg@dewire.com> <1229472439-24104-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 17:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCyzR-0006fN-DP
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 17:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYLQQJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 11:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbYLQQJf
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 11:09:35 -0500
Received: from george.spearce.org ([209.20.77.23]:42717 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbYLQQJe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 11:09:34 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id DA1A138200; Wed, 17 Dec 2008 16:09:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1229472439-24104-2-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103357>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> This reverts commit 61133091d5f22398828b350ff772165e9945db8a.
> 
> Bisect says this is the commit that failed, which is odd. Bad QA.

Hmmph.  This revert fails here.

> diff --git a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
> index 0ce2d7f..aae1ef4 100644
> --- a/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
> +++ b/org.spearce.egit.core.test/src/org/spearce/egit/core/op/T0001_ConnectProviderOperationTest.java
> @@ -99,8 +99,9 @@ assertTrue("tree missing", new File(gitDir,
>  				"objects/08/ccc3d91a14d337a45f355d3d63bd97fd5e4db9").exists());
>  		assertTrue("tree missing", new File(gitDir,
>  				"objects/9d/aeec817090098f05eeca858e3a552d78b0a346").exists());
> +
>  		assertTrue("commit missing", new File(gitDir,
> -				"objects/09/6f1a84091b90b6d9fb12f95848da69496305c1").exists());
> +				"objects/45/df73fd9abbc2c61620c036948b1157e4d21253").exists());

Debugging this test shows that the commit we created in the test
is actually:

--
$ git cat-file commit 4c1bc1435f93c9409c93db5239e111271a8ccf55
tree 9daeec817090098f05eeca858e3a552d78b0a346
author J. Git <j.git@egit.org> 60876086400 +0100
committer J. Git <j.git@egit.org> 60876086400 +0100

testNewUnsharedFile

Junit tests
--

Which has me starting to wonder, what the heck is different
between systems that is being reflected in this commit object?
The only thing I can think of is the timestamp we are creating by
the deprecated Date constructor call back on line 82.  Perhaps
on different JVMs it is using different values for the hh:mm:ss
parts of the timestamp value?

-- 
Shawn.
