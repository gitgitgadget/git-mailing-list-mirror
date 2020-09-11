Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB09C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 21:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E599D221EB
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 21:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CDQg/QVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgIKVA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 17:00:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52962 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgIKVAW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 17:00:22 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6177B78AD8;
        Fri, 11 Sep 2020 17:00:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OZmoCbY86Ubnt2d3KfnpZxiMvAI=; b=CDQg/Q
        VJALmzJxh6B8mN+F8P8J4HqjJ/a2FgKsauO9K7F+BH6t3Nygvtn5g5Yo70/KbvfB
        qCSCnWeGIwxCjDiKtqnhvwil46pfPEV7vE/93DYxRtHFk2U62SznVhDKInkHLIB7
        Z+G5xeRUqgD/DrLpDwaw/qnHnPz599d5s9qlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BSFRnlsQB3gMTJBboZPf6t9zr2Mur5Qz
        8KeLlfj/tv2QBV94Ehut4dfzbXuHGAHWLDj++d9S7CaPsW1jBF0VOceeMePZL+R/
        uWMkog/wtKZLxKiSNxGRR1Hz284tjvCYilENlIdPXPw4RnWaP4qkonunXF+2XL0F
        Vlzo2uCDWbg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 588D078AD7;
        Fri, 11 Sep 2020 17:00:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFECB78AD6;
        Fri, 11 Sep 2020 17:00:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
Subject: Re: [PATCH 4/4] clone: allow configurable default for `-o`/`--origin`
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
        <5c519376c29a28bd89a712cf0b8125fc1c2c81be.1599848727.git.gitgitgadget@gmail.com>
Date:   Fri, 11 Sep 2020 14:00:16 -0700
In-Reply-To: <5c519376c29a28bd89a712cf0b8125fc1c2c81be.1599848727.git.gitgitgadget@gmail.com>
        (Sean Barag via GitGitGadget's message of "Fri, 11 Sep 2020 18:25:27
        +0000")
Message-ID: <xmqqwo10m3kv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB555050-F471-11EA-85A4-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sean Barag via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 1cd62d0001..aeb41f15f3 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -53,6 +53,7 @@ static int option_shallow_submodules;
>  static int deepen;
>  static char *option_template, *option_depth, *option_since;
>  static char *option_origin = NULL;
> +static char *remote_name = "origin";

This has a side effect of making all the code locations that used to
refer to option_origin much easier to read, like ...

> @@ -721,7 +722,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  		if (!option_bare) {
>  			update_ref(msg, "HEAD", &our->old_oid, NULL, 0,
>  				   UPDATE_REFS_DIE_ON_ERR);
> -			install_branch_config(0, head, option_origin, our->name);
> +			install_branch_config(0, head, remote_name, our->name);

... this place ;-)  Happy.

>  static int git_clone_config(const char *k, const char *v, void *cb)
>  {
> +	if (!strcmp(k, "clone.defaultremotename") && !option_origin)
> +		remote_name = xstrdup(v);
>  	return git_default_config(k, v, cb);
>  }

clone.defaultremotename is a single valued configuration variable,
and this correctly implements the "last one wins" behaviour (but
previous remote_name will leak every time clone.defaultremotename
is seen in the config stream).

Also this code arrangement is not quite satisfactory.  It means that
we cannot re-read any configuration variable that does not have an
accompanying command line option.  I thought the whole point of
doing the write_config() was so that anything came from the command
line option can be written back to the configuration file, so I am
not sure what the harm would be to update remote_name from the
configuration whether option_origin is used or not here.  Perhaps
add "clone.defaultremotename" to the set of configuration setting
write_config() uses, when --option is given from the command line,
and remove this special case?

By the way, I now realized why 2/4's "read twice" is OK.  init_db()
calls create_default_files() and we do clare the cached configset by
calling git_config_clear() there.

Thanks.
