From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: restriction of pulls
Date: Fri, 09 Feb 2007 18:36:17 +0200
Message-ID: <45CCA301.4060504@dawes.za.net>
References: <200702091149.12462.duelli@melosgmbh.de> <Pine.LNX.4.63.0702091554160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45CC941E.9030808@dawes.za.net> <200702091619.23058.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christoph Duelli <duelli@melosgmbh.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 17:36:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFYjh-0003IY-F3
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 17:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946615AbXBIQga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 11:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946625AbXBIQga
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 11:36:30 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:54095 "EHLO
	spunkymail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1946615AbXBIQg3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Feb 2007 11:36:29 -0500
X-Greylist: delayed 3797 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Feb 2007 11:36:29 EST
Received: from [192.168.201.100] (dsl-146-24-208.telkomadsl.co.za [165.146.24.208])
	by spunkymail-a5.g.dreamhost.com (Postfix) with ESMTP id 44E7914D6AB;
	Fri,  9 Feb 2007 08:36:22 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <200702091619.23058.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39185>

Andy Parkins wrote:
> On Friday 2007 February 09 15:32, Rogan Dawes wrote:
> 
>> One obstacle to implementing partial checkouts is that one does not know
>> which objects have changed or been deleted. One way of addressing this
> 
> Why would you want to do a partial checkout.  I used subversion for a long 
> time before git, which does to partial checkouts and it's a nightmare.
> 
> Things like this
> 
>  cd dir1/
>  edit files
>  cd ../dir2
>  edit files
>  svn commit
>  * committed revision 100
> 
> KABLAM!  Disaster.  Revision 100 no longer compiles/runs.  The changes in dir1 
> and dir2 were complimentary changes (say like renaming a function and then 
> the places that call that function).

Please note that my suggestion does NOT imply allowing partial checkins 
(or if it does, it was not my intention)

What I am trying to support is Jon Smirl's description of how some 
Mozilla contributors work, specifically the documentation folks.

They do not have any need to look at the actual code, but simply limit 
themselves to the files in the doc/ directory.

Supporting a partial checkout of this doc/ directory would allow them to 
get a "check in"-able subdirectory, without having to download the rest 
of the source.

What I intended to convey was that when determining which files have 
changed, and presenting them to the user to decide whether to commit 
them or not, the filesystem-walker would first check the "negative 
index" to see if that directory/file had been explicitly excluded from 
the checkout. This implies that they did not (and do not intend to) 
modify that portion of the tree. Which implies that the committer can 
then construct a complete view of the entire tree (now including the 
changes that were made in the partial checkout) by resolving the 
modified files with the knowledge of the hashes of the unmodified 
files/trees.

> 
> In every way that matters you can do a partial checkout - I can pull any 
> version of any file out of the repository.  However, it should certainly not 
> be the case that git records that fact.

Why not? If you only want to modify that file, does it not make sense 
that you can just check out that file, modify it, and check it back in?

Or at least if not check it in, construct a diff for mailing to the 
maintainer?

Or even, allowing the maintainer to pull/merge the changes from the 
contributor, even though the contributor doesn't necessarily have all 
the blobs required to make up the tree he is committing? They should all 
be available from the "alternate" if required.

Rogan
