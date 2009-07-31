From: Brian Ristuccia <brian@ristuccia.com>
Subject: Re: git clone ignores GIT_ALTERNATE_OBJECT_DIRECTORIES
Date: Fri, 31 Jul 2009 08:55:39 -0400
Message-ID: <20090731125539.GX12813@osiris.978.org>
References: <20090730175833.GV12813@osiris.978.org> <7vab2maqeo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 14:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWreM-00045b-1g
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 14:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbZGaMzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 08:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbZGaMzk
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 08:55:40 -0400
Received: from osiris.978.org ([72.70.36.11]:36032 "HELO osiris.978.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751097AbZGaMzj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 08:55:39 -0400
Received: (qmail 8297 invoked by uid 1000); 31 Jul 2009 08:55:39 -0400
Received: by osiris.978.org (hashcash-sendmail, from uid 1000);
	Fri, 31 Jul 2009 08:55:39 -0400
Content-Disposition: inline
In-Reply-To: <7vab2maqeo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.3.28i
X-Hashcash: 1:21:090731:gitster@pobox.com::1hyI1aGUjJvhhm/c:00000000000000000000
	000000000000000000000000189C
X-Hashcash: 1:21:090731:git@vger.kernel.org::qF7vqeZOXIG9k91d:000000000000000000
	00000000000000000000000016Cp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124557>

On Thu, Jul 30, 2009 at 01:04:31PM -0700, Junio C Hamano wrote:
> Brian Ristuccia <brian@ristuccia.com> writes:
> 
> > Is this behavior intentional for some good reason I've overlooked, or have I
> > stumbled on a bug?
> 
> Most likely not a bug.
> 
> When you talk about "clone", you need to realize that there actually are
> two repositories (and two object databases) involved: cloned source and
> destination.
> 
> Which repository should GIT_ALTERNATE_OBJECT_DIRECTORIES affect?
> 

Whichever one git is currently working in. (Even if git picks the "wrong"
repository, object f1d2d2f924e986ac86fdf7b36c94bcdf32beec15 is still
f1d2d2f924e986ac86fdf7b36c94bcdf32beec15 regardless of which repo it appears
in and the end result will be consistent). 

My understanding after reading gitrepository-layout(5), git-fsck(1),  is
that the effect of listing a directory in GIT_ALTERNATE_OBJECT_DIRECTORIES
should be roughly the same as listing it in the .git/objects/info/alternates
of whatever repository git happens to be working on.
   
> If you are making a clone from a remote over the network, and if you
> already have another local repository of a related project that has
> necessary objects, you may want to look at
> 
>     "git clone --reference"
> 

Yes, this does the right thing as I mentioned in my previous message.
(Behind the scenes, it's setting up .git/objects/info/alternates). My
question is why doesn't GIT_ALTERNATE_OBJECT_DIRECTORIES behave the same as
.git/objects/info/alternatives in all cases?

-- 
Brian Ristuccia
brian@ristuccia.com
