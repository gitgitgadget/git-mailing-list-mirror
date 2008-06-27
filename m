From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] commit-tree: lift completely arbitrary limit of 16
 parents
Date: Fri, 27 Jun 2008 18:46:43 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271845450.9925@racer>
References: <alpine.LFD.1.10.0806262243130.2988@localhost.localdomain> <alpine.DEB.1.00.0806271259440.9925@racer> <alpine.DEB.1.00.0806271324010.9925@racer> <7v7icassr8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Len Brown <lenb@kernel.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:49:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCI4q-0003r1-Ap
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436AbYF0Rso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754345AbYF0Rso
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:48:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:55972 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752434AbYF0Rsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:48:43 -0400
Received: (qmail invoked by alias); 27 Jun 2008 17:48:41 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp041) with SMTP; 27 Jun 2008 19:48:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1953GMN7EZ5JNfThREoi/RPBHiVXoLeOnA2qtORfH
	tfSha6cMUjBtY2
X-X-Sender: gene099@racer
In-Reply-To: <7v7icassr8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86611>

Hi,

On Fri, 27 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > -static int new_parent(int idx)
> > +static void new_parent(struct commit *parent, struct commit_list **parents_p)
> >  {
> > -	int i;
> > -	unsigned char *sha1 = parent_sha1[idx];
> > -	for (i = 0; i < idx; i++) {
> > -		if (!hashcmp(parent_sha1[i], sha1)) {
> > +	unsigned char *sha1 = parent->object.sha1;
> > +	struct commit_list *parents;
> > +	for (parents = *parents_p; parents; parents = parents->next) {
> > +		if (!hashcmp(parents->item->object.sha1, sha1)) {
> 
> Wouldn't it be enough to compare (parents->item == parent)?

Probably, since we now use lookup_commit().  Feel free to change.

> > @@ -69,18 +63,16 @@ int cmd_commit_tree(int argc, const char **argv, 
> > const char *prefix)
> >  
> >  	check_valid(tree_sha1, OBJ_TREE);
> >  	for (i = 2; i < argc; i += 2) {
> > +		unsigned char sha1[40];
> 
> s/4/2/;

Yes, I admitted that already in response to Hannes.

Mea culpa, mea maxima culpa.

Sorry,
Dscho
