From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Upstream merging and conflicts (was Re: Using cvs2git to track an external CVS project)
Date: Fri, 3 Jun 2005 08:59:57 +1200
Message-ID: <46a038f9050602135971ece082@mail.gmail.com>
References: <46a038f905060105358e24723@mail.gmail.com>
	 <1117631266.26067.40.camel@imp.csi.cam.ac.uk>
	 <46a038f905060213104d9ad96f@mail.gmail.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jun 02 23:01:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdwmU-00076W-Ea
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 22:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVFBVBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 17:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFBVBM
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 17:01:12 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:29889 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261368AbVFBVAC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 17:00:02 -0400
Received: by rproxy.gmail.com with SMTP id i8so384912rne
        for <git@vger.kernel.org>; Thu, 02 Jun 2005 13:59:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UiFTdwd6sZy4k6FmqB4hWc9RCll/Hgw+X5H42Ve4sxursNAKnuzccqm5r7Nj0rOYfZJE+3HSXLpMloRGpvvvAISB0X5+y2ByZ25bH1JpmeYtGdU16Ty4NYH+iR44y2ZZKOBW281l37/zIBh4Z4aQ24hYw+YtRrNIc3ToyaAE+Oc=
Received: by 10.38.88.1 with SMTP id l1mr547961rnb;
        Thu, 02 Jun 2005 13:59:57 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Thu, 2 Jun 2005 13:59:57 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <46a038f905060213104d9ad96f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(reposted with appropriate subject)

On 6/2/05, Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> Disregarding anything about cvs2git there is one point you may not be
> thinking about but you may want to care about:  when you send something
> upstream to the cvs repository and then get it back via cvs2git you will
> get a completely different commit to the one your local git repository
> has.

If upstream hasn't touched the files I'm patching, and cvs2gig/cvs2ps
use -kk there is some hope that the objects should be the same...
right?

>  So while the file changes inside those two commits are the same
> the actual commits are not and you will end up with all those commits in
> duplicate because of it as well as an automatic merge commit to merge
> the two commits.

So, this is the scenario for a situation where the files I'm patching
have changed upstream, so upstream merges my patch on top of previous
patches, and I get commit objects echoed back that logically contain
my patch but git sees as different.

Is it any better if upstream is using git as well? Is there any chance
for a private branch or tree to survive anything but a "perfect match"
merge where upstream and the branch are in perfect sync before and
after?

I understand this is architected to _not_ support cherry picking in
the darcs/arch sense and I think it's a good idea. But it seems than
any non-trivial merge ends up being a completely manual process.
Anyone having to work on a series of patches for Linux that get
accepted in stages is going to find himself forced to a potentially
time-consuming remerge every time Linus does a partial merge. Argh.

So it seems to me that git is well suited for a set of closely related
HEADs that are very aggressive in synching with each other. Synching
work is pushed out to the peripheral branches -- a design decision I
agree with -- but there's very little support to help me keep a
peripheral branch in sync.

The assumption that those peripheral branches must be short-lived and
discardable is valid for a limited set of cases -- very circumscribed
to short-term dev work. As soon as a dev branch has to run a little
longer, it cannot afford to not sync with the HEAD. Particularly, it
cannot skip a _single_ patch coming from HEAD.

And if I'm doing development from my branch and pushing to HEAD, and
the guy doing the merge in HEAD merges my patches in a different order
I'll have a spurious conflict.

I use peripheral branches to track versions of code in production,
that may have different sets of patches applied. For that purpose,
patch-based SCMs are quite helpful (you can ask what patch is applied
where), but as Linus pointed out, they don't actually help convergence
at all. Git pulls towards convergence like a demon AFAICS -- yet some
primitive patch trading smarts would save a lot of effort at the
borders of the dev network.

cheers,


martin
