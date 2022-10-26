Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB5AC38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiJZVZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiJZVZD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:25:03 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5FA19C0A
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:25:01 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h24so11022485qta.7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWlungKrYJ0clazixPf5msvUSK2SzSKe000tyNBgNGQ=;
        b=ky1uIuPCG4dG8J7zLO1zzHMqysv4moho8bKqNjjVvq4TSrmYpADK/pdQoRH5gJDNBW
         ZeOZ+ITMzaZEHEIcHkarc+WO3G+LSyvtNF8bWIfmTQlXZ56hqrBn5oFJk6ubuN3XLsQG
         kUtOrmnZwTc461Amf9hmhw349/aB64K87MuNKxsYi6mXgQ2MJCaO8XMC8AlNnlzdEI0c
         /e6W0dGIii+mmXVojzwDp5a4w/ccL5zGoJL3ZT8UCXJTbZBoi3GZ7cdNNQfcVMhTLT1R
         B3XjNeIPyjvERww1YRWmj1Sk/FSdAudsdDu9ZQwGX0TYS1EUKwDu4+lDr9QYey4lhE6p
         0SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWlungKrYJ0clazixPf5msvUSK2SzSKe000tyNBgNGQ=;
        b=jWFerWJl9XDpQ9mCFhBFUKyTHud/ZhUNYrh1TY5z7xZSMjtuHmi72Dv4teaFpTgEyq
         QyLkjrqZyTxNvnkUCAE81E/EXfkznZ8VMiPqtLTzpfZHUK+M0WTGbOOmH9fBE6niHQMz
         JzzhhwtQPMU5xoac5psLLsD+27kGnfPSbrA1HHGK9EjaPi1oVZmvNI8/41E4jMh1PQoh
         RtOCfoiZR2N1zWrW/BG9yhz5eZARfWWDzcppsGLuwaLeShGYqC8W7ug9IB0wOMPSAMks
         DiWsgoGPsCqqrueE5FejQllMjLM/8WX9Vm2VDx8uhC0sZugV9F9tqhjpx1uud+h7J1k0
         fYRw==
X-Gm-Message-State: ACrzQf2SkxVKv4xobnrKaL8UKy69Oj9PX6KmaZoIGDSmXBsdO9fM/P+A
        41S5X1h7gItVLMvdTPzGirZYWSeyvXBz7Q==
X-Google-Smtp-Source: AMsMyM7hYl/AH40PnEB2fI5sIzYS+BR9GDzgCOrT7HhCqDsknIxXdHOqlJLmIPxJrln/RccdJeGzzQ==
X-Received: by 2002:a05:622a:554:b0:39c:ef65:bc66 with SMTP id m20-20020a05622a055400b0039cef65bc66mr38884552qtx.550.1666819500754;
        Wed, 26 Oct 2022 14:25:00 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id fg16-20020a05622a581000b003a4c3c4d2d4sm2460137qtb.49.2022.10.26.14.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 14:25:00 -0700 (PDT)
Subject: Re: [PATCH 4/9] subtree: prefix die messages with 'fatal'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
 <a70fda5582d6bd84b8bedaba33768d3886846090.1666365220.git.gitgitgadget@gmail.com>
 <221021.86r0z1dtjq.gmgdl@evledraar.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <3f8e9f2f-aa98-f152-46d3-21f69dc2d3bb@gmail.com>
Date:   Wed, 26 Oct 2022 17:24:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <221021.86r0z1dtjq.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 2022-10-21 à 12:30, Ævar Arnfjörð Bjarmason a écrit :
> 
> On Fri, Oct 21 2022, Philippe Blain via GitGitGadget wrote:
> 
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Just as was done in 0008d12284 (submodule: prefix die messages with
>> 'fatal', 2021-07-10) for 'git-submodule.sh', make the 'die' messages
>> outputed by 'git-subtree.sh' more in line with the rest of the code base
>> by prefixing them with "fatal: ", and do not capitalize their first
>> letter.
> 
> I don't really care since we're unlikely to ever give git-subtree the
> i18n treatment, so translators don't need to worry about the churn.
> 
> But given how few in-tree-users we have of "die" and "git-sh-setup" this
> would be much shorter & future-proof as just e.g. (untested):
> 	
> 	diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> 	index 7562a395c24..0d8f87c5a20 100755
> 	--- a/contrib/subtree/git-subtree.sh
> 	+++ b/contrib/subtree/git-subtree.sh
> 	@@ -25,6 +25,8 @@ then
> 	 	exit 126
> 	 fi
> 	 
> 	+GIT_SH_SETUP_DIE_PREFIX='fatal: '
> 	+
> 	 OPTS_SPEC="\
> 	 git subtree add   --prefix=<prefix> <commit>
> 	 git subtree add   --prefix=<prefix> <repository> <ref>
> 	diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> 	index ce273fe0e48..81456d7266e 100644
> 	--- a/git-sh-setup.sh
> 	+++ b/git-sh-setup.sh
> 	@@ -53,7 +53,7 @@ die () {
> 	 die_with_status () {
> 	 	status=$1
> 	 	shift
> 	-	printf >&2 '%s\n' "$*"
> 	+	printf >&2 '%s%s\n' "$GIT_SH_SETUP_DIE_PREFIX" "$*"
> 	 	exit "$status"
> 	 }
> 	 
>> -		die "assertion failed: $*"
>> +		die "fatal: assertion failed: $*"
> 
> Then you could just leave this, but...
> 
>> -		die "Unknown command '$arg_command'"
>> +		die "fatal: unknown command '$arg_command'"
> 
> ...would still need to change these for the capitalization change.
>

Yeah, I guess to this could be done in a later refactor if someone wishes.

It would probably require changes to other tests scripts (since there are other users
of 'die'), though, and so would widen the scope of the series a bit too much, I would say. 
