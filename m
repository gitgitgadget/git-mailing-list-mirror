Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED3C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8842396F
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 14:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbhAHOqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAHOqA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 09:46:00 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EBEC061380
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 06:45:20 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x126so6368988pfc.7
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 06:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRPiB31Eln29WE7xRLCN6SfhrCiBp/1D8UShEp9+kcI=;
        b=k3GS6k2QmqcIGdiOw6SlagiG/ktUXkLVFnyMMIUHrAdUCNz4FX0FIy+VHvQuJ6QOo9
         O/UqDITap5YUQvwmYSyBZwIYg0UPUXBA6MrHuwXaeEq3rrsWCK3VfbOsuSbXAyMZgOLk
         bUHwUfnfMuCTuyZgncbVsJdIuY9htg9VzEnynCqkj2e3RIln1qBQ63iME/iRVEvSYh0W
         Ff8+EVEOJQp+yPobiO+92wmG0bcleCbST46YkPMJJWPhqif1zGXcV32EOivSgBH1Db9p
         L7erPxJIR47eHft6Tf/GdFi3U2koFZ/hR4YyUAvo7oj7tr9IyfQAzuhUajD8LIZuVZ5M
         7MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRPiB31Eln29WE7xRLCN6SfhrCiBp/1D8UShEp9+kcI=;
        b=bw+PlVSVKpOnfjLT9Kktq9KHuApxobOK5PhTCYj/4k+fHjoYpIYq2aqMQJ+VNdBfnv
         7VXzeJNiL4qMGJ+E1HbaXTKxCPoDw+cSdD+hiIzZM51o/LZmoUzfz7dR3YzEiQF1ABMU
         RUH0LUWSRFy6rWxQ0vtSL39a4la5X3QsulADCbvIPUIXkHUCAgxT4HvkRkF8ElUZutqx
         4G3TKjQ4qqSBUMKvSIbJ8NlvfmrwcrQYyW31BNG4d+HxqKy7tVdjhVRoQRPkqd9OR0Jj
         VgCIolA6juXoZtEQbf9WijTJvsQQ5R/EqKzU9yvYeB5vbgf/x84uB7650voE/mMunUB0
         giYA==
X-Gm-Message-State: AOAM5332u+OIAMnqfSHI2to0vfr+f8q7cDEJbbB5azMkJc0ynTcUD+6z
        BN23R5fwVsBhHHqKXYmP26E=
X-Google-Smtp-Source: ABdhPJxfv8b7WU58TqujWT+GSEsxs2UjxLRzB1pLRMRc5ukIW4o54WhfRc4GeN7UHrUJ3Lbh3gN07A==
X-Received: by 2002:aa7:8499:0:b029:19e:6c5:b103 with SMTP id u25-20020aa784990000b029019e06c5b103mr3883371pfn.13.1610117119785;
        Fri, 08 Jan 2021 06:45:19 -0800 (PST)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q15sm9471894pgk.11.2021.01.08.06.45.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 06:45:19 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 0/2] Improvements for git-bundle
Date:   Fri,  8 Jan 2021 09:45:12 -0500
Message-Id: <20210108144514.24805-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <X/cqrTgilKAW9P9G@danh.dev>
References: <X/cqrTgilKAW9P9G@danh.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Two improvements for git-bundle

1. Commit "bundle: lost objects when removing duplicate pendings",
   which fixes command like:

        $ git bundle create <file> 'master^!'
  
2. Commits "bundle: arguments can be read from stdin",
   which add "--stdin" option support for git-bundle, like:

        $ git bundle create <file> <input


## Changes of v4

+ Refactor t6020.


## Range diff of v3...v4

