Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 065F7200B9
	for <e@80x24.org>; Fri,  4 May 2018 19:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeEDTkp (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 15:40:45 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42148 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeEDTko (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 15:40:44 -0400
Received: by mail-wr0-f171.google.com with SMTP id v5-v6so22159535wrf.9
        for <git@vger.kernel.org>; Fri, 04 May 2018 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=p2rm/GZxigbKKPoYBynWONN/WWfGOKCPGUgvAzHBaT4=;
        b=r4+XPCwIeJaBpf4Ttu2TUHoCB2XwckPuQCNCTm/whHjr3QsLyebLoodXaQhDyT/TLD
         GN8JCpsIEHDUI6QAACamhfzzCvRmBvjdTmj5JkUQ7EqRgahb4hyLd9wBspqo8eUwvVhv
         osOoJIVXKnSvBg9UzanmWe/CmtoWVLQlb1rYtRWEV2nbKr1VOwDQZLYmopaqFvzKfEyC
         MRTcgijQQrswMJ1O5+OQME0Sfg8P1YDzwK3AS2SiQ80PFxNth2RB/nxqoFZ1cnkTCqku
         Hnu/f2U2SuK8lIIDBslkFg/K5yrPo1Xej6P8Wt2ZuALCAlQ9l4q6OEBoZGW/BwxnqudE
         Vf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=p2rm/GZxigbKKPoYBynWONN/WWfGOKCPGUgvAzHBaT4=;
        b=fow1F2eJGVqbHBCBIecDwkcWDMZ4clNMr2Fzrbo9uXn6Z+FoeWKEg/uU32phzwHKDR
         smsDhAF3eY7nLIbO7MHm6yjZc49Hq19qlDccSsG0QFC+qBOAukhTz5VB+CtnAwkh4tb4
         +NbE1DT+9ea9jvdHCeIhYHCs2KY+Rb541rmVcaA+mWQEvCdlGfFpp2RpVPEo8s6PoArX
         R/QHBnqz4Y8IzFE4pnmMgZtxuyM2tdSHZkE3LF1SXtNVVD3sgiAeFb21zEM1Iw8jd2bT
         CuDvbiLoIRYXrZ6BpdwBM644nubA7/CR1uwEaCcWn4zC1M+623cw8A5qBWr09v63xOC8
         uZmQ==
X-Gm-Message-State: ALQs6tBD9SnVFUc3ytTo7ePZTdj+t3hoD7qAo+uGUhMVJqXk7hvdUIQf
        p/kcIFh4G2CPhadYkM/2A4HLLmVD
X-Google-Smtp-Source: AB8JxZpep4HaHJw0mHVmhv8hu7dp6sQ3HsQkUM/CKBlJfuGsOKjxB3rmCevNQJKGR9loGrVM6wff9w==
X-Received: by 2002:adf:9d0d:: with SMTP id k13-v6mr23672370wre.179.1525462842641;
        Fri, 04 May 2018 12:40:42 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egh248.neoplus.adsl.tpnet.pl. [83.21.71.248])
        by smtp.gmail.com with ESMTPSA id a13-v6sm16596822wrc.19.2018.05.04.12.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 May 2018 12:40:41 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: [RFC] Other chunks for commit-graph, part 1 - Bloom filters, topo order, etc.
Date:   Fri, 04 May 2018 21:40:38 +0200
Message-ID: <86zi1fus3t.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

With early parts of commit-graph feature (ds/commit-graph and
ds/lazy-load-trees) close to being merged into "master", see
https://public-inbox.org/git/xmqq4ljtz87g.fsf@gitster-ct.c.googlers.com/
I think it would be good idea to think what other data could be added
there to make Git even faster.


Commit-graph format
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A quick reminder: in its current incarnation the commit graph file
includes the following data [1]:

1. Some commit data that is just enough for many Git operations:
   - commit parents
   - commit tree (root tree OID)
   - committer date

2. The generation number of the commit. Commits with no parents have
   generation number 1; commits with parents have generation number one
   more than the maximum generation number of its parents.

The commit-graph file is split into chunks, which theoretically allows
extending the format wihout need for a version bump... though there is
currently no specified policy about unknown chunks (and understandably
so, as currently there are not any).

I think it would be good idea to talk about what more could be added to
be stored in the commit-graph file.

[1]: https://github.com/git/git/blob/pu/Documentation/technical/commit-grap=
h-format.txt


Requirements and recommendations about possible new chunks
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

Because the main goal of commit-graph feature is better performance in
large repositories, any proposed new chunks (or, at higher level, every
proposed piece of new data) needs to have the following properties.


1. First, it needs to have bounded and sensible size.  This means that
the size of new proposed chunk should be constant, proportional to the
number of commits, or at worst proportional to the number of edges.

From the existing chunks, OIDF (OID Fanout) has constant size, both OIDL
(OID Lookup) and CGET/CDAT (Commit Data) has size proportional to the
number of commits, while not always present EDGE (Large Edge List) has
size proportional to the number of "excess" edges in "huge vertices"
(octopus merges).


2. Second, we want fast access, in most cases fast random access.  This
means using fixed-size records.  All currently existing chunks have
records (columns) of fixed and aligned size.

This restriction means that idexes where we have variable amount of data
per vertex (per commit) are discouraged.


3. Third, it needs to be reasonably fast to create, and fast to update.
This means time to create the chunk to be proportional to number of
commits, or sum of number of commits and edges (which for commit graph
and other sparse graphs is proprtional to the number of nodes / commits
anyway).  In my opinion time proportional to n*lug(n), where 'n' is the
number of commits, is also acceptable.  Times proportional to n^2 or n^3
are not acceptable.

It is also strongly preferred that time to update the chunk is
proportional to the number of new commits, so that incremental
(append-only) update is possible.  The generation numbers index has this
property.


Generic new chunks
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There are a few ideas for new chunks, new pieces of data to be added to
the commit-graph file, that are not connected with some labeling scheme
for directed acyclic graphs like GRAIL, FERRARI, FELINE or TF-Label.
Let's list them here.

If you have an idea of another bit of information that could be added to
the commit-graph file, please tell us.


Bloom filter for changed paths
------------------------------

The goal of this chunk is to speed up checking if the file or directory
was changed in given commit, for queries such as "git log -- <file>" or
"git blame <file>".  This is something that according to "Git Merge
contributor summit notes" [2] is already present in VSTS (Visual Studio
Team Services - the server counterpart of GVFS: Git Virtual File System)
at Microsoft:

