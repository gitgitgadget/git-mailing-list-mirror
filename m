From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
 family
Date: Mon, 5 Oct 2009 11:21:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910051120430.4985@pacific.mpi-cbg.de>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 11:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MujpT-0007U7-GG
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 11:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbZJEJUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 05:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbZJEJUV
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 05:20:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:58268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932304AbZJEJUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 05:20:20 -0400
Received: (qmail invoked by alias); 05 Oct 2009 09:19:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 05 Oct 2009 11:19:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19o9J9DCPBoEB2stywx/3Vq7vau94N8YDRu6U8F1+
	iMMXTOnxROf8yw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0910051027010.4985@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129543>

Hi,

On Mon, 5 Oct 2009, Johannes Schindelin wrote:

> On Sun, 4 Oct 2009, Junio C Hamano wrote:
> 
> >  - Checking "del" to decide if you want to say "reset" feels funny.
> 
> Right.  But I wanted to avoid checking for del, add and reset 
> separately.
> 
> So I was wrong, and will fix.

This is the current interdiff:

-- snipsnap --
diff --git a/submodule.c b/submodule.c
index 3f2590d..b441ea1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -92,15 +92,18 @@ void show_submodule_summary(FILE *f, const char *path,
 	if (!message) {
 		while ((commit = get_revision(&rev))) {
 			strbuf_setlen(&sb, 0);
-			if (del)
-				strbuf_addstr(&sb, commit->object.flags &
-						SYMMETRIC_LEFT ? del : add);
+			if (commit->object.flags & SYMMETRIC_LEFT) {
+				if (del)
+					strbuf_addstr(&sb, del);
+			}
+			else if (add)
+				strbuf_addstr(&sb, add);
 			format_commit_message(commit, format, &sb,
 					rev.date_mode);
-			if (del)
+			if (reset)
 				strbuf_addstr(&sb, reset);
 			strbuf_addch(&sb, '\n');
-			fwrite(sb.buf, sb.len, 1, f);
+			fprintf(f, "%s", sb.buf);
 		}
 		clear_commit_marks(left, ~0);
 		clear_commit_marks(right, ~0);
