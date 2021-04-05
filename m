Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C2C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 01:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FA061396
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 01:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhDEBCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 21:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhDEBCp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 21:02:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A57BC061756
        for <git@vger.kernel.org>; Sun,  4 Apr 2021 18:02:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u17so8527791ejk.2
        for <git@vger.kernel.org>; Sun, 04 Apr 2021 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version:content-transfer-encoding;
        bh=uC3PUjQ0ycdywbcUN3hj2bblLgxa9vb7NcTxVyhsfRQ=;
        b=tfs0qXCLI0uuSn043SGF3CAkxqCU3RXCeD3OIZ1AJgGdOTl2uEi69l6nkkTn/ZCBWc
         dlHmHo8AzRR/dsP3HXAsXYDfhjlsBsSymQNx/MUwdxuPbdvIUeg6H+pVIcMDpBpEoxSl
         dIjkjko13T1XOC+FtTbpzW+OuXwsdJ4OTlH9Lld6NUOQkmp+xHg0BE6+OI6aulJGF7i2
         rQ998lrFcx+mm5ytRBzvNi9c7n3/m9yp4jzMBgaFCu++I1ezY8cpgCD3qo5/q2xGcSfL
         u/LgO52GuWPVzv4KqinRl1IrHAyFTHgeLEtj8Q7Ee4yME0eNBEgZDMSMnVD6nd1VjDHE
         nhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version:content-transfer-encoding;
        bh=uC3PUjQ0ycdywbcUN3hj2bblLgxa9vb7NcTxVyhsfRQ=;
        b=qg2D0LhcNN4v+djgEzEncCvplFkfgYDhFVI3DsQqP3J/qgLUOesc8kcdMv0g6AoJIK
         jvxnPS1kaLdTqWg4lZLgiR3zkIBJJUCqWafNE1fNlMTKNlgaedY1d4mJQ077Z11DUT8t
         a94uzxemOv/5i+6airjSFaJcagOqGmtm8R/OLg7PwTD7lj8cS3YeXu5b4lkiCz0kO83r
         aujos+yY2uVuxgEz60orXzPv2FSsvsa/7ueSXR7xQ8uPPy6lI4etcJ8XmuKZf8ROz6EI
         e26vcVk721jGHkuTGH65HvVxH9xJrH3ccilaJ9OYB7SeFDfis/3JPTARG0CeHAL1i52p
         FRDA==
X-Gm-Message-State: AOAM530gGb4ZuK42GBS4eCdyVyq8ZfZJ5dopnN7HnlujVz7Et2OH6a7f
        0QoLbvbinAAdKkicbTxpmWumUvlAZrg=
X-Google-Smtp-Source: ABdhPJzatv7w3Cytqvglwx9iRjtlcfYAoEsdvR19+PgwXXehqczGOvn1MgG4bdSCssCbVtWg1ZHvhA==
X-Received: by 2002:a17:906:934c:: with SMTP id p12mr25634767ejw.131.1617584556519;
        Sun, 04 Apr 2021 18:02:36 -0700 (PDT)
Received: from cpm12071.fritz.box ([79.140.120.197])
        by smtp.gmail.com with ESMTPSA id gq9sm7700066ejb.62.2021.04.04.18.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 18:02:35 -0700 (PDT)
References: <20210403090412.GH2271@szeder.dev>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: rather slow 'git repack' in 'blob:none' partial clones
Message-ID: <gohp6ko8et3jdm.fsf@cpm12071.fritz.box>
In-reply-to: <20210403090412.GH2271@szeder.dev>
Date:   Mon, 05 Apr 2021 03:02:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Hi,
>
> here are trace timings of running 'git gc' in a "normal" and in a
> 'blob:none' partial clone:
>
>   $ git clone --bare https://github.com/git/git git-full.git
>   $ GIT_TRACE_PERFORMANCE=3D2 /usr/bin/time --format=3D'elapsed: %E  max =
RSS: %Mk' git -C git-full.git/ gc
>   10:35:24.007277 trace.c:487             performance: 0.001550225 s: git=
 command: /usr/local/libexec/git-core/git pack-refs --all --prune
