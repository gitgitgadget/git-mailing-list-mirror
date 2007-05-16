From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT RFC] Changing patch@branch syntax
Date: Wed, 16 May 2007 08:54:38 +0200
Message-ID: <20070516065438.GA7453@diana.vm.bytemark.co.uk>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT list <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed May 16 08:57:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoDSN-0004tQ-D2
	for gcvg-git@gmane.org; Wed, 16 May 2007 08:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbXEPG5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 May 2007 02:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbXEPG5u
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 02:57:50 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3216 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbXEPG5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 02:57:49 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HoDPC-00021O-00; Wed, 16 May 2007 07:54:38 +0100
Content-Disposition: inline
In-Reply-To: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47422>

On 2007-05-16 00:03:10 +0200, Yann Dirson wrote:

> The patch@branch syntax is annoying, at least for bash-completion
> purposes: we don't want to provide all possible completions accross
> all branches, yet we'd like to get completion for foreign patches.

Yes, that's annoying.

> Another place where I feel it is bad is when using the full
> "patch@branch//top" syntax: the MSB is in the middle, and the LSB is
> on the right.

I agree. (Similarly, YYYYMMDD is the one true date format!)

> Both issues would be solved by switching to a MSB ordering, with a
> way to distinguish branchnames when given. Something similar to
> pathnames would fit well - eg. [/branchname/]patchname[//top].
> However, I'm not sure using slashes would be a good choice,
> precisely because of the similarity with real pathnames. But we
> don't have so many separator chars that are not special in one way
> or another, and would require quoting them to avoid more user
> confusion.

Branch names can contain slashes, and in the future patch names might
as well, so we'd need another separator. _Except_ for the fact that if
foo/bar is a branch, foo/bar/baz can't also be a branch, so using a
slash as separator is actually unambiguous.

If we similarly make it illegal for patches a/b and a/b/c to exist
simultaneously (whenever we get around to implementing slashy patch
names), we could use a single slash for patchname/{top,bottom} too.

The only remaining difficulty is to decide whether a/b/c is patch b/c
on branch a, or patch a/b/c on the current branch. We can't forbid
patch names and branch names to collide, since git can create new
branch names behind stgit's back. So I guess we'd need some way to
indicate whether branch name is included. The leading slash in your
suggestion seems as good a way as any.

However, I'm not going to recommend using only slashes. I believe life
will be much simpler if we simply use two different separators, like
this:

  branch:patch@top

Then all these subsets will be trivially parseable:

  branch:patch

  patch

  patch@top

And even this one, if we feel crazy some day:

  /path/to/other/repository#branch:patch@top

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
