Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800C1C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 17:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E11361244
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 17:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347366AbhDMRuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 13:50:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52710 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347359AbhDMRuD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 13:50:03 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52CD9CD983;
        Tue, 13 Apr 2021 13:49:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GDXIV1uDVRdHoycnqyqju99tL0w=; b=XM2Y/q
        F/hot+ddTmSoQx2SnZ/mmQnkPdOg2+M51pAHw+5wxMd41ndNaP37Li34dUE+I/X+
        gXpsGnrbVjvkZ1YI824r9SMwUxHgVBWqCnvHR9DRCo2n7DsqIXxRRC2gDovn/Ori
        AUSa88W7OqAX2Chmv9smiHRcqshT01f1PjFbs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l0t6XTwivuVW+WlC36kh9twpD5PgEobC
        N2Ks4nNAUMwmlocz7Swa6RaDoEGw6G8uIwX6o0IP8vDu0QPy2/WLZXFb0rNzXA5L
        rFhjyP4E5kS1gDiXKxOG9IYsm+BE+ePIEoog/MIchLzYD1dqahJUC3+a2ZvJt+uZ
        inUm6oSYeUA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41FD1CD980;
        Tue, 13 Apr 2021 13:49:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C596CCD97F;
        Tue, 13 Apr 2021 13:49:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/3] config: allow overriding global/system config
References: <cover.1618238567.git.ps@pks.im> <cover.1618297711.git.ps@pks.im>
Date:   Tue, 13 Apr 2021 10:49:40 -0700
In-Reply-To: <cover.1618297711.git.ps@pks.im> (Patrick Steinhardt's message of
        "Tue, 13 Apr 2021 09:11:37 +0200")
Message-ID: <xmqqblaim5vv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FF419CA-9C80-11EB-B541-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Compared to v3, I only dropped the special-casing of `/dev/null`. As
> Junio rightly pointed out, the special-casing was incomplete and would
> have required more work to do the right thing for all cases. It can
> still be re-added at a later point if the usecase actually comes up.
>
> Patrick
>
> Patrick Steinhardt (3):
>   config: rename `git_etc_config()`
>   config: unify code paths to get global config paths
>   config: allow overriding of global and system configuration
>
>  Documentation/git-config.txt |  5 +++
>  Documentation/git.txt        | 10 +++++
>  builtin/config.c             |  6 +--
>  config.c                     | 41 +++++++++++++++------
>  config.h                     |  4 +-
>  t/t1300-config.sh            | 71 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 121 insertions(+), 16 deletions(-)

This round looks good to me.  Sorry for suggesting the "/dev/null"
thing in the first place to lead you into wild goose chase during
the last round.

Will queue.  Thanks for working on it.

And thanks for reviewing, everybody.

>
> Range-diff against v3:
> 1:  34bdbc27d6 = 1:  34bdbc27d6 config: rename `git_etc_config()`
> 2:  30f18679bd = 2:  30f18679bd config: unify code paths to get global config paths
> 3:  af663640ae ! 3:  d27efc0aa8 config: allow overriding of global and system configuration
>     @@ Commit message
>              - If unset, git continues to use the usual locations.
>      
>              - If set to a specific path, we skip reading the normal
>     -          configuration files and instead take the path.
>     -
>     -        - If set to `/dev/null`, we do not load either global- or
>     -          system-level configuration at all.
>     +          configuration files and instead take the path. By setting the path
>     +          to `/dev/null`, no configuration will be loaded for the respective
>     +          level.
>      
>          This implements the usecase where we want to execute code in a sanitized
>          environment without any potential misconfigurations via `/dev/null`, but
>     @@ Documentation/git.txt: for further details.
>       	Whether to skip reading settings from the system-wide
>       	`$(prefix)/etc/gitconfig` file.  This environment variable can
>      
>     - ## builtin/config.c ##
>     -@@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
>     - 		char *user_config, *xdg_config;
>     - 
>     - 		git_global_config(&user_config, &xdg_config);
>     --		if (!user_config)
>     -+		if (!user_config) {
>     -+			if (getenv("GIT_CONFIG_GLOBAL"))
>     -+				die(_("GIT_CONFIG_GLOBAL=/dev/null set"));
>     -+
>     - 			/*
>     - 			 * It is unknown if HOME/.gitconfig exists, so
>     - 			 * we do not know if we should write to XDG
>     -@@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
>     - 			 * is set and points at a sane location.
>     - 			 */
>     - 			die(_("$HOME not set"));
>     -+		}
>     - 
>     - 		given_config_source.scope = CONFIG_SCOPE_GLOBAL;
>     - 
>     -
>       ## config.c ##
>      @@ config.c: static int git_config_from_blob_ref(config_fn_t fn,
>       
>       char *git_system_config(void)
>       {
>      +	char *system_config = xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
>     -+	if (system_config) {
>     -+		if (!strcmp(system_config, "/dev/null"))
>     -+			FREE_AND_NULL(system_config);
>     ++	if (system_config)
>      +		return system_config;
>     -+	}
>       	return system_path(ETC_GITCONFIG);
>       }
>       
>     @@ config.c: static int git_config_from_blob_ref(config_fn_t fn,
>      +	char *user_config = xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
>      +	char *xdg_config = NULL;
>      +
>     -+	if (user_config) {
>     -+		if (!strcmp(user_config, "/dev/null"))
>     -+			FREE_AND_NULL(user_config);
>     -+		xdg_config = NULL;
>     -+	} else {
>     ++	if (!user_config) {
>      +		user_config = expand_user_path("~/.gitconfig", 0);
>      +		xdg_config = xdg_config_home("config");
>      +	}
