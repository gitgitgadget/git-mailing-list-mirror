X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Continue traversal when rev-list --unpacked finds a packed commit.
Date: Mon, 30 Oct 2006 17:47:14 -0800
Message-ID: <7vk62hs1ct.fsf@assigned-by-dhcp.cox.net>
References: <20061029093754.GD3847@spearce.org>
	<Pine.LNX.4.64.0610301332440.11384@xanadu.home>
	<20061030202611.GA5775@spearce.org>
	<20061030205200.GA20236@delft.aura.cs.cmu.edu>
	<7v3b95wjmg.fsf@assigned-by-dhcp.cox.net>
	<20061030225500.GG3617@delft.aura.cs.cmu.edu>
	<7vhcxltmit.fsf@assigned-by-dhcp.cox.net>
	<20061031013749.GA19885@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 01:49:12 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061031013749.GA19885@delft.aura.cs.cmu.edu> (Jan Harkes's
	message of "Mon, 30 Oct 2006 20:37:49 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30560>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeijH-0004dL-M2 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 02:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965183AbWJaBrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 20:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWJaBrQ
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 20:47:16 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:57289 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S965183AbWJaBrP
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 20:47:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031014715.GSKL18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 20:47:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gpmv1V00H1kojtg0000000 Mon, 30 Oct 2006
 20:46:55 -0500
To: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: git-owner@vger.kernel.org

Jan Harkes <jaharkes@cs.cmu.edu> writes:

> When getting the list of all unpacked objects by walking the commit history,
> we would stop traversal whenever we hit a packed commit. However the fact
> that we found a packed commit does not guarantee that all previous commits
> are also packed. As a result the commit walkers did not show all reachable
> unpacked objects.
>
> Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>

Thanks.

With this, I think revs->unpacked should not mean "limited", so
I suspect this is also needed, no?

diff --git a/revision.c b/revision.c
index 93f2513..2d7cad9 100644
--- a/revision.c
+++ b/revision.c
@@ -1010,7 +1010,7 @@ int setup_revisions(int argc, const char
 		add_pending_object(revs, object, def);
 	}
 
-	if (revs->topo_order || revs->unpacked)
+	if (revs->topo_order)
 		revs->limited = 1;
 
 	if (revs->prune_data) {


