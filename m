Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5A53AF646
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786358764; cv=none; b=P1lgXmNjQj6m5RZafsP/Q3oaghPHAyMdGtB5x+59OjMXcpB2tESCmCCyBHOwNxtcG207R4IBgqfsqvOi6KzdAexh7zG64pWctqfVaLIixWJknu7mRNFC1ZTrMlUFc0ioZFOTF+ocYuudlbpCVZJ3AJxB6u4/xl3liTOhbyT7zhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786358764; c=relaxed/simple;
	bh=fkCyTHwK5ev9o7zOCUTiWzRfOuTAyl9hulK+rXmY1mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jal1grc1DbINRVTAlaUnIqoOel9O3M2xlrVRScX+UJT86PlqS4ZlvQY/4GZbY3CqQmbCAmtOmNXkAJCJ0mGDMU/z8u7G+GcdYbsmNvkNJJjZe9iZvUoqEcrGK33eFibPVMf3ZTg+XIek6NBAgQWQ+FS0J1BNyevuOPc7LaB2Cww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=Tu+vsU+L; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="Tu+vsU+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202608070029; t=1786358758;
	bh=pIW4v5T/tdb+02SYn8DroJmP8QEeZ+Qg1JJeELrOSC0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=Tu+vsU+LZqrpBwq6YIbEY83qeuTwuL/4r+ap515dYpqtrjDrbM74b0vaEoDYrCRPa
	 zVj96tpc/KNG7O7pPPv7cTXf/OSkwM3SNpLFC9VL2cZIuIiUGyM8JeKMvLZ04s43VW
	 BtubGu+ixA2kj9gvo3Hihj9Z+jTfkY0g+IVyFkcY3wZ1b3W8NtJts1pejm2D+1aq4C
	 0tq4hSLm4etzprw3KesrKWQF8ccFRGEQ8+nQOsmXJFN/3+LCPv6CttQqyQlPpxPAm/
	 qVwoAaML0d649oNNJ35wZJWSITkocFMy0xcCp7FBD+d5TvufmGTPpG+APdtK0/wD4d
	 KKLrGX498un/g==
Received: from [192.168.42.64] (66-97-142-46.pool.kielnet.net [46.142.97.66])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id CFBE93C0659;
	Mon, 10 Aug 2026 12:45:57 +0200 (CEST)
Message-ID: <4f6a96ac-d993-4872-b3c4-30d899f61ca9@haller-berlin.de>
Date: Mon, 10 Aug 2026 12:45:57 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] t: fix races caused by background maintenance
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
 Taylor Blau <me@ttaylorr.com>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260220-b4-pks-maintenance-default-geometric-strategy-v1-1-faeb321ad13b@pks.im>
 <17d460c0-564e-45fd-830e-548f60e01e01@haller-berlin.de>
 <anlfk0P7UillhlUd@pks.im>
 <801031d7-f219-4410-a863-7410cff7952f@haller-berlin.de>
 <anmNX-WVohAyjEcc@pks.im>
Content-Language: de-DE, en-US
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <anmNX-WVohAyjEcc@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ----

On 10.08.26 10:35, Patrick Steinhardt wrote:

> On Mon, Aug 10, 2026 at 09:37:01AM +0200, Stefan Haller wrote:
>
>> On 10.08.26 07:20, Patrick Steinhardt wrote:
>>
>> I had cases where the commit fails with
>>
>>   error: invalid object 100644 50d5612... for 'file09.txt'
>>   error: Error building trees
> 
> That's a bug then that we ought to fix. Do you maybe have a reproducer
> for this?

I had my friendly AI agent dig into this more, and below is what it came up
with. Disclaimer: I only skimmed it, and didn't check it for accuracy; I'm way
too unfamiliar with any of this stuff. I hope this is of some use.

----------

Subject: [BUG] geometric-repack --auto fires on tiny repos, and the
 resulting background repacks race concurrent commands

Since v2.54.0, `git commit` in an ordinary small repository can leave a
detached `git repack` running behind it, and it does so far more often
than intended: the auto condition that is documented as "at least 100
loose objects" is in practice satisfied by a repository containing four
objects.  The background repacks that result break concurrent git
commands at a rate of roughly one in a thousand commits in my testing.

