Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AD2C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 09:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiG0JZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiG0JZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 05:25:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0265F93
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:25:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i13so11504813edj.11
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=wlraMQnhQVOifO1vz58epFM5uAxuEffljY8JJuQVIqg=;
        b=FP1N9nty6q1pG+0CenhaZ/FqM+TcZsKBkaMLPJJD3N0817TpFupv+W9VrSxBFt+fUN
         n1AXhi0fnjhmOR2jR/V2woLoIPTFhOpMXZDHhWD2u0B10b1wTh0Ro3D9gTcj9RRutA15
         MJzZfeJr5BMT6BWP5wCo7C5eoTFLZ7nJDV3HAeEzIu+VBjyezfToRChS5X9kD4KxHLwd
         DecAf/MFoWOOfs6t13DWVIKwysCVK34FIJRMa5rG8h6VSS/yUlrD2UwUWrspA/J1JXwK
         kDyaV4pbN7abSehIlql2uId2uztnqZce/Zl6PsgIO6MOU6PU8LI/qgQSTQ118/b04O+i
         eWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wlraMQnhQVOifO1vz58epFM5uAxuEffljY8JJuQVIqg=;
        b=6M7GA1jGJJM2j+iBe4ukuOHbAW+Zlhp8Vk+L/QXa8lup5mzVuB2ibVnrUHvv+bVwhr
         hwYiqh639Hk+Xpp2tdMh4aaa4XnzZRO0av6Lrb+F9UfK77atL2h8mXoPH8Ragm/cwycP
         WRRcqMRTwpEvTouQxSnhei5BsDT0d3NqT9qdMkp6WLnmxq57aI5L02f2UwJLN0b9u2ZV
         lcjBLNYBfA7JZTIHGST5F445ZdFAB4OGNR/l4hoNgEZZYij7LBR+gVi7szVfuZSc1dun
         YikLINn5wacrDfslNi53jSBGoUo0ZPtVdRnSM6PTqUg0xhTOhKDuEpcWIfR7uZuDkyNk
         5I+Q==
X-Gm-Message-State: AJIora9IeOPEjEbpmG+9mJicCN+TgqOy3Bt3sOSgQttPBeiUWpdq7PQy
        hgtr8Muxp5UcdEDcfhMJtLz5/p5fr5ey9A==
X-Google-Smtp-Source: AGRyM1uS8jvwPIAb3nosVCGw+RpwdZWMuJrbLe8EVeGM5X+NZ/VzxsAQFExVUUCr2bypkLDdGOgyBw==
X-Received: by 2002:a05:6402:1d54:b0:43b:e20b:4ff1 with SMTP id dz20-20020a0564021d5400b0043be20b4ff1mr19354593edb.385.1658913910140;
        Wed, 27 Jul 2022 02:25:10 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o13-20020a170906768d00b0072f9e7ce354sm6851844ejm.139.2022.07.27.02.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 02:25:09 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGdHw-006bXc-Rh;
        Wed, 27 Jul 2022 11:25:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6] submodule merge: update conflict error message
Date:   Wed, 27 Jul 2022 11:20:33 +0200
References: <20220718214349.3379328-1-calvinwan@google.com>
 <20220726210020.3397249-1-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220726210020.3397249-1-calvinwan@google.com>
Message-ID: <220727.86ilnilxfv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Calvin Wan wrote:


Aside from what Elijah pointed out already...

> +
> +	/* field that holds submodule conflict information */
> +	struct string_list conflicted_submodules;

Looks good!

>  cleanup:
> +	if (!ret) {
> +		struct string_list *csub = &opt->priv->conflicted_submodules;
> +		char *util;
> +		const char *abbrev;
> +
> +		abbrev = repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV);
> +		util = xstrdup(abbrev);
> +
> +		string_list_append(csub, path)->util = util;

Elijah pointed out that these don't need to be dup'd at all, and you
should follow that advice. I'm not really familiar at all with this code
(compared to him).

FWIW the "util" here could be dropped in any case, in my version it was
because we were making a struct, but the idiom for this would just be:

	string_list_append(....)->util = xstrdup(...);

> +			printf(_(" - go to submodule (%s), and either merge commit %s\n"
> +				    "   or update to an existing commit which has merged those changes\n"),
> +					item->string, abbrev);

FWIW what I mentioned in v5 was to arrange this so that " - " or
whatever would be _()'d separately, so translators wouldn't need to
worry about the formatting...

> +				printf("       git add %s", item->string);
> +				first = 0;
> +			} else {
> + 				printf(" \\\n               %s", item->string);

And if we're translating *some* whitespace we should translate all of
it. In RTL languages the a string like " foo" needs to be translated as
"foo ". I.e. the whitespace from the "right" side of your terminal.

That was what I was pointing out in the object-name.c code,
usage_with_options_internal() is another example.

> +			}
> +		printf(_("\n\n   to record the above merge or update\n"

We can add \n\n unconditionally, no need to put it in the translation.

