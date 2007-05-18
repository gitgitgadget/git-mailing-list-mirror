From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Fri, 18 May 2007 08:57:16 +0100
Message-ID: <200705180857.18182.andyparkins@gmail.com>
References: <200705170539.11402.andyparkins@gmail.com> <20070517215841.GB29259@mellanox.co.il> <200705180141.06862.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 09:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoxLJ-0004dn-4v
	for gcvg-git@gmane.org; Fri, 18 May 2007 09:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174AbXERH5c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 03:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755321AbXERH5c
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 03:57:32 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:5154 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbXERH5b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 03:57:31 -0400
Received: by mu-out-0910.google.com with SMTP id w1so537832mue
        for <git@vger.kernel.org>; Fri, 18 May 2007 00:57:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qSheMZnoshZKgQKd+ojJR6BVAhyuARcHT/dK8YSowNYfGIC04kv5QmYiNhXrcNZQ9P/qmDvP34Bsgkl8whX0kAb+yD/1e6eWf3TgAuoaRy9kAXMRGU3/fJpRhMVucNBm8QmzxlxRuwzK6ZEZABxHU3qiomlBHM1jFdSb3AdBV5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=crmdgLDiVMHTEty9hRXoF1WDE91RZZDJ0TbETJeWqYsGW3c+daQ0Apr9rQWmG1koy4pu92rWbSxcu1EruOza2mKz9S52rE/D2hQa5Jy4ARz15EFmu0gcBs7cRCZDJ2Jnsz3YdNM9hzImvW5Djy80g3UhYaFOogOGEm574A/IoF4=
Received: by 10.82.100.1 with SMTP id x1mr2210379bub.1179475048701;
        Fri, 18 May 2007 00:57:28 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b33sm2519437ika.2007.05.18.00.57.24;
        Fri, 18 May 2007 00:57:26 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <200705180141.06862.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47576>

On Friday 2007 May 18, Josef Weidendorfer wrote:

> However, I think the usage of "url"/"url hint" as the 1st level subproject
> identifier really is badly misleading and confusing for users; it would be
> better for this identifier to not look like a URL at all. But by naming it
> "url" in .gitmodules, the user is tempted to put an URL at this place.

Bear in mind that what you're suggesting is no different in implementation 
from what Junio is suggesting but with one difference: in Junio's option 
the "identifier" will act as a default URL if no override is found.

Yours:

.gitmodules:
  kernel mykernelsubprojectid
.git/config
  [subproject "mykernelsubprojectid"]
     url = git://host/blah/blah.git

Junio's:

.gitmodules:
  kernel git://oldhost/blah/blah.git
.git/config
  [subproject "git://oldhost/blah/blah.git"]
     url = git://host/blah/blah.git

There is no difference between these two in terms of implementation.  Both 
assign a key to the "kernel" submodule then use that key to look up an 
override.  The advantage of Junio's suggestion is that when an override is 
not needed the key itself is used and therefore it Just Works (tm) with no 
change to the .git/config necessary.

> And why not use the .gitattributes for the ".gitmodules" needs?

I can't think of a reason why not; I think that's a separate question though.

> Again, we could have a default URL in the absence of this config entry
> which is relative to the URL of the superproject, and which allows for the
> superproject repository to act as proxy.

This is why Junio's option of URL=Key is better.  You are relying on the 
default being correct in order for a simple clone to work.  The relative path 
scheme you propose as a default, while logical, doesn't match anything that 
anyone does right now.  Look at any server that hosts multiple projects; they 
are stored flat not deep:

 project1/
 project2/
 project3/

One advantage of submodule support is that multiple supermodules can contain 
the same submodule, so you really can't force a hierarchical representation 
on the world just to make the default URL correct.

 project2/
  project1/
 project3/
  project1/

Oops.

> As relative path I would propose $SUPERURL/subproject/$SUBPROJECTNAME, ie.
> if the superproject is at git://git.kernel.org/pub/super.git, the above
> subproject would default to the URL
> git://git.kernel.org/pub/super.git/subproject/linux24 which could be a
> symlink on the server.

I'm really uncomfortable with the idea of relying on directory structure 
passed the root repository path; from the
 git://git.kernel.org/pub/super.git/
point onwards; we don't have any right to expect that this is a real directory 
tree.  As an example; svn URLs don't match up with what's on disk:

 svn://svnhost/pub/repo/trunk/src
                       ^^^^^^^^^^

On disk there is no such directory as /trunk/src under the repository 
directory.  In the same way, even technically what you suggest would work, 
the part of the URL under git://git.kernel.org/pub/super.git/ is git's own 
namespace - it's not the users to mess with.  E.g. if I had a subproject 
called "refs" you'd be in trouble.

> To support different subproject repositories linked in at the
> same path of a superproject, Nicolas noted that we would have to replace
> the subproject repository at top/kernel/.git (taking my example above)
> whenever we cross the subproject change boundary in a checkout (e.g. from
> linux24 to linux26). The natural thing here would be to have
> subproject repositories at a seperate place, like inside of the
> superproject repository such as at ".git/subproject/linux24", which works
> well with my default interpretation of relative subproject paths above. At
> checkout, the correct repository would be bound by a symlink:

Your objection to the url=key scheme was lack of simplicity - to me the above 
is significantly more complex and is relying far too much on the submodule 
being on the same server as the supermodule.  Big mistake.  A typical use of 
submodules would be to integrate someone else's project, not your own, nor 
indeed your own checkout of that project.  Why should I have to keep my own 
copies of, say, kernel2.4 and kernel2.6 when there are perfectly acceptable 
URLs to the real repositories?

> > 2. Suppose .gitmodules in upstream tree points at subproject repo at
> > kernel.org, and I clone from there - my repo will point at kernel.org by
> > default? But now, I'd like everyone who clones from *my* repo to get
> > pointed at *my* server by default (e.g. for mirroring),
> > but would not changing .gitmodules create a commit so my
> > head will now differ from upstream  - so it won't be signed properly
> > etc... Did I misunderstand something?
>
> No, that is correct. Supporting a relative URL specification as proposed
> above should solve this issue.

I think that's the wrong solution.  A change of source URL for a submodule 
from what upstream uses to your own server is a _fork_ from upstream, 
therefore you would fork your own branch in your supermodule and 
alter .gitmodules to point at your server.  Everybody is happy, and the fork 
is recorded.

The override system is only there for the local repository (which always takes 
precedence) not for the server provider to hide detail from those checking 
the repo out.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