>   10:35:24.044641 trace.c:487             performance: 0.035631270 s: git=
 command: /usr/local/libexec/git-core/git reflog expire --all
>   10:35:24.061070 read-cache.c:2315       performance: 0.000008506 s:  re=
ad cache ./index
>   Enumerating objects: 305283, done.
>   Counting objects: 100% (305283/305283), done.
>   Delta compression using up to 4 threads
>   Compressing objects: 100% (75016/75016), done.
>   Writing objects: 100% (305283/305283), done.
>   Total 305283 (delta 227928), reused 305283 (delta 227928), pack-reused 0
>   10:35:32.604546 trace.c:487             performance: 8.555651283 s: git=
 command: /usr/local/libexec/git-core/git pack-objects --local --delta-base=
-offset objects/pack/.tmp-2946975-pack --keep-true-parents --honor-pack-kee=
p --non-empty --all --reflog --indexed-objects --unpack-unreachable=3D2.wee=
ks.ago
>   10:35:32.680597 trace.c:487             performance: 8.633068356 s: git=
 command: /usr/local/libexec/git-core/git repack -d -l -A --unpack-unreacha=
ble=3D2.weeks.ago
>   10:35:32.683130 trace.c:487             performance: 0.000959377 s: git=
 command: /usr/local/libexec/git-core/git prune --expire 2.weeks.ago
>   10:35:32.684401 trace.c:487             performance: 0.000180173 s: git=
 command: /usr/local/libexec/git-core/git worktree prune --expire 3.months.=
ago
>   10:35:32.685730 trace.c:487             performance: 0.000263898 s: git=
 command: /usr/local/libexec/git-core/git rerere gc
>   10:35:33.514816 trace.c:487             performance: 9.511597988 s: git=
 command: git -C git-full.git/ gc
>   elapsed: 0:09.51  max RSS: 358964k
>
>   $ git clone --bare --filter=3Dblob:none https://github.com/git/git git-=
partial.git
>   $ GIT_TRACE_PERFORMANCE=3D2 /usr/bin/time --format=3D'elapsed: %E  max =
RSS: %Mk' git -C git-partial.git/ gc
>   10:35:47.637735 trace.c:487             performance: 0.000872539 s: git=
 command: /usr/local/libexec/git-core/git pack-refs --all --prune
>   10:35:47.675498 trace.c:487             performance: 0.036246403 s: git=
 command: /usr/local/libexec/git-core/git reflog expire --all
>   Enumerating objects: 188205, done.
>   Counting objects: 100% (188205/188205), done.
>   Delta compression using up to 4 threads
>   Compressing objects: 100% (66520/66520), done.
>   Writing objects: 100% (188205/188205), done.
>   Total 188205 (delta 119967), reused 188205 (delta 119967), pack-reused 0
>   10:35:50.081709 trace.c:487             performance: 2.402625839 s: git=
 command: /usr/local/libexec/git-core/git pack-objects --local --delta-base=
-offset objects/pack/.tmp-2946990-pack
>   10:35:50.100131 read-cache.c:2315       performance: 0.000009979 s:  re=
ad cache ./index
>   10:37:04.973541 trace.c:487             performance: 74.885793630 s: gi=
t command: /usr/local/libexec/git-core/git pack-objects --local --delta-bas=
e-offset objects/pack/.tmp-2946990-pack --keep-true-parents --honor-pack-ke=
ep --non-empty --all --reflog --indexed-objects --exclude-promisor-objects =
--unpack-unreachable=3D2.weeks.ago
>   Removing duplicate objects: 100% (256/256), done.
>   10:37:07.482791 trace.c:487             performance: 79.804973525 s: gi=
t command: /usr/local/libexec/git-core/git repack -d -l -A --unpack-unreach=
able=3D2.weeks.ago
>   10:37:07.549333 trace.c:487             performance: 0.008025426 s: git=
 command: /usr/local/libexec/git-core/git prune --expire 2.weeks.ago --excl=
