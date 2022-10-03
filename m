Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD8C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 09:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiJCJqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiJCJqC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 05:46:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6087B58B65
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 02:43:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u21so9572432edi.9
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 02:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=kFTUOoKgrDVg9RnPPGZrCjS2biWgGHQhS1N14Fm7xww=;
        b=LScyQnASR2LW36GYMhwhOR0lVG4XRfWj7vcsT6g+BLJsLtE6xeNjaw1GPCfLqevFcR
         o2A8LTXLLJvYZ9qm+EAsWf6U31spsSIY1RAb3VaClyJrVSt8lqU3ebCJNpPbSwWItcEI
         0DB9fCM3P6xIIJUjY2tQP4cm8JeshBq8vob3H1PeqajHLNIETDavIYlAhvqCbjdHx6cG
         tLy49NMIdqvBipHvlNfiykBEXISr/JD5isdiNkDtWcnJa+JxZVJ3kFWb8IZ5cQ6oCgZq
         cTAv6WfpcUb9M54AWGRrY4mZgUe00Imwz5bCrXox4HSIpfmuOK+DQscpWrNd/m3gdHe5
         Kghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kFTUOoKgrDVg9RnPPGZrCjS2biWgGHQhS1N14Fm7xww=;
        b=1qlOV5qFu1AZNlzz2Ts9ue2cy3vqVSivEwIP7nCByl9KBXQetJhM7IcJlxVOmgEa8u
         2qPTSUp5Esng3B8YPjlNj3Sxheu5P40QTSSdEsxtjqNNalxcOYbnDrFkVYeV90Y5fdZO
         ZlBXwCE7vn4ldONY0AcTNg0wOxCr9ZyEYwANtFrul+EQSP7PJvrAOFDBF0RU730mNdMX
         pvb0TbW2mR03mgHnZm94b/S6Z2fmhc++4Sh2+47gY5NNb9mZXoNstmDXLjbwDhat1Y7k
         jSd6eW4kVpxyeKkUIFkveFpwlv/HV1pdTkbHCEdSAkdLaEO1GFAsO3K4K+HRVbcftgDS
         uAaA==
X-Gm-Message-State: ACrzQf3WOMNvakRkra/SjYqFy6e8mIB6r0u1bmK3HRwY8Q4/cthFicwg
        t32VRHGOw1bwawZbTvHfRmY=
X-Google-Smtp-Source: AMsMyM6Rj3fOt8qdc/jAMvtxoI6dO7lNga0uirMOwxk20g8xrPia/eGIGf0q7EUJw7s7H8DLGaNw/A==
X-Received: by 2002:aa7:c849:0:b0:453:9543:6ef3 with SMTP id g9-20020aa7c849000000b0045395436ef3mr18006617edt.105.1664790189252;
        Mon, 03 Oct 2022 02:43:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j5-20020aa7de85000000b004542e65337asm7051974edv.51.2022.10.03.02.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:43:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ofHyd-0021iS-2T;
        Mon, 03 Oct 2022 11:43:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "Michael V. Scovetta" <michael.scovetta@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: detect author name errors in
 read_author_script()
Date:   Mon, 03 Oct 2022 11:40:52 +0200
References: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
 <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
Message-ID: <221003.86k05htf84.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 03 2022, Jeff King wrote:

> On Sun, Oct 02, 2022 at 11:39:16PM -0700, Michael V. Scovetta wrote:
>
>> In commit 2a7d63a2, sequencer.c:912 looks like:
>> 912  if (name_i == -2)
>> 913      error(_("missing 'GIT_AUTHOR_NAME'"));
>> 914  if (email_i == -2)
>> 915      error(_("missing 'GIT_AUTHOR_EMAIL'"));
>> 916  if (date_i == -2)
>> 917      error(_("missing 'GIT_AUTHOR_DATE'"));
>> 918  if (date_i < 0 || email_i < 0 || date_i < 0 || err)    <-- date_i
>> is referenced here twice
>> 919      goto finish;
>> 
>> I'm fairly sure that line 918 should be:
>> 918  if (name_i < 0 || email_i < 0 || date_i < 0 || err)
>
> Agreed, but +cc Phillip as the original author.
>
>> I haven't validated this, but I suspect that if
>> `rebase-merge/author-script` contained two GIT_AUTHOR_NAME fields,
>> then name_i would be set to -1 (by the error function), but control
>> wouldn't flow to finish, but instead to line 920 ( *name =
>> kv.items[name_i].util; ) where it would attempt to access memory
>> slightly outside of items' memory space.
>
> Correct. It also happens if GIT_AUTHOR_NAME is missing.
>
>> I haven't been able to actually trigger the bug, but strongly suspect
>> I'm just not familiar enough with how rebasing works under the covers.
>
> It's a little tricky, because we avoid writing and reading the
> author-script file unless necessary. An easy way to need it is to break
> with a conflict (which writes it), and then resume with "git rebase
> --continue" (which reads it back while committing).
>
> Here's a patch to fix it. Thanks for your report!
>
> -- >8 --
> Subject: sequencer: detect author name errors in read_author_script()
>
> As we parse the author-script file, we check for missing or duplicate
> lines for GIT_AUTHOR_NAME, etc. But after reading the whole file, our
> final error conditional checks "date_i" twice and "name_i" not at all.
> This not only leads to us failing to abort, but we may do an
> out-of-bounds read on the string_list array.
>
> The bug goes back to 442c36bd08 (am: improve author-script error
> reporting, 2018-10-31), though the code was soon after moved to this
> spot by bcd33ec25f (add read_author_script() to libgit, 2018-10-31).
> It was presmably just a typo in 442c36bd08.
>
> We'll add test coverage for all the error cases here, though only the
> GIT_AUTHOR_NAME ones fail (even in a vanilla build they to segfault
> consistently, but certainly with SANITIZE=address).
>
> Reported-by: Michael V. Scovetta <michael.scovetta@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The tests kind of feel like overkill, as this is such a specific
> condition and I doubt we'd regress to have the same bug twice. But it
> was nice at least to confirm the bug and the fix now.

