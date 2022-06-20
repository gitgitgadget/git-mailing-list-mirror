Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E88C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 20:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245089AbiFTUe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 16:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245715AbiFTUeW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 16:34:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA58719036
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:34:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so23302315eja.8
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xa9KCGCMHX/Yh1eKd6fCTdG+mVHeAOimfQ99nUy2WPo=;
        b=XouhIcILRnlvC+HsA+MGZlXWmYT5IrrwEZgsL79xrIRge2CYmEuPXtYg1gpJeLiRzk
         umDw18KJLQ3CBRppb8TzedsIuQ96YI6DperaCFIxA3aJeXdoZCViIIC7Nil2eJDmOitH
         LnhqvjESquNiKhOMhk+qbfFYzDt81ZnC8EwHPR+PMszlzH0XeX7oVL7A+lH+yBZupXkd
         lk8UjrjyjcEXjEU++iRtNkOPD6djY/yL0BnK5pV+0OLO2lWVbVmBtJLM1t7F3lp2clJ4
         bGIR5y3ty+gW2A9c+SKooqPIFsI0pcYTWdmVZJQyYXfz7JlU+CecQFSmNgPFXr5yuLV7
         ZebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xa9KCGCMHX/Yh1eKd6fCTdG+mVHeAOimfQ99nUy2WPo=;
        b=cyI0cHUmL3aaDBSUM/KtEeLXQNKrqcAkUcgiGwI4PZDJRI8EukRSyp5F3irVBF3DyZ
         7Z5dqt5w2MTBK9gfU/lX5WZ+3JDzejW7ZXbPM3cgm3ku3AzyOi/kz8XBwUTt4swW9zwo
         yhhGDXmn0aeFPqukIYlOYwls0EEk4982zv04ewiPMka1Bs57J9I5T8rmASmqOIwZgkuS
         JJNo36O/dzPsMrtSMxAdUOYHOtfij4IDe8vae7DN9fN9MPH8sXqj7qBuACOV6kzIdZ2y
         ejQGONOhjRIBTVseUpFNhLRoO0D763OjuHzm8v0vzI6Eku1Xu5f9xYfX0zVEJtpVr8Lq
         pAxQ==
X-Gm-Message-State: AJIora/qQCvkiNEhDVSsRHQBUdh+nLGA/FG3U2XWKdOjo/xCwOMaCoiH
        /9/Loer5yK6ggCqahEmDr/29Y8u3oag=
X-Google-Smtp-Source: AGRyM1sTrYcYl3GdA2Ysf7B0CNHYNHqDz3xY1mZGoKp9UKiteqBt7eEQjxzPvClG03AYJiiEhwCurw==
X-Received: by 2002:a17:906:739d:b0:713:c3f4:6ef with SMTP id f29-20020a170906739d00b00713c3f406efmr22192191ejl.180.1655757259233;
        Mon, 20 Jun 2022 13:34:19 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id sb6-20020a1709076d8600b0070aaad0a173sm6458473ejc.192.2022.06.20.13.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:34:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o3O6D-0007V7-Uq;
        Mon, 20 Jun 2022 22:34:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1
Date:   Mon, 20 Jun 2022 22:30:08 +0200
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
 <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
 <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
Message-ID: <220620.861qvjvzue.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 20 2022, Derrick Stolee wrote:

