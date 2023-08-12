Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2D5C001B0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 19:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHLTg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Aug 2023 15:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjHLTg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2023 15:36:56 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50891E65
        for <git@vger.kernel.org>; Sat, 12 Aug 2023 12:36:59 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76714caf466so222545685a.1
        for <git@vger.kernel.org>; Sat, 12 Aug 2023 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google; t=1691869018; x=1692473818;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+qQ5cVRXtSZB9PwpNRV4wvJCZSLnOyrJCBw596EFbvA=;
        b=Xu22ymDDnfEk5JRTXLDJjO4hBRN093nIuEyw8K4+NLftU9JgejKMhgjMq4seW1EX3t
         3RnE3txybXOlCv7xT5p7XiDEku5m7dupO3ezM0Mq9F8VYZy0C7z/AQZQ0pNLY4l9I7Zs
         54ME6fehjYOEAXrGuVUkr5LKFKUIU/5XqBbMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691869018; x=1692473818;
        h=user-agent:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qQ5cVRXtSZB9PwpNRV4wvJCZSLnOyrJCBw596EFbvA=;
        b=iqCrKfwnC/op/0Ku3wY14HR/tqHV1NvWpGM6gG/egpLyf1G3Hdpx+qjjcnbKkz0vf5
         21n10aZzM3YFb90ZiqQ++Q+LGTJ62bNjeQ4VTq4KqSSCSTrSpUfp1LVwRRUdsxqeLWoI
         HtVATB6JqvM98/Q72aoHHLCfFWo+TITS2jI6IwLss3+EBz1Bwn3+dqZADun1LUsAfDr4
         NhQvOEhjONRs/MnEtBfC+bX4xmGSXNSsWX0EIM/fVHHwwp5lOyKdCuqZG+7sArHJVsuJ
         bmJwfJPnLYkmF/p+L63znsECYVTeUI0qmjKomYEhq/RE7XSMJuukN46Oo2Oi61QHrDYg
         7LKw==
X-Gm-Message-State: AOJu0Yxup7sNK7EYighRiTKBYFktCZgHZ6HKueFYfg9eO7a3hKw7AC0H
        HSBhvN2DN+iSVmRE2A46XLBA16GTw6OGrhVH4PctMA==
X-Google-Smtp-Source: AGHT+IEpKb5ocDkAWrsx0o2V7shkNPF8mT+8jv9ivAu7ENvqe67/l4eDKmfPT1IHSEu3JfYgvZ2lOg==
X-Received: by 2002:ac8:5790:0:b0:400:7b89:df58 with SMTP id v16-20020ac85790000000b004007b89df58mr7515440qta.10.1691869018353;
        Sat, 12 Aug 2023 12:36:58 -0700 (PDT)
Received: from localhost (2603-7080-8d00-1f7e-d654-8bff-fe0c-3294.res6.spectrum.com. [2603:7080:8d00:1f7e:d654:8bff:fe0c:3294])
        by smtp.gmail.com with ESMTPSA id a28-20020a05620a125c00b0076cc7219ac9sm1956268qkl.7.2023.08.12.12.36.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:36:57 -0700 (PDT)
Date:   Sat, 12 Aug 2023 15:36:56 -0400
From:   Ben Boeckel <ben.boeckel@kitware.com>
To:     git@vger.kernel.org
Subject: [BUG] `git describe` doesn't traverse the graph in topological order
Message-ID: <ZNffWAgldUZdpQcr@farprobe>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5SxREHz53H5LeiFL"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5SxREHz53H5LeiFL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

I found an issue where `git describe` doesn't find a "closer" tag than
another tag as the correct one to base the description off of. I have a
reproducer, but I'll first give details of the real world issue.

Repository: https://gitlab.kitware.com/vtk/vtk.git
`master` as of: dedf87b3a1b7e5be5d8cdb46b37ad3030590b8ac

$ git rev-parse HEAD
dedf87b3a1b7e5be5d8cdb46b37ad3030590b8ac
$ git rev-parse HEAD~2^2
da2482f716310fc59ac4be42ce977f6badc6af95
$ git rev-prase v9.3.0.rc1
f150d52568f4e00aa9c8b1568a521a08ded8d4cb
$ git rev-prase v9.3.0.rc1^{commit}
da2482f716310fc59ac4be42ce977f6badc6af95
$ git rev-parse HEAD~2^2~2
0a77d7cf4fdbf489ee5d38c6fec6517574cdaeb5
$ git rev-prase v9.3.0.rc0
e5e13b14629d445bf65d5f8a181920ed9b97d54c
$ git rev-prase v9.3.0.rc0^{commit}
0a77d7cf4fdbf489ee5d38c6fec6517574cdaeb5
$ git describe HEAD
v9.3.0.rc0-56-gdedf87b3a1
$ git describe --matches v9.3.0.rc1 HEAD
v9.3.0.rc1-86876-gdedf87b3a1

As you can see:

