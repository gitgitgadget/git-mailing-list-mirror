Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134F5C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 11:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbiAXLbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbiAXLbk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 06:31:40 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134BFC06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 03:31:40 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id me13so20563406ejb.12
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 03:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xPBXAuR0ldmifP8J+WSI3/isqZeZFbRiYdOC++s4nbM=;
        b=c3fTJAT8vBsGqfg4J+yhSZGsKNO/T4yBoRzYIeinzDpIQGiHFlLGbn40Ppqyla9Keu
         WucMYZcdlp7almAVAzMvYPsZSAuEATVp8g4ytmmdNDA2imHmsefhXGUwKBtLXYbEtVd1
         lRQaJkID9e9jObz3UtAx0bmLxgIzGR1aP81qbB0W1mXPpp/Dp7/tm+QMOmiU2yZPqNVw
         MlQkRR3t7ZhNWdQsckjTbaDJY94TjrEHGK0/rNQejQXJoLCZwwjpvaYDOFCbVWPC6KqO
         G6QOcxdjaR/9qwGbJJe67vhZPG6+7bKb9k4CH7VKW+0ZjfbbAnU1ta6CPDXynQbYPFCt
         ABKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xPBXAuR0ldmifP8J+WSI3/isqZeZFbRiYdOC++s4nbM=;
        b=hoRHk2pJDM12CzqWMxdtjKyOQr9r3lqQv0ju93tt1rXzxQf2+7hMNfiveWx3dvfUCQ
         WSHtnp5HcHsMET1FrKCTQY8IbUNnRLwalIvwB8JOzn3h+gHSMSp8XOysfJvd66cregly
         dbnBE5V3HmV4nnRLeJj2M6nzASHezrRI2E511OmvRLgZmuVzVsZA8NIJZZ0OKU8Nrfyr
         lsVjG4LDueuqqDzLbls+Lm/+19dIvbzLa0TAPk+edv9eJWITWeTmWOCuRJiqwKOCSVxV
         ecph8WvXycRihN4IDNa6Y/hHgfiTWvHJSXrXEfXCREWjSq3zpTpFV1EKRiLv+sAKzuGb
         /vxw==
X-Gm-Message-State: AOAM532Qn/MZxWCJe692rRZ3kVEeGi2tY3N4/3ukNqFH+f+Nw3GLxp7S
        nveNBzsz5kItfTQ9GNetIS4=
X-Google-Smtp-Source: ABdhPJy7iPM+TdB3yG8XoCJJc4TimBu08d0j6brdaxToXU2v3LLlJDRw+dkeo0yTefwcSu0X4+rB2Q==
X-Received: by 2002:a17:906:1e09:: with SMTP id g9mr11645074ejj.37.1643023897826;
        Mon, 24 Jan 2022 03:31:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p2sm6454364edy.73.2022.01.24.03.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 03:31:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nBxZQ-002SoM-OV;
        Mon, 24 Jan 2022 12:31:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, jabolopes@google.com
Subject: Re: [PATCH v2] sparse-checkout: create leading directory
Date:   Mon, 24 Jan 2022 12:17:38 +0100
References: <20220120185548.3648549-1-jonathantanmy@google.com>
 <20220121174441.3991963-1-jonathantanmy@google.com>
 <220121.8635lgkj17.gmgdl@evledraar.gmail.com>
 <CABPp-BHgRQ+qNvq19wsBsMCR+Cn7FS+0FMYXVyyzEAZTsg-wjA@mail.gmail.com>
 <220122.86tudwht17.gmgdl@evledraar.gmail.com>
 <CABPp-BG5WzgcEwxnjraEN-SEKxUUvz-wD68afjQd_sWFe6R=Vg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BG5WzgcEwxnjraEN-SEKxUUvz-wD68afjQd_sWFe6R=Vg@mail.gmail.com>
Message-ID: <220124.86zgnlgyjr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 22 2022, Elijah Newren wrote:

> On Sat, Jan 22, 2022 at 4:08 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Fri, Jan 21 2022, Elijah Newren wrote:
>>
>> > On Fri, Jan 21, 2022 at 6:12 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> > <avarab@gmail.com> wrote:
>> >>
>> >> On Fri, Jan 21 2022, Jonathan Tan wrote:
>> >>
> ...
>> >> > =C3=86var mentioned "git sparse-checkout add" but I think that that=
 is a
