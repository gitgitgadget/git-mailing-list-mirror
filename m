From: John Keeping <john@keeping.me.uk>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Tue, 18 Feb 2014 20:01:46 +0000
Message-ID: <20140218200146.GC1048@serenity.lan>
References: <20140214113136.GA17817@raven.inka.de>
 <87a9dt981o.fsf@igel.home>
 <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
 <xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
 <20140215085355.GA15461@lanh>
 <xmqqha7wfdld.fsf@gitster.dls.corp.google.com>
 <20140218193520.GB1048@serenity.lan>
 <xmqqtxbwdwt2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 21:02:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFqrj-0004gs-DP
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 21:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbaBRUB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 15:01:58 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:42178 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbaBRUB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 15:01:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5BA7E86604F;
	Tue, 18 Feb 2014 20:01:57 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JpML28dfkgqG; Tue, 18 Feb 2014 20:01:57 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id EA031866046;
	Tue, 18 Feb 2014 20:01:56 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id DCB54161E42C;
	Tue, 18 Feb 2014 20:01:56 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yut9g2VxP0Q6; Tue, 18 Feb 2014 20:01:56 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 3F4A8161E4CB;
	Tue, 18 Feb 2014 20:01:48 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqtxbwdwt2.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242348>

On Tue, Feb 18, 2014 at 11:51:05AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > There's already the arbitrary set of prefixes in
> > refs.c::prettify_refname() and refs.c::ref_rev_parse_rules().  I can see
> > how a user might think that since "git log refs/heads/name" is
> > equivalent to "git log master" then "git branch refs/heads/name" should
> > be equivalent to "git branch name".
> 
> Not quite, I am afraid.  Branch names used for "git branch <name>"
> and "git checkout <name>" are like the Lvalue of an assignment, as
> opposed to extended SHA-1 expressions to express any commit
> (e.g. 'master^0', 'refs/heads/master', or 'master') that correspond
> to the Rvalues used in an expression.  Because "git checkout" can
> take a branch name or an arbitrary commit object name, there needs a
> way for the users to disambiguate.
> 
> Saying that "git checkout refs/heads/name" must be equivalent to
> "git checkout name" is like arguing that assignment "value+0 = x"
> should be valid because "value+0" is a valid value.

That isn't my argument.  I agree that the "create" and "view" operations
are distinct.  The problem appears to be that not all users expect this
and it caused them confusion because they are able to create refs like
refs/heads/refs/heads/master.

I don't think we should apply the mapping, but I also do not think that
using a set of known (but arbitrary) constraints to prevent the creation
of potentially confusing branch names is a particularly big leap from
applying a similar set of rules in prettify_ref() and dwim_ref().
Especially if there's an escape hatch via '--force' or 'git update-ref'
for those who know what they're doing.
