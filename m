From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 11:01:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904211100350.10279@pacific.mpi-cbg.de>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>  <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302> <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk>  <20090421024433.GC14479@coredump.intra.peff.net>
 <7vskk2bt3x.fsf@gitster.siamese.dyndns.org> <fabb9a1e0904210148w4c6b869l396122baef1c0ee3@mail.gmail.com> <alpine.DEB.1.00.0904211055160.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 11:01:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwBrR-0004p4-V7
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbZDUJAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbZDUJAM
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:00:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:35976 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751520AbZDUJAL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 05:00:11 -0400
Received: (qmail invoked by alias); 21 Apr 2009 09:00:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 21 Apr 2009 11:00:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VmFRx1x/VSFtbx5nYKhcSYf2fNCDvtpTMdUDGcL
	JsxbKex5dXlSAg
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0904211055160.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117108>

Hi,

On Tue, 21 Apr 2009, Johannes Schindelin wrote:

> I actually agree with Junio, though, that we want this special handling 
> of empty files only in merge-recursive.

And this _might_ be enough (not even compile-tested due to lack of time; 
the OP did not provide the test as a proper patch):

---

 merge-recursive.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 774bacd..b7ea3cd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -343,7 +343,7 @@ static struct string_list *get_renames(struct merge_options *o,
 		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = diff_queued_diff.queue[i];
-		if (pair->status != 'R') {
+		if (pair->status != 'R' || !re->pair->one->size) {
 			diff_free_filepair(pair);
 			continue;
 		}
