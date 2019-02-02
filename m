Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 339BC1F453
	for <e@80x24.org>; Sat,  2 Feb 2019 13:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfBBNan (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 08:30:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33519 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfBBNan (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 08:30:43 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so4310238pgu.0
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 05:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+5t13r3cDWitYp2sRVj6ZRnu/HZEkBHIDIjL9sQA2g=;
        b=SQ6lA48DNN5l8LT/X40JCHCK7MsmESqs8NPFglJi08JouBnYJ/Fq5xXMFLLzaP5Je2
         L4+dCPXo6yeIjQIoCkBFrOuULshDC2+9N7yQnD2cT7fEJNmG39yV7H/FAAbVzEHNPpbj
         uu4T7QjDDs/Zz8/OY+EcoTzaTeYETRQgRWtVbD9V6CGObt+UO75fneQiOEDdo4Qrptug
         eDdqgnWMxHqYjAFu7JggPLbIb7xQRMvszI5ZexQRh75vys+2NlRH+TYIEP3WjIg4CeKz
         +u8WTGSN06kcz5fxuJ3xyEDqpZTK0w66dHWS9YseOIDI6EpWnK12K+LoDXjpC/FUY/Rm
         hbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+5t13r3cDWitYp2sRVj6ZRnu/HZEkBHIDIjL9sQA2g=;
        b=fgJxucnNl+ezF9lBYpvRLkVqctHc09fsFMH3fEfl3EnaY7YK1GHiGIxCP/sLNnGuaB
         NZv1dE2ruyll/csYI5/nD2JvmOdb3Lzluwhsi2ErBtriitxAVtSrseXVi9sGtzBsVWaD
         817IkG6VjoTOE0rvV6skC1S95KqKHbiTYoxMt9bhkLhfgDdvOYwXviF6dsAadwiu/OuQ
         Crs7EICV4cInnyUdQo3jd4o7lflYcsFkFPCtcj7kUg5oUrud/8SgIE2O/4+1fiyJx8OD
         5Nbc9xAuEX4Ls55WQd5gq2r1OCarGtmGsFi1ltirxLsOztq6Clugnq4RVkR/fV8KnBo9
         6NLQ==
X-Gm-Message-State: AHQUAua+fi1sEfy/c7CwSnmUiLjpLz1bHJ9QuPizXEin0gmVxHoLbZJU
        QsH6wTsRddgbwmKUi9foR1E=
X-Google-Smtp-Source: AHgI3IYI5ZOhFTVr3qar2OxMviFk/oItMg2aTd7o3axxFEX7BhW/zNeWh2LO9IZVIUcdav+5NGTr8g==
X-Received: by 2002:a63:ee0e:: with SMTP id e14mr6019314pgi.8.1549114241903;
        Sat, 02 Feb 2019 05:30:41 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:c5:f1ee:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id t21sm12580010pgg.24.2019.02.02.05.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 05:30:40 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Sun Chao <16657101987@163.com>
Subject: [PATCH v10 0/6] pack-redundant: new algorithm to find min packs
Date:   Sat,  2 Feb 2019 21:30:11 +0800
Message-Id: <20190202133017.1039-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
References: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sun Chao (my former colleague at Huawei) found a bug of
git-pack-redundant.  If there are too many packs and many of them
overlap each other, running `git pack-redundant --all` will
exhaust all memories and the process will be killed by kernel.

There is a script in commit log of commit 3/6, which can be used to
create a repository with lots of redundant packs. Running `git
pack-redundant --all` in it can reproduce this issue.

## Changes since re-roll v9

Eric Sunshine <sunshine@sunshineco.com> 于2019年2月2日周六 上午3:43写道：
>
> On Fri, Feb 1, 2019 at 11:22 AM Jiang Xin <worldhello.net@gmail.com> wrote:
> > Add test cases for git pack-redundant to validate new algorithm for git
> > pack-redundant.
> >
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > ---
> > diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
> > @@ -0,0 +1,510 @@
> > +# Note: DO NOT run it in a subshell, otherwise the variables will not be set
>
> Which variables won't be set? It's not clear what this restriction is about.
>
> > +# Usage: create_commits_in <repo> A B C ...
> > +create_commits_in () {
> > +       repo="$1" &&
> > +       parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null) || parent=
>
> Broken &&-chain. Instead, perhaps:
>
>     if ! parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null)
>     then
>         parent=
>     fi &&
>
> or something simpler.

Fixed.

> > +       T=$(git -C "$repo" write-tree) &&
> > +       shift &&
> > +       while test $# -gt 0
> > +       do
> > +               name=$1 &&
> > +               test_tick &&
> > +               if test -z "$parent"
> > +               then
> > +                       oid=$(echo $name | git -C "$repo" commit-tree $T)
> > +               else
> > +                       oid=$(echo $name | git -C "$repo" commit-tree -p $parent $T)
> > +               fi &&
> > +               eval $name=$oid &&
> > +               parent=$oid &&
> > +               shift ||
> > +               return 1
> > +       done
>
> Broken &&-chain. Use:
>
>     done &&
>

Fixed, thanks.

> > It would have been easier for you to grok if the note instead said
> > "this function sets two global shell variables" or something,
> > perhaps?  Such a variable would certainly not be visible if this
> > function is called inside a subshell to the main process.
>
> Yes, better function comments would facilitate comprehension both for
> the reviewer and those working on the code in the future. For
> instance:
>
>     # Create commit for each argument [...with blah properties...] and
>     # assign [...] to shell variable of same name as argument.
>     # NOTE: Avoid calling this function from a subshell since variable
>     # assignments will disappear when subshell exits.

Polished comments for `create_commits_in` and `create_pack_in` helper
function.

>     create_pack_4 () {
>         ...
>         eval P$P4=P4:$P4
>     }
>    ...
>    test_expect_success 'create pack 4, 5' '
>         create_pack_4 && create_pack_5
>     '
>
> I haven't been able to convince myself that this helps readability --
> especially since the function definition is often far removed from the
> single point of use -- over merely inlining the function body directly
> in the sole test which calls it.

Use a new helper function `create_pack_in` to create packs near test 
functions.


## Range diff since v9:

1:  c8dbf8cef2 ! 1:  4719043603 t5323: test cases for git-pack-redundant
    @@ -43,8 +43,8 @@
     +    ALL | x x x x x x x x x x x x x x x x x x x
     +
     +Another repository `shared.git` has unique objects (X-Z), while other objects
    -+(marked with letter s) are shared through alt-odb (of `master.git`). The
    -+relationship between packs and objects is as follows:
    ++(marked with letter s) can be found in the shared alt-odb (of `master.git`).
    ++The relationship between packs and objects is as follows:
     +
     +        | T A B C D E F G H I J K L M N O P Q R   X Y Z
     +    ----+----------------------------------------------
    @@ -57,11 +57,19 @@
     +master_repo=master.git
     +shared_repo=shared.git
     +
    -+# Note: DO NOT run it in a subshell, otherwise the variables will not be set
    -+# Usage: create_commits_in <repo> A B C ...
    ++# Create commits in <repo> and assign each commit's oid to shell variables
    ++# given in the arguments (A, B, and C). E.g.:
    ++#
    ++#     create_commits_in <repo> A B C
    ++#
    ++# NOTE: Avoid calling this function from a subshell since variable
    ++# assignments will disappear when subshell exits.
     +create_commits_in () {
     +	repo="$1" &&
    -+	parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null) || parent=
    ++	if ! parent=$(git -C "$repo" rev-parse HEAD^{} 2>/dev/null)
    ++	then
    ++		parent=
    ++	fi &&
     +	T=$(git -C "$repo" write-tree) &&
     +	shift &&
     +	while test $# -gt 0
    @@ -78,101 +86,26 @@
     +		parent=$oid &&
     +		shift ||
     +		return 1
    -+	done
    ++	done &&
     +	git -C "$repo" update-ref refs/heads/master $oid
     +}
     +
    -+# Note: DO NOT run it in a subshell, otherwise the variables will not be set
    -+create_pack_1 () {
    -+	P1=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
    -+		$T
    -+		$A
    -+		$B
    -+		$C
    -+		$D
    -+		$E
    -+		$F
    -+		$R
    -+		EOF
    -+	) &&
    -+	eval P$P1=P1:$P1
    -+}
    -+
    -+create_pack_2 () {
    -+	P2=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
    -+		$B
    -+		$C
    -+		$D
    -+		$E
    -+		$G
    -+		$H
    -+		$I
    -+		EOF
    -+	) &&
    -+	eval P$P2=P2:$P2
    -+}
    -+
    -+create_pack_3 () {
    -+	P3=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
    -+		$F
    -+		$I
    -+		$J
    -+		$K
    -+		$L
    -+		$M
    -+		EOF
    -+	) &&
    -+	eval P$P3=P3:$P3
    -+}
    -+
    -+create_pack_4 () {
    -+	P4=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
    -+		$J
    -+		$K
    -+		$L
    -+		$M
    -+		$P
    -+		EOF
    -+	) &&
    -+	eval P$P4=P4:$P4
    -+}
    -+
    -+create_pack_5 () {
    -+	P5=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
    -+		$G
    -+		$H
    -+		$N
    -+		$O
    -+		EOF
    -+	) &&
    -+	eval P$P5=P5:$P5
    -+}
    -+
    -+create_pack_6 () {
    -+	P6=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
    -+		$N
    -+		$O
    -+		$Q
    -+		EOF
    -+	) &&
    -+	eval P$P6=P6:$P6
    -+}
    -+
    -+create_pack_7 () {
    -+	P7=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
    -+		$P
    -+		$Q
    -+		EOF
    -+	) &&
    -+	eval P$P7=P7:$P7
    -+}
    -+
    -+create_pack_8 () {
    -+	P8=$(git -C "$master_repo/objects/pack" pack-objects -q pack <<-EOF
    -+		$A
    -+		EOF
    -+	) &&
    -+	eval P$P8=P8:$P8
    ++# Create pack in <repo> and assign pack id to variable given in the 2nd argument
    ++# (<name>). Commits in the pack will be read from stdin. E.g.:
    ++#
    ++#     create_pack_in <repo> <name> <<-EOF
    ++#         ...
    ++#         EOF
    ++#
    ++# NOTE: commits from stdin should be given using heredoc, not using pipe, and
    ++# avoid calling this function from a subshell since variable assignments will
    ++# disappear when subshell exits.
    ++create_pack_in () {
    ++	repo="$1" &&
    ++	name="$2" &&
    ++	pack=$(git -C "$repo/objects/pack" pack-objects -q pack) &&
    ++	eval $name=$pack &&
    ++	eval P$pack=$name:$pack
     +}
     +
     +format_packfiles () {
    @@ -209,8 +142,34 @@
     +#     ALL | x x x x x x x x x x x x x x         x
     +#
     +#############################################################################
    -+test_expect_success 'no redundant for pack 1, 2, 3' '
    -+	create_pack_1 && create_pack_2 && create_pack_3 &&
    ++test_expect_success 'master: no redundant for pack 1, 2, 3' '
    ++	create_pack_in "$master_repo" P1 <<-EOF &&
    ++		$T
    ++		$A
    ++		$B
    ++		$C
    ++		$D
    ++		$E
    ++		$F
    ++		$R
    ++		EOF
    ++	create_pack_in "$master_repo" P2 <<-EOF &&
    ++		$B
    ++		$C
    ++		$D
    ++		$E
    ++		$G
    ++		$H
    ++		$I
    ++		EOF
    ++	create_pack_in "$master_repo" P3 <<-EOF &&
    ++		$F
    ++		$I
    ++		$J
    ++		$K
    ++		$L
    ++		$M
    ++		EOF
     +	(
     +		cd "$master_repo" &&
     +		git pack-redundant --all >out &&
    @@ -218,10 +177,6 @@
     +	)
     +'
     +
    -+test_expect_success 'create pack 4, 5' '
    -+	create_pack_4 && create_pack_5
    -+'
    -+
     +#############################################################################
     +# Chart of packs and objects for this test case
     +#
    @@ -236,7 +191,20 @@
     +#     ALL | x x x x x x x x x x x x x x x x x   x
     +#
     +#############################################################################
    -+test_expect_success 'one of pack-2/pack-3 is redundant' '
    ++test_expect_success 'master: one of pack-2/pack-3 is redundant' '
    ++	create_pack_in "$master_repo" P4 <<-EOF &&
    ++		$J
    ++		$K
    ++		$L
    ++		$M
    ++		$P
    ++		EOF
    ++	create_pack_in "$master_repo" P5 <<-EOF &&
    ++		$G
    ++		$H
    ++		$N
    ++		$O
    ++		EOF
     +	(
     +		cd "$master_repo" &&
     +		cat >expect <<-EOF &&
    @@ -248,10 +216,6 @@
     +	)
     +'
     +
    -+test_expect_success 'create pack 6, 7' '
    -+	create_pack_6 && create_pack_7
    -+'
    -+
     +#############################################################################
     +# Chart of packs and objects for this test case
     +#
    @@ -268,7 +232,16 @@
     +#     ALL | x x x x x x x x x x x x x x x x x x x
     +#
     +#############################################################################
    -+test_expect_success 'pack 2, 4, and 6 are redundant' '
    ++test_expect_success 'master: pack 2, 4, and 6 are redundant' '
    ++	create_pack_in "$master_repo" P6 <<-EOF &&
    ++		$N
    ++		$O
    ++		$Q
    ++		EOF
    ++	create_pack_in "$master_repo" P7 <<-EOF &&
    ++		$P
    ++		$Q
    ++		EOF
     +	(
     +		cd "$master_repo" &&
     +		cat >expect <<-EOF &&
    @@ -282,10 +255,6 @@
     +	)
     +'
     +
    -+test_expect_success 'create pack 8' '
    -+	create_pack_8
    -+'
    -+
     +#############################################################################
     +# Chart of packs and objects for this test case
     +#
    @@ -303,7 +272,10 @@
     +#     ALL | x x x x x x x x x x x x x x x x x x x
     +#
     +#############################################################################
    -+test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
    ++test_expect_success 'master: pack-8 (subset of pack-1) is also redundant' '
    ++	create_pack_in "$master_repo" P8 <<-EOF &&
    ++		$A
    ++		EOF
     +	(
     +		cd "$master_repo" &&
     +		cat >expect <<-EOF &&
    @@ -318,7 +290,7 @@
     +	)
     +'
     +
    -+test_expect_success 'clean loose objects' '
    ++test_expect_success 'master: clean loose objects' '
     +	(
     +		cd "$master_repo" &&
     +		git prune-packed &&
    @@ -327,7 +299,7 @@
     +	)
     +'
     +
    -+test_expect_success 'remove redundant packs and pass fsck' '
    ++test_expect_success 'master: remove redundant packs and pass fsck' '
     +	(
     +		cd "$master_repo" &&
     +		git pack-redundant --all | xargs rm &&
    @@ -347,7 +319,7 @@
     +	)
     +'
     +
    -+test_expect_success 'no redundant packs without --alt-odb' '
    ++test_expect_success 'shared: all packs are redundant, but no output without --alt-odb' '
     +	(
     +		cd "$shared_repo" &&
     +		git pack-redundant --all >out &&
    @@ -380,7 +352,7 @@
     +#     ALL | x x x x x x x x x x x x x x x x x x x
     +#
     +#############################################################################
    -+test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
    ++test_expect_success 'shared: show redundant packs in stderr for verbose mode' '
     +	(
     +		cd "$shared_repo" &&
     +		cat >expect <<-EOF &&
    @@ -396,7 +368,7 @@
     +	)
     +'
     +
    -+test_expect_success 'remove redundant packs by alt-odb, no packs left' '
    ++test_expect_success 'shared: remove redundant packs, no packs left' '
     +	(
     +		cd "$shared_repo" &&
     +		cat >expect <<-EOF &&
    @@ -409,10 +381,9 @@
     +	)
     +'
     +
    -+# Note: DO NOT run function `create_pack_*` in sub shell, or variables are not set
    -+create_pack_x1_in () {
    -+	repo="$1" &&
    -+	Px1=$(git -C "$repo/objects/pack" pack-objects -q pack <<-EOF
    ++test_expect_success 'shared: create new objects and packs' '
    ++	create_commits_in "$shared_repo" X Y Z &&
    ++	create_pack_in "$shared_repo" Px1 <<-EOF &&
     +		$X
     +		$Y
     +		$Z
    @@ -420,13 +391,7 @@
     +		$B
     +		$C
     +		EOF
    -+	) &&
    -+	eval P${Px1}=Px1:${Px1}
    -+}
    -+
    -+create_pack_x2_in () {
    -+	repo="$1" &&
    -+	Px2=$(git -C "$repo/objects/pack" pack-objects -q pack <<-EOF
    ++	create_pack_in "$shared_repo" Px2 <<-EOF
     +		$X
     +		$Y
     +		$Z
    @@ -434,17 +399,9 @@
     +		$E
     +		$F
     +		EOF
    -+	) &&
    -+	eval P${Px2}=Px2:${Px2}
    -+}
    -+
    -+test_expect_success 'create new objects and packs in shared.git' '
    -+	create_commits_in "$shared_repo" X Y Z &&
    -+	create_pack_x1_in "$shared_repo" &&
    -+	create_pack_x2_in "$shared_repo"
     +'
     +
    -+test_expect_success 'no redundant without --alt-odb' '
    ++test_expect_success 'shared: no redundant without --alt-odb' '
     +	(
     +		cd "$shared_repo" &&
     +		git pack-redundant --all >out &&
    @@ -475,7 +432,7 @@
     +#     ALL | s s s s s s s s s s s s s s s s s s s   x x x
     +#
     +#############################################################################
    -+test_expect_success 'one pack is redundant' '
    ++test_expect_success 'shared: one pack is redundant with --alt-odb' '
     +	(
     +		cd "$shared_repo" &&
     +		git pack-redundant --all --alt-odb >out &&
    @@ -508,7 +465,7 @@
     +#                                                  (ignored objects, marked with i)
     +#
     +#############################################################################
    -+test_expect_success 'set ignore objects and all two packs are redundant' '
    ++test_expect_success 'shared: ignore unique objects and all two packs are redundant' '
     +	(
     +		cd "$shared_repo" &&
     +		cat >expect <<-EOF &&
2:  a6300516d7 = 2:  4feb1eaa40 pack-redundant: delay creation of unique_objects
3:  fb71973df5 = 3:  875367d7b4 pack-redundant: delete redundant code
4:  9963d1c49f ! 4:  50cb2854f1 pack-redundant: new algorithm to find min packs
    @@ -331,35 +331,35 @@
      #     ALL | x x x x x x x x x x x x x x x x x   x
      #
      #############################################################################
    --test_expect_success 'one of pack-2/pack-3 is redundant' '
    -+test_expect_failure 'one of pack-2/pack-3 is redundant (failed on Mac)' '
    - 	(
    - 		cd "$master_repo" &&
    - 		cat >expect <<-EOF &&
    +-test_expect_success 'master: one of pack-2/pack-3 is redundant' '
    ++test_expect_failure 'master: one of pack-2/pack-3 is redundant (failed on Mac)' '
    + 	create_pack_in "$master_repo" P4 <<-EOF &&
    + 		$J
    + 		$K
     @@
      #     ALL | x x x x x x x x x x x x x x x x x x x
      #
      #############################################################################
    --test_expect_success 'pack 2, 4, and 6 are redundant' '
    -+test_expect_failure 'pack 2, 4, and 6 are redundant (failed on Mac)' '
    - 	(
    - 		cd "$master_repo" &&
    - 		cat >expect <<-EOF &&
    +-test_expect_success 'master: pack 2, 4, and 6 are redundant' '
    ++test_expect_failure 'master: pack 2, 4, and 6 are redundant (failed on Mac)' '
    + 	create_pack_in "$master_repo" P6 <<-EOF &&
    + 		$N
    + 		$O
     @@
      #     ALL | x x x x x x x x x x x x x x x x x x x
      #
      #############################################################################
    --test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
    -+test_expect_failure 'pack-8 (subset of pack-1) is also redundant (failed on Mac)' '
    - 	(
    - 		cd "$master_repo" &&
    - 		cat >expect <<-EOF &&
    +-test_expect_success 'master: pack-8 (subset of pack-1) is also redundant' '
    ++test_expect_failure 'master: pack-8 (subset of pack-1) is also redundant (failed on Mac)' '
    + 	create_pack_in "$master_repo" P8 <<-EOF &&
    + 		$A
    + 		EOF
     @@
      	)
      '
      
    --test_expect_success 'remove redundant packs and pass fsck' '
    -+test_expect_failure 'remove redundant packs and pass fsck (failed on Mac)' '
    +-test_expect_success 'master: remove redundant packs and pass fsck' '
    ++test_expect_failure 'master: remove redundant packs and pass fsck (failed on Mac)' '
      	(
      		cd "$master_repo" &&
      		git pack-redundant --all | xargs rm &&
    @@ -367,8 +367,8 @@
      	)
      '
      
    --test_expect_success 'no redundant packs without --alt-odb' '
    -+test_expect_failure 'no redundant packs without --alt-odb (failed on Mac)' '
    +-test_expect_success 'shared: all packs are redundant, but no output without --alt-odb' '
    ++test_expect_failure 'shared: all packs are redundant, but no output without --alt-odb (failed on Mac)' '
      	(
      		cd "$shared_repo" &&
      		git pack-redundant --all >out &&
    @@ -376,8 +376,8 @@
      #     ALL | x x x x x x x x x x x x x x x x x x x
      #
      #############################################################################
    --test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
    -+test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr (failed on Mac)' '
    +-test_expect_success 'shared: show redundant packs in stderr for verbose mode' '
    ++test_expect_failure 'shared: show redundant packs in stderr for verbose mode (failed on Mac)' '
      	(
      		cd "$shared_repo" &&
      		cat >expect <<-EOF &&
5:  b8f80ad454 = 5:  4af03876d4 pack-redundant: rename pack_list.all_objects
6:  8a12ad699e ! 6:  89ed4fb2a5 pack-redundant: consistent sort method
    @@ -96,8 +96,12 @@
      #     ALL | x x x x x x x x x x x x x x x x x   x
      #
      #############################################################################
    --test_expect_failure 'one of pack-2/pack-3 is redundant (failed on Mac)' '
    -+test_expect_success 'one of pack-2/pack-3 is redundant' '
    +-test_expect_failure 'master: one of pack-2/pack-3 is redundant (failed on Mac)' '
    ++test_expect_success 'master: one of pack-2/pack-3 is redundant' '
    + 	create_pack_in "$master_repo" P4 <<-EOF &&
    + 		$J
    + 		$K
    +@@
      	(
      		cd "$master_repo" &&
      		cat >expect <<-EOF &&
    @@ -110,26 +114,26 @@
      #     ALL | x x x x x x x x x x x x x x x x x x x
      #
      #############################################################################
    --test_expect_failure 'pack 2, 4, and 6 are redundant (failed on Mac)' '
    -+test_expect_success 'pack 2, 4, and 6 are redundant' '
    - 	(
    - 		cd "$master_repo" &&
    - 		cat >expect <<-EOF &&
    +-test_expect_failure 'master: pack 2, 4, and 6 are redundant (failed on Mac)' '
    ++test_expect_success 'master: pack 2, 4, and 6 are redundant' '
    + 	create_pack_in "$master_repo" P6 <<-EOF &&
    + 		$N
    + 		$O
     @@
      #     ALL | x x x x x x x x x x x x x x x x x x x
      #
      #############################################################################
    --test_expect_failure 'pack-8 (subset of pack-1) is also redundant (failed on Mac)' '
    -+test_expect_success 'pack-8 (subset of pack-1) is also redundant' '
    - 	(
    - 		cd "$master_repo" &&
    - 		cat >expect <<-EOF &&
    +-test_expect_failure 'master: pack-8 (subset of pack-1) is also redundant (failed on Mac)' '
    ++test_expect_success 'master: pack-8 (subset of pack-1) is also redundant' '
    + 	create_pack_in "$master_repo" P8 <<-EOF &&
    + 		$A
    + 		EOF
     @@
      	)
      '
      
    --test_expect_failure 'remove redundant packs and pass fsck (failed on Mac)' '
    -+test_expect_success 'remove redundant packs and pass fsck' '
    +-test_expect_failure 'master: remove redundant packs and pass fsck (failed on Mac)' '
    ++test_expect_success 'master: remove redundant packs and pass fsck' '
      	(
      		cd "$master_repo" &&
      		git pack-redundant --all | xargs rm &&
    @@ -137,8 +141,8 @@
      	)
      '
      
    --test_expect_failure 'no redundant packs without --alt-odb (failed on Mac)' '
    -+test_expect_success 'no redundant packs without --alt-odb' '
    +-test_expect_failure 'shared: all packs are redundant, but no output without --alt-odb (failed on Mac)' '
    ++test_expect_success 'shared: all packs are redundant, but no output without --alt-odb' '
      	(
      		cd "$shared_repo" &&
      		git pack-redundant --all >out &&
    @@ -146,8 +150,8 @@
      #     ALL | x x x x x x x x x x x x x x x x x x x
      #
      #############################################################################
    --test_expect_failure 'pack-redundant --verbose: show duplicate packs in stderr (failed on Mac)' '
    -+test_expect_success 'pack-redundant --verbose: show duplicate packs in stderr' '
    +-test_expect_failure 'shared: show redundant packs in stderr for verbose mode (failed on Mac)' '
    ++test_expect_success 'shared: show redundant packs in stderr for verbose mode' '
      	(
      		cd "$shared_repo" &&
      		cat >expect <<-EOF &&

--

Jiang Xin (4):
  t5323: test cases for git-pack-redundant
  pack-redundant: delay creation of unique_objects
  pack-redundant: rename pack_list.all_objects
  pack-redundant: consistent sort method

Sun Chao (2):
  pack-redundant: delete redundant code
  pack-redundant: new algorithm to find min packs

 builtin/pack-redundant.c  | 232 ++++++++-----------
 t/t5323-pack-redundant.sh | 467 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 559 insertions(+), 140 deletions(-)
 create mode 100755 t/t5323-pack-redundant.sh

-- 
2.20.1.103.ged0fc2ca7b

