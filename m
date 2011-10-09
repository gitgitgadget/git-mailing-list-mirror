From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Sun, 9 Oct 2011 22:57:28 +0000
Message-ID: <robbat2-20111009T225253-591026811Z@orbis-terrarum.net>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <robbat2-20111006T221637-481195848Z@orbis-terrarum.net>
 <4E8EBAFE.8020805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "	Robin H. Johnson" <robbat2@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 00:59:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD2Ku-0001yR-VS
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 00:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123Ab1JIW5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 18:57:30 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:49849 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851Ab1JIW53 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 18:57:29 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 59DCC1B401C
	for <git@vger.kernel.org>; Sun,  9 Oct 2011 22:57:29 +0000 (UTC)
Received: (qmail 13064 invoked by uid 10000); 9 Oct 2011 22:57:28 -0000
Content-Disposition: inline
In-Reply-To: <4E8EBAFE.8020805@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183215>

On Fri, Oct 07, 2011 at 10:40:30AM +0200,  Michael J Gruber wrote:
> [readding JCH to cc whom you dropped]
> Robin H. Johnson venit, vidit, dixit 07.10.2011 00:24:
> > On Wed, Oct 05, 2011 at 05:56:55PM -0700,  Junio C Hamano wrote:
> >> And this uses the gpg-interface.[ch] to allow signing the commit, i.e.
> >>
> >>     $ git commit --gpg-sign -m foo
> >>     You need a passphrase to unlock the secret key for
> >>     user: "Junio C Hamano <gitster@pobox.com>"
> >>     4096-bit RSA key, ID 96AFE6CB, created 2011-10-03 (main key ID 713660A7)
> >>
> >>     [master 8457d13] foo
> >>      1 files changed, 1 insertions(+), 0 deletions(-)
> > I like it, but I have a couple of questions: 
> > 1. Are the sig lines used in computed SHA1/commitid of a given commit (I
> >    see examples w/ --amend and that would usually change the SHA1)?
> Yes, just like with tag objects.
Ok, at the core, this is going to pose a problem with multiple
signatures.

Workflow example:
1. Dev1 creates a commit, signs it, pushes to central repo.
2. Dev2 pulls, signs the tip commit, pushes it back.

Since signing model here actually alters the commit, the push by Dev2
loses the history point of a commit with only a single signature, like
if somebody pushes a rewritten history (which should usually be
prohibited).

The push certificate variant of signing does permit this case without
breaking history.

> > I think this isn't a replacement for push certificates, but has value in
> > itself. It's certainly provides better integration than the
> > signature-in-note variants.
> > 
> 
> I do think it's meant as an implementation of push certificates. I don't
> see any other value in it which could not be achieved by signed tags.
> Can you describe any?
Identify of the committer for verification.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
