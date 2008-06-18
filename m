From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [egit-jgit] excluded patterns are decorated as being untracked
Date: Thu, 19 Jun 2008 00:03:36 +0200
Message-ID: <200806190003.36791.robin.rosenberg.lists@dewire.com>
References: <4857E9A0.7070408@redhat.com> <200806172316.46416.robin.rosenberg.lists@dewire.com> <48592C88.3080302@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Florian Koeberle <florianskarten@web.de>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: Galder Zamarreno <galder.zamarreno@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:08:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K95pA-0002da-Up
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 00:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbYFRWHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 18:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbYFRWHU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 18:07:20 -0400
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:42418 "EHLO
	av10-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754223AbYFRWHT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 18:07:19 -0400
Received: by av10-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id D66B13841D; Thu, 19 Jun 2008 00:07:16 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av10-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id A190137E52; Thu, 19 Jun 2008 00:07:16 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 8459E37E47;
	Thu, 19 Jun 2008 00:07:16 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <48592C88.3080302@redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85413>

onsdagen den 18 juni 2008 17.40.56 skrev Galder Zamarreno:
> Hmmmm, is marking a resource as "derived" recursive? i.e. if I mark 
> "output" folder as derived, would anything under it be considered 
> derived? It'd be a pain to go a mark as derived each and every class.

It seems it is not recursive and worse, not saved with the project.

> I suppose you still need the patch to use Team.isIgnoredHint to get 
> derived resources to be ignored, correct?

You'll need another patch for the decorator to pick up derived resources
properly. Probably not the final solution to decorations. For one thing the
decorators are horribly inefficient.

> Hmmmm, so the proper way is either marking resources as derived and use 
> your patch or implementing .git/info/exclude, correct?

I'd say implementing .git/info/exlude is the proper solution. The others are
mere workarounds.

-- robin

>From 7acc0e63886ed8eda6b38a5edbfe9a6aa4d509dc Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Wed, 18 Jun 2008 23:50:42 +0200
Subject: [PATCH] Decorate derived resources as ignored.

This is done by using the appropriate API.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../internal/decorators/GitResourceDecorator.java  |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 4b6394c..0308f6a 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -273,8 +273,7 @@ public class GitResourceDecorator extends LabelProvider implements
 							}
 
 						} else {
-							if (rsrc.getType() == IResource.FILE
-									&& Team.isIgnored((IFile) rsrc)) {
+							if (Team.isIgnoredHint(rsrc)) {
 								decoration.addSuffix("(ignored)");
 							} else {
 								decoration.addPrefix(">");
-- 
1.5.5.1.178.g1f811
