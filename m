Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624C1C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 23:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJNXqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 19:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJNXqW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 19:46:22 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7025ADEAA
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 16:46:21 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E39D71C2A1F;
        Fri, 14 Oct 2022 19:46:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/iVsg0V0TtHIOyl6ML/zyKmjuYXCbCwlB9zCpJ
        jBASk=; b=begoY+x8rb5rHye1ad9EMQ5MTVFjMvhsc/W4xvHXnxB8qSI33u/MQ/
        m88lAq6sUN58dBH8Jcxx6nOQRj453iy/ghYGYJRaxvoXnAkFINmRFsG91fBQiCqY
        YomZsiAOkHXDc8LGoHa4dhQhyIFcGVBFcTe0VEAfQWaHUlY8JZ5h0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB71D1C2A1E;
        Fri, 14 Oct 2022 19:46:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1C5561C2A1D;
        Fri, 14 Oct 2022 19:46:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v2 07/12] fsmonitor: prepare to share code between Mac
 OS and Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <295beb89ab10f001724fb64fa55944d05ee29fc7.1665783945.git.gitgitgadget@gmail.com>
Date:   Fri, 14 Oct 2022 16:46:17 -0700
In-Reply-To: <295beb89ab10f001724fb64fa55944d05ee29fc7.1665783945.git.gitgitgadget@gmail.com>
        (Eric DeCosta via GitGitGadget's message of "Fri, 14 Oct 2022 21:45:39
        +0000")
Message-ID: <xmqqmt9y55py.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65EE4368-4C1A-11ED-8732-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  ifdef FSMONITOR_DAEMON_BACKEND
>  	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
> +	ifdef FSMONITOR_DAEMON_COMMON
> +		COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_COMMON).o
> +	else
> +		COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
> +	endif
>  	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
>  	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
> -	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
>  endif
>  
>  ifdef FSMONITOR_OS_SETTINGS
>  	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
> +	ifdef FSMONITOR_DAEMON_COMMON
> +		COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_COMMON).o
> +	endif
>  	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
>  	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
>  endif

Ugly.  

One overrides backend with common, while the other one doesn't.
That asymmetry alone should stop us and wonder if there is something
fishy in the approach that can be improved.  It makes it look like
the word "common" means something quite different between the -ipc
and the -settings world.

I suspect that in both, you should not expose "unix" to this part of
the Makefile.  Linux and macOS occasionally being similar in some
places does not have to be exposed here.  INstead you can use
backend "linux" and "macos", whose C sources may include from a
separate C source file whose name may contain "unix".  That would
allow you to get rid of FSMONITOR_DAEMON_COMMON in a cleaner way.
