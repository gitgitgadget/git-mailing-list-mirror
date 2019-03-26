Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1D620248
	for <e@80x24.org>; Tue, 26 Mar 2019 10:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfCZKKU (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 06:10:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37533 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfCZKKU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 06:10:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id v21so10213312edq.4
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 03:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=D5ZfGg0+97qRtJ68WVF3zepnPahr9+OZRErv5W69WXQ=;
        b=loAFVd8HphmLp5mFLooq3KI37FVaaO/rQp1e6RQUkCbSrcTCno4VUjDH2vRsRNvfIn
         OhcfJ9OhkR4PZf6USy+u5GyR8xOUILFgZF+wxC1x1yh2KEWTby1mfnbXIYHenLM/RiAi
         HMR7lg8EcaDTE96XwI3xRLJnbn9sa7ZFyUHV+DVgjlHHAvekwoxk5KXt2uwrE27SNhy8
         1LVmjDroTTPRrKrofSxAeVLtNzxNCQuofejaUv7PTkhPGjjGZD6Tl4ootgzaatqYwGUf
         IKu9U7lPweMQS5JjN56RK/FkxP7Jf4E/v9G/rkMn86pis97ogpz/rgG8TLR7rHoExb/h
         vJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=D5ZfGg0+97qRtJ68WVF3zepnPahr9+OZRErv5W69WXQ=;
        b=TwBmRH5C2awfKA3imDo872geOJXyZHPVVilHq+eVqIxnKNxG/IpccU0hVnUCrqLNx6
         3pzMKFl+DDQ13td/sgCjHoIAAo/2BMicwWiC0LS8MiL2Qb90GSpaPYFNq/eKlqhdgdoM
         RueNtWkfeFT0jfZBZbt8SyimuI2dR6C7kjLsBy7QH58uVh0UuCGAwS3UNvlKAqU4BZyG
         J5GsO9+gaHlPbEujJBUCZuAHjPNOpF0uLwKcPM8L7gv/IpcbRMxo73bV7Bl2vu59Ltcd
         4zRhRhVU5gAuAHkIleOLObC1FQEbLgY79g4DDdI747/gQkT2SZVxMw7Xu1HFBUYHq+kS
         SuRg==
X-Gm-Message-State: APjAAAUt3BoYUOIr+U5/DC37KgdBs5KkOm3aKyGAmi0fGHtcZhepYM2B
        cA4YRmc2HH2LnDEd4pFb+vsLMdk3D1k=
X-Google-Smtp-Source: APXvYqzfbobbrPZ0lR6mHpjNbzCpPK9Z7gQ0T7XQ/1D1FmFleet3HVAICrC54PAvXbrdhlkYFAXe6A==
X-Received: by 2002:a17:906:60d7:: with SMTP id f23mr16700014ejk.177.1553595017304;
        Tue, 26 Mar 2019 03:10:17 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id l20sm1042376ejb.30.2019.03.26.03.10.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 03:10:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: [PATCH 1/3] tag: prevent recursive tags
References: <20190325233723.GD23728@sigill.intra.peff.net> <cover.1553586707.git.liu.denton@gmail.com> <c371a653b4049256f3427e467b144385ee47ef43.1553586707.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <c371a653b4049256f3427e467b144385ee47ef43.1553586707.git.liu.denton@gmail.com>
Date:   Tue, 26 Mar 2019 11:10:15 +0100
Message-ID: <87imw6aquw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 26 2019, Denton Liu wrote:

>  static const char * const git_tag_usage[] = {
> -	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
> +	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [--allow-recursive-tag]\n"
> +		"\t\t<tagname> [<head>]"),
>  	N_("git tag -d <tagname>..."),
> -	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]"
> -		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
> +	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
> +		"\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
>  	N_("git tag -v [--format=<format>] <tagname>..."),
>  	NULL

Better to split the refactoring part of this into a leading
change. I.e. the latter 2 removed/2 added here, and the former could
also start with a wrap to 79 chars...

>  	type = oid_object_info(the_repository, object, NULL);
>  	if (type <= OBJ_NONE)
> -	    die(_("bad object type."));
> +		die(_("bad object type."));

Ditto this 4 space -> tab change.

> +
> +	if (type == OBJ_TAG && !opt->allow_recursive_tag) {
> +		error(_("refusing to make a recursive tag"));
> +		if (advice_recursive_tag)
> +			advise(_(message_advice_recursive_tag), tag, tag, tag);
> +		exit(1);
> +	}

This patch of mine didn't end up making it in, but shows how instead of
"tag, tag, tag" here you can just pass it once and use positional printf
arguments in the message. It makes things a lot more self-explanatory:
https://public-inbox.org/git/20181026192734.9609-8-avarab@gmail.com/

