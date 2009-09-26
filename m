From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] make 'git clone' ask the remote only for objects it
	cares about
Date: Sat, 26 Sep 2009 12:50:39 -0700
Message-ID: <20090926195039.GG14660@spearce.org>
References: <alpine.LFD.2.00.0908082246020.440@xanadu.home> <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com> <vpqvdj6izt6.fsf@bauges.imag.fr> <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com> <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com> <alpine.LFD.2.00.0909252045290.4997@xanadu.home> <alpine.LFD.2.00.0909252314260.4997@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jason Merrill <jason@redhat.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Hin-Tak Leung <hintak.leung@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 26 21:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrdIC-0003Ub-Rb
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 21:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbZIZTug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 15:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbZIZTuf
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 15:50:35 -0400
Received: from george.spearce.org ([209.20.77.23]:40394 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbZIZTuf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 15:50:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2107E38151; Sat, 26 Sep 2009 19:50:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0909252314260.4997@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129170>

Nicolas Pitre <nico@fluxnic.net> wrote:
> Current behavior of 'git clone' when not using --mirror is to fetch 
> everything from the peer, and then filter out unwanted refs just before 
> writing them out to the cloned repository.  This may become highly 
> inefficient if the peer has an unusual ref namespace, or if it simply 
> has "remotes" refs of its own, and those locally unwanted refs are 
> connecting to a large set of objects which becomes unreferenced as soon 
> as they are fetched.
...
> +static void write_remote_refs(const struct ref *local_refs, const char *reflog)

Here reflog is now unused.  I'm going to squash this in.

diff --git a/builtin-clone.c b/builtin-clone.c
index edf7c7f..4992c25 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -342,7 +342,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 	return local_refs;
 }
 
-static void write_remote_refs(const struct ref *local_refs, const char *reflog)
+static void write_remote_refs(const struct ref *local_refs)
 {
 	const struct ref *r;
 
@@ -534,7 +534,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (refs) {
 		clear_extra_refs();
 
-		write_remote_refs(mapped_refs, reflog_msg.buf);
+		write_remote_refs(mapped_refs);
 
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =

-- 
Shawn.
