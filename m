From: Markus Armbruster <armbru@redhat.com>
Subject: Re: Cover grafting in the Git User's Manual
Date: Thu, 29 Nov 2007 14:20:32 +0100
Message-ID: <87bq9drxwf.fsf@pike.pond.sub.org>
References: <87ejeateka.fsf@pike.pond.sub.org>
	<20071128184228.GB4461@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 29 14:21:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxjKB-0000LA-Qo
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 14:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbXK2NUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 08:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbXK2NUj
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 08:20:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755230AbXK2NUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 08:20:38 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lATDKZP2014028;
	Thu, 29 Nov 2007 08:20:35 -0500
Received: from pike.pond.sub.org (vpn-4-9.str.redhat.com [10.32.4.9])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lATDKY65031155;
	Thu, 29 Nov 2007 08:20:34 -0500
Received: by pike.pond.sub.org (Postfix, from userid 1000)
	id 08C1490066; Thu, 29 Nov 2007 14:20:33 +0100 (CET)
In-Reply-To: <20071128184228.GB4461@xp.machine.xx> (Peter Baumann's message of "Wed\, 28 Nov 2007 19\:42\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66532>

Peter Baumann <waste.manager@gmx.de> writes:

> On Wed, Nov 28, 2007 at 07:23:01PM +0100, Markus Armbruster wrote:
>> The only mention of grafting in the manual is in the glossary:
>> 
>>     Grafts enables two otherwise different lines of development to
>>     be joined together by recording fake ancestry information for
>>     commits. This way you can make git pretend the set of parents
>>     a commit has is different from what was recorded when the
>>     commit was created. Configured via the .git/info/grafts file.
>> 
>> I believe it would be useful to cover this better, perhaps in chapter
>> 5. Rewriting history and maintaining patch series.  It certainly would
>> have saved me a few hours of digging.  I already understood enough of
>> git to *know* that what I wanted must be possible (supply missing
>> parents of merges in a repository imported with parsecvs), but I
>> didn't know the magic keyword was graft.  I managed to figure it out
>> >from the glossary, git-filter-branch(1) and GitWiki's GraftPoint page.
>> 
>> I'm neither writer nor git expert, but here's my try anyway:
>> 
>> Rewriting ancestry with grafts
>> 
>> Grafts enables two otherwise different lines of development to be
>> joined together by recording fake ancestry information for commits.
>> This way you can make git pretend the set of parents a commit has is
>> different from what was recorded when the commit was created.
>> 
>> Why would you want to do that?  Say, you imported a repository from an
>> SCM that doesn't record merges properly, e.g. CVS.  Grafts let you add
>> the missing parents to the merge commits.  Or you switched your
>> project to git by populating a new repository with current sources,
>> and later decide you want more history.  Committing old versions is
>> easy enough, but you also need to graft a parent to your original root
>> commit.
>> 
>> Graft points are configured via the .git/info/grafts file.  It has one
>> record per line describing a commit and its fake parents by listing
>> object names separated by a space and terminated by a newline.
>> 
>>     <commit sha1> <parent sha1> [<parent sha1>]*
>> 
>> A graft point does not actually change its commit.  Nothing can.  What
>> can be done is rewriting the commit and its descendants.
>> git-filter-branch does that:
>> 
>>     $ cat .git/info/grafts
>>     db5a561750ae87615719ae409d1f50c9dfc3fa71 08f2fa81d104b937c1f24c68f56e9d5039356764 8c231303bb995cbfdfd1c434a59a7c96ea2f0251
>>     git-filter-branch HEAD ^08f2fa81d104b937c1f24c68f56e9d5039356764 ^8c231303bb995cbfdfd1c434a59a7c96ea2f0251
>> 
>> This rewrites history between head and the graft-point to include the
>> grafted parents.
>
> Did I overlook something or isn't
>
>      git-filter-branch HEAD ^db5a561750ae87615719ae409d1f50c9dfc3fa71
>
> what you are looking for? Only db5a56 could get rewritten and obviously
> all the commits having it as a parent.
>
> -Peter

That rewrites all commits reachable from HEAD that are not reachable
from db5a56.  In particular, it doesn't rewrite db5a56, does it?
