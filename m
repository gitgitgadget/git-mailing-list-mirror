From: Stephen Kelly <steveire@gmail.com>
Subject: Re: gitk with submodules does not show new commits on other branches
Date: Mon, 23 Jun 2014 20:24:24 +0200
Message-ID: <lo9rcn$8tu$1@ger.gmane.org>
References: <lo6o2h$vva$1@ger.gmane.org> <53A6F978.4010005@web.de> <lo9mg1$bma$1@ger.gmane.org> <lo9ogu$4in$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 20:24:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz8v5-0003ZN-5i
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 20:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbaFWSYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 14:24:39 -0400
Received: from plane.gmane.org ([80.91.229.3]:49066 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbaFWSYj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 14:24:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Wz8ux-0003Uw-H9
	for git@vger.kernel.org; Mon, 23 Jun 2014 20:24:35 +0200
Received: from 188.111.54.34 ([188.111.54.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 20:24:35 +0200
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 20:24:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252363>

Stephen Kelly wrote:

> I see that gitk is showing the output of git diff --submodule, similar to
> git submodule summary.
> 
> Assuming that is not going to be changed, maybe I can hack
> parseblobdiffline locally. I have not really tried to read of write tcl
> code before though, so I'd still prefer a 'proper' solution somehow.

I dug deeper and came up with this patch which suits my needs:

diff --git a/submodule.c b/submodule.c
index b80ecac..0dacd61 100644
--- a/submodule.c
+++ b/submodule.c
@@ -297,7 +297,7 @@ static int prepare_submodule_summary(struct rev_info 
*rev, const char *path,
        init_revisions(rev, NULL);
        setup_revisions(0, NULL, rev, NULL);
        rev->left_right = 1;
-       rev->first_parent_only = 1;
+  rev->max_parents = 1;
        left->object.flags |= SYMMETRIC_LEFT;
        add_pending_object(rev, &left->object, path);
        add_pending_object(rev, &right->object, path);


The 'merge pull request' merges are only noise to me.

Thanks,

Steve.