- v9.3.0.rc1 is "closer" to `HEAD` than v9.3.0.rc0 (created as a
  workaround for this bug; v9.2.6 is otherwise reported)
- v9.3.0.rc0 is an ancestor of v9.3.0.rc1
- Both v9.3.0.rc0 and v9.3.0.rc1 are ancestors of `HEAD`
- `git describe` reports that `HEAD` is "closest" to v9.3.0.rc0
- Forcing the issue and asking for v9.3.0.rc1 shows that it thinks there
  are almost 87000 commits somehow not on that commit.

I have a reproducer script attached. It reproduces back to 2.9.0 and
probably before. 2.8.0 didn't support the structure hiding that newer
OpenSSL 1.1 has done and given that it's at least that old, I don't
think it matters too much for backporting or anything like that.

I instrumented `git describe` with some `printf` debugging (diff
attached) and found out that the commit traversal is not happening in
topological order. I suspect that this is the root cause of the issue:

    looking at commit 0a77d7cf4fdbf489ee5d38c6fec6517574cdaeb5
    depth of 0a77d7cf4fdbf489ee5d38c6fec6517574cdaeb5: 16
    find order of 0a77d7cf4fdbf489ee5d38c6fec6517574cdaeb5: 2
    setting flag 4 for commit 0a77d7cf4fdbf489ee5d38c6fec6517574cdaeb5
    flag for 0a77d7cf4fdbf489ee5d38c6fec6517574cdaeb5: 5
    pushing depth of da2482f716310fc59ac4be42ce977f6badc6af95 because of 0a77d7cf4fdbf489ee5d38c6fec6517574cdaeb5 (flag_within): 16
    setting flag 5 for commit d478d2e22e81ee2602035fe1d731b402d9b4eda7 due to ancestry

    looking at commit 1c3d839dac92761ae0866e23d89bdc8ee690de08
    depth of 1c3d839dac92761ae0866e23d89bdc8ee690de08: 17
    find order of 1c3d839dac92761ae0866e23d89bdc8ee690de08: 3
    setting flag 8 for commit 1c3d839dac92761ae0866e23d89bdc8ee690de08
    flag for 1c3d839dac92761ae0866e23d89bdc8ee690de08: b
    pushing depth of 0a77d7cf4fdbf489ee5d38c6fec6517574cdaeb5 because of 1c3d839dac92761ae0866e23d89bdc8ee690de08 (flag_within): 17
    setting flag f for commit 0a77d7cf4fdbf489ee5d38c6fec6517574cdaeb5 due to ancestry

It looks at 0a77d7cf4 before it looks at 1c3d839da (which is
v9.3.0.rc1~), but 1c3d839da~ *is* 0a77d7cf4. Because 0a77d7cf4 has
already passed on its presence flags to its parent(s), the update
performed when processing 1c3d839da has no effect. Therefore the
"entire" history is not seen as being reachable from da2482f71 and it
ends up not being the best match.

I will note that the authorship date of 1c3d839da is before that of
either 0a77d7cf4 or da2482f71 (due to a rebase that reordered the
commits to keep 1c3d839da on the release-only part of the branch), but
the reproducer script doesn't seem to care that much.

I suspect that building of the `commit_list` is the problem, probably by
using `commit_list_insert_by_date` instead of by topological sorting.
The reproducer script doesn't do anything (AFAICT) sneaky with dates
(e.g., rebasing and such) though, so I'm nowhere near 100% confident
about that.

Perhaps commits should be re-scheduled if their `flags` get updated
based on a newly discovered ancestor while traversing? I suspect that
depth tracking becomes more complicated in that case though because the
second pass on 0a77d7cf4 needs to subtract a depth from the relevant
tags with the new flag value. But it'd find the right tag at least…

Thanks,

--Ben