AV> - VSTS adds bloom filters to know which paths have changed on the commit
AV> - tree-same check in the bloom filter is fast; speeds up file history c=
hecks
AV> - might be useful in the client as well, since limited-traversal is com=
mon
AV> - if the file history is _very_ sparse, then bloom filter is useful
AV> - but needs pre-compute, so useful to do once
AV> - first make the client do it, then think about how to serve it central=
ly

[2]: https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@alexm=
v-linux/

I think it was what Derrick Stolee was talking about at the end of his
part of "Making Git for Windows" presentation at Git Merge 2018:
https://youtu.be/oOMzi983Qmw?t=3D1835

This was also mentioned in subthread of "Re: [PATCH v2 0/4] Lazy-load
trees when reading commit-graph", starting from [3]
[3]: https://public-inbox.org/git/86y3hyeu6c.fsf@gmail.com/

A quick reminder: a Bloom filter is a space-efficient probabilistic data
structure that is used to test whether an element is a member of a set.
False negatives are not possible: if a Bloom filter says that the
element is not in set, then it certainly isn't.  False positives matches
are possible: if a Bloom filter says that element is in set, then maybe
it is -- it is possible with some probability that it really is not.
The probability depends on number of elements in set, number of bits
Bloom filter uses (with fewer than 10 bits per element are required for
a 1% false positive probability), and number of [independent] hash
functions it uses.

This Bloom filter can be used to store in a compact and fixed-size way a
set of files (and possibly also directories) changed by given commit.
Then when "git log -- <file>" is called, Git can quickly check if the
commit in question touches given file.  If Bloom filter say that it most
probably is, only then Git would need to perform a diff to check if it
actually is (and usually get data to show).

There are a few problems that needs to be solved, though.

* First, and most important is the performance considerations of
  actually creating Bloom filter.  It is very expensive to do the full
  diff for each commit to create Bloom filter.

  As Derrick Stolee said in [3]:

  DS> My guess is that only server-side operations will need the added
  DS> response time, and can bear the cost of computing them when
  DS> writing the commit-graph file. Clients are less likely to be
  DS> patient waiting for a lot of diff calculations.
  DS>
  DS> If we add commit-graph file downloads to the protocol, then the
  DS> server could do this computation and send the data to all
  DS> clients. But that would be "secondary" information that maybe
  DS> clients want to verify, which is as difficult as computing it
  DS> themselves.

* What to do about merge commits, and octopus merges in particular?
  Should Bloom filter be stored for each of the parents?  How to ensure
  fast access then (fixed-width records) - use large edge list?

* Then there is problem of rename and copying detection - I think we can
  simply ignore it: unless someone has an idea about how to handle it?

  Though this means that "git log --follow <file>" wouldn't get any
  speedup, and neither the half of "git gui blame" that runs "git blame
  --incremental -C -C -w" -- the one that allows code copying and
  movement detection.

