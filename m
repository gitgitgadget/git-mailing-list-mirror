Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7536C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbiGYMpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiGYMo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:44:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7B1BF7
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:44:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id oy13so20365381ejb.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KWSmpwYAM/HVHws7XVw/VsMl9AsEnK/q5z3qdOXeQh0=;
        b=F8Kn40Y2zg7JJ51rgJbtBYmL3m5bBo4sU6Nfij5z0jXNZgHO8HnaGp8XIWz/rGFr70
         fY3Yzj5uGHBLSSmHtN0NRsocxPl9Kv+m+9V8VUnD4lAu8GMIk/6MHP8eolYAXJEXPpCl
         +FDQi0euWp7zbwrxjXwiwRHiHyt+p3HQVd2v6k1fVOweshNPRj/h/G/SOPyDZkFuuyEg
         BApqDJNGKP2lKkLSVQX/d3VQNeiedrpizXX0P39cqWok9ueUMCG2m88eXd50xGdq5mDv
         IrR3AZKVzTj6oI2HziVPJzyntjOLvtmxIdAGkBlS7MIa8rHkAiae/pJpEUrAfizLQ/eg
         YrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KWSmpwYAM/HVHws7XVw/VsMl9AsEnK/q5z3qdOXeQh0=;
        b=xTZKe3N7OH4J9WVq1E/np3hFTVoVxF3YhYo48D6Nb7G+HsI6xHrhB78MSpfcvNs5Da
         KasODJzJ5vj2TjdUCWqEFkRlTMGSNb1POD0i07oX2o5YWTcaNGnqGl+ujJ4pb9hVpvqY
         Xv0uwIlgrD4IId2ZtArTyI6laVhnF3RgNH6UrrNPmZoGpUWY9CGUpfEfIMHjUE8nbvi/
         rZao13QpiwsTNTXPR9oCYkDCzUf4v+rynN4sS8ArpU260XSYe2YQ1KuF152ic9kBlgm9
         v0lnVAHUOiIpOrP9Z2Ie+/4SThZPS0DB9ajhcsZ2PgxyCl/6c0fdhvnlL8VeFPeHbvs1
         mHDw==
X-Gm-Message-State: AJIora+yxVfqMhLBJzrreEUTLrqLDnts9seSuuxPD5NzJB6eJFBkvWJp
        elIZMGVOO1dEGXtqjviwJG520z8QN1Y=
X-Google-Smtp-Source: AGRyM1simMVBGwgvtXcKO0BpowntpVtcx5Czap0KDbmbxfeg7n/aL7n3NfBT8ntEK1xC/a8JGeWCYg==
X-Received: by 2002:a17:907:28d4:b0:72b:47ca:e37a with SMTP id en20-20020a17090728d400b0072b47cae37amr9727876ejc.378.1658753096507;
        Mon, 25 Jul 2022 05:44:56 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f5-20020a50fc85000000b0043bc4b28464sm7033704edq.34.2022.07.25.05.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:44:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oFxSA-005h1p-TI;
        Mon, 25 Jul 2022 14:44:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, gitster@pobox.com,
        newren@gmail.com, levraiphilippeblain@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5] submodule merge: update conflict error message
Date:   Mon, 25 Jul 2022 14:31:39 +0200
References: <20220712231935.2979727-1-calvinwan@google.com>
 <20220718214349.3379328-1-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220718214349.3379328-1-calvinwan@google.com>
Message-ID: <220725.86v8rlpdix.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Calvin Wan wrote:

I'll have some more comments, but just on the output/i18n:

> +		printf(_("Recursive merging with submodules currently only supports trivial cases.\n"
> +			"Please manually handle the merging of each conflicted submodule.\n"
> +			"This can be accomplished with the following steps:\n"));
> +		for (i = 0; i < csub->nr; i++) {
> +			printf(_(" - go to submodule (%s), and either merge commit %s\n"
> +				    "or update to an existing commit which has merged those changes\n"),

This seems to have some formatting issues, i.e. we'll emit things like:

 - one
one continued
 - tow
two continued

Whereas we want this, surely?;

 - one
   one continued
 - two
   two continued

I.e. we're using " - " to mark list items, but then not indenting the
items.


> +					csub->items[i].path,
> +					csub->items[i].oid);
> +			if (csub->items[i].resolution_exists)
> +				printf(_("such as one listed above\n"));

	that people might read this backwards
	You need to consider

:)

I.e. this is "translation lego" that we try to avoid.

It's a bit more verbose (but it often is, unfortunately)

I think you can borrow a bit from ba5e8a0eb80 (object-name: make
ambiguous object output translatable, 2022-01-27) here, i.e.:

 1. Just translate a message like "go to submodule ...\nor update to
    an", have another variant for the "resolution exists".

 2. As translators retain those \n split those lines and format them
    with e.g. _(" %s") (you could borrow the string used in
    object-name.c via ba5e8a0eb80), or _("- %s").

    This will give you list-itemized output, which will also format
    correctly in RTL languages, and takes the formatting concerns
    completely out of the hands of translators, and allows us to change
    it later ourselves.

    I.e. we can safely assume that for a \n-delimited translation we can
    take \n-delimited input from a translator and treat the first line
    specially as a "first line in new list item".

> +		}
> +		printf(_(" - come back to superproject, and `git add"));
> +		for (i = 0; i < csub->nr; i++)
> +			printf(_(" %s"), csub->items[i].path);

More inconsistent indentation, and per ba5e8a0eb80 you should explain
any addition of magical formatting like " %s" with a TRANSLATORS
comment.


> +		printf(_("` to record the above merge or update \n"
> +			" - resolve any other conflicts in the superproject\n"
> +			" - commit the resulting index in the superproject\n"));

A bit more odd formatting, i.e.:

 - A trailing  " " before a \n?

 - " " after `, what is that ` doing? At first I thought it was a typo,
   but looking again it's a continuation of `` from above

   It's quite odd to tell a user to run a command with the `` syntax,
   which is used for interpolation. Let's instead suggest:

        blah blah blah run:

		git add foo \
			bar \ [...]
	                baz

   I.e. use \ at the end of lines to note a multi-line command, not wrap
   the whole thing in ``-quotes.

 - If a message must always end in a \n just add it between _()'s,
   instead of making it part of the _() string.
