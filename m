Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BC6C07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 15:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiIZPC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbiIZPCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 11:02:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CE417AB8
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:32:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c30so7872845edn.2
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 06:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=clQHlbkfB+gAV4P1YiE4slmNgQJ8Yf/DgZiouxL7YlQ=;
        b=V/mYgVHtZaRx0VzcIf63YDw28KF0OFP83OEy6NCpZ+RQaelx+Mn1pZ3NJFK8Hi0C2G
         xt2Km8jyKMEoCzPohh1hpApVw4uCn1Ih7YqksL9TbjxLgV77wV7DEIsR9hOSOC900yCV
         F00uJI0tTWXrKZRbDYW2fFWoBoDH9Q06Lo66XiDArNmxg4agEwaCc4NVSgHxQojk8IAN
         S0FP1m4atmzY3pEi7loPV6IPnb29Yj4rNYU2NTIqKVMXDrSmo4qbjDX84xhczzXab5Dz
         qBX5p/Z+jFYQRrh5ljlc5fzEPgTT2sBrOBSfhRirHSuFDlNADeADUL604BXSbsHzkjZ2
         LATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=clQHlbkfB+gAV4P1YiE4slmNgQJ8Yf/DgZiouxL7YlQ=;
        b=vGJPMC9KXKJLFmkKR7rclbUNJKuLu5soE7qYpLYAgtrT0hyvEOSH3DHhmaZy5etHLq
         EDePKdfXsIkI8PcLDifCHa4vOLyP225GS1Ec8m5/l8KNHNU5hj58jZ5/k9nyPmF2T0Tv
         oR3Fc+sebu0+W1fOE2/gsMUoi3jb2Ux7MjjuT20CGyFtplLtqJPaSZt5eOXYcP5Vu8wg
         JaTtJO8RVJgc+eimS9RmF2f5gQbS5b/FA30RhumrV6w2Gmw+mkHtPIABop8Evrl9r9am
         43MjF4F84ZBJ/HRXbEAjoWebXg4L/0FbuQ/W1YtW20ViJSxz9AE0kYlajne4Po2L9c/Y
         dmEA==
X-Gm-Message-State: ACrzQf2TPZIb+oKMakCJlA2ou9sVR0sCtvduAiF8nFC5vuTrqJKUGxic
        r/YngOQCPJ7u3wg1MOuPkKtIS3uC+bI=
X-Google-Smtp-Source: AMsMyM4pObxD7SGmfDD24xq8DvZ2hn1dnhjxNk87NIoOlbd0aKQdrMl9a2FAwUyt5nWENsjIwtkAXA==
X-Received: by 2002:a50:ed05:0:b0:456:d6fe:d800 with SMTP id j5-20020a50ed05000000b00456d6fed800mr15547079eds.101.1664199146313;
        Mon, 26 Sep 2022 06:32:26 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id p13-20020a056402044d00b00456d2721d93sm6421285edw.64.2022.09.26.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:32:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocoDg-0005ww-36;
        Mon, 26 Sep 2022 15:32:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
        johncai86@gmail.com
Subject: Re: [PATCH v2 1/2] cat-file: add mailmap support to -s option
Date:   Mon, 26 Sep 2022 15:25:44 +0200
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20220926105343.233296-1-siddharthasthana31@gmail.com>
 <20220926105343.233296-2-siddharthasthana31@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20220926105343.233296-2-siddharthasthana31@gmail.com>
Message-ID: <220926.86h70u1ct3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 26 2022, Siddharth Asthana wrote:

