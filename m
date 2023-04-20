Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C9AC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 19:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjDTTQN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 15:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDTTQM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 15:16:12 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E7D26B2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 12:16:09 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 3B0BD40003;
        Thu, 20 Apr 2023 19:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1682018168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WM3mCSyiE8xN8VUtVCez/VFww4PmFhnldxQi9TCugaM=;
        b=GQ6oorOs3UjoA+qwMS2uE1AT+a3cDgLvobVQxqQEGyQlhrZX0UiwRNroF3zW8AL133qUhG
        bqh1MBM6GhlScqiR22xo39UIO94LIFzciz6OQnLsM3e8bzn5tzIyv+9+Y9+EhnZUB6sG2u
        xRs2myDdZlRz1hnvphdhmLDdk4MmxGO6WgBdGIItlXL0WsIBIUWa5dTTs+YY0X68TVJWSn
        bJ89r8AJO1G3m2Yzg8efnhE4cOBPIGvpGHcwMe89SxDxLrXlmfu1QoqNHmwwRT8OFcOSax
        wx55KIYFsaIBNgEIZQcsKB+KIDhFyiBGYwTxPOaciMxnJzHuA+yIIk7E+oRo+Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 20 Apr 2023 21:16:05 +0200
Message-Id: <CS1TOE1MCMH0.2OMA9UHSDG7RC@ringo>
Cc:     "Phillip Wood" <phillip.wood123@gmail.com>,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH v5] send-email: export patch counters in validate
 environment
From:   "Robin Jarry" <robin@jarry.cc>
To:     <git@vger.kernel.org>
X-Mailer: aerc/0.14.0-180-g18d3291fb702-dirty
References: <20230414152843.659667-1-robin@jarry.cc>
 <20230414155249.667180-1-robin@jarry.cc>
In-Reply-To: <20230414155249.667180-1-robin@jarry.cc>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Jarry, Apr 14, 2023 at 17:52:
> diff --git a/templates/hooks--sendemail-validate.sample b/templates/hooks=
--sendemail-validate.sample
> new file mode 100755
> index 000000000000..ad2f9a86473d
> --- /dev/null
> +++ b/templates/hooks--sendemail-validate.sample
> @@ -0,0 +1,77 @@
> +#!/bin/sh
> +
> +# An example hook script to validate a patch (and/or patch series) befor=
e
> +# sending it via email.
> +#
> +# The hook should exit with non-zero status after issuing an appropriate
> +# message if it wants to prevent the email(s) from being sent.
> +#
> +# To enable this hook, rename this file to "sendemail-validate".
> +#
> +# By default, it will only check that the patch(es) can be applied on to=
p of
> +# the default upstream branch without conflicts in a secondary worktree.=
 After
> +# validation (successful or not) of the last patch of a series, the work=
tree
> +# will be deleted.
> +#
> +# The following config variables can be set to change the default remote=
 and
> +# remote ref that are used to apply the patches against:
> +#
> +#   sendemail.validateRemote (default: origin)
> +#   sendemail.validateRemoteRef (default: HEAD)
> +#
> +# Replace the TODO placeholders with appropriate checks according to you=
r
> +# needs.
> +
> +validate_cover_letter() {
> +	file=3D"$1"
> +	# TODO: Replace with appropriate checks (e.g. spell checking).
> +	true
> +}
> +
> +validate_patch() {
> +	file=3D"$1"
> +	# Ensure that the patch applies without conflicts.
> +	git am -3 "$file" || return
> +	# TODO: Replace with appropriate checks for this patch
> +	# (e.g. checkpatch.pl).
> +	true

Hey folks,

I had an idea after sending v5. Instead of leaving TODO placeholders, it
would be nicer to introduce other git config sendemail.validate* options
specific to this hook template so that users can directly use it without
any modifications simply by setting options in their local clone:

    git config sendemail.validatePatchCmd 'tools/checkpatch.sh'
    git config sendemail.validateSeriesCmd 'make tests lint'

And reuse these commands if defined in the hook template.

What do you think?