ude-promisor-objects
>   10:37:07.552499 trace.c:487             performance: 0.000362981 s: git=
 command: /usr/local/libexec/git-core/git worktree prune --expire 3.months.=
ago
>   10:37:07.554521 trace.c:487             performance: 0.000273834 s: git=
 command: /usr/local/libexec/git-core/git rerere gc
>   10:37:10.168233 trace.c:487             performance: 82.533331484 s: gi=
t command: git -C git-partial.git/ gc
>   elapsed: 1:22.54  max RSS: 1891832k
>
> Notice the ~9s vs. 82s runtime and ~350M vs. 1.9G memory consumption
> increase.  What's going on here?
>
> Also note that that second 'git pack-objects' invocation doesn't show
> any progress for ~75s.
>
> FWIW, doing the same in a 'tree:0' partial clone is fast.

I'm not expert on the area - by "area": the entire git code base :).
However, I was intrigued by this performance numbers and decided to give
it a try on the investigation, mostly for learning. While I'm not sure
about the solution of the problem, I decided to share it here with the
hope that at least I'll be saving someone else time.

When I was digging into the code and adding trace2_region_*() calls, I
notice most of the time spent on the `git gc` (for the reported
situation) was in:

       # In builtin/pack-objects.c
       static void get_object_list(int ac, const char **av)
       {
               ...
               if (unpack_unreachable)
                       loosen_unused_packed_objects();
               ...
       }

The loosen_unused_packed_objects() will unpack unreachable objects as
loose objects, and given that the partial cloned .pack file is
incomplete, this result in writing a lot of loose objects in $GIT_DIR
increasing the execution time and memory consumption. This can be seen
by watching the $GIT_DIR/objects/ during the `git gc` execution on the
partial cloned repo.  On the fully clone repository all the objects
exist, at least on the fresh clone like in your report thus no object is
loose from the .pack file.

To provide some insight in the magnitude of the written loose objects,
I counted the number of objects that was being feed into
force_object_loose() with the following patch:

-- >8 --
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 525c2d8552..f912b54a5f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3478,7 +3478,7 @@ static int loosened_object_can_be_discarded(const str=
uct object_id *oid,
 static void loosen_unused_packed_objects(void)
 {
 	struct packed_git *p;
-	uint32_t i;
+	uint32_t i, loosen_obj_counter =3D 0;
 	struct object_id oid;
=20
 	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
@@ -3492,10 +3492,13 @@ static void loosen_unused_packed_objects(void)
 			nth_packed_object_id(&oid, p, i);
 			if (!packlist_find(&to_pack, &oid) &&
 			    !has_sha1_pack_kept_or_nonlocal(&oid) &&
-			    !loosened_object_can_be_discarded(&oid, p->mtime))
+			    !loosened_object_can_be_discarded(&oid, p->mtime) &&
+			    ++loosen_obj_counter)
 				if (force_object_loose(&oid, p->mtime))
 					die(_("unable to force loose object"));
 		}
+		fprintf(stderr, "loosen_unused_packed_objects() total of objects: %d\n",=
 p->num_objects);
+		fprintf(stderr, "loosen_unused_packed_objects() objects that is being lo=
osed: %d\n", loosen_obj_counter);
 	}
 }
=20
-- >8 --

Running on a fresh and fully cloned git.git repo, there are (obviously)
0 unreachable objects that are being written as loose objects:

    $ bin-wrappers/git clone --bare https://github.com/git/git git-full.git
    $ time --format=3D'elapsed: %E | max RSS: %Mk' bin-wrappers/git -C git-=