1:  9df48434f3 ! 1:  0abad6486a bundle: lost objects when removing duplicate pendings
    @@ t/t6020-bundle-misc.sh (new)
     +
     +. ./test-lib.sh
     +
    ++# Check count of objects in a bundle file.
    ++# We can use "--thin" opiton to check thin pack, which must be fixed by
    ++# command `git-index-pack --fix-thin --stdin`.
     +test_bundle_object_count () {
    ++	thin= &&
    ++	if test "$1" = "--thin"
    ++	then
    ++		thin=yes
    ++		shift
    ++	fi &&
    ++	if test $# -ne 2
    ++	then
    ++		echo >&2 "args should be: <bundle> <count>"
    ++		return 1
    ++	fi
     +	bundle=$1 &&
     +	pack=${bundle%.bdl}.pack &&
     +	convert_bundle_to_pack <"$bundle" >"$pack" &&
    -+	git index-pack "$pack" &&
    -+	git verify-pack -v "$pack" >verify.out &&
    -+	count=$(grep "^$OID_REGEX " verify.out | wc -l) &&
    ++	if test -n "$thin"
    ++	then
    ++		test_must_fail git index-pack "$pack" &&
    ++		mv "$pack" "$pack"-thin &&
    ++		cat "$pack"-thin |
    ++			git index-pack --stdin --fix-thin "$pack"
    ++	else
    ++		git index-pack "$pack"
    ++	fi &&
    ++	git verify-pack -v "$pack" >verify.out
    ++	if test $? -ne 0
    ++	then
    ++		echo >&2 "error: fail to convert $bundle to $pack"
    ++		return 1
    ++	fi
    ++	count=$(grep -c "^$OID_REGEX " verify.out) &&
     +	test $2 = $count && return 0
    -+	echo object count for $bundle is $count, not $2
    -+	return 1
    -+}
    -+
    -+
    -+test_thin_bundle_object_count () {
    -+	bundle=$1 &&
    -+	pack=${bundle%.bdl}.pack &&
    -+	convert_bundle_to_pack <"$bundle" |
    -+		test_must_fail git index-pack --stdin "$pack" &&
    -+	rm -f "$pack" &&
    -+	convert_bundle_to_pack <"$bundle" |
    -+		git index-pack --stdin --fix-thin "$pack" &&
    -+	git verify-pack -v "$pack" >verify.out &&
    -+	count=$(grep "^$OID_REGEX " verify.out | wc -l) &&
    -+	test $2 = $count && return 0
    -+	echo object count for $bundle is $count, not $2
    ++	echo >&2 "error: object count for $bundle is $count, not $2"
     +	return 1
     +}
     +
    ++# Display the pack data contained in the bundle file, bypassing the
    ++# header that contains the signature, prerequisites and references.
     +convert_bundle_to_pack () {
     +	while read x && test -n "$x"
     +	do
    @@ t/t6020-bundle-misc.sh (new)
     +	cat
     +}
     +
    ++# Create a commit or tag and set the variable with the object ID.
    ++test_commit_setvar () {
    ++	notick= &&
    ++	signoff= &&
    ++	indir= &&
    ++	merge= &&
    ++	tag= &&
    ++	var= &&
    ++	while test $# != 0
    ++	do
    ++		case "$1" in
    ++		--merge)
    ++			merge=yes
    ++			;;
    ++		--tag)
    ++			tag=yes
    ++			;;
    ++		--notick)
    ++			notick=yes
    ++			;;
    ++		--signoff)
    ++			signoff="$1"
    ++			;;
    ++		-C)
    ++			indir="$2"
    ++			shift
    ++			;;
    ++		-*)
    ++			echo >&2 "error: unknown option $1"
    ++			return 1
    ++			;;
    ++		*)
    ++			test -n "$var" && break
    ++			var=$1
    ++			;;
    ++		esac
    ++		shift
    ++	done &&
    ++	indir=${indir:+"$indir"/} &&
    ++	if test $# -eq 0
    ++	then
    ++		echo >&2 "no args provided"
    ++		return 1
    ++	fi &&
    ++	if test -z "$notick"
    ++	then
    ++		test_tick
    ++	fi &&
    ++	if test -n "$merge"
    ++	then
    ++		git ${indir:+ -C "$indir"} merge --no-edit --no-ff \
    ++			${2:+-m "$2"} "$1" &&
    ++		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
    ++	elif test -n "$tag"
    ++	then
    ++		git ${indir:+ -C "$indir"} tag -m "$1" "$1" &&
    ++		oid=$(git ${indir:+ -C "$indir"} rev-parse "$1")
    ++	else
    ++		file=${2:-"$1.t"} &&
    ++		echo "${3-$1}" > "$indir$file" &&
    ++		git ${indir:+ -C "$indir"} add "$file" &&
    ++		git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
    ++		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
    ++	fi &&
    ++	eval $var=$oid
    ++}
    ++
    ++
     +# Format the output of git commands to make a user-friendly and stable
     +# text.  We can easily prepare the expect text without having to worry
     +# about future changes of the commit ID and spaces of the output.
     +make_user_friendly_and_stable_output () {
     +	sed \
    -+		-e "s/ *\$//" \
    -+		-e "s/$A/<COMMIT-A>/g" \
    -+		-e "s/$B/<COMMIT-B>/g" \
    -+		-e "s/$C/<COMMIT-C>/g" \
    -+		-e "s/$D/<COMMIT-D>/g" \
    -+		-e "s/$E/<COMMIT-E>/g" \
    -+		-e "s/$F/<COMMIT-F>/g" \
    -+		-e "s/$G/<COMMIT-G>/g" \
    -+		-e "s/$H/<COMMIT-H>/g" \
    -+		-e "s/$I/<COMMIT-I>/g" \
    -+		-e "s/$J/<COMMIT-J>/g" \
    -+		-e "s/$K/<COMMIT-K>/g" \
    -+		-e "s/$L/<COMMIT-L>/g" \
    -+		-e "s/$M/<COMMIT-M>/g" \
    -+		-e "s/$N/<COMMIT-N>/g" \
    -+		-e "s/$O/<COMMIT-O>/g" \
    -+		-e "s/$P/<COMMIT-P>/g" \
    ++		-e "s/$A/<COMMIT-A>/" \
    ++		-e "s/$B/<COMMIT-B>/" \
    ++		-e "s/$C/<COMMIT-C>/" \
    ++		-e "s/$D/<COMMIT-D>/" \
    ++		-e "s/$E/<COMMIT-E>/" \
    ++		-e "s/$F/<COMMIT-F>/" \
    ++		-e "s/$G/<COMMIT-G>/" \
    ++		-e "s/$H/<COMMIT-H>/" \
    ++		-e "s/$I/<COMMIT-I>/" \
    ++		-e "s/$J/<COMMIT-J>/" \
    ++		-e "s/$K/<COMMIT-K>/" \
    ++		-e "s/$L/<COMMIT-L>/" \
    ++		-e "s/$M/<COMMIT-M>/" \
    ++		-e "s/$N/<COMMIT-N>/" \
    ++		-e "s/$O/<COMMIT-O>/" \
    ++		-e "s/$P/<COMMIT-P>/" \
    ++		-e "s/$TAG1/<TAG-1>/" \
    ++		-e "s/$TAG2/<TAG-2>/" \
    ++		-e "s/$TAG3/<TAG-3>/" \
     +		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
     +		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
     +		-e "s/$(echo $C | cut -c1-7)[0-9a-f]*/<OID-C>/g" \
    @@ t/t6020-bundle-misc.sh (new)
     +		-e "s/$(echo $N | cut -c1-7)[0-9a-f]*/<OID-N>/g" \
     +		-e "s/$(echo $O | cut -c1-7)[0-9a-f]*/<OID-O>/g" \
     +		-e "s/$(echo $P | cut -c1-7)[0-9a-f]*/<OID-P>/g" \
    -+		-e "s/$TAG1/<TAG-1>/g" \
    -+		-e "s/$TAG2/<TAG-2>/g" \
    -+		-e "s/$TAG3/<TAG-3>/g" \
     +		-e "s/$(echo $TAG1 | cut -c1-7)[0-9a-f]*/<OID-TAG-1>/g" \
     +		-e "s/$(echo $TAG2 | cut -c1-7)[0-9a-f]*/<OID-TAG-2>/g" \
     +		-e "s/$(echo $TAG3 | cut -c1-7)[0-9a-f]*/<OID-TAG-3>/g" \
    -+		-e "s/$ZERO_OID/<ZERO-OID>/g"
    ++		-e "s/ *\$//"
     +}
     +
     +#            (C)   (D, pull/1/head, topic/1)
    @@ t/t6020-bundle-misc.sh (new)
     +# (A)   (B)  (E, tag:v1) (I)  (J)                  (K)       (O)   (P)
     +#
     +test_expect_success 'setup' '
    -+	# commit A & B
    -+	cat >main.txt <<-EOF &&
    -+		Commit A
    -+		EOF
    -+	git add main.txt &&
    -+	test_tick &&
    -+	git commit -m "Commit A" &&
    ++	# Try to make a stable fixed width for abbreviated commit ID,
    ++	# this fixed-width oid will be replaced with "<OID>".
    ++	git config core.abbrev 7 &&
     +
    -+	cat >main.txt <<-EOF &&
    -+		Commit B
    -+		EOF
    -+	git add main.txt &&
    -+	test_tick &&
    -+	git commit -m "Commit B" &&
    -+	A=$(git rev-parse HEAD~) &&
    -+	B=$(git rev-parse HEAD) &&
    ++	# branch main: commit A & B
    ++	test_commit_setvar A "Commit A" main.txt &&
    ++	test_commit_setvar B "Commit B" main.txt &&
     +
    -+	# branch topic/1
    ++	# branch topic/1: commit C & D, refs/pull/1/head
     +	git checkout -b topic/1 &&
    -+	cat >topic-1.txt <<-EOF &&
    -+		Commit C
    -+		EOF
    -+	git add topic-1.txt &&
    -+	test_tick &&
    -+	git commit -m "Commit C" &&
    -+
    -+	cat >topic-1.txt <<-EOF &&
    -+		Commit D
    -+		EOF
    -+	git add -u &&
    -+	test_tick &&
    -+	git commit -m "Commit D" &&
    ++	test_commit_setvar C "Commit C" topic-1.txt &&
    ++	test_commit_setvar D "Commit D" topic-1.txt &&
     +	git update-ref refs/pull/1/head HEAD &&
    -+	C=$(git rev-parse topic/1~) &&
    -+	D=$(git rev-parse topic/1) &&
     +
    -+	# commit E
    ++	# branch topic/1: commit E, tag v1
     +	git checkout main &&
    -+	cat >main.txt <<-EOF &&
    -+		Commit E
    -+		EOF
    -+	git add main.txt &&
    -+	test_tick &&
    -+	git commit -m "Commit E" &&
    -+	E=$(git rev-parse HEAD) &&
    -+	test_tick &&
    -+	git tag -m "v1" v1 HEAD &&
    -+	TAG1=$(git rev-parse refs/tags/v1) &&
    -+
    -+	# branch topic/2
    -+	git checkout -b topic/2 &&
    -+	cat >topic-2.txt <<-EOF &&
    -+		Commit F
    -+		EOF
    -+	git add topic-2.txt &&
    -+	test_tick &&
    -+	git commit -m "Commit F" &&
    ++	test_commit_setvar E "Commit E" main.txt &&
    ++	test_commit_setvar TAG1 --tag v1 &&
     +
    -+	cat >topic-2.txt <<-EOF &&
    -+		Commit G
    -+		EOF
    -+	git add -u &&
    -+	test_tick &&
    -+	git commit -m "Commit G" &&
    ++	# branch topic/2: commit F & G, refs/pull/2/head
    ++	git checkout -b topic/2 &&
    ++	test_commit_setvar F "Commit F" topic-2.txt &&
    ++	test_commit_setvar G "Commit G" topic-2.txt &&
     +	git update-ref refs/pull/2/head HEAD &&
    ++	test_commit_setvar H "Commit H" topic-2.txt &&
     +
    -+	cat >topic-2.txt <<-EOF &&
    -+		Commit H
    -+		EOF
    -+	git add -u &&
    -+	test_tick &&
    -+	git commit -m "Commit H" &&
    -+	F=$(git rev-parse topic/2~2) &&
    -+	G=$(git rev-parse topic/2~) &&
    -+	H=$(git rev-parse topic/2) &&
    -+
    -+	# merge commit I & J
    ++	# branch main: merge commit I & J
     +	git checkout main &&
    -+	test_tick &&
    -+	git merge --no-ff --no-edit topic/1 &&
    -+	test_tick &&
    -+	git merge --no-ff --no-edit refs/pull/2/head &&
    -+	I=$(git rev-parse HEAD~) &&
    -+	J=$(git rev-parse HEAD) &&
    -+
    -+	# commit K
    ++	test_commit_setvar I --merge topic/1 "Merge commit I" &&
    ++	test_commit_setvar J --merge refs/pull/2/head "Merge commit J" &&
    ++
    ++	# branch main: commit K
     +	git checkout main &&
    -+	cat >main.txt <<-EOF &&
    -+		Commit K
    -+		EOF
    -+	git add main.txt &&
    -+	test_tick &&
    -+	git commit -m "Commit K" &&
    -+	K=$(git rev-parse HEAD) &&
    ++	test_commit_setvar K "Commit K" main.txt &&
     +
    -+	# branch release
    ++	# branch release:
     +	git checkout -b release &&
    -+	cat >release.txt <<-EOF &&
    -+		Commit L
    -+		EOF
    -+	git add release.txt &&
    -+	test_tick &&
    -+	git commit -m "Commit L" &&
    ++	test_commit_setvar L "Commit L" release.txt &&
    ++	test_commit_setvar M "Commit M" release.txt &&
    ++	test_commit_setvar TAG2 --tag v2 &&
    ++	test_commit_setvar N "Commit N" release.txt &&
    ++	test_commit_setvar TAG3 --tag v3 &&
     +
    -+	cat >release.txt <<-EOF &&
    -+		Commit M
    -+		EOF
    -+	git add -u &&
    -+	test_tick &&
    -+	git commit -m "Commit M" &&
    -+	test_tick &&
    -+	git tag -m "v2" v2 HEAD &&
    -+
    -+	cat >release.txt <<-EOF &&
    -+		Commit N
    -+		EOF
    -+	git add -u &&
    -+	test_tick &&
    -+	git commit -m "Commit N" &&
    -+	test_tick &&
    -+	git tag -m "v3" v3 HEAD &&
    -+	L=$(git rev-parse HEAD~2) &&
    -+	M=$(git rev-parse HEAD~) &&
    -+	N=$(git rev-parse HEAD) &&
    -+	TAG2=$(git rev-parse refs/tags/v2) &&
    -+	TAG3=$(git rev-parse refs/tags/v3) &&
    -+
    -+	# merge commit O
    -+	git checkout main &&
    -+	test_tick &&
    -+	git merge --no-ff --no-edit tags/v2 &&
    -+	O=$(git rev-parse HEAD) &&
    -+
    -+	# commit P
    ++	# branch main: merge commit O, commit P
     +	git checkout main &&
    -+	cat >main.txt <<-EOF &&
    -+		Commit P
    -+		EOF
    -+	git add main.txt &&
    -+	test_tick &&
    -+	git commit -m "Commit P" &&
    -+	P=$(git rev-parse HEAD)
    ++	test_commit_setvar O --merge tags/v2 "Merge commit O" &&
    ++	test_commit_setvar P "Commit P" main.txt
     +'
     +
     +test_expect_success 'create bundle from special rev: main^!' '
    @@ t/t6020-bundle-misc.sh (new)
     +'
     +
     +test_expect_success 'create bundle with --since option' '
    ++	since="Thu Apr 7 15:26:13 2005 -0700" &&
    ++	git log -1 --pretty="%ad" $M >actual &&
    ++	echo "$since" >expect &&
    ++	test_cmp expect actual &&
    ++
     +	git bundle create since.bdl \
    -+		--since "Thu Apr 7 15:26:13 2005 -0700" \
    -+		--all &&
    ++		--since "$since" --all &&
     +
     +	git bundle list-heads since.bdl |
     +		make_user_friendly_and_stable_output >actual &&
    @@ t/t6020-bundle-misc.sh (new)
     +		EOF
     +	test_i18ncmp expect actual &&
     +
    -+	test_thin_bundle_object_count since.bdl 16
    ++	test_bundle_object_count --thin since.bdl 16
     +'
     +
     +test_expect_success 'create bundle 1 - no prerequisites' '
2:  86ad41e4d4 = 2:  48ef4aa44e bundle: arguments can be read from stdin

--
Jiang Xin (2):
  bundle: lost objects when removing duplicate pendings
  bundle: arguments can be read from stdin

 bundle.c                | 111 ++++----
 object.c                |  10 +-
 t/t5607-clone-bundle.sh |   4 +-
 t/t6020-bundle-misc.sh  | 546 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 614 insertions(+), 57 deletions(-)
 create mode 100755 t/t6020-bundle-misc.sh

-- 
2.30.0.2.g06d2f50715

