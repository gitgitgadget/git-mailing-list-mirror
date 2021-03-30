Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BBBC433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E42619CD
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhC3TFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhC3TFX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 15:05:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76671C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 12:05:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hq27so26397513ejc.9
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 12:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IymyU8FBH75BjSwlGShcGOO9RUOqEmSngyDuhF626uA=;
        b=fLBtHrCFGtVzz9frYNrm4Xab6eoK1Mf0WjEdT6PkfbWhDxjiqLOM6ZTm0XlU/l0Zn0
         /pVf6qW3iZFWK1iBCsQpqdmI8PUKZuvCEw1GdeZw3xQKMJS68RUQxFLTIy0ex/22LSab
         ANQtQL4lwNejNmpzO/RbEcmCzH2p2AOd2nbNvqJ4UItpXpvLY8H3CVAHQNaEPR461jbS
         CTYc3j3iu3KPtVlaVEMDzyLvQe+qx1zbzPZtMJUYBNzKhjMf0rO1I9XMOYHJxcyDBJoi
         6sc95zHtKcK86IWaLHjRWpo9YW1wxZ31U+OK6I7cMUoS4b53PaZYRl+CrWih87jrjIqM
         RfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IymyU8FBH75BjSwlGShcGOO9RUOqEmSngyDuhF626uA=;
        b=h0QhGJdpKRiVNkwdRuLk0w6dwsYYT8KVPNBXUDfj+YQX8Gbdlcr6Xmq+j7NBboWYqK
         Y+n6zUEuxja6Jues8fbDQ9UGPovBqMMfKLndr+wpKf2gMVKVFope1eykPPLLBCpJXfg0
         MQMv66VsCdjGEpf6Ji8KvVn04Txu4eMMbzx61o23guCGDR7VeuYBgjA9mC8nDbMqXIpJ
         vM1ALxDtvOEny4YBuqP5ONVyHtcH+lDKkjbxHuCND3h/5RTP3rHBkqf5TSaNUdaRJvm5
         SqQzqPE6CwJx38nfW59KTLMWL2n5vvYAJMYjj8qMRmOESM23JpcRxLaXdqm/1d7iptN1
         DDwQ==
X-Gm-Message-State: AOAM532Pjtd/R8mxbySPbA4RcYroUW4WDg4zWfL33YXyUtbxXBaBLs7p
        l7Eb7pgRIwYFllSeiLlIiSUhRT5Fm66kbowSab0=
X-Google-Smtp-Source: ABdhPJx7xBFjtfWgEeZzkwqrVp4pfwGeo6al63cVO7x2uub5x76Pkm2FSV4Fu1xszjVaGy72/KOA9Q==
X-Received: by 2002:a17:906:86c1:: with SMTP id j1mr35810905ejy.373.1617131121733;
        Tue, 30 Mar 2021 12:05:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:1d6d:c581:cf0b:2ca7])
        by smtp.googlemail.com with ESMTPSA id b18sm10733542ejb.77.2021.03.30.12.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 12:05:20 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     git@vger.kernel.org
Cc:     stdedos+git@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2] pathspec: advice: long and short forms are incompatible
Date:   Tue, 30 Mar 2021 22:05:17 +0300
Message-Id: <20210330190517.21138-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <xmqqmtunks8q.fsf@gitster.g>
References: <xmqqmtunks8q.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Administrivia.
>
> If "Stavros Ntentos <133706+stdedos@users.noreply.github.com>" is an
> address that is not meant to receive any e-mail, please do not
> include it on the Cc line and force those who respond to you to
> remove it when replying.

I am trying. However, git-send-email keeps pulling that no-reply address, and
git-send-email does not offer any `--exclude-addresses="*glob*"`-like option.

> or even just
>
> 	':!(...': cannot mix short and long form pathspec magic
>
> it may be sufficiently clear where the problem is.

I slightly disagree, and prefer the `extra_lookahead_chars`. Just 3 characters
[`:!(`] is a bit too little, and the total message sits below the "you can
disable this message" hint.

> The seemingly-stray '; or' at the end aside, I am not sure what this
> is trying to say.

See the testcase:

> hint: If '(glob)*...' is a valid path, explicitly terminate magic parsing with ':'; or
> hint: Disable this message with "git config advice.mixedShortLongMagicPathspec false"

I am segway-ing from the "explicitly stop parsing" to the "disable this message" sentence.

> If ':(global,icase)foo' were the exact path the user wants to match
> with, then "prefix the whole thing with ":(literal)" would be an
> understandable hint, but that is not what you are suggesting.

I am siding with the "user entered this situation by mistake", and not with the
"user is explicitly trying to match a file named `:(global,icase)foo`" side.

Offering a more complete message, will become more complex. I disagree with that.
I can settle by offering examples (mine and yours) in the documentation.

> It may be more helpful if, rather than looking at what comes after
> '(', we looked at what came before '(' and helped the user write
> them out in the longform

I don't see any explicit code in parsing the shortform magics, except:
		/* Special case alias for '!' */
		if (ch == '^') {
			*magic |= PATHSPEC_EXCLUDE;
			continue;
		}
and therefore I would like to avoid such task (although I love well-written
DWIMs-or-close-to-them).

> > +static int extra_lookahead_chars = 7;
>
> A few problems:
>
>  - This is not something we want to configure.  It does not need to
>    be a variable.

I hate macros, only because I cannot expand or modify them during gdb.
(Suggestions welcome! :-D)

>
>  - This is not something anybody other than the code in the new
>    block "if (ch  == '(')" in parse_short_magic() needs to know.  It
>    does not need to be a file-scope static.

True, but the message was explicitly referred to with i18n code
specifically targeted for such initialization.

I like code doing the same job, sitting together.
I'd prefer to either move both inside (since no one else will ever
refer to this message either), or keep them as-is.

>  - 7 is way too long for warning against something like ":!(glob)",
>    no?

GRRRRR C :-p
(I'll push the changes on the next iteration; including the `like glob`
removed, and whatever comes from our discussion.)

> But with the above "It may be more helpful" suggestion, notice that
> I am deliberately refraining from looking at what comes after '(',
> so extra-lookahead may not be necessary after all, and nitpicking
> about it may be moot.

Lookahead is simply to inform user what git will do with the current
state of affairs, i.e.:

	git log --oneline --format=%s -- ':!(glob)**/file'

will filter with

	NOT '(glob)**/file'

path (truncated for brevity)