Having a regression test never feels like overkill to me :)

>
>  sequencer.c                    |  2 +-
>  t/t3438-rebase-broken-files.sh | 53 ++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 1 deletion(-)
>  create mode 100755 t/t3438-rebase-broken-files.sh
>
> diff --git a/sequencer.c b/sequencer.c
> index d26ede83c4..83e0425b04 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -915,7 +915,7 @@ int read_author_script(const char *path, char **name, char **email, char **date,
>  		error(_("missing 'GIT_AUTHOR_EMAIL'"));
>  	if (date_i == -2)
>  		error(_("missing 'GIT_AUTHOR_DATE'"));
> -	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
> +	if (name_i < 0 || email_i < 0 || date_i < 0 || err)
>  		goto finish;
>  	*name = kv.items[name_i].util;
>  	*email = kv.items[email_i].util;
> diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
> new file mode 100755
> index 0000000000..e68aac4b36
> --- /dev/null
> +++ b/t/t3438-rebase-broken-files.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +
> +test_description='rebase behavior when on-disk files are broken'
> +. ./test-lib.sh
> +
> +test_expect_success 'set up conflicting branches' '
> +	test_commit base file &&
> +	git checkout -b branch1 &&
> +	test_commit one file &&
> +	git checkout -b branch2 HEAD^ &&
> +	test_commit two file
> +'
> +
> +check_broken_author () {
> +	title=$1; shift
> +	script=$1; shift
> +
> +	test_expect_success "$title" '
> +		# create conflicted state
> +		test_when_finished "git rebase --abort" &&
> +		git checkout -B tmp branch2 &&
> +		test_must_fail git rebase branch1 &&
> +
> +		# break author-script
> +		'"$script"' &&
> +
> +		# resolving notices broken author-script
> +		echo resolved >file &&
> +		git add file &&
> +		test_must_fail git rebase --continue
> +	'
> +}
> +
> +for item in NAME EMAIL DATE
> +do
> +	check_broken_author "detect missing GIT_AUTHOR_$item" '
> +		grep -v $item .git/rebase-merge/author-script >tmp &&
> +		mv tmp .git/rebase-merge/author-script'
> +done
> +
> +for item in NAME EMAIL DATE
> +do
> +	check_broken_author "detect duplicate GIT_AUTHOR_$item" '
> +		grep -i $item .git/rebase-merge/author-script >tmp &&
> +		cat tmp >>.git/rebase-merge/author-script'
> +done
> +
> +check_broken_author 'unknown key in author-script' '
> +	echo "GIT_AUTHOR_BOGUS=${SQ}whatever${SQ}" \
> +		>>.git/rebase-merge/author-script'
> +
> +
> +test_done

Maybe I just have too much PTSD from dealing with shell quoting issues
with this '"$script"" pattern when you need to pass arguments with
spaces in it, or even quotes. Although it probably won't ever be an
issue here.

But in this case just passing the "script" on stdin nicely avoids any
future quoting issues, maybe this would be good to squash in?:

diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
index e68aac4b36d..6911e145f08 100755
--- a/t/t3438-rebase-broken-files.sh
+++ b/t/t3438-rebase-broken-files.sh
@@ -12,17 +12,19 @@ test_expect_success 'set up conflicting branches' '
 '
 
 check_broken_author () {
-	title=$1; shift
-	script=$1; shift
+	title=$1 && shift &&
 
-	test_expect_success "$title" '
+	# Avoid quoting issues
+	write_script script.sh &&
+
+	test_expect_success "$title of '$script'" '
 		# create conflicted state
 		test_when_finished "git rebase --abort" &&
 		git checkout -B tmp branch2 &&
 		test_must_fail git rebase branch1 &&
 
-		# break author-script
-		'"$script"' &&
+		./script.sh >tmp &&
+		mv tmp .git/rebase-merge/author-script &&
 
 		# resolving notices broken author-script
 		echo resolved >file &&
@@ -33,21 +35,22 @@ check_broken_author () {
 
 for item in NAME EMAIL DATE
 do
-	check_broken_author "detect missing GIT_AUTHOR_$item" '
-		grep -v $item .git/rebase-merge/author-script >tmp &&
-		mv tmp .git/rebase-merge/author-script'
+	check_broken_author "detect missing GIT_AUTHOR_$item" <<-EOF
+	grep -v $item .git/rebase-merge/author-script
+	EOF
 done
 
 for item in NAME EMAIL DATE
 do
-	check_broken_author "detect duplicate GIT_AUTHOR_$item" '
-		grep -i $item .git/rebase-merge/author-script >tmp &&
-		cat tmp >>.git/rebase-merge/author-script'
+	check_broken_author "detect duplicate GIT_AUTHOR_$item" <<-EOF
+	cat .git/rebase-merge/author-script &&
+	grep -i $item .git/rebase-merge/author-script
+	EOF
 done
 
-check_broken_author 'unknown key in author-script' '
-	echo "GIT_AUTHOR_BOGUS=${SQ}whatever${SQ}" \
-		>>.git/rebase-merge/author-script'
-
+check_broken_author 'unknown key in author-script' <<-EOF
+cat .git/rebase-merge/author-script &&
+echo "GIT_AUTHOR_BOGUS=${SQ}whatever${SQ}"
+EOF
 
 test_done

