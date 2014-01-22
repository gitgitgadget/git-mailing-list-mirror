From: Robert Hancock <hancock@sedsystems.ca>
Subject: Re: Problem importing from SVN repository with branches/tags at multiple
 levels using git-svn
Date: Wed, 22 Jan 2014 13:03:29 -0600
Organization: SED Systems
Message-ID: <52E01601.8090705@sedsystems.ca>
References: <52D6EB42.2060509@sedsystems.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 22 20:03:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W635C-0001Ik-Rw
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jan 2014 20:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707AbaAVTDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jan 2014 14:03:16 -0500
Received: from sed198n136.SEDSystems.ca ([198.169.180.136]:9206 "EHLO
	sed198n136.sedsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755686AbaAVTDK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jan 2014 14:03:10 -0500
Received: from barney.sedsystems.ca (barney [198.169.180.121])
	by sed198n136.sedsystems.ca  with ESMTP id s0MJ39xC021729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 22 Jan 2014 13:03:09 -0600 (CST)
Received: from eng1n65.eng.sedsystems.ca (eng1n65.eng.sedsystems.ca [172.21.1.65])
	by barney.sedsystems.ca (8.13.1/8.13.1) with ESMTP id s0MJ38nR001063
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 22 Jan 2014 13:03:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52D6EB42.2060509@sedsystems.ca>
X-Enigmail-Version: 1.6
X-Scanned-By: MIMEDefang 2.64 on 198.169.180.136
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240843>

On 01/15/2014 02:10 PM, Robert Hancock wrote:
> We have an SVN repository that has a structure for tags (likewise for
> branches) like this:
> 
> tags/tag1
> tags/tag2
> tags/tag3/
> tags/subdir/tag4
> tags/subdir/tag5
> 
> The idea is that I want to have git-svn import everything inside subdir
> as tags and everything else inside the root tags directory as tags, so I
> end up with tag1-tag5 in Git. I've got tags= entries like this in the
> Git configuration to try to achieve this:
> 
> tags = tags/subdir/*:refs/remotes/tags/*
> tags = tags/*:refs/remotes/tags/*
> 
> My expectation was that everything inside subdir would match the first
> line first and everything else would match the second line, so
> everything would work out OK. Unfortunately it seems like for the tags
> inside subdir, it's matching the second line and therefore trying to
> import everything in there as directories inside one tag called subdir.
> Changing the order of those lines doesn't seem to help either, it seems
> determined to try to match to tags/* regardless of what order the lines
> are in.
> 
> Clearly it would have been better if the repository had not been
> structured this way. However, rearranging it now won't help since the
> paths are like this in the SVN repository history.
> 
> The only solution I've found that kind of works is to use
> tags/{tag1,tag2,tag3} instead of tags/*. Unfortunately there are a ton
> of tags in that directory and adding in a giant list of tags there seems
> to slow down the import process a great deal. Also, there are
> potentially still tags being created in that root directory, so I would
> have to keep regenerating and updating this list in the Git
> configuration every time one was added. So this is not a good solution.
> It would be much easier if I could get a wildcard solution to work here.
> 
> Any thoughts?

Just to respond to my own question, it appears that the ignore-refs
configuration option allows one to deal with this situation. In this
case one would add something like:

ignore-refs = refs/remotes/tags/subdir$

to prevent git-svn from trying to create a Git ref called subdir.

Unfortunately there seems to be no documentation at all about this
option other than in the source commit which introduced it, unlike all
the other settings for git-svn - that seems like a bit of an oversight..

-- 
Robert Hancock
System Analyst
SED Systems
Email: hancock@sedsystems.ca
