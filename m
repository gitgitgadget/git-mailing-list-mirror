From: Johan Herland <johan@herland.net>
Subject: Re: A generalization of git notes from blobs to trees - git metadata?
Date: Sun, 07 Feb 2010 02:36:12 +0100
Message-ID: <201002070236.12711.johan@herland.net>
References: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 02:46:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdwEk-00010Z-HF
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 02:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230Ab0BGBgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 20:36:17 -0500
Received: from smtp.getmail.no ([84.208.15.66]:47599 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932141Ab0BGBgR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 20:36:17 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXG00FET74ENFC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 07 Feb 2010 02:36:14 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXG007F974D4C20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 07 Feb 2010 02:36:14 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.7.12426
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139207>

On Saturday 06 February 2010, Jon Seymour wrote:
> git notes is a nice innovation - well done to all those involved.

Thanks.

> Has consideration ever been given to generalizing the concept to allow
> note (or more correctly -  metadata) trees with arbitrary sha1s?

Not sure what you mean here. The note infrastructure allows _any_ SHA1 (not 
necessarily the SHA1 of an existing Git object) to be bound to a note 
object.

Furthermore, although we currently assume that all note objects are blobs, 
someone (who?) has already suggested (as mentioned in the notes TODO list) 
that a note object could also be a _tree_ object that can be unpacked/read 
to reveal further "sub-notes". Hence, in addition to having multiple notes 
refs (e.g. refs/notes/commits:deadbeef, refs/notes/bugs:deadbeef, etc.) to 
categorize notes, you could also classify notes _after_ having traversed the 
notes tree (e.g. refs/notes/bugs:deadbeef/fixes, 
refs/notes/bugs:deadbeef/causes). Note that support for this has not yet 
been written, and AFAIK it is also uncertain how such a change would affect 
the different use cases for notes (e.g. how to display them in 'git log')

> For example, suppose you had reason to cache the distribution that
> resulted from the build of a particular commit, then it'd be nice to
> be able to do this using a notes like mechanism.
> 
>     git metadata import foo-1.1.0 dist ~/foo/dist
> 
> would create a git tree from the contents of ~/foo/dist and then bind
> it to meta item called dist associated with the sha1 corresponding to
> foo-1.1.0

You can do this already today by simply using 'git tag':
	# Prepare an index with the contents of ~/foo/dist
	git tag foo-1.1.0-dist $(git write-tree)

I don't see why you'd need to add a new metadata command.

> To retrieve the contents of the previous build, you'd do something like
> 
>    get metadata export foo-1.1.0 dist /tmp/foo-1.1.0
> 
> This would find the metadata tree associated with foo-1.1.0, extract
> the dist subtree from that tree and write it to disk at /tmp/foo-1.1.0

Or, if you use a tag instead:
	git --work-tree=/tmp/foo-1.1.0 checkout foo-1.1.0-dist

> I've used build outputs as an example here, but really it needn't be
> limited to that. I can see this facility would be useful for any kind
> of annotation or derived result that is more complex than a single
> text blob. Metadata trees in combination with a name spacing
> technique, could be used to store arbitrary metadata created by an
> arbitrary set of tools to arbitrary SHA1 objects.

I still don't see why this provides anything that isn't already supported by 
either using 'git tag', or by implementing support for notes-as-trees in the 
notes feature.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
