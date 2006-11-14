X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] support fetching into a shallow repository
Date: Tue, 14 Nov 2006 11:43:31 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611141140530.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0610302008520.26682@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac2u1oee.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 14 Nov 2006 10:43:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vac2u1oee.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31341>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjvlQ-0005v7-VB for gcvg-git@gmane.org; Tue, 14 Nov
 2006 11:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933395AbWKNKne (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 05:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933397AbWKNKne
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 05:43:34 -0500
Received: from mail.gmx.de ([213.165.64.20]:3741 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S933395AbWKNKnd (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 05:43:33 -0500
Received: (qmail invoked by alias); 14 Nov 2006 10:43:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 14 Nov 2006 11:43:31 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 13 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/shallow.c b/shallow.c
> > new file mode 100644
> > index 0000000..3cf2127
> > --- /dev/null
> > +++ b/shallow.c
> >...
> > +struct commit_list *get_shallow_commits(struct object_array *heads, int depth)
> > +{
> > +	int i = 0, cur_depth = 0;
> > +	struct commit_list *result = NULL;
> > +	struct object_array stack = {0, 0, NULL};
> > +	struct commit *commit = NULL;
> > +
> > +	while (commit || i < heads->nr || stack.nr) {
> > +		struct commit_list *p;
> > +		if (!commit) {
> >...
> > +		}
> > +		parse_commit(commit);
> > +		cur_depth++;
> > +		for (p = commit->parents, commit = NULL; p; p = p->next) {
> > +			if (!p->item->util) {
> >...
> > +			} else {
> >...
> > +			}
> > +			if (cur_depth < depth) {
> > +				if (p->next)
> > +					add_object_array(&p->item->object,
> > +							NULL, &stack);
> > +				else {
> > +					commit = p->item;
> > +					cur_depth = *(int *)commit->util;
> > +				}
> > +			} else
> > +				commit_list_insert(p->item, &result);
> > +		}
> > +	}
> > +
> > +	return result;
> > +}
> 
> I think the "commit = p->item" part is trying to do a tail
> recursion optimization, but this is a bit too clever to my
> liking (at first I mistook that the code forgot to re-point p at
> its parents list and incrementing cur_depth).

I take it as a compliment ;-)

Seriously again, would you like me to add a comment, or rather do away 
with the tail recursion optimization? It is not a huge optimization 
anyway. Maybe a cleverer way would be to use an object_array instead of a 
commit_list?

Ciao,
Dscho
