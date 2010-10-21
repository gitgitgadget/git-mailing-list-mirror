From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
Date: Thu, 21 Oct 2010 20:37:07 +0200
Message-ID: <201010212037.09618.jnareb@gmail.com>
References: <4424833.537061.1287669604786.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: Will Palmer <wmpalmer@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 20:37:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9011-0005Ml-4E
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 20:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253Ab0JUShU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 14:37:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46073 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335Ab0JUShS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 14:37:18 -0400
Received: by bwz18 with SMTP id 18so675731bwz.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tLCHpd6DgwVNpo69g9gPihFeBg3x4SQW6O7Kx9KvAcQ=;
        b=ewzE2efqL47wsPINfuy3xaA6WcFW0ZxqHsA7SLh3uIKnL5pqNnKZMmtdujR70k0w0W
         EnQYskbAchPGlNSz3R0/URr2F8bQZVcB69hbcYndXhA3jGxmyLTqd2q0A7o9Hkqt9GVz
         vdvWfZq4ezoADYVXGmKGPmRZoXrRhCy0lsnSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YE7bfwiu71g56eTryOsL4CR7a/2+GGTTKVjP58eR3GDEenHlUG+13Beho1SahOBK8v
         z9m18157LIyayNaTWJsMfB9APWBgOwpgljxbZ+jYYKta07IIQaqe5m78aNvvX5S5wsWi
         0Xh8FiQCwUIMK+272Ry92Ki80tjI4KTdzY/lM=
Received: by 10.204.113.196 with SMTP id b4mr884451bkq.176.1287686235976;
        Thu, 21 Oct 2010 11:37:15 -0700 (PDT)
Received: from [192.168.1.13] (abvl250.neoplus.adsl.tpnet.pl [83.8.209.250])
        by mx.google.com with ESMTPS id m8sm2054705faj.1.2010.10.21.11.37.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 11:37:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4424833.537061.1287669604786.JavaMail.root@mail.hq.genarts.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159532>

On Thu, 21 Oct 2010, Stephen Bash wrote:
> Will Palmer <wmpalmer@gmail.com> wrote:

> > Of course, "ignoring merges" is temporary and a total cop-out
> 
> This is still bugging me...  Even with svn mergeinfo (which I think
> is a small percentage of the SVN revisions in the world),

>From what I understand to have svn:mergeinfo you have to have version >= 
1.5 of Subversion installed on server, and to use it also >= 1.5 
client.

> IMO an SVN merge is *not* a Git merge.  I think of it as a git
> cherry-pick (someone correct me if this mental model is wrong).
> The key point in my mind is SVN merge doesn't have to merge the entire
> branch history.  Perhaps some heuristics can be applied in Git to
> decide if an SVN merge is a "true merge" or a cherry-pick?  But I have
> a nagging feeling that in the end the model mismatch is going to be
> very hard to overcome.        

Hopefully in most common situations (i.e. SVN repository is not 
mishandled) the svn:mergeinfo would be _only_ on branch folders
("branches/<branchname>") and inherited downwards.  This should be 
fairly easy, I think, to translate to git merges (merge commits).

But because Subversion doesn't impose strict separation between branch 
namespace and in-repository paths, somebody somewhere would certainly 
at some time screw this up.  And only then we would have to rely on 
subtree merge / git-subtree split similarity detection.


BTW. Subversion doesn't have "svn cherry-pick", nor equivalent to 
"git reset" == "git cherry-pick -R"... well, at least I don't think it 
has.

......................................................................
Warning! Rant ahead!
<rant skip="if needed">
I have read some documentation about svn:mergeinfo property:
  http://svnbook.red-bean.com/en/1.5/svn.branchmerge.basicmerging.html
  http://www.collab.net/community/subversion/articles/merge-info.html

I see how "branches are folders" model, without a concept of version
included in (belonging to) some branch and without the concept of 
'previous version in the same line of development' leads to such 
strange, bizzare things.

First, svn:mergeinfo is not about tracking which commits (which parents) 
were involved in creating given version, like in Git (where merge 
commit that was result of merging branch 'bar' into 'foo' has commits 
which were then tips of 'bar' and of 'foo' as two parents of commit 
representing result of merge).

No, svn:mergeinfo is ass-backwards solution to the problem that "merge 
tracking" solves, namely that of repeated merging.  Let's take a look 
at the following situation:

   ---1---B---2---3---M1--4---5---M2   <-- foo
           \         /           /
            \-a---b-/-----c---d-/      <-- bar

B is branching point, M1 and M2 are merge commits.

In Git, and I assume that also in Subversion, when doing merge M1, the 
VCS notices that from revision B branches 'foo' and 'bar' have common
commits (in git we say that merge base of 'foo' and 'bar' at the point
of doing merge M1 is commit B).  VCS it know then that it has to 
integrate changes that were made on branch 'bar' since cleft point B,
i.e. changes brought by revisions 'a' and 'b', with changes made on 
branch 'foo' since B, i.e. changes brought by revisions '2' and '3'.
Git does that by running 3-way merge (same as rcsmerge / diff3 merge)
with '3' as ours aka mine version, 'b' as theirs aka yours version,
and 'B' as ancestor aka older version; I assume that Subversion does
the same thing, or equivalent.

Now here is where things begin to be different in Git and in Subversion.  
In Git, commit 'M1' with merge resolution has simply two parents: '3' 
and 'b'.  

In Subversion there is no such thing like parent of revision. Instead
of this SVN records that it integrated changes brought by revisions 'a' 
and 'b' into 'M1', which means that from revision 'M1' the branch 
folder ("project/branches/foo") acquires svn:mergeinfo property with 
the contents '/branches/bar:B-b' (B-b is a:b, i.e. range from B to b, 
excluding B).  PLEASE CORRECT ME IF I AM MISTAKEN.

Note branch info in svn:mergeinfo property.  Note the revision range 
instead of just its endpoint 'b'.  Note lack of reference to what would 
be first parent in git merge commit, i.e. '3'.


Let's take a look what happens at point M2 (i.e. second merge) in Git 
and in Subversion.

In Git it is easy.  Git calculates merge base by travelling parentage 
links (which include all parents of merge commits), and notices that at 
point 'M2' merge base, i.e. first common ancestor of branches 'foo' and 
'bar' is commit 'b'.  It then runs 3-way merge with '5' as ours, 'd' as 
theirs, and 'b' as ancestor, and records merge commit with parents '5' 
and 'd'.

Subversion instead examines svn:mergeinfo property to check what it 
already merged in, and somehow notices that it has to integrate changes 
c+d made on branch 'bar' (but not a+b+c+d, as a+b were already 
integrated) with changes 4+5 on branch 'foo'.  Probably it somehow 
notices that 'b' is common ancestor.  But you can see how this 
mechanism is fraught with peril and can break easily in more complex 
situations ("The 1.5 release of merge tracking has basic support for 
common scenarios; we will be extending the feature in upcoming 
releases."... they hope!).

Subversion then updates svn:mergeinfo property at branch 'foo'.
</rant>

-- 
Jakub Narebski
Poland