There are two separate issues here.  The first is a plain bug; the
second is its fallout.

1. The geometric-repack auto condition triggers ~256x too eagerly
----------------------------------------------------------------

Documentation/config/maintenance.adoc says:

    maintenance.geometric-repack.auto::
            [...] a positive value implies the command should run either
            when there are packfiles that need to be merged together to
            retain the geometric progression, or when there are at least
            this many loose objects that would be written into a new
            packfile. The default value is 100.

Reproducer, on a repository with four objects (v2.54.0 and v2.55.0):

    git init repro && cd repro
    git config maintenance.auto false   # so that the setup itself does
                                        # not fork any maintenance
    echo 263 >a.txt                     # blob 175b6c5d...
    echo 410 >b.txt                     # blob 17e344e7...
    git add . && git commit -m initial

    $ find .git/objects -type f
    .git/objects/17/5b6c5dfd7f9bf6e2b2c4e2dcf3e2341298575d
    .git/objects/17/e344e7c08441fa81d5b56c21008dc0feeeaa20
    .git/objects/70/a9a72c46fc85c654e626f54e77c4946950da52
    .git/objects/7f/174478a536fc641c735e6b6e1a1944c868ba0c

    $ git maintenance run --auto --no-detach
    $ ls .git/objects/pack/
    multi-pack-index
    pack-f826a2dd....idx
    pack-f826a2dd....pack
    pack-f826a2dd....rev

(only the two blob IDs are fixed; the tree and commit depend on the
commit timestamp.)  Committing only a.txt -- three objects, one of them
in objects/17 -- does not trigger the repack.  Adding the second blob
whose object ID starts with "17" does.  That is the whole condition.

geometric_repack_auto_condition() (builtin/gc.c) passes its threshold to
too_many_loose_objects(), which does not count loose objects: it counts
the entries of .git/objects/17 and scales by 256.  In v2.54.0:

    int auto_threshold = DIV_ROUND_UP(limit, 256);
    [...]
            if (++num_loose > auto_threshold) {

and equivalently after the rewrite in v2.55.0:

    /*
     * This is weird, but stems from legacy behaviour: [...]
     */
    int auto_threshold = DIV_ROUND_UP(limit, 256) * 256;
    [...]
    return loose_count > auto_threshold;

with loose_count coming from ODB_COUNT_OBJECTS_APPROXIMATE, i.e. the
same one-directory estimate.  Either way, any limit <= 256 collapses to
"two or more objects share the objects/17 directory".

That estimator is fine for gc.auto, whose default of 6700 needs 27
entries in that directory -- a number you only reach with thousands of
objects, and whose documentation says "approximately".  It falls apart
for a threshold below 256, where the smallest representable estimate
step exceeds the threshold itself and a single fanout collision decides
the outcome.  For a repository with n objects the condition is satisfied
with probability ~1-(1-p)^n-np(1-p)^(n-1), p=1/256: about 5% at 90
objects, and much higher for repositories that accumulate objects over
time.

By contrast maintenance.loose-objects.auto, documented in the same terms,
is implemented as an exact count in loose_object_auto_condition().

Since 452b12c2e0 (builtin/maintenance: use "geometric" strategy by
default, 2026-02-24) this condition governs what `git maintenance run
--auto` does, and run_auto_maintenance() invokes that from commit, am,
fetch, merge and rebase, with --detach unless gc.autoDetach says
otherwise.  So the practical effect is: once any two objects in a
repository collide in objects/17 -- and the condition only becomes
easier to satisfy as the repository grows -- every subsequent commit
forks a detached repack.

Measured on a fixture repository built by 40 commits of "write a file,
git add, git commit": a background repack fired in 4 of 25 runs (the
prediction from the 40 nondeterministic commit object IDs alone is
1-(255/256)^40 = 14%).

2. The resulting background repacks break concurrent commands
-------------------------------------------------------------

