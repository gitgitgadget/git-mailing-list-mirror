From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Tue, 29 Jan 2008 10:58:57 +1300
Message-ID: <479E5021.7010404@vilain.net>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 22:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJbzh-0003HD-QU
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 22:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbYA1V5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 16:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbYA1V5t
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 16:57:49 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:42748 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbYA1V5s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 16:57:48 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 65534)
	id BB47821D18D; Tue, 29 Jan 2008 10:57:46 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.1.7-deb
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 65E5A21D17F;
	Tue, 29 Jan 2008 10:57:42 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080128081258.GE24004@spearce.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71903>

Shawn O. Pearce wrote:
> To be perfectly honest, in a wide open source community I think
> the truely distributed nature of development like the linux kernel
> or git itself uses works very well.  Development schedules aren't
> organized into "next 30 minutes", "next 4 hours", and "next week".
> 
> Peer review and community acceptance of changes is a very important
> concept.  Blindly accepting changes into a tree because of a PGP
> signature/SSL certificate/SSH key isn't really the norm, and is
> far from the best solution.  We've all posted cr**p^Wless-than-
> the-best-code to this list before, and yet many of us would have
> "committer access" to the git tree under a centralized model.
>
> I'm happy my changes aren't accepted just because I signed them.
> Its better that Linus/Nico/Dscho/Junio/you/et.al. have looked at
> them and also felt they were worthwhile.

I agree wholeheartedly - hence my comment about "mob" branches.  What I
was implying is that you could model it conceptually off repo.or.cz.

That is, when you start a project, you "own" a namespace.  Everyone else
has to pick a fork name, and the first push they make to
"forks/forkname/*" registers that fork name to that key.

This could support fully distributed access control over the namespaces.
  What it means for access control to be distributed is that any node
can check the log of tags that granted permission to people, and
assuming that they processed the same grants in the same order they will
arrive at the same access control result.

To describe this with an example, say Linus decides that Junio can push
to any ref on the project, he can note in a tag;

  "From this release forward, Junio Hamano <KEYID> will be authorized to
   push to any reference, and grant access to others under the reference
   space 'refs/heads/topics/'".

Or, preferably something more automatically parsable.  Anyway, the
presence of a signed document is a hint for the audit program to try to
reach Junio's key from Linus' key (like this would:
http://pgp.cs.uu.nl/mk_path.cgi?FROM=76E21CBB&TO=F3119B9A&PATHS=trust+paths)
if it can, and then add the signing key to the ACL's PGP keyring.

The ACL state could be a branch in a funny refspace with a directory for
the keyring, and a place to keep copies of any tags it removed because
they were there just for the push.

And yes, it would need a simple interface.

> But in a smaller business type setting, where there's under 100
> employees working, odds are you've already created the user account
> on systems, and physically passed the initial password via a sticky
> note after checking the person's government issued IDs.  In such a
> setting having yet another authentication system (PGP keys) is just
> yet more work for the already over worked/under appreciated IT staff.

Agreed - again I'd personally consider allowing receive-pack with
reflogs in those environments if setting up PGP or SSH keys was a hassle.

Sam.