One possible way of solving the issue of large amount of work required
to compute Bloom filter could be updating it as a side effect of
operation that calculates full diff anyway (like "git log -p" or "git
show") if the commit is in commit-graph file.  We would need then some
special value that marks Bloom filter as not filled in (in addition to
the one saying that there were too many changes, and the one saying that
there were no changes at all - as rare as the latter might been).

Because not all queries that require calculating diff do it for full
hierarchy, maybe additionally there could be a additional field denoting
the depth to which diff and changed files were calculated.  For example
depth of 1 means that only top-level files and top-level directories
were added to Bloom filter, so you can only verify the first component
of the path to check if it could have been changed.  Zero depth may mean
unlimited.

A final note: Git would use this Bloom filter for changed files in quite
different way than is this structure typical use case: instead of
checking large number of elements against given Bloom filter, Git would
be checking given element against large amount of Bloom filters.  This
means that the optimization people came up with, like fast-forward Bllom
filters (https://github.com/efficient/ffbf) wouldn't necessary help.


Commit-graph validity
---------------------

One problem with commit-graph feature that needs to be solved is that it
stores one particular view of the project history, and there exist
features that change it.  Beween writing commit-graph file and using it,
commits may have been replaced by commits with different parents,
shallow clone may have been shortened or deepened, or grafts file may
have been edited.

One possible solution would be to automatically turn off commit-graph if
any of those features is present.  For shallow clone it may even be
acceptable solution - the hstory is shortened, so the queries are fast
anyway, and commit-graph is less needed.

If we join the working repository with the historical one (via grafts or
replacements) to examine the full history of a project, last thing we
would want is to make operations slower.

A possible way of solving this would be to add a chunk which says for
what combination of graft file content, shallow file content, and the
state of replace refs given commit-graph file is valid for.  If they do
not match, Git would not use commit-graph feature and fall back on
ordinary slower mechanism of answering queries.

Moreover, with this solution, when shallow clone changes its depth
(e.g. with 'git fetch --deepen=3D<depth>' or 'git fetch --unshallow), or
when a replacement is added with 'git replace', Git can either update
commit-graph file, or update the validity - saying that commit-graph
file is valid for the new state.  The latter is more important for
git-replace, which does not need to affect history at all.  There isn't
anything like that for grafts, but the mechanism is deprecated anyway,
and I am not opposed to just turning off commit-graph feature if there
is grafts file present: this could help convince people to upgrade to
git-replace, which should be easy now thanks to the new
--convert-graft-file option.

The verification could be as simple as verification hash / check over
contents of grafts file, over contents of shallow file, and over
replacement refs represented as fragment of packed-refs file.


Topographical ordering of commits
---------------------------------

The idea is simple: store topological order of commits, so that 'git log
--topo-order' and 'git log --graph' are faster.

This could be done with two chunks: one storing the position of given
commit in topological order (commits sorted by their OID, like for
metadata), and list of commits in topological order.  The first chunk
can also be thought of as the index into later.

This way it would be possible to list commits in topological order
starting at given commit, and ending at given commit or after given
number of commits.

The problem is with updating this data.  It should be possible to update
a topological order, but I am not sure if it would be possible to update
topological order based only on changed files and existing order to
still fulfill the criteria on --topo-order:

  --topo-order ::
      Show no parents before all of its children are shown, and avoid
      showing commits on multiple lines of history intermixed.

The second requirement may (or may not be) hard to fulfill when updating.


Bitmap indices indicator
------------------------

Bitmap index is supported since 2015 for Git itself [4], and since at
least 2013 for JGit [5].  The main goal of this feature was to improve
the "counting objects" phase of clone and fetch performance.

A quick reminder: bitmap index file is computed per packfile, and it
refers to objects by their position in packfile.  Bitmap index can be
currenly generated only for a packfile with full closure (i.e. where
every single object in the packfile can find its parent links inside the
same packfile).

A single bitmap in a bitmap index file is a bit vector, where i-th
position (i-th bit of bitmap) corresponds to the i-th object in
packfile.  There are 4 bitmaps that act as type indexes, for example
commit type index has "1" on i-th position if i-th object in packfile is
a commit object.  There are also N entries for commits, where i-th bit
in bitmap for given commit denotes whether i-th object is reachable from
the commit this bitmap is for.

I think that bitmap indexes does not see much use when Git needs to
answer reachability query; correct me if I am wrong here.  Maybe some
kind of indicator that given commit has reachability bitmap in some
bitmap file could help?

As soon as we arrive at commit for which reachability bitmap exist,
answering reachability query is easy: just find out the position of the
commit we want to check if it is reachable in same packfile, and if i-th
bit in bitmap is "1" then it is reachable.  Finding path is slightly
more involved: just use reachability bitmap to steer walk, always
choosing only reachable parents.

I don't know if we can find merge-base, also known as lowest common
ancestor (or sometimes as greatest common ancestor) with reachability
bitmaps.  You can easily find *all* ancestors (with bitwise AND
operation on bitmaps).  Maybe starting from the ones that have highest
generation numbers we can remove redundant ancestors (with AND NOT --
but not all commits have reachability bitmaps).

I wonder if it would be better to store indicators that commit has
reachability bitmap (and in which packfile, if it is possible with
mentioned restriction to have more than one bitmap file) in commit-file,
or if it would be easier when reading commit-graph information into
memory to simply read bitmap file for this information and add it to
in-memory representation.

[4]: http://githubengineering.com/counting-objects/
[5]: https://www.eclipsecon.org/2013/sites/eclipsecon.org.2013/files/Scalin=
g%20Up%20JGit%20-%20EclipseCon%202013.pdf


As this post is getting long, I'll post other ideas, about commit
labeling for faster reachability queries in a separate email.

Regards,
--=20
Jakub Nar=C4=99bski
