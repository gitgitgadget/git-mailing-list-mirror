Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from einhorn-mail-out.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B25519A7
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 15:51:09 -0800 (PST)
X-Envelope-From: oliver@first.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 3AONp6DD782338
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 25 Nov 2023 00:51:06 +0100
Date: Sat, 25 Nov 2023 00:51:06 +0100
From: Oliver Bandel <oliver@first.in-berlin.de>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: git@vger.kernel.org
Subject: Re: "git overlay" - command for overlaying branches
Message-ID: <647focpqwyild7dbmw7dloc5q2irijk7z77ymmfut5zdjrqhzy@xsle27m6flun>
References: <n46dskd3hudzssaam56jesxr5elzdvs3asurqvbxkgsdcqitjs@qlufclnnjpsq>
 <20231124205945.GA9696@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231124205945.GA9696@kitsune.suse.cz>

Quoting  Michal Suchánek <msuchanek@suse.de> (snt: 2023-11-24 21:59 +0100 CET) (rcv: 2023-11-24 21:59 +0100 CET):
> On Fri, Nov 24, 2023 at 05:39:12PM +0100, Oliver Bandel wrote:
> > Hello,
> > 
> > I'm adressing the problem with files separated from the main branch(es),
> > which currently might be (more or less) solved with either submodules or subtrees.
> > I want to suggest a new command here.
> > 
> > As usecase-example I assume a project that has 'branch_a' and 'branch_b'
> > with some files may be identical, some different between them.
> > I assume that the (classical) way the files are handled
> > by belonging to those branches is intended.
> > 
> > Then say later I want to add more files to these branches,
> > but don't want to commit them in either of these existing branches.
> > Instead a branch 'branch_addons' is created, which solely contains
> > files that are used in 'branch_a' as well as 'branch_b'.
> 
> Now you can merge branch_addons onto branch_a and branch_b and be done.

Maybe my example or the explanation was not clear enough or stopped to early.

After a merge, I may have added files from one branch to another branch
and some files might be changed during the merge operation and this is
persistent then.

But the overlay would be a temporal situation and so no "pollution" with files from
other branches would occur and no changes of the files with same names
(some were just temporarily hidden).

In an overlay situation, all involved branches are checked out into the
working dir (the non-hidden files are checked out) at the same time.
All changes (change/add/commit) could then be done in one go (with 'git
add' and 'git commit' as in the usual way), and all commits will only
affect those branches where the changed files are comming from.
This means editing more than one branch at the same time,
committing to more than one branch at the same time,
but not merging them.

After un-overloading, the temporarily overlayed files from other
branches will be removed from the working dir by git.
No merge has been done, but changes to more than one branch might have
happened.

I hope it's more clear now, how that differs from normal merge-branches situation.

Ciao,
  Oliver

P.S.: Changing sources and tests together but only publishing the code would be
      easy this way.
      Just check out the sources, overlay the tests, do the work, commit
      the changes and after un-overlaying the sources branch has no
      "tests pollution", and no other tricks are needed then.

      Also useful, when working with LaTeX documents and you temporarily
      want to change the included extra files (or use the other layoutet
      old version together with the current one) from a different
      branch, but don't want the changes be permanently in your
      currently preferred main branch (nevertheless change the main-doc
      and the extra files in one go).

      For those people who commit their passwords or private keys into git,
      this also could increase security ;-)
      For testing the code, the secrets are just overlayed.
