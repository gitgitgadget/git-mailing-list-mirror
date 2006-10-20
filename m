From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 11:51:12 +0200
Message-ID: <200610201151.13199.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<87ods727pn.wl%cworth@cworth.org>
	<a7e835d40610191953i467ce853k4b4740bbfdd92936@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Fri Oct 20 11:51:56 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gar2K-0006ES-4h
	for gcvbg-bazaar-ng@m.gmane.org; Fri, 20 Oct 2006 11:51:32 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gar28-0004DR-5E; Fri, 20 Oct 2006 10:51:20 +0100
Received: from ug-out-1314.google.com ([66.249.92.172])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1Gar20-0004Cz-RD
	for bazaar-ng@lists.canonical.com; Fri, 20 Oct 2006 10:51:14 +0100
Received: by ug-out-1314.google.com with SMTP id 36so637230ugg
	for <bazaar-ng@lists.canonical.com>;
	Fri, 20 Oct 2006 02:51:12 -0700 (PDT)
Received: by 10.66.220.17 with SMTP id s17mr1600273ugg;
	Fri, 20 Oct 2006 02:51:12 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
	by mx.google.com with ESMTP id p32sm885254ugc.2006.10.20.02.51.10;
	Fri, 20 Oct 2006 02:51:11 -0700 (PDT)
To: "James Henstridge" <james@jamesh.id.au>
User-Agent: KMail/1.9.3
In-Reply-To: <a7e835d40610191953i467ce853k4b4740bbfdd92936@mail.gmail.com>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29433>

James Henstridge wrote:
> On 20/10/06, Carl Worth <cworth@cworth.org> wrote:
>> On Thu, 19 Oct 2006 19:01:58 -0400, Aaron Bentley wrote:

>>>             Additionally, the new mainline can keep a mirror of the
>>> abandoned mainline in its repository, because there are virtually no
>>> additional storage requirements to doing so.
>>
>> And this part I don't understand. I can understand the mainline
>> storing the revisions, but I don't understand how it could make them
>> accessible by the published revision numbers of the "abandoned"
>> line. And that's the problem.
> 
> With this sort of setup, I would publish my branches in a directory
> tree like this:
> 
>     /repo
>         /branch1
>         /branch2
> 
> I make "/repo" a Bazaar repository so that it stores the revision data
> for all branches contained in the directory (the tree contents,
> revision meta data, etc).

And here we have a feature which is as far as I see unique to git,
namely to have persistent branches with _separate namespace_. It means
that we can have hierarchical branch names (including names like
"remotes/<remotename>/<branch of remote>", or "jc/diff"), and we don't
have to guess where repository name ends and branch name begins.

The idea of "branches (and tags) as directories" was if I understand
it correctly introduced by Subversion, and from what can be seen from
troubles with git-svn (stemming from the fact that division between
project name and branch name is the matter of _convention_) at least
slightly brain-damaged.
 
> The "/repo/branch1" essentially just contains a list of mainline
> revision IDs that identify the branch.  This could probably be just
> store the head revision ID, but there are some optimisations that make
> use of the linear history here.
> 
> If the ancestry of "/repo/branch2" is a subset of branch1 (as it might
> be if the in the case of forked then merged projects), then all its
> revision data will already be in the repository when branch1 was
> imported.  The only cost of keeping the branch around (and publishing
> it) is the list of revision IDs in its mainline history.
> 
> For similar reasons, the cost of publishing 20 related Bazaar branches
> on my web server is generally not 20 times the cost of publishing a
> single branch.
> 
> I understand that you get similar benefits by a GIT repository with
> multiple head revisions.

You can get similar benefits by a GIT repository with shared object
database using alternates mechanism. And that is usually preferred
over storing unrelated branches, i.e. branches pointing to disconnected
DAG (separate trees in BK terminology) of revision, if that you mean by
multiple head revisions (because in GIT there is no notion of "mainline"
branch, only of current (HEAD) branch).


>>>> But for these communications, revision numbers will not provide
>>>> historically stable values that can be used.
>>>
>>> They certainly can.
>>>
>>> The coder says "I've put up a branch at http://example.com/bzr/feature.
>>>  In revision 5, I started work on feature A.  I finished work in
>>> revision 6.  But then I had to fix a related bug in revision 7."
>>
>> "I've put this branch up" isn't historically stable...
> 
> With the repository structure mentioned above, the cost of publishing
> multiple branches is quite low.  If I continue to work on the project,
> then there is no particular bandwidth or disk space reasons for me to
> cut off access to my old branches.
> 
> For similar reasons, it doesn't cost me much to mirror other people's
> related branches if I really care about them.

But the revision number in this case _changes_. It is from 7 to
branch:7 but still it changes somewhat.

[...]
>> The naming in git really is beautiful and beautifully simple.
> 
> I don't think anyone is saying that universally unique names are bad.
> But I also don't see a problem with using shorter names that only have
> meaning in a local scope.
> 
> I've noticed some people using abbreviated SHA1 sums with GIT.  Isn't
> that also a case of trading potential global uniqueness for
> convenience when working in a local scope?

Emphasisis on _potential_. SHA1 id abbreviated to 6 characters might
be not unique in larger project, but for example the chance that
SHA1 id abbreviated to 7 or 8 characters is not unique is really low.


Yet another analogy:

SHA1 identifiers of commits (and not only commits) can be compared
to Message-Ids of Usenet messages, while revision numbers can be compared
to Xref number of Usenet message which if I understand correctly is unique
only for given news server. But Message-Ids cannot be shortened
meaningfully like SHA1 ids can; newertheless they are used in communication
without any problems. Even if namespace is not simple ;-)
