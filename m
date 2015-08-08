From: perryh@pluto.rain.com (Perry Hutchison)
Subject: Re: resolving a (possibly remote) branch HEAD to a hash
Date: Sat, 08 Aug 2015 00:05:14 -0700
Message-ID: <55c5aa2a.sK/tpvXyORYGVq0d%perryh@pluto.rain.com>
References: <55c47766.dDi8LaxdDqOeptUd%perryh@pluto.rain.com>
 <xmqq8u9nyptx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 08 09:21:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNyS4-0002Gz-Kl
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 09:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbbHHHVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2015 03:21:37 -0400
Received: from agora.rdrop.com ([199.26.172.34]:4102 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbbHHHVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2015 03:21:36 -0400
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id t787Lfh3074615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 8 Aug 2015 00:21:41 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id t787Lff3074614;
	Sat, 8 Aug 2015 00:21:41 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA12020; Sat, 8 Aug 15 00:05:30 PDT
In-Reply-To: <xmqq8u9nyptx.fsf@gitster.dls.corp.google.com>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275510>

Junio C Hamano <gitster@pobox.com> wrote:

> perryh@pluto.rain.com (Perry Hutchison) writes:
>
> >   $ git rev-parse r5.0.1
> >   r5.0.1
> >   fatal: ambiguous argument 'r5.0.1': unknown revision or path not in the working tree.
> >   Use '--' to separate paths from revisions
>
> This is not because of ambiguity among refs.  The message is telling
> you:
>
>     r5.0.1 is not interpretable as a revision, and it is not likely
>     to be interpretable as a path.  If you meant to use it as a
>     revision, put '--' after it, if you meant to use it as a path,
>     put '--' before it.
> ...
> Now, admittably, if you say "git rev-parse r5.0.1 --" in this
> situation, it is not likely that the corrected command line will
> succeed.

Yes, I tried that also.  It didn't work.

> ... we do not say "append 'refs/remotes/<anything>/' for various
> values of <anything> and see if such a ref exists" when resolving
> an abbreviated refname 'master'.

checkout appears to.

If I enter "git checkout foo"
   and the local branch refs/heads/foo exists
checkout will:
1. recognize that foo refers to a local branch
2. check out that local branch (refs/heads/foo).

OTOH, if I enter "git checkout foo"
   and there is no foo in refs/heads or refs/tags
   and refs/remotes/origin/foo _does_ exist
checkout will:
1. recognize that foo refers to a remote branch
2. set up a local branch (refs/heads/foo) that tracks
   the remote branch (refs/remotes/origin/foo)
3. check out the (now) local branch (refs/heads/foo).

However I don't think the command I want is spelled "checkout"
because, in either case, I want just step 1 -- with the result
being returned as the HEAD commit id of the selected branch.
I don't want the whole checkout experience, just the identification
of the commit that is the HEAD of the specified branch, which may
be either local (in refs/heads) or remote (in refs/heads/origin).

It is certainly possible that the command I am looking for is
not spelled "rev-parse" either -- and it does not matter whether
it is considered plumbing or porcelain.  It just needs to produce
the correct result, for either the local or the remote case.

(In the situation at hand I happen to know that the name will
always refer to a branch, not a tag, so a solution that looks
only in refs/heads and refs/remotes -- and not in refs/tags --
would be fine.  A solution that, like checkout, also looks in
refs/tags would also be OK.)
