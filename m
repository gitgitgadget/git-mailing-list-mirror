Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B410CFA373D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 16:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJUQe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 12:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJUQey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 12:34:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAABC6A50A
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:34:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t16so7961916edd.2
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1UXZU02jd6x42J0nV8Nvrc2q70+vKMbWol+WbCWJ9qw=;
        b=bZVYhHWDkJnjM8y++x/BdXuOr3il9sKCx3vgQ1TsUz4O8S77KhlaRVZn0hpO+LQ6dT
         GU5KDHMdIsWDb6qvhUV4unCC/Oqrw7bAmtNfgzlLJ2MgYxBYTzR2wvZQMk5jLavjKhlF
         DKtKCtrV4xgwihlAbObk3vqEIP+1QS8WPba3qSXNWIPuHnp3du14PBeEOJfIPahUzZMB
         pcHtzu/0kUoMww7H4Rvmqsg4nuO4h1mxK3lT//viBiHICSvlf/D1xnMEGOKccppeJVn1
         TOK/WH8tnUmTLL3OebmLgH5DOOQ9NvgWF/f+tiDcVLDhiRn5xf9Qy7uvKGUnk6wWxm5U
         +yAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UXZU02jd6x42J0nV8Nvrc2q70+vKMbWol+WbCWJ9qw=;
        b=LP7xgFWlKjsXSaaJKbWUVx3FsTo9Iujd82N4HABR2qsQconHqaSY3QhF7A52j6xtmC
         bLbRRin5A0bR3VGDYHLZvUy5UAJ0AGvRfkXGsKRRcEy4xXbtAUulZRTzS8ILAHjNVnet
         IkVQ0MDdk3Vpm2wpcyAr5I/rWc3oRdpnY+qq361X+tHEzVMB01nyODgEodOqWcVDzpDh
         pfbHIQuXd6JgVjPIRx/Q9YYmmXb6WHSmOtYp/Do2YEJAK6W5cRHqd0WcU9iq/k/yQBXQ
         mOvTO8s9PRsjs8J8hOKNowgmthA2BCpOFZmNTyoSmMDWwghvbtuMfnrKZuGkO6HznrqY
         uq8A==
X-Gm-Message-State: ACrzQf2XwqGjH4ldsQnw4vdczeNGRIhbFqKRuJ/r54uuzDc+gfHPuHEo
        8y8kyqvbvZUczDT6p2C4gLiRTAZoq0tsyg==
X-Google-Smtp-Source: AMsMyM4dePdZ3IMr5tDwA9vndRc623FNsceuhgW9Yu3yCRjn/gz/hiVsLdvKoBs5dGkfmH05/X9dYA==
X-Received: by 2002:a17:907:97cc:b0:797:c389:de5f with SMTP id js12-20020a17090797cc00b00797c389de5fmr7559679ejc.627.1666370091492;
        Fri, 21 Oct 2022 09:34:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fe7-20020a056402390700b004587c2b5048sm13853510edb.52.2022.10.21.09.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:34:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oluyv-0075X9-25;
        Fri, 21 Oct 2022 18:34:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 4/9] subtree: prefix die messages with 'fatal'
Date:   Fri, 21 Oct 2022 18:30:44 +0200
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
 <a70fda5582d6bd84b8bedaba33768d3886846090.1666365220.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <a70fda5582d6bd84b8bedaba33768d3886846090.1666365220.git.gitgitgadget@gmail.com>
Message-ID: <221021.86r0z1dtjq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 21 2022, Philippe Blain via GitGitGadget wrote:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Just as was done in 0008d12284 (submodule: prefix die messages with
> 'fatal', 2021-07-10) for 'git-submodule.sh', make the 'die' messages
> outputed by 'git-subtree.sh' more in line with the rest of the code base
> by prefixing them with "fatal: ", and do not capitalize their first
> letter.

I don't really care since we're unlikely to ever give git-subtree the
i18n treatment, so translators don't need to worry about the churn.

But given how few in-tree-users we have of "die" and "git-sh-setup" this
would be much shorter & future-proof as just e.g. (untested):
	
	diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
	index 7562a395c24..0d8f87c5a20 100755
	--- a/contrib/subtree/git-subtree.sh
	+++ b/contrib/subtree/git-subtree.sh
	@@ -25,6 +25,8 @@ then
	 	exit 126
	 fi
	 
	+GIT_SH_SETUP_DIE_PREFIX='fatal: '
	+
	 OPTS_SPEC="\
	 git subtree add   --prefix=<prefix> <commit>
	 git subtree add   --prefix=<prefix> <repository> <ref>
	diff --git a/git-sh-setup.sh b/git-sh-setup.sh
	index ce273fe0e48..81456d7266e 100644
	--- a/git-sh-setup.sh
	+++ b/git-sh-setup.sh
	@@ -53,7 +53,7 @@ die () {
	 die_with_status () {
	 	status=$1
	 	shift
	-	printf >&2 '%s\n' "$*"
	+	printf >&2 '%s%s\n' "$GIT_SH_SETUP_DIE_PREFIX" "$*"
	 	exit "$status"
	 }
	 
> -		die "assertion failed: $*"
> +		die "fatal: assertion failed: $*"

Then you could just leave this, but...

> -		die "Unknown command '$arg_command'"
> +		die "fatal: unknown command '$arg_command'"

...would still need to change these for the capitalization change.
