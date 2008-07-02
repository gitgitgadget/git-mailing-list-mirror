From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: RFC: grafts generalised
Date: Wed, 02 Jul 2008 18:43:22 +0200
Message-ID: <g4gb7a$ket$1@ger.gmane.org>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 18:44:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE5Rb-0005Sw-6o
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 18:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYGBQni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 12:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbYGBQni
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 12:43:38 -0400
Received: from main.gmane.org ([80.91.229.2]:56266 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbYGBQnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 12:43:37 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KE5QZ-0003fQ-Fb
	for git@vger.kernel.org; Wed, 02 Jul 2008 16:43:31 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 16:43:31 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 02 Jul 2008 16:43:31 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <m3lk0kfdo1.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87159>

Jakub Narebski venit, vidit, dixit 02.07.2008 18:35:
> "Stephen R. van den Berg" <srb@cuci.nl> writes:
> 
>> I'm in the process of converting and stitching and patching vast amounts
>> of initially disjunct CVS and SVN repositories into larger complete
>> histories inside a single git repository.  Recreating history as
>> accurately as possible.
>>
>> The problem I encounter is that any number of times I have to "edit"
>> history in a non-parameterable fashion, in any of the following ways:
>> - Change parents.
>> - Add merges.
>> - Change author, committer, commitdate, authordate.
>> - Change the tree (because of conversion errors in the automated
>>   conversion process) belonging to a single commit.
>> - Retrofit a patch which has to ripple through all of history until
>>   the present.
>>
>> The only things which are easily done at the moment are:
>> Change parents and add merges.  This can be accomplished fairly easily
>> using the grafts file.
>> The other changes are messy at best and need to be parameterised into the
>> form of a shell script so that git filter-branch can have a go at it.
> [...]
> 
>> I propose the following:
>> - Extend git fsck to do more sanity checks on the content of the grafts
>>   file (to make it more difficult to shoot yourself in the foot with
>>   that file; my feet will be grateful).
>> - Extend the grafts file format to support something like the following syntax:
>>
>> commit eb03813cdb999f25628784bb4f07b3f4c8bfe3f6
>> Parent: 7bc72e647d54c2f713160b22e2e08c39d86c7c28
>> Merge: 3b3da24960a82a479b9ad64affab50226df02abe 13b8f53e8ccec3b08eeb6515e6a10a2a
>> Merge: ac719ed37270558f21d89676fce97eab4469b0f1
>> Tree: 32fc99814b97322174dbe97ec320cf32314959e2
>> Author: Foo Bar (FooBar) <foo@bar>
>> AuthorDate: Sat Jun 6 13:50:44 1998 +0000
>> Commit: Foo Bar (FooBar) <foo@bar>
>> CommitDate: Sat Jun 7 13:50:44 1998 +0000
>> Logmessage: First line of logmessage override
>> Logmessage: Second line of logmessage override
>> Logmessage: Etc.
> [...]
> 
> First, if I remember correctly (from KernelTrap and now defunct Kernel
> Traffic and one issue of Git Traffic) the 'graft' mechanizm was
> created so it would be possible to "graft" (join) historical
> conversion repository with the "current work" git repository (started
> from zero when git was deemed good enough for Linux kernel
> development).  The same mechanism is used for shallow clone, where one
> goes in the opposite direction, shortening history instead of joining
> two repositories (two histories).
> 
> The fact that git-filter-branch (and earlier cg-admin-rewrite-hist)
> respects grafts, and rewrites history so that grafts are no-op and are
> not needed further is a bit of side-effect.  So I think that it would
> be better to provide generic git-filter-branch filter which can
> understand this "generalized grafts" file format, or rather
> 'description of changes' file.  Put it in contrib/, and here you
> go...
> 

Maybe the upcoming git-sequencer could be the appropriate place? It 
tries to achieve just that: edit history by specifying a list of 
commands. The currently planned set of commands would need to be 
amended, but the framework should be in place.

Michael
