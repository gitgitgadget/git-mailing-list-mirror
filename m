From: david@lang.hm
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 14:28:35 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic> <20090405070412.GB869@curie-int> <20090405190213.GA12929@vidovic>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:31:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZvo-0003R0-Cd
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672AbZDEV2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbZDEV2t
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:28:49 -0400
Received: from mail.lang.hm ([64.81.33.126]:53921 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbZDEV2s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:28:48 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n35LSZYq027304;
	Sun, 5 Apr 2009 14:28:35 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20090405190213.GA12929@vidovic>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115714>

On Sun, 5 Apr 2009, Nicolas Sebrecht wrote:

> On Sun, Apr 05, 2009 at 12:04:12AM -0700, Robin H. Johnson wrote:
>
>> Before I answer the rest of your post, I'd like to note that the matter
>> of which choice between single-repo, repo-per-package, repo-per-category
>> has been flogged to death within Gentoo.
>>
>> I did not come to the Git mailing list to rehash those choices. I came
>> here to find a solution to the performance problem.
>
> I understand. I know two ways to resolve this:
> - by resolving the performance problem itself,
> - by changing the workflow to something more accurate and more suitable
>  against the facts.
>
> My point is that going from a centralized to a decentralized SCM
> involves breacking strongly how developers and maintainers work. What
> you're currently suggesting is a way to work with Git in a centralized
> way. This sucks. To get the things right with Git I would avoid shared
> and global repositories. Gnome is doing it this way:
> http://gitorious.org/projects/gnome-svn-hooks/repos/mainline/trees/master

guys, back off a little on telling the gentoo people to change. the kernel 
developers don't split th kernel into 'core' 'drivers' etc pieces just 
because some people only work on one area. I see the gentoo desire to keep 
things in one repo as being something very similar.

the problem here is a real one, if you have a large repo, git send-pack 
will always generate a new pack, even if it doesn't need to (with the 
extreme case being the the repo is fully packed)

>>          The GSoC 2009 ideas contain a potential project for caching the
>> generated packs, which, while having value in itself, could be partially
>> avoided by sending suitable pre-built packs (if they exist) without any
>> repacking.
>
> Right. It could be an option to wait and see if the GSoC gives
> something.

the GSOC project is not the same thing. in this case the packs are already 
'cached' (they are stored on disk), what is needed is some option to let 
git send existing pack(s) if they exist rather then taking the time to 
try and generate an 'optimal' pack.

I'm actually aurprised that this is happening, I thought that the 
recommendation was that the public repository should do a very agressive 
pack (that takes a lot of resources) for the old content so that people 
cloning from it get the advantage of the tight packing without having to 
do it themselves.

if the server _always_ re-generates the pack from scratch then this is a 
waste of time (except for people who clone via the dumb, unsafe 
mechanisms)

David Lang
