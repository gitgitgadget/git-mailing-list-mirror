From: Timothy Shimmin <tes@sgi.com>
Subject: Re: git pull a subtree, embedded trees
Date: Mon, 18 Sep 2006 15:50:17 +1000
Message-ID: <450E3399.5070601@sgi.com>
References: <4508020F.2050604@sgi.com> <ee945j$h3u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 07:49:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPC0n-00071k-PC
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 07:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965418AbWIRFtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 01:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965419AbWIRFtm
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 01:49:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59045 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965418AbWIRFtm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 01:49:42 -0400
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with SMTP id k8I8PDtH019914;
	Mon, 18 Sep 2006 01:25:14 -0700
Received: from [134.14.55.141] (boing.melbourne.sgi.com [134.14.55.141]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA04755; Mon, 18 Sep 2006 15:49:34 +1000
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ee945j$h3u$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27227>

Hi Jakub,

Jakub Narebski wrote:
> Tim Shimmin wrote:
> 
>> I'm new to git and have a couple of novice questions.
>>
>> * Is it possible to only pull in a subtree from
>> a repository.
> 
> I assume that by pull you mean checkout...
> 
> I think it is possible (try git-read-tree with --prefix option, 
> and select subtree by giving either it's sha1, or e.g.
> HEAD:<path> form), but not easy to do. Git revisions are 
> snapshots of the whole project (the revisions are states of
> the whole project).
> 
I'm not sure if that was what I was wanting.

I'm just starting to understand git better (I think:).
It seems like it is about having object snapshots.
We have snapshots of files (blobs) and snapshots of a directory,
tree objects which reference other trees and blob snapshots,
and then we link the snapshots in time using commit objects.
So every time we do a "git-update-index file" we create a new blob
in the object directory and every time we do a "git-write-tree" we
create tree objects in the database (.git/object/xx/xxxx....).
So at these snapshot points, do we just keep adding more and more objects?
I'm used to rcs and sccs, where we just keep diffs for file history,
we don't do that here do we?; we keep the whole snapshot but in compressed
form. (And then we have a packed form too.)

So trying to understand your suggestion and the command:
Given a tree object in our object database, we can update our
index with the tree objects but they will be stored in the index
with entry names which have prepended to them the given "prefix/".
We can then use git-checkout-index to populate our workarea
with the prefix/ files and dirs.
So how do I get the foreign tree objects into the database;
just copy them in?
And this works with prefix/ dir not already existing in workarea.
Hmmmmm....


>> Moreover, is it possible to have a subtree based on another
>> repository.
> 
> It is possible. For example, make empty directory <subproject>
> somewhere, add this directory, or just all the files in it
> either to .gitignore or .git/info/excludes file, then clone
> the other project (subproject) to this place. You would have
> the following directory structure
> 
>   /
>   dir1
>   dir2
>   dir2/subdir
>   subproject
>   subproject/.git
>   subproject/subprojectsubdir
>   ...
> 
This could be handy.
Looks like by using .gitignore, I can check the file in.
(So the ingore/excludes are used by git scripts which call
git-ls-files --others.)


>> * Are there any tools for dumping out the contents of the
>> git objects in the .git/objects directory.
>> By dumping out, I mean an ascii representation of the data
>> fields for the commit and tree objects in particular.
>> I've written a simple small program to dump out the index
>> entries (cache entries).
> 
> git-cat-file -p
> 
Excellent, thanks. (looks like the option is undocumented - secret option:)
So I added this to a script which walks over the objects directory,
to work out what all the object ids are so I can apply git-cat-file
to all the objects on my test directory.
I guess this will fall down if the objects are stored in a pack :)
I'll have to look and see how to extract all the object ids using
some command.


What I have is an existing full tree with a subproject directory.
And then I have a separate tree just for the subproject.
The development happens in the subproject tree.
At certain points we want to update the existing full tree's subproject
directory with the work we have done in the subproject tree.
At these points I'd like to effectively copy over the new tree objects
and blobs to the full tree, but I guess I'd need new commits
(which are based on the new commits of the subproject tree which would
include their commit messages)
which refer to new higher level tree objects (which refer down
to my subproject tree objects).
This presupposes that no other outside changes happened to subproject
in the full tree - since I'm just copying over objects.
Probably should be merging, just in case.
Does this sound too confusing and awkward? :)

--Tim
