From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] git-stash: add new 'drop' subcommand
Date: Sat, 5 Jan 2008 05:46:49 +0000 (UTC)
Message-ID: <loom.20080105T053356-853@post.gmane.org>
References: <1199495198-26270-1-git-send-email-casey@nrlssc.navy.mil> <477EDDD4.5060509@nrlssc.navy.mil> <7vtzltf3gg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 06:50:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB1vb-0006iK-BT
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 06:50:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbYAEFuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 00:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbYAEFuH
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 00:50:07 -0500
Received: from main.gmane.org ([80.91.229.2]:50407 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbYAEFuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 00:50:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JB1v0-0002Qm-My
	for git@vger.kernel.org; Sat, 05 Jan 2008 05:50:03 +0000
Received: from adsl-070-145-056-067.sip.bix.bellsouth.net ([70.145.56.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 05:50:02 +0000
Received: from drafnel by adsl-070-145-056-067.sip.bix.bellsouth.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 05:50:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 70.145.56.67 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920 Firefox/1.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69640>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Brandon Casey <casey <at> nrlssc.navy.mil> writes:
> 
> > I'm not sure if there is a proper way to get 'stash@{0}' from
> > 'refs/stash' so I kept my usage of that former string outside
> > of the drop_stash() function.
> 
> Doesn't "$refs_stash@{0}" (which would give refs/stash@{0} not
> stash@{0}) work for you?

yep that works. much nicer.

> > diff --git a/git-stash.sh b/git-stash.sh
> > -USAGE='[  | save | list | show | apply | clear | create ]'
> > +USAGE='[  | save | list | show | apply | clear | create | drop ]'
> 
> Might want to put drop next to clear, but that is minor.

no problem.


> > +	git reflog delete "$@" && echo "Dropped $@ ($s)" ||
> 
> The second $@ is inconsistent with the next line's use of $*; intentional?

not intentional.

> > +		set -- "stash@{0}"
> > +	fi
> > +	drop_stash "$@" &&
> > +	(git rev-parse --verify "stash@{0}" > /dev/null 2>&1 || clear_stash)
> 
> Curious.
> 
>  (1) Why not do the clearing inside drop_stash?

only because I didn't like stash@{0} notation and didn't want it
buried inside a function.

> 
>  (2) Why is clearning necessary in the first place (iow,
>      shouldn't "reflog delete" take care of that)?

clear_stash additionally deletes refs/stash and logs/refs/stash at least.

-brandon
