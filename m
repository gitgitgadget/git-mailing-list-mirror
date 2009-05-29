From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Fri, 29 May 2009 11:12:08 +0200
Message-ID: <20090529091208.GA12039@diana.vm.bytemark.co.uk>
References: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com> <20090528124817.GA22262@diana.vm.bytemark.co.uk> <b0943d9e0905280738n51476ab7vd0498ea7a236c4a7@mail.gmail.com> <b0943d9e0905280751k3b9f26c9gd907a7c11ca9d5e2@mail.gmail.com> <20090529072050.GA9760@diana.vm.bytemark.co.uk> <b0943d9e0905290140i57aeaa33r8de34302b63ffa5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 11:12:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9y8R-0006Bf-9m
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 11:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293AbZE2JMK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 May 2009 05:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754903AbZE2JMI
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 05:12:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:49193 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbZE2JMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 05:12:08 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1M9y8G-0003AN-00; Fri, 29 May 2009 10:12:08 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0905290140i57aeaa33r8de34302b63ffa5e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120263>

On 2009-05-29 09:40:59 +0100, Catalin Marinas wrote:

> 2009/5/29 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2009-05-28 15:51:20 +0100, Catalin Marinas wrote:
> >
> > > 2009/5/28 Catalin Marinas <catalin.marinas@gmail.com>:
> > >
> > > What about this change to the original patch (it's faster to
> > > just return the sha1 refs than building the Commit objects):
> >
> > Creating Commit objects is really cheap---just look at the
> > constructor. I made them that way on purpose, so that we'd never
> > have to think twice about using Commit objects instead of passing
> > sha1s around.
>
> I was worried it may invoke git to get the CommitData.

Only if you try to access it---it's evaluated lazily.

> > Also, you said "set", and I agree---the return value of
> > get_mege_bases() should be a set. That's what it _is_,
> > conceptually, and it makes little sense to obscure that fact.
>
> If we return a set of commits, I suspect the Repository object
> guarantees that having the same sha1 value always returns the same
> Commit object

Yes, exactly. As long as you get all your Commit objects from the
Repository object like you're supposed to, there'll be at most one
Commit object for each sha1. In fact, the Commit objects don't have an
__eq__ method on purpose---straight object comparison already does
exactly what we want!

> and the code below is valid:

Yes, this is precisely what I meant.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