>> >> > different problem - in the "git sparse-checkout init" case, we coul=
d get
>> >> > into this case with a template that does not have .git/info, but in=
 the
>> >> > "git sparse-checkout add" case, the user would have had to explicit=
ly
>> >> > remove the info directory. So I'll limit this patch to the "init" c=
ase,
>> >> > for now.
>> > ...
>> >>
>> >> I agree that it's a slightly different problem, but I was just
>> >> advocating for us testing what happened in these cases.
>> >>
>> >> The below fix-up does that.
>> >
>> > Different problem...addressed with a "fix-up"?  Why would we squash
>> > extra testing of a different problem into the same commit?  I think
>> > it'd at least deserve its own commit message.
>>
>> Sure, or split up, or with an amended commit message etc.
>
> I think it's a totally different kind of thing and wouldn't belong in
> the same commit even with an amended commit message.  I'm curious why
> we're so far apart on this and whether I'm missing something.

I think I'm biased by my initial look at this problem[1], which was to look
at the various "sparse_filename" callers and their non-coverage. In my
mind fixing & testing for that general problem would make for a nice
atomic change.

> ...
>> >> +test_expect_success 'git sparse-checkout add -- info/sparse-checkout=
 missing' '
>> >> +       test_when_finished "rm -rf empty" &&
>> >> +       git init --template=3D empty &&
>> >> +       git -C empty sparse-checkout init &&
>> >> +       rm -rf empty/.git/info &&
>> >> +
>> >> +       cat >expect <<-\EOF &&
>> >> +       fatal: unable to load existing sparse-checkout patterns
>> >> +       EOF
>> >> +       test_expect_code 128 git -C empty sparse-checkout add bar 2>a=
ctual &&
>> >> +       test_cmp expect actual
>> >> +'
>> >> +
>> >> +test_expect_success 'git sparse-checkout list -- info/sparse-checkou=
t missing' '
>> >> +       test_when_finished "rm -rf empty" &&
>> >> +       git init --template=3D empty &&
>> >> +       git -C empty sparse-checkout init &&
>> >> +       rm -rf empty/.git/info &&
>> >> +
>> >> +       cat >expect <<-\EOF &&
>> >> +       warning: this worktree is not sparse (sparse-checkout file ma=
y not exist)
>> >> +       EOF
>> >> +       git -C empty sparse-checkout list 2>actual &&
>> >> +       test_cmp expect actual
>> >> +'
>> >> +
>> >
>> > So...you're trying to test what happens when a user intentionally
>> > bricks their repository?
>>
>> I'm just saying that it's cheap to add a regression test for this
>> missing bit of related coverage, so why not add it?
>
> So, this is a slightly different issue than I was getting at before,
> but this feels slightly obstructionist to me.  Now, suggesting related
> improvements and ideas sounds totally fine; we should point those out
> -- once.  But pushing it again as though it needs to be addressed as
> part of the submission just doesn't feel right.  Jonathan's patch
> fixes a real problem and feels complete to me.  There are always
> additional things that could also be fixed or addressed for any patch
> or series.  Expecting folks submitting a series to address every "next
> step improvement along these lines" that any reviewer can think of
> seems unfriendly, especially as it has a snowball effect.
>
> Granted, if there's a bug with the patch, or it doesn't fully solve
> the stated problem, then it's a different situation, but I don't think
> that's the case here.  (Well, modulo the leftover removing of
> "blank-template" which is a real issue you identified with the patch.)

The first thing I said in this thread is "Thanks. This fix looks good to
me.". I'd be happy to have just this fix in. This patch resolves a
blocked of an earlier series of mine.

The rest of the feedback here (aside from the trivial "rm -rf" fix) was
an attempt to bridge the gap between this & my earlier look in [1].

> And I think I'd say the same thing even if I saw your tests as being
> much more closely related to what Jonathan was checking.
>
> That's my $0.02 on "why not?".  The story totally changes if you want
> to submit these tests separate from Jonathan's series.  If that's the
> scenario, then I fully agree with you on "it's cheap to add more test
> coverage so why not include it?"

Sure, or maybe he'd be interested, or not. I'd rather try to suggest
some small proposed changes than submit a patch of my own as an initial
approach.