> Even though the cat-file command with `-s` option does not complain when
> `--use-mailmap` option is given, the latter option is ignored. Compute
> the size of the object after replacing the idents and report it instead.
>
> In order to make `-s` option honour the mailmap mechanism we have to
> read the contents of the commit/tag object. Make use of the call to
> `oid_object_info_extended()` to get the contents of the object and store
> in `buf`. `buf` is later freed in the function.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  Documentation/git-cat-file.txt |  4 +++-
>  builtin/cat-file.c             | 13 +++++++++++++
>  t/t4203-mailmap.sh             | 10 ++++++++++
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index ec30b5c574..594b6f2dfd 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -45,7 +45,9 @@ OPTIONS
>  
>  -s::
>  	Instead of the content, show the object size identified by
> -	`<object>`.
> +	`<object>`. If used with `--use-mailmap` option, will show the
> +	size of updated object after replacing idents using the mailmap
> +	mechanism.
>  
>  -e::
>  	Exit with zero status if `<object>` exists and is a valid
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 989eee0bb4..9942b93867 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -132,8 +132,21 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
>  
>  	case 's':
>  		oi.sizep = &size;
> +
> +		if (use_mailmap) {
> +			oi.typep = &type;
> +			oi.contentp = (void**)&buf;
> +		}
> +
>  		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
>  			die("git cat-file: could not get object info");
> +
> +		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {

Just following along here: We want to handle both tag printing and size
computations. I.e. we happily search-replace the author in tag objects:
	
	$ git -P diff -- .mailmap
	diff --git a/.mailmap b/.mailmap
	index 07db36a9bb9..cace49e462b 100644
	--- a/.mailmap
	+++ b/.mailmap
	@@ -125,7 +125,7 @@ Jonathan del Strother <jon.delStrother@bestbefore.tv> <maillist@steelskies.com>
	 Josh Triplett <josh@joshtriplett.org> <josh@freedesktop.org>
	 Josh Triplett <josh@joshtriplett.org> <josht@us.ibm.com>
	 Julian Phillips <julian@quantumfyre.co.uk> <jp3@quantumfyre.co.uk>
	-Junio C Hamano <gitster@pobox.com> <gitster@pobox.com>
	+Foo <bar@baz.blah> Junio C Hamano <gitster@pobox.com>
	 Junio C Hamano <gitster@pobox.com> <junio@hera.kernel.org>
	 Junio C Hamano <gitster@pobox.com> <junio@kernel.org>
	 Junio C Hamano <gitster@pobox.com> <junio@pobox.com>
	$ ./git cat-file --use-mailmap tag v2.37.0 | head -n 4
	object e4a4b31577c7419497ac30cebe30d755b97752c5
	type commit
	tag v2.37.0
	tagger Foo <bar@baz.blah> 1656346695 -0700

And we want the "-s" to match, okey, but... (continued below)

> +			size_t s = size;
> +			buf = replace_idents_using_mailmap(buf, &s);
> +			size = cast_size_t_to_ulong(s);
> +		}
> +
>  		printf("%"PRIuMAX"\n", (uintmax_t)size);
>  		ret = 0;
>  		goto cleanup;
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index cd1cab3e54..59513e7c57 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -1022,4 +1022,14 @@ test_expect_success '--mailmap enables mailmap in cat-file for annotated tag obj
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-EOF &&

nit: use \ before EOF, no variables here.

> +	C O Mitter <committer@example.com> Orig <orig@example.com>
> +	EOF
> +	echo "220" >expect &&

nit: no need for "" quotes.

> +	git cat-file --use-mailmap -s HEAD >actual &&

I'd find this a bit easier to follow if acter setting up .mailmap we did
something like (I didn't look up what the actual "234" value is):

	>actual &&
	git cat-file -s HEAD >actual &&
	git cat-file -s --use-mailmap HEAD >>actual &&
	cat >expect <<-\EOF
        234
        220
	EOF

We surely test that somewhere else, but it would be a bit more
self-documenting, as the difference in sizes would correspond to the
size of the address (or a multiple thereof, if it's used replaced N
times).

> +	test_cmp expect actual
> +'

...our test only checks the commit handling. Let's be a bit more
defensive here & test both potential paths through that new "if".