--5SxREHz53H5LeiFL
Content-Type: application/x-sh
Content-Disposition: attachment; filename="repro-git-describe.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Aset -e=0Aset -x=0A=0Areadonly workdir=3D"${1:-repro}"=0A=
=0A# Give ourselves a fresh start.=0Arm -rf "$workdir"=0Amkdir -p "$workdir=
"=0Acd "$workdir"=0Agit init=0Agit branch -m main || :=0A=0A# Make a root c=
ommit.=0Atouch repro=0Agit add repro=0Agit commit -m root=0A=0A# Create a b=
ranch and merge it according to Kitware workflow guidelines.=0Amake_branch =
() {=0A    local branch=3D"$1"=0A    readonly branch=0A    shift=0A=0A    #=
 Create the branch.=0A    git checkout -b "$branch"=0A    local base=0A    =
base=3D"$( git rev-parse HEAD )"=0A    readonly base=0A=0A    local topic=
=0A    for n in $( seq 1 2 ); do=0A        git checkout -b "$branch-$n" "$b=
ase"=0A        echo "commit $n" >> "$branch.$n.txt"=0A        git add "$bra=
nch.$n.txt"=0A        git commit -m "topic $n for $branch"=0A        topic=
=3D"$( git rev-parse HEAD )"=0A=0A        # Merge with `main`=0A        git=
 checkout main=0A        git merge --no-edit --no-ff "$topic"=0A=0A        =
# Merge with `branch`=0A        git checkout "$branch"=0A        git merge =
--no-edit --no-ff "$topic"=0A=0A        # Sync with `main`=0A        git ch=
eckout main=0A        git merge --no-edit --no-ff -s ours "$branch"=0A     =
   git checkout "$base"=0A    done=0A=0A    git checkout "$branch"=0A    gi=
t tag -a -m "previous tag for $branch" "tag-prev-$branch"=0A=0A    git chec=
kout -b "$branch-tag" "$branch"=0A    echo "release prep for $branch" >> "$=
branch.prep.txt"=0A    git add "$branch.prep.txt"=0A    git commit -m "comm=
it for tag preparation for $branch"=0A    echo "tag for $branch" >> "$branc=
h.txt"=0A    git add "$branch.txt"=0A    git commit -m "commit for tag for =
$branch"=0A    git tag -a -m "tag for $branch" "tag-$branch"=0A    git chec=
kout "$branch"=0A    git merge --ff-only "$branch-tag"=0A=0A    # Sync with=
 `main`=0A    git checkout main=0A    git merge --no-edit --no-ff -s ours "=
$branch"=0A    git checkout "$base"=0A}=0A=0Amake_branch release=0A=0Agit c=
heckout main=0Adescribe=3D"$( git describe )"=0Areadonly describe=0A=0Acase=
 "$describe" in=0A    tag-prev-*)=0A        echo "failed: found 'tag-prev-'=
"=0A        exit 1=0A        ;;=0A    tag-*)=0A        echo "success"=0A   =
     :=0A        ;;=0Aesac=0A
--5SxREHz53H5LeiFL
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="describe-trace.diff"

diff --git a/builtin/describe.c b/builtin/describe.c
index b28a4a1f82..5895d1af3a 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -264,8 +264,10 @@ static unsigned long finish_depth_computation(
 			}
 			if (!a)
 				break;
-		} else
+		} else {
 			best->depth++;
+			fprintf(stderr, "pushing depth of %s (finish_depth_computation): %d\n", oid_to_hex(&c->object.oid), best->depth);
+		}
 		while (parents) {
 			struct commit *p = parents->item;
 			repo_parse_commit(the_repository, p);
@@ -363,19 +365,24 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		struct commit_list *parents = c->parents;
 		struct commit_name **slot;
 
+		fprintf(stderr, "\n\nlooking at commit %s\n", oid_to_hex(&c->object.oid));
 		seen_commits++;
 		slot = commit_names_peek(&commit_names, c);
 		n = slot ? *slot : NULL;
 		if (n) {
 			if (!tags && !all && n->prio < 2) {
+				fprintf(stderr, "skipping unannotated tag %s\n", oid_to_hex(&c->object.oid));
 				unannotated_cnt++;
 			} else if (match_cnt < max_candidates) {
 				struct possible_tag *t = &all_matches[match_cnt++];
 				t->name = n;
 				t->depth = seen_commits - 1;
+				fprintf(stderr, "depth of %s: %d\n", oid_to_hex(&c->object.oid), t->depth);
 				t->flag_within = 1u << match_cnt;
 				t->found_order = match_cnt;
+				fprintf(stderr, "find order of %s: %d\n", oid_to_hex(&c->object.oid), t->found_order);
 				c->object.flags |= t->flag_within;
+				fprintf(stderr, "setting flag %x for commit %s\n", t->flag_within, oid_to_hex(&c->object.oid));
 				if (n->prio == 2)
 					annotated_cnt++;
 			}
@@ -386,11 +393,15 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		}
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
-			if (!(c->object.flags & t->flag_within))
+			if (!(c->object.flags & t->flag_within)) {
 				t->depth++;
+				fprintf(stderr, "flag for %s: %x\n", oid_to_hex(&c->object.oid), c->object.flags);
+				fprintf(stderr, "pushing depth of %s because of %s (flag_within): %d\n", oid_to_hex(&t->name->peeled), oid_to_hex(&c->object.oid), t->depth);
+			}
 		}
 		/* Stop if last remaining path already covered by best candidate(s) */
 		if (annotated_cnt && !list) {
+			fprintf(stderr, "checking for best candidate\n");
 			int best_depth = INT_MAX;
 			unsigned best_within = 0;
 			for (cur_match = 0; cur_match < match_cnt; cur_match++) {
@@ -415,6 +426,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 			if (!(p->object.flags & SEEN))
 				commit_list_insert_by_date(p, &list);
 			p->object.flags |= c->object.flags;
+			fprintf(stderr, "setting flag %x for commit %s due to ancestry\n", p->object.flags, oid_to_hex(&p->object.oid));
 			parents = parents->next;
 
 			if (first_parent)

--5SxREHz53H5LeiFL--