> Anyway...back to my curiosity about why we're so far apart on the
> relatedness of your tests...
>
>> We need to deal with the real world, a repo might be in all sorts of odd
>> states, including because of a user mistake.
>
> So, Jonathan was fixing behavior seen when the user hadn't even made a
> mistake.  Opening up to all possible user mistakes seems to widening
> scope pretty dramatically and feels like a different kind of thing to
> me.  But even that scope doesn't seem to include the tests you've
> proposed, at least not to me.  Under what circumstances would your
> tests model a user mistake?  A user mistake to me looks like one of
> the following:
>
>   * "I hit Ctrl+C while a `git switch` or `git sparse-checkout set
> ...`  just happened to be furiously writing files"
>   * "I ran `git sparse-checkout (add|list|reapply)` without first
> running `git sparse-checkout (init|set)` as per the docs"
>
> Your tests look roughly the same class as the following kinds of things:
>
>   * echo garbage >.git/refs/heads/master
>   * rm .git/objects/${random_loose_object_or_pack}
>
> I know users can attempt surgery on $GIT_DIR, and that perhaps curious
> ones will do that to see how things break in order to help them
> understand how things work, but that seems to me to be a different
> realm.
>
> Note that I'm not saying we shouldn't test what happens when the repo
> is intentionally corrupted; there's probably merit in that.  I'm just
> curious why we're so far apart on this.  You view your tests as a
> "slightly different problem" and feel these tests could be included in
> Jonathan's commit with an "amended commit message".  I think they're
> not only different classes of problems, but separated by a third class
> ("user mistake") between the two types of problems.  If Jonathan had
> included your tests in his commit, I think I'd ask that they at
> _least_ be split into different commits.
>
> Am I missing the boat entirely somewhere?

I was using "fix-up" rather loosely upthread. FWIW I never meant that
this needed to be in the same commit, but was going for "this solves
some test blind spots in this adjacent area in nearby functions", or
something like that.

I'm all for splitting extra tests into another commit or whatever,
however that eventually lands in tree.

[...]

>> > (Note that `sparse-checkout init` sets core.sparseCheckout=3Dtrue, as
>> > explicitly documented.  core.sparseCheckout=3Dtrue instructs git to pay
>> > attention to $GIT_DIR/info/sparse-checkout for every unpack_trees()
>> > call that updates the working tree, which basically means nearly any
>> > significant Git operation involving a worktree update now needs that
>> > file in order to function.  So, your commands told Git that this
>> > directory is mandatory, and then you nuked the directory.)
>>
>> *nod*. But in that case shouldn't the errors say that you've configured
>> core.sparseCheckout=3Dtrue but you're missing XYZ file?
>
> Yeah, it probably should.
>
> I just did a little more testing and it looks like commands like
> "switch" don't even error out; they just treat the missing
> $GIT_DIR/info/sparse-checkout files the same as all files being
> included.  Weird.  It seems to come from dir.c:add_patterns(), which
> appears to have perhaps gotten that way due to assuming the code was
> exclusively about .gitignore files rather than the sparse-checkout
> file.  I think this may be yet another example of why it was a mistake
> to use gitignore-style patterns for the sparse-checkout feature,
> though I'm more than a decade too late with my complaints.
>
> Ugh.
>
> But yeah, you're right to suggest we should have tests for this, and
> perhaps some fixes as well...in a separate submission from this one.
> ;-)

FWIW I don't think it's all that important to focus too much on how
users would get into this scenario. Sure, for the "init" case it's a
thing that's broken with --template=3D, so that's more urgent.

But for the rest we're already carrying code for those edge cases (errno
handling and all), we just don't test for it.

So just adding tests seems prudent.

>> > Now, if you could find a testcase based on `git worktree add ...`
>> > (which doesn't create an "info" directory) and then triggers problems
>> > somehow without the intentional bricking, then what you'd have would
>> > be more in line with what Jonathan is addressing here, but as it
>> > stands it's hard to even call your testcases related.  There may be
>> > some merit to testing deliberately broken repositories, but I'm just
>> > not sure if that's what you really intended and were suggesting.  Was
>> > it?  Or am I just missing something here?
>>
>> Doesn't the worktree case just use the "main" info/*, e.g. for
>> info/excludes (didn't have time to test it now).
>
> Maybe for info/excludes, I don't know.  But it certainly won't use the
> main info/sparse-checkout; that'd be _horribly_ broken.  Each worktree
> should be allowed to have its own sparsity rules.  And having multiple
> worktrees where one worktree is not sparse, while others are sparse
> but with different sparsity patterns from each other (often only
> slightly different, but sometimes completely unrelated) is actually a
> common usecase.  We do that a lot at $DAYJOB.

1. https://lore.kernel.org/git/211220.86zgovt9bi.gmgdl@evledraar.gmail.com/

For what it's worth I rebased my earlier --no-template series locally on
this, and tried removing the creation of the "info" dir under
--no-template.

The below diff shows the fixes that were needed for info/sparse-checkout
as a result. Now I'm *not* saying this needs to be in this series or
whatever, it's just an FYI sanity check, i.e. this didn't reveal any
remaining cases where "git sparse-checkout" in whatever mode broke
unexpectedly without a .git/info.

These cases are just ones where we're manually setting up the sparse
checkout. Of course we may have missing coverage etc., but I think this
is one more datapoint in favor of this proposed change being a good one.

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-spars=
e-checkout.sh
index 24092c09a95..822d753bd95 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -53,6 +53,7 @@ test_expect_success 'read-tree without .git/info/sparse-c=
heckout' '
 '
=20
 test_expect_success 'read-tree with .git/info/sparse-checkout but disabled=
' '
+	mkdir .git/info &&
 	echo >.git/info/sparse-checkout &&
 	read_tree_u_must_succeed -m -u HEAD &&
 	git ls-files -t >result &&
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-sco=
pe.sh
index 3deb4901874..669b114db03 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -25,6 +25,7 @@ test_expect_success 'create feature branch' '
=20
 test_expect_success 'perform sparse checkout of main' '
 	git config --local --bool core.sparsecheckout true &&
+	mkdir .git/info &&
 	echo "!/*" >.git/info/sparse-checkout &&
 	echo "/a" >>.git/info/sparse-checkout &&
 	echo "/c" >>.git/info/sparse-checkout &&
@@ -66,6 +67,7 @@ test_expect_success 'in partial clone, sparse checkout on=
ly fetches needed blobs
 	git -C server commit -m message &&
=20
 	test_config -C client core.sparsecheckout 1 &&
+	mkdir client/.git/info &&
 	echo "!/*" >client/.git/info/sparse-checkout &&
 	echo "/a" >>client/.git/info/sparse-checkout &&
 	git -C client fetch --filter=3Dblob:none origin &&
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 3e93506c045..e1d9d0d3c7a 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -249,6 +249,7 @@ test_expect_success 'checkout -b to a new branch preser=
ves mergeable changes des
 	test_commit file2 &&
=20
 	echo stuff >>file1 &&
+	mkdir .git/info &&
 	echo file2 >.git/info/sparse-checkout &&
 	git config core.sparseCheckout true &&
=20
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict=
.sh
index 979e843c65a..dbd37147c63 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -558,6 +558,7 @@ test_expect_success 'cherry-pick preserves sparse-check=
out' '
 		echo \"/*\" >.git/info/sparse-checkout
 		git read-tree --reset -u HEAD
 		rm .git/info/sparse-checkout" &&
+	mkdir .git/info &&
 	echo /unrelated >.git/info/sparse-checkout &&
 	git read-tree --reset -u HEAD &&
 	test_must_fail git cherry-pick -Xours picked>actual &&
diff --git a/t/t6435-merge-sparse.sh b/t/t6435-merge-sparse.sh
index 74562e12356..6fd0bdf38ac 100755
--- a/t/t6435-merge-sparse.sh
+++ b/t/t6435-merge-sparse.sh
@@ -26,6 +26,7 @@ test_expect_success 'setup' '
 	git rm modify_delete &&
 	test_commit_this ours &&
 	git config core.sparseCheckout true &&
+	mkdir .git/info &&
 	echo "/checked-out" >.git/info/sparse-checkout &&
 	git reset --hard &&
 	test_must_fail git merge theirs
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-spa=
rse-gitmodules.sh
index f87e524d6d4..5cc0b7e700f 100755
--- a/t/t7418-submodule-sparse-gitmodules.sh
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -33,6 +33,7 @@ test_expect_success 'sparse checkout setup which hides .g=
itmodules' '
 	) &&
 	git clone upstream super &&
 	(cd super &&
+		mkdir .git/info &&
 		cat >.git/info/sparse-checkout <<-\EOF &&
 		/*
 		!/.gitmodules