>
>  	strbuf_addf(&header,
>  		    "object %s\n"
> @@ -403,6 +423,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  					N_("use another key to sign the tag")),
>  		OPT__FORCE(&force, N_("replace the tag if exists"), 0),
>  		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create a reflog")),
> +		OPT_BOOL(0, "allow-recursive-tag", &opt.allow_recursive_tag,
> +					N_("allow recursive tags to be made")),
>
>  		OPT_GROUP(N_("Tag listing options")),
>  		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 6da48a2e0a..841f922e07 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -70,7 +70,7 @@ test_expect_success 'blame 1 author' '
>
>  test_expect_success 'blame by tag objects' '
>  	git tag -m "test tag" testTag &&
> -	git tag -m "test tag #2" testTag2 testTag &&
> +	git tag -m "test tag #2" --allow-recursive-tag testTag2 testTag &&
>  	check_count -h testTag A 2 &&
>  	check_count -h testTag2 A 2
>  '
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index bce02788e6..5f06c2d76f 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -16,7 +16,7 @@ pack_as_from_promisor () {
>
>  promise_and_delete () {
>  	HASH=$(git -C repo rev-parse "$1") &&
> -	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
> +	git -C repo tag -a -m message my_annotated_tag --allow-recursive-tag "$HASH" &&
>  	git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
>  	# tag -d prints a message to stdout, so redirect it
>  	git -C repo tag -d my_annotated_tag >/dev/null &&
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index f42a69faa2..018550f3b2 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -511,7 +511,7 @@ test_expect_success 'set up log decoration tests' '
>
>  test_expect_success 'log decoration properly follows tag chain' '
>  	git tag -a tag1 -m tag1 &&
> -	git tag -a tag2 -m tag2 tag1 &&
> +	git tag -a tag2 -m tag2 --allow-recursive-tag tag1 &&
>  	git tag -d tag1 &&
>  	git commit --amend -m shorter &&
>  	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
> diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
> index a5eca210b8..c99850c1c0 100755
> --- a/t/t5305-include-tag.sh
> +++ b/t/t5305-include-tag.sh
> @@ -68,7 +68,7 @@ test_expect_success 'check unpacked result (have commit, have tag)' '
>  test_expect_success 'create hidden inner tag' '
>  	test_commit commit &&
>  	git tag -m inner inner HEAD &&
> -	git tag -m outer outer inner &&
> +	git tag -m outer --allow-recursive-tag outer inner &&
>  	git tag -d inner
>  '
>
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 49c540b1e1..c549b37aec 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -562,7 +562,7 @@ test_expect_success 'test --all wrt tag to non-commits' '
>  		hello tag
>  	EOF
>  	) &&
> -	git tag -a -m "tag -> tag" tag-to-tag $tag &&
> +	git tag -a -m "tag -> tag" --allow-recursive-tag tag-to-tag $tag &&
>
>  	# `fetch-pack --all` should succeed fetching all those objects.
>  	mkdir fetchall &&
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index fc067ed672..f7b56ae195 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -12,7 +12,7 @@ test_expect_success 'setup some history and refs' '
>  	git checkout -b side &&
>  	test_commit four &&
>  	git tag -m "An annotated tag" annotated-tag &&
> -	git tag -m "Annonated doubly" doubly-annotated-tag annotated-tag &&
> +	git tag -m "Annonated doubly" --allow-recursive-tag doubly-annotated-tag annotated-tag &&
>
>  	# Note that these "signed" tags might not actually be signed.
>  	# Tests which care about the distinction should be marked
> @@ -24,7 +24,7 @@ test_expect_success 'setup some history and refs' '
>  		sign=
>  	fi &&
>  	git tag $sign -m "A signed tag" signed-tag &&
> -	git tag $sign -m "Signed doubly" doubly-signed-tag signed-tag &&
> +	git tag $sign -m "Signed doubly" --allow-recursive-tag doubly-signed-tag signed-tag &&
>
>  	git checkout master &&
>  	git update-ref refs/odd/spot master
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 0b01862c23..7a7c0ccee9 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1265,7 +1265,7 @@ echo "A message for another tag" >>expect
>  echo '-----BEGIN PGP SIGNATURE-----' >>expect
>  test_expect_success GPG \
>  	'creating a signed tag pointing to another tag should succeed' '
> -	git tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
> +	git tag -s -m "A message for another tag" --allow-recursive-tag tag-signed-tag signed-tag &&
>  	get_tag_msg tag-signed-tag >actual &&
>  	test_cmp expect actual
>  '
> @@ -1690,7 +1690,7 @@ test_expect_success '--points-at finds annotated tags of commits' '
>  '
>
>  test_expect_success '--points-at finds annotated tags of tags' '
> -	git tag -m "describing the v4.0 tag object" \
> +	git tag -m "describing the v4.0 tag object" --allow-recursive-tag \
>  		annotated-again-v4.0 annotated-v4.0 &&
>  	cat >expect <<-\EOF &&
>  	annotated-again-v4.0
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 5690fe2810..b5ed7e119a 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -441,8 +441,8 @@ test_expect_success 'set-up a few more tags for tag export tests' '
>  	HEAD_TREE=$(git show -s --pretty=raw HEAD | grep tree | sed "s/tree //") &&
>  	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
>  	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
> -	git tag    tag-obj_tag     -m "tagging a tag" tree_tag-obj &&
> -	git tag -a tag-obj_tag-obj -m "tagging a tag" tree_tag-obj
> +	git tag    tag-obj_tag     -m "tagging a tag" --allow-recursive-tag tree_tag-obj &&
> +	git tag -a tag-obj_tag-obj -m "tagging a tag" --allow-recursive-tag tree_tag-obj
>  '
>
>  test_expect_success 'tree_tag'        '

At least some of these tests should change the existing test line to a
"test_must_fail", i.e. assert that without the new option these aren't
created, maybe for good measure test --force too.