`git repack -d` installs the new pack, removes the redundant ones and
then calls prune_packed_objects(), which unlinks the loose copies of
objects that are now packed and rmdir()s the fanout directories it
empties.  Doing that concurrently with unrelated git processes in the
same repository is new exposure: before v2.54.0 the same repositories
never reached the gc.auto threshold and no such repack ever ran.

Stress test: 24 concurrent workers, each repeatedly creating a fresh
repository and running 40 iterations of "write a file, git add, git
commit", with maintenance.geometric-repack.auto=-1 so that the condition
fires on every commit rather than in ~15% of repositories.  Nothing else
touches the repositories; the only concurrency is git's own detached
auto-maintenance.

109280 commits produced 97 failing commands, i.e. one per ~1100 commits.
Message lines across those 97 failures (one failure often emits two of
them, e.g. a temporary-file error followed by a fatal):

      71  error: packfile .../pack-....pack index unavailable
      50  fatal: failed to write commit object
      37  error: unable to create temporary file: Invalid argument
      23  error: unable to create temporary file: No such file or directory
      10  error: unable to index file '...'
      10  fatal: adding files failed

At least the ENOENT variant has a straightforward explanation:

  - The writer, in create_tmpfile() (object-file.c), calls
    mkstemp(".git/objects/XX/tmp_obj_XXXXXX").  On ENOENT it mkdir()s
    the fanout directory and retries -- exactly once.

  - The repack, in prune_subdir() (prune-packed.c), rmdir()s each fanout
    directory after pruning its contents.

An rmdir() landing between the writer's mkdir() and its retried
mkstemp() defeats the single retry, and the command aborts.  The writer
retries a bounded number of times against interference that is not
bounded.

(For anyone hitting this meanwhile: setting maintenance.auto=false makes
it go away, since it stops the fork at the source.  We have done that in
lazygit's test configuration.)

3. Where this came from
-----------------------

lazygit's integration tests started failing intermittently on CI, always
and only in the job running the newest git (2.54.0 on GitHub Actions
ubuntu-latest), never in the jobs pinned to 2.32.0/2.38.2/2.44.0, and
always during test fixture setup, which is a plain loop of "write a
file, git add, git commit":

    error: invalid object 100644 50d561270fcfcdc9afc85f6136f937c529accaaa for 'file09.txt'
    error: invalid object 100644 50d561270fcfcdc9afc85f6136f937c529accaaa for 'file09.txt'
    error: Error building trees

(the first message really is printed twice), i.e. the cache-tree
existence check in update_one() (cache-tree.c) failing to find a blob
that a previous iteration had successfully committed.  The hash is the
correct blob for the file's content, so `git add` had staged it fine.

Those fixture repositories are exactly the case in section 1: they
contain one object in objects/17 by construction, so a single commit
object hashing into the same directory tips them over, and every
following commit forks a repack.  The affected tests were, without
exception, the ones whose fixtures build six or more commits.

I could not reproduce this specific failure outside Linux, and I have
not isolated the window that produces it.  A fresh process is robust
(7200 lookups against a repack loop, no misses), and so is a `git
commit` whose repack completes mid-flight -- the flag the cache-tree
check passes, ODB_HAS_OBJECT_RECHECK_PACKED, makes a missing lookup
reprepare the pack list and retry, and that recovery does work in
everything I could construct deliberately.  So I am reporting this as
the symptom that led to the above rather than as a diagnosed bug, in
case it is familiar to someone.

One observation from reading that retry path, which may or may not be
related: packfile_store_reprepare() refreshes the pack list but never
reloads the multi-pack-index, because prepare_multi_pack_index_one()
(midx.c) returns early when one is already loaded.  A long-lived process
therefore keeps a midx that may reference packs a concurrent repack has
since deleted, for its entire lifetime.

Environment
-----------

Original failures: git 2.54.0, GitHub Actions ubuntu-latest.
Reproducers and measurements above: git 2.55.0 (built from source),
macOS 26, APFS.  Code references are to v2.54.0 unless stated; I checked
that the behaviour is unchanged in v2.55.0.

Thanks,
Stefan