full.git gc
    loosen_unused_packed_objects() total of objects: 305292
    loosen_unused_packed_objects() objects that is being loosed: 0
    Enumerating objects: 305292, done.
    Counting objects: 100% (305292/305292), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (75035/75035), done.
    Writing objects: 100% (305292/305292), done.
    Selecting bitmap commits: 63006, done.
    Building bitmaps: 100% (317/317), done.
    Total 305292 (delta 227918), reused 305292 (delta 227918), pack-reused 0
    elapsed: 0:09.23 | max RSS: 438628k

On the other hand, when running on a fresh and partial cloned repo, we
can see that all the objects (at least according to my findings) are
being move out of .pack file into a loose object.

    $ bin-wrappers/git clone --bare --filter=3Dblob:none https://github.com=
/git/git git-partial.git
    $ time --format=3D'elapsed: %E | max RSS: %Mk' bin-wrappers/git -C git-=
partial.git gc
    Enumerating objects: 188213, done.
    Counting objects: 100% (188213/188213), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (66524/66524), done.
    Writing objects: 100% (188213/188213), done.
    Total 188213 (delta 119971), reused 188213 (delta 119971), pack-reused 0
    loosen_unused_packed_objects() total of objects: 188213
    loosen_unused_packed_objects() objects that is being loosed: 188213
    loosen_unused_packed_objects() total of objects: 188213
    loosen_unused_packed_objects() objects that is being loosed: 376426
    Removing duplicate objects: 100% (256/256), done.
    elapsed: 3:24.86 | max RSS: 2085552k

Another interesting thing is, the loosen_unused_packed_objects()
function is being called twice because the function loads all packs
files, via get_all_packs(), which will return the .temp-*pack file that
is created by the `git pack-objects` child process from `git gc`:

    git pack-objects ... --delta-base-offset objects/pack/.tmp-82853-pack .=
..

For this specific case, this make the situation worse as we end up
processing the object from both packfiles.  Also, the second
execution, which operates on the normal .pack file, is processing 2x
"objects" (in terms of counting the execution of
force_object_loose()), I couldn't quite figure out why.

I'm not entirely sure about this (not this late in the day), but it seems to
me that we should simply skip the "missing" (promisor) files when
operating on a partial clone.

Perhaps something like:

--- >8 ---
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 525c2d8552..fedf58323d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3468,6 +3468,8 @@ static int loosened_object_can_be_discarded(const str=
uct object_id *oid,
 {
        if (!unpack_unreachable_expiration)
                return 0;
+       if (exclude_promisor_objects && is_promisor_object(oid))
+               return 1;
        if (mtime > unpack_unreachable_expiration)
                return 0;
        if (oid_array_lookup(&recent_objects, oid) >=3D 0)
--- >8 ---

I'll try to prepare a patch for this change with proper testing, if this
turns out to be proper way to handle partial clone repository.

A quick benchmark did show some promising result:

    # built from: 2e36527f23 (The sixth batch, 2021-04-02)
    Benchmark #1: ./bin-wrappers/git -C git.git gc
          Time (mean =C2=B1 =CF=83):     135.669 s =C2=B1  0.665 s    [User=
: 42.789 s, System: 91.332 s]
          Range (min =E2=80=A6 max):   134.905 s =E2=80=A6 136.115 s    3 r=
uns

    # built from: 2e36527f23 + minor patch (from above)
    Benchmark #2: ./bin-wrappers/git -C git.git gc
          Time (mean =C2=B1 =CF=83):     12.586 s =C2=B1  0.031 s    [User:=
 11.462 s, System: 1.365 s]
          Range (min =E2=80=A6 max):   12.553 s =E2=80=A6 12.616 s    3 runs

    Summary:
          'Benchmark #2' ran 10.78 =C2=B1 0.06 times faster than 'Benchmark=
 #1'


--=20
Thanks
Rafael
