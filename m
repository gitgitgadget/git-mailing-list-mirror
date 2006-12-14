X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 13:06:18 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612141251520.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
 <200612141136.59041.andyparkins@gmail.com> <20061214114546.GI1747@spearce.org>
 <8764ce6654.wl%cworth@cworth.org> <20061214120518.GL1747@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 14 Dec 2006 18:06:42 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061214120518.GL1747@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34378>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guuya-0006Zc-LE for gcvg-git@gmane.org; Thu, 14 Dec
 2006 19:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751953AbWLNSGV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 13:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbWLNSGV
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 13:06:21 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24883 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751953AbWLNSGU (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 13:06:20 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA90094CZMIHZ30@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 13:06:19 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Shawn Pearce wrote:

> But the problem raised is that there are many types of repositories,
> and not all should always have reflogs enabled, and its hard to
> tell which one should and which shouldn't by default, and its even
> worse to force it into a user's ~/.gitconfig as then repositories
> which should not have reflogs are getting them anyway.

Thank you for reminding me the reasons why.

However I'd argue that the lack of reflog data is much much worse than 
needlessly having it.

It is therefore much saner to disable it in the config and remove the 
unwanted reflog files than being sorry because it wasn't enabled when 
you would have needed it.

>  * Normal working repository (wants reflogs);
>  * Bare private (backup) repository (wants reflogs);
>  * Bare shared repository (probably doesn't want reflogs);
>  * Import generated repository (probably doesn't want reflogs);

And what would be the actual problem if reflog was enabled (i.e. was not 
explicitly disabled if enabled by default) in those last two cases?

> Find a way to make git-init-db know the difference magically and 
> you'll probably see a patch emerge quickly afterwards.  But right now 
> I don't think anyone really has a great solution to the problem.

I'd say screw that.  The solution should really be this patch:

diff --git a/environment.c b/environment.c
index 84d870c..98275b2 100644
--- a/environment.c
+++ b/environment.c
@@ -15,7 +15,7 @@ int use_legacy_headers = 1;
 int trust_executable_bit = 1;
 int assume_unchanged;
 int prefer_symlink_refs;
-int log_all_ref_updates;
+int log_all_ref_updates = 1;
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";

> I know Junio wrote something on this not too long ago (and it was a
> good writeup too) but I can never find threads in gmane's archives,
> so I'm just going to leave that to someone else...

Well I must have missed it.

But unless there is real harm to have reflog enabled even when you don't 
need it I really think the default should be set to enabled.


