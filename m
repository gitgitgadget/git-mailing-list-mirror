From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rev-list --max-age, --max-count: support --boundary
Date: Tue, 20 Feb 2007 01:27:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702200126180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702190312120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xet67j3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:28:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIre-00074b-Bh
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965707AbXBTA1W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965714AbXBTA1V
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:27:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:59017 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965707AbXBTA1T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:27:19 -0500
Received: (qmail invoked by alias); 20 Feb 2007 00:27:18 -0000
X-Provags-ID: V01U2FsdGVkX19spwYn/Zdsw+e3e4i1vC3iZP+DOKJQdhdkYUsjzn
	E5jw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xet67j3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40175>

Hi,

On Mon, 19 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > @@ -1336,7 +1342,17 @@ struct commit *get_revision(struct rev_info *revs)
> >  	case -1:
> >  		break;
> >  	case 0:
> > -		return NULL;
> > +		if (revs->boundary) {
> > +			struct commit_list *list = revs->commits;
> > +			while (list) {
> > +				list->item->object.flags |=
> > +					BOUNDARY_SHOW | BOUNDARY;
> > +				list = list->next;
> > +			}
> > +			revs->max_count = -1;
> > +			revs->limited = 1;
> > +		} else
> > +			return NULL;
> 
> The resetting of max_count and limited probably needs some
> commenting.

Right. Could you --amend with this, if you find it sufficient?

---

 revision.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 87aea9c..be57191 100644
--- a/revision.c
+++ b/revision.c
@@ -1349,6 +1349,7 @@ struct commit *get_revision(struct rev_info *revs)
 					BOUNDARY_SHOW | BOUNDARY;
 				list = list->next;
 			}
+			/* all remaining commits are boundary commits */
 			revs->max_count = -1;
 			revs->limited = 1;
 		} else
