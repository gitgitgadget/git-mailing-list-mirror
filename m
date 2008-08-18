From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [TopGit PATCH] tg-create.sh: Introduce --add option to add a
 dependency.
Date: Mon, 18 Aug 2008 11:18:23 +0200
Organization: lilypond-design.org
Message-ID: <1219051103.8816.29.camel@heerbeest>
References: <1218637514.7561.30.camel@heerbeest>
	 <Pine.GSO.4.62.0808131100280.1278@harper.uchicago.edu>
	 <1218787834.7585.13.camel@heerbeest>
	 <Pine.GSO.4.62.0808150913180.9955@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Jan Holesovsky <kendy@suse.cz>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Mon Aug 18 13:11:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV2dn-0006Vs-AU
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 13:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYHRLKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 07:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbYHRLKL
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 07:10:11 -0400
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:38356 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYHRLKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 07:10:08 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id CA85D677F0;
	Mon, 18 Aug 2008 13:10:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 32115DC070;
	Mon, 18 Aug 2008 13:10:06 +0200 (CEST)
In-Reply-To: <Pine.GSO.4.62.0808150913180.9955@harper.uchicago.edu>
X-Mailer: Evolution 2.23.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92700>

On vr, 2008-08-15 at 10:25 -0500, Jonathan Nieder wrote:

Hi,

> 1) How should the tree of B' be determined?
> 2) What should the parents of B' be?
> 3) How should the tree of P' be determined from P, B, and B'?
> 4) What should the parents of P' be?

> So all this trouble is there when we try to come up with the topic 
> base
> for a new topic, as long as it is possible /in some way/ to weaken
> dependencies.

Which I have just been avoiding...  Thanks, that clarifies things for
me.

> or, if we make B a parent of B',
> 
> 	$ git checkout P
> 	$ git merge B'
> 
> which might be preferrable.

> I tried this out, and it seems here I was worrying needlessly.

Ok, good to know.

> > Ouch, I'm feeling so git-unitiated here; what is read-tree doing 
> > differently from merge?  Isn't here a -m missing?
> 
> Why?  We want to just blindly take the tree from P' and using it.  The
> point is to make setting the contents of the new branch tip and its
> parentage separate decisions.

Hmm, for one, "git read-tree -u SHA" does not work for me.

> > Removing or [re-]adding one dependency using this rebase-by-merging 
> > approch would take ~7 minutes on my machine.
> 
> Can you be more precise here?  What user action causes topgit to do
> so much work (adding one dependency to what topic)?  What other
> approach avoids all this work?

Good question, I was thinking a bit careless here.  Creating the master
topgit branch, which depends on ~300 single-topic topgit branches, like
so

    tg create t/master $(git branch | grep -vE '/|patched|pristine')

takes ~7 minutes; which does not really surprise me.

I realise now that if we make a strict *adding* of dependencies a
special case, we can just checkout our old B, and add (merge) the
additional dependencies on top of that.

However, when *removing* a dependency, I see no easy way to do that cheaply.

Greetings,
Janneke

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
