From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git reflog expire honour core.sharedRepository.
Date: Mon, 16 Jun 2008 17:15:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0806161713520.3302@eeepc-johanness>
References: <1213565862-23247-1-git-send-email-madcoder@debian.org> <7vhcbuco2w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	gitster@pobox.com, joerg@debian.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 17:15:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8GQ6-00020r-Sd
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 17:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbYFPPOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 11:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbYFPPOD
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 11:14:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:38011 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752505AbYFPPOB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 11:14:01 -0400
Received: (qmail invoked by alias); 16 Jun 2008 15:13:58 -0000
Received: from unknown (EHLO eeepc-johanness.viawireless.co.uk) [212.183.134.211]
  by mail.gmx.net (mp066) with SMTP; 16 Jun 2008 17:13:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oyUkpDZXoZYr6FozUVKN7kgdNb+s1+Z+iV2oVEE
	TO9mrKatSSq7un
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vhcbuco2w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85192>

Hi,

On Sun, 15 Jun 2008, Junio C Hamano wrote:

> Pierre Habouzit <madcoder@debian.org> writes:
> 
> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >  builtin-reflog.c       |    1 +
> >  t/t1301-shared-repo.sh |   15 +++++++++++++++
> >  2 files changed, 16 insertions(+), 0 deletions(-)
> >
> >  Some people like to have logAllRefUpdates even for bare repositories, and if
> >  shared, git-gc breaks them.
> >
> > diff --git a/builtin-reflog.c b/builtin-reflog.c
> > index 897d1dc..430929f 100644
> > --- a/builtin-reflog.c
> > +++ b/builtin-reflog.c
> > @@ -308,6 +308,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
> >  		} else if (cmd->updateref && commit_ref(lock)) {
> >  			status |= error("Couldn't set %s", lock->ref_name);
> >  		}
> > +		adjust_shared_perm(log_file);
> 
> Why is it sane to do this unconditionally, instead of putting in another
> else or something?

Because adjust_shared_perm() checks for shared_repository, and returns 
when there is nothing to do.

IMO this is a sane convention, since you _never_ want to do this 
unconditionally anyway, and you avoid a lot of identical "if () adjust()" 
constructs.

Ciao,
Dscho