> On 6/20/22 2:59 PM, rsbecker@nexbridge.com wrote:
>> On June 20, 2022 2:46 PM, Derrick Stolee wrote:
>
>>> The issue is this line (some tabs removed):
>>>
>>>  new_cmdline=$(printf "%s" "$cmdline" | perl -pe
>>> 's[origin(?!/)]["'"$remote_url"'"]g')
>>>
>>> At this point, $remote_url contains the file path including the @ symbol. However,
>>> this perl invocation is dropping everything starting at the @ to the next slash.
>>>
>>> I'm not sure of a better way to accomplish what is trying to be done here (replace
>>> 'origin' with that specific url) without maybe causing other issues.
>>>
>>> This line was introduced by e1790f9245f (fetch tests: fetch <url> <spec> as well as
>>> fetch [<remote>], 2018-02-09).
>> 
>> How about using sed instead of perl for this?
>
> I wasn't sure if using sed would create a different kind of replacement
> problem, but using single-quotes seems to get around that kind of issue.
>
> Please see the patch below. I'm currently running CI in a GGG PR [1]
>
> [1] https://github.com/gitgitgadget/git/pull/1267
>
> Thanks,
> -Stolee
>
>
> --- >8 ---
>
> From 1df4fc66d4a62adc7087d7d22c8d78842b4e9b4d Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <derrickstolee@github.com>
> Date: Mon, 20 Jun 2022 15:52:09 -0400
> Subject: [PATCH] t5510: replace 'origin' with URL more carefully
>
> The many test_configured_prune tests in t5510-fetch.sh test many
> combinations of --prune, --prune-tags, and using 'origin' or an explicit
> URL. Some machinery was introduced in e1790f9245f (fetch tests: fetch
> <url> <spec> as well as fetch [<remote>], 2018-02-09) to replace
> 'origin' with this explicit URL. This URL is a "file:///" URL for the
> root of the $TRASH_DIRECTORY.
>
> However, if the current build tree has an '@' symbol, the replacement
> using perl fails. It drops the '@' as well as anything else in that
> directory name.
>
> You can verify this locally by cloning git.git into a "victim@03"
> directory and running the test script.
>
> To resolve this issue, replace the perl invocation with two sed
> commands. These two are used to ensure that we match exactly on the
> whole word 'origin'. We can guarantee that the word boundaries are
> spaces in our tests. The reason to use exact words is that sometimes a
> refspec is supplied, such as "+refs/heads/*:refs/remotes/origin/*" which
> would cause an incorrect replacement. The two commands are used because
> there is not a clear POSIX way to match on word boundaries without
> getting extremely pedantic about what possible characters we could have
> at the boundaries.
>
> Reported-by: Randall Becker <rsbecker@nexbridge.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  t/t5510-fetch.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 4620f0ca7fa..8ca3aa5e931 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -853,7 +853,9 @@ test_configured_prune_type () {
>  		then
>  			new_cmdline=$cmdline_setup
>  		else
> -			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
> +			new_cmdline=$(printf "%s" "$cmdline" | \
> +					sed "s~origin ~'$remote_url' ~g" | \
> +					sed "s~ origin~ '$remote_url'~g")
>  		fi
>  
>  		if test "$fetch_prune_tags" = 'true' ||

Thanks for looking at this. Checking this out again this whole quoting
mess is a bit of a ... mess, I wonder if there's some better way to
avoid this. Anyway:

So, is this functionally the same as:
	
	diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
	index 4620f0ca7fa..9cd8b36f835 100755
	--- a/t/t5510-fetch.sh
	+++ b/t/t5510-fetch.sh
	@@ -853,7 +853,9 @@ test_configured_prune_type () {
	 		then
	 			new_cmdline=$cmdline_setup
	 		else
	-			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
	+			new_cmdline=$(printf "%s" "$cmdline" |
	+				      perl -pe 's[origin ]["'"$remote_url"'" ]g' |
	+				      perl -pe 's[ origin][ "'"$remote_url"'"]g')
	 		fi
	 
	 		if test "$fetch_prune_tags" = 'true' ||

?

I don't mind the migration to "sed", but doing so to fix a bug makes
this especially hard to analyze. I.e. you've gotten rid of the (?!/), I
haven't re-looked at this enough to see if/how that's important.

I just came up with the above as a quick hack, but for any proper
migration to sed can't we do this in one command?

In any case you never need "| \" in your scripts, just end the line with
"|".
