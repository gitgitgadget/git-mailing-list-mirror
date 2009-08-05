From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/5] Revamping "git status"
Date: Wed, 5 Aug 2009 22:14:12 +0200
Message-ID: <200908052214.13512.trast@student.ethz.ch>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com> <200908052052.28067.trast@student.ethz.ch> <7v3a862fnj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:14:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYmsd-000620-Jc
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbZHEUO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbZHEUO1
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:14:27 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:52106 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbZHEUO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:14:27 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 22:14:26 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 22:14:25 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <7v3a862fnj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124962>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > So it detects there are worktree changes, but then decides not to show
> > them because it's an unmerged entry.  I think the following should go
> > in 3/5, but note that I haven't looked at the rest of the code to
> > check if it breaks anything:
> 
> Thanks.  Shouldn't it go in 4/5 instead, though?

Er, yeah. *sigh*

> > -- 8< --
> > diff --git i/wt-status.c w/wt-status.c
> > index 6370fe2..5a68297 100644
> > --- i/wt-status.c
> > +++ w/wt-status.c
> > @@ -400,7 +400,8 @@ static int wt_status_check_worktree_changes(struct wt_status *s)
> >  	for (i = 0; i < s->change.nr; i++) {
> >  		struct wt_status_change_data *d;
> >  		d = s->change.items[i].util;
> > -		if (!d->worktree_status)
> > +		if (!d->worktree_status
> > +		    || d->index_status == DIFF_STATUS_UNMERGED)
> >  			continue;
> >  		changes = 1;
> >  		if (d->worktree_status == DIFF_STATUS_DELETED)
> > -- >8 --
> 
> Not "d->worktree_status"?  That would be more consistent with what
> wt_status_print_changed() actually ends up checking.

Hmm, true.  I just picked index_status because unmerged state is an
index property.  It's probably better if the two functions agree on
the criterion.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
