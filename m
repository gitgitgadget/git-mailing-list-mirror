From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: push.default???
Date: Wed, 24 Jun 2009 23:59:23 +0200
Message-ID: <20090624215922.GA13575@pvv.org>
References: <h1nks1$vdl$1@ger.gmane.org> <20090623103428.GA4214@pvv.org> <4A40D19E.60606@gmail.com> <20090623131131.GA7011@pvv.org> <4A40D864.8040208@gmail.com> <20090623144805.GB24974@pvv.org> <f865508f0906230932n4a2f2b54s1e76ab1d70d95073@mail.gmail.com> <7vprcu96td.fsf@alter.siamese.dyndns.org> <4A41E8B8.8050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 23:59:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJaVG-00008s-Or
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 23:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbZFXV7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbZFXV7Z
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 17:59:25 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:49872 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbZFXV7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 17:59:25 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1MJaV1-0003VD-5O; Wed, 24 Jun 2009 23:59:23 +0200
Content-Disposition: inline
In-Reply-To: <4A41E8B8.8050803@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122162>

On Wed, Jun 24, 2009 at 10:50:00AM +0200, Paolo Bonzini wrote:
>
> Here is what I think you are missing: in the proposed workflow, there is  
> an entire group working on one big feature, so there is effectively one  
> remote per feature.

I think you are making this more complicated than it is. I just claim
that the idea that "branch names must be identical in both ends" is
not necessarily the best model.

In a sufficiently large origanisation with multiple levels of
repositories (access restrictions, locality, whatever) branch names
are not globally unique, and there is no reasonable way to check if a
branch name is used elsewhere. It is much easier to treat local branch
names as strictly local, and worry about naming (only) when you push
somewhere.

So - even if someone decided to name something "issue-331318" on a
public repository, it doesn't mean you want to call it that locally,
even if you want to push to it.

If a branch already exists on a public repo, it doesn't mean a branch
with the same name but with different contents/purpose cannot exist in
a different repo. So you may have to name the branch something else
locally. Pull knows how to deal with this, but push did not (before
"--tracking").

Another example:

You have worked for a few days on an issue, but need help from someone
else with something. You have set up a public shared repo named
"public", and do:

git push public HEAD:fred-helpme

Fred wants to name it something else that makes him remember what this
branch is about, and does:

git fetch public
git checkout -b tmp-help-john public/fred-helpme
<hack hack>
git commit
git push   (no more arguments, and no need to remember what it was named)

You then fetch and look at what Fred has done, and maybe you just use
it, or maybe you don't. Afterwards git push public :fred-helpme to get
rid of the temporary shared branch.

- Finn Arne
