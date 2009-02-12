From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to use path limiting (using a glob)?
Date: Thu, 12 Feb 2009 11:09:36 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp80rg.rmg.sitaramc@sitaramc.homelinux.net>
References: <20090211191432.GC27232@m62s10.vlinux.de>
 <alpine.LFD.2.00.0902111129190.3590@localhost.localdomain>
 <20090212102719.GD27232@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 12:11:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXZTn-0005P6-E0
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 12:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758607AbZBLLJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 06:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbZBLLJs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 06:09:48 -0500
Received: from main.gmane.org ([80.91.229.2]:54372 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758604AbZBLLJr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 06:09:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LXZRz-000402-2z
	for git@vger.kernel.org; Thu, 12 Feb 2009 11:09:47 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 11:09:47 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 11:09:47 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109602>

On 2009-02-12, Peter Baumann <waste.manager@gmx.de> wrote:
> On Wed, Feb 11, 2009 at 11:40:44AM -0800, Linus Torvalds wrote:

>> On Wed, 11 Feb 2009, Peter Baumann wrote:
>> 
>> > after reading Junio's nice blog today where he
>> > explained how to use git grep efficiently, I saw him
>> > using a glob to match for the interesting files:
>> > 
>> > 	 $ git grep -e ';;' -- '*.c'
>> > 
>> > Is it possible to have the same feature in git diff and the revision
>> > machinery?
>> 
>> Not really. Git has two different kinds of path limiters, and they are 
>> really really different.
>> 
>>  - the "walk current index/directory recursively" kind that "git ls-files" 
>>    uses, which takes a 'fnmatch()' type path regexp (not a real regexp, 
>>    but the kind you're used to with shell)
>> 
>>    NOTE! On purpose, we don't set the FNM_PATHNAME, so "*.c" here is 
>>    different from *.c in shell (it's more like "**.c" in tcsh). IOW, * 
>>    matches '/' too, and will walk subdirectories.
>> 
>
> Hm. But if git does only anchor the * at the current directory, wouldn't
> this solve (or at least reduce) the performance problems you described in the
> later paragraph? Having the "**.c" do a recurisve search for every .c
> file would then be used to do a recusrive search. 

I think Linus meant that it's expensive to look for all *.c
files at any depth in the tree, for every commit in
repository.

You can have either a prefix matcher to limit the search
*within* a tree so you can afford to walk all revs in the
repo, or you stick to just one tree (or a few explicitly
named ones).

You seem to be saying 'fine, I know, and I'm willing to
indicate that I'm accepting this cost by using a different
syntax'.

But the syntax is not the point.  You can certainly do that
right now, if you really wish to.  Just don't try it on a
large repo :-)

    git grep -e pattern $(git rev-list --all) -- *.c

Make suitable modifications to the '--all' in the git
rev-list to limit the revs you want to search.

Regardless of whether there is a simple syntax to support it
or not, this is probably not what you want, most of the time
:-)

Sitaram
