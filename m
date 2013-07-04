From: "Paul A. Kennedy" <pakenned@pobox.com>
Subject: Re: unexpected file deletion after using git rebase --abort
Date: Thu, 4 Jul 2013 15:35:51 -0400
Message-ID: <20130704193550.GA4183@localhost.localdomain>
References: <20130703224402.GF9016@localhost.localdomain>
 <20130703225642.GU408@google.com>
 <7vip0rckjs.fsf@alter.siamese.dyndns.org>
Reply-To: "Paul A. Kennedy" <pakenned@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Paul A. Kennedy" <pakenned@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 21:36:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UupKJ-0000bU-PL
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 21:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677Ab3GDTgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 15:36:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751Ab3GDTgA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 15:36:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 104682E5B3;
	Thu,  4 Jul 2013 19:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:reply-to:references:mime-version
	:content-type:in-reply-to; s=sasl; bh=E8EZokoVgZMICF7G3yRErMdsUn
	A=; b=l3dz2mzNRRlx3tXKL7GYFqqOSD/IyW1V8x6wC9iE1YinIpq23swGArcvKK
	qyoUZd3beFbwnIO+JUTgR/fG6dZwoSAYTz0yfwIvsO15ixIPA23OGlPPZ44Dypx8
	2Yz1Ow8pfkiBfwgdQKIQc90+oBrR/UBjZIzx2AEpQHqGEoQ3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:reply-to:references:mime-version
	:content-type:in-reply-to; q=dns; s=sasl; b=sYiuA2N9F2gWVvlUaJog
	qzp7KXIO3XwLPc/Wu3q22HKaoG9l5WjNhd0mQ+U9oIG9ofjueqXs+QoP8KHIh4b1
	A7ZrksRVHEw6k9DPhHn4J7UpIR7lzTjNmkJKjeOGgYAcBA3ZGgPA9lgubcYFfyzT
	l8bf6j1bTB/eacsyF6laq8E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5AD42E5B2;
	Thu,  4 Jul 2013 19:35:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.56.44.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 261BD2E5AE;
	Thu,  4 Jul 2013 19:35:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vip0rckjs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: F2DF71EE-E4E0-11E2-8633-E84251E3A03C-07946896!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229609>

On Wed, Jul 03, 2013 at 04:04:23PM -0700, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> > Paul A. Kennedy wrote:
> > > If we don't expect this, should we update the documentation for the
> > > --abort heading in the git rebase man page to indicate that newly
> > > staged content will be lost after a git rebase --abort?
> >
> > How about something along these lines?
> >
> > diff --git i/Documentation/git-rebase.txt w/Documentation/git-rebase.txt
> > index 6b2e1c8..dcae40d 100644
> > --- i/Documentation/git-rebase.txt
> > +++ w/Documentation/git-rebase.txt
> > @@ -240,6 +240,9 @@ leave out at most one of A and B, in which case it defaults to HEAD.
> >  	started, then HEAD will be reset to <branch>. Otherwise HEAD
> >  	will be reset to where it was when the rebase operation was
> >  	started.
> > ++
> > +This discards any changes to files tracked in the working tree or <branch>.
> > +You may want to stash your changes first (see linkgit:git-stash[1]).
> >  
> 
> "rebase --abort" is typically used to get rid of conflicted mess the
> user does not want to resolve right now, and "stash" would not be a
> sensible thing to use in such a situation, I think.  Doesn't it even
> refuse to work if there is a conflicted entry in the index?

Thanks for thinking about this with me.  

After contemplating your messages, I think that it's unreasonable to
expect git rebase --abort to be able to properly handle content from
completely outside the repo and only placed in the index.

I think that Jonathan's suggestion makes too mild a point (and I
think Junio's objection may be a consequence of this).  I've added a
little paragraph to the documentation that covers two cases: what you
should do before you started (i.e. git-stash if messing about with
adding content); and how to recover in case you managed to "lose"
content in this way (hence the links to git-fsck and git-cat-file).

This is the diff (against v.1.8.3.2 in the git tree):

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index aca8405..ffaef29 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -238,6 +238,13 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	will be reset to where it was when the rebase operation was
 	started.
 
+	Untracked files added to the index will not be unstaged, and
+	therefore, not present in the working directory upon abort.
+	Unstage files before the abort, or stash untracked content before
+	starting the rebase (see linkgit:git-stash[1]).  Dangling blobs
+	may be found and recovered using fsck and cat-file (see
+	linkgit:git-fsck[1], linkgit:git-cat-file[1]).
+
 --keep-empty::
 	Keep the commits that do not change anything from its
 	parents in the result.

--
Paul A. Kennedy
pakenned@pobox.com
