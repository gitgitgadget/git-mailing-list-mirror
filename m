Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938CCC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 10:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiCCKfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 05:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCCKf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 05:35:29 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E432EFF
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 02:34:42 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r13so9673632ejd.5
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=q9refXzogYuuso8rukFvFxQqBx3t12GYOugi1Za7+T4=;
        b=ethnBW2hSZlyLCZC/d8/Hu28z+7sUS2rRo6J4pw6tOhBuHieib8ICdS/J1nPcdgu+Y
         Caauuy+zrI99M9jqT9LPsyZW8riL60NLeexlu2/zkWAGlzI4YeRrNT5OJDpRmMpIv1oU
         kQHSBT4XQe3WIGb3l794KDgCQeWylq4ua0D2mXYAL6fyZw1bHJtHJ+mzwQsZKQvjAn9B
         aJe3uWrhFw/jVEbTg+wB0+sHbNJnsSfJzGIlFNHg7eBztnJzeOQ2NnJss2VbPqsvTARs
         cFygArrJRs6Nny0ssGD4602lYwhiMTeYPe2wIJk7MxkKYENsHxkttlTHS+FKo4WUjexl
         N83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=q9refXzogYuuso8rukFvFxQqBx3t12GYOugi1Za7+T4=;
        b=7438UVqLPX4yJm/T5VgSLZONFMoccWQ6HDA9z6Yv8rPzafFzZa16deQTICsudN97Bd
         An22mwkBgrQzjI/t2Cd1uXgFZ984HoVraK9ELzUvuYl4ipCMOkGEx4HJlDvyEbjnnW13
         On7zqdKLyzIw3e96ihqcsYwVj+Ho1Z8LPMa32lUXQSCET45joPAMx1/d37nNxv48SYqY
         /SACYZI8oqgzRa/oU+o+Kgy5kSbTyogeaWPIwl62ThzEns7tEDmY913M0hrmnSzBSHGU
         Hk4ZeH629K9K6ezKbf215sIhOs4eq0y2VSZd/Up5D7GFBZAg55CECHVIw6SW3DghQD0B
         2znw==
X-Gm-Message-State: AOAM5322mnABPWpe6ONDMe+z+KhLCMUoCLRGhe4AgBX8CRCu1dxMIA3P
        8PDNcFoRfMMykUEsRHutzBk=
X-Google-Smtp-Source: ABdhPJxp8CKquqinfOySOqfhrmzRsXLSqqYQk3A0ojtgcaxbgTtm50jwVF90FETRK92QpT7nlObGhA==
X-Received: by 2002:a17:907:7f8b:b0:6da:6eeb:72e4 with SMTP id qk11-20020a1709077f8b00b006da6eeb72e4mr4865764ejc.311.1646303680829;
        Thu, 03 Mar 2022 02:34:40 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sa13-20020a1709076d0d00b006ce3ef8e1d4sm550281ejc.31.2022.03.03.02.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 02:34:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPin9-000QN6-OC;
        Thu, 03 Mar 2022 11:34:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5503: simplify setup of test which exercises failure
 of backfill
Date:   Thu, 03 Mar 2022 11:23:48 +0100
References: <cc7de043de67bb8243c764ef6764b07170b01929.1646291929.git.ps@pks.im>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cc7de043de67bb8243c764ef6764b07170b01929.1646291929.git.ps@pks.im>
Message-ID: <220303.86bkyn5npc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> In the testcase to exercise backfilling of tags for fetches we evoke a
> failure of the backfilling mechanism by creating a reference that later
> on causes a D/F conflict. Because the assumption was that git-fetch(1)
> would notice the D/F conflict early on this conflicting reference was
> created via the reference-transaction hook just when we were about to
> write the backfilled tag. As it turns out though this is not the case,
> and the fetch fails in the same way when we create the conflicting ref
> up front.
>
> Simplify the test setup creating the reference up front, which allows us
> to get rid of the hook script.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> This simplifies the test setup of t5503 as discussed in [1]. The patch
> applies on top of Junio's ps/fetch-atomic (583bc41923 (fetch: make
> `--atomic` flag cover pruning of refs, 2022-02-17)).

FWIW for something in "next" already the OID will be stable, so it's OK
(and better) to mention 583bc419235 in the commit message itself.

> Patrick
>
>  t/t5503-tagfollow.sh | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
> index e72fdc2534..a3c01014b7 100755
> --- a/t/t5503-tagfollow.sh
> +++ b/t/t5503-tagfollow.sh
> @@ -212,21 +212,11 @@ test_expect_success 'atomic fetch with backfill should use single transaction' '
>  test_expect_success 'backfill failure causes command to fail' '
>  	git init clone5 &&
>  
> -	write_script clone5/.git/hooks/reference-transaction <<-EOF &&
> -		while read oldrev newrev reference
> -		do
> -			if test "\$reference" = refs/tags/tag1
> -			then
> -				# Create a nested tag below the actual tag we
> -				# wanted to write, which causes a D/F conflict
> -				# later when we want to commit refs/tags/tag1.
> -				# We cannot just `exit 1` here given that this
> -				# would cause us to die immediately.
> -				git update-ref refs/tags/tag1/nested $B
> -				exit \$!
> -			fi
> -		done
> -	EOF
> +	# Create a tag that is nested below the tag we are about to fetch via
> +	# the backfill mechanism. This causes a D/F conflict when backfilling
> +	# and should thus cause the command to fail.
> +	empty_blob=$(git -C clone5 hash-object -w --stdin </dev/null) &&
> +	git -C clone5 update-ref refs/tags/tag1/nested $empty_blob &&

This looks better, but FWIW for the discussion about quoted
v.s. unquoted here-doc in this case it's also OK for the pre-image (and
arguably better) to do (and any issues of $? v.s. $! etc. aside):
	
	diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
	index e72fdc25346..eebf0ddc4c2 100755
	--- a/t/t5503-tagfollow.sh
	+++ b/t/t5503-tagfollow.sh
	@@ -212,18 +212,18 @@ test_expect_success 'atomic fetch with backfill should use single transaction' '
	 test_expect_success 'backfill failure causes command to fail' '
	 	git init clone5 &&
	 
	-	write_script clone5/.git/hooks/reference-transaction <<-EOF &&
	+	write_script clone5/.git/hooks/reference-transaction <<-\EOF &&
	 		while read oldrev newrev reference
	 		do
	-			if test "\$reference" = refs/tags/tag1
	+			if test "$reference" = refs/tags/tag1
	 			then
	 				# Create a nested tag below the actual tag we
	 				# wanted to write, which causes a D/F conflict
	 				# later when we want to commit refs/tags/tag1.
	 				# We cannot just `exit 1` here given that this
	 				# would cause us to die immediately.
	-				git update-ref refs/tags/tag1/nested $B
	-				exit \$!
	+				git update-ref refs/tags/tag1/nested '$B'
	+				exit $!
	 			fi
	 		done
	 	EOF

I.e. to end the quote and interpolate $B. IMO also more readable as
e.g. shell syntax highlighting will show that we're interpolating that
outside-test $B.

>  
>  	test_must_fail git -C clone5 fetch .. $B:refs/heads/something &&
>  	test $B = $(git -C clone5 rev-parse --verify refs/heads/something) &&

(In the pre-image, but..) this way of using "test" will hide segfaults
etc. from the invoked git command.

Better to:

    echo $B >expect &&
    git ... >actual &&
    test_cmp expect actual

Or better yet "test_cmp_rev" in this case, but all of that's in "next"
already, so purely optional (and also more food for the "hiding exit
status" microproject) :)
