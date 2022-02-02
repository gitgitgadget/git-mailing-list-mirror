Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8175C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347555AbiBBVco (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiBBVcn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:32:43 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BA6C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:32:43 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a19so439334pfx.4
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:user-agent:date:message-id
         :mime-version;
        bh=b8dmNyW+lIIOqUag155wRRFoqs7t/8G2zh3XRH+7zPc=;
        b=HXpyiie05LYS/treBDJWLv6f4B3Iff1+Ubvr2b4ItE40vnOkKc6fuYFiahs17XgjFL
         rU8CMKgnREB1uV4KBV3tmAxFVHPoWynQVmRqLDGA5K59+4b1LIY/Lc7TKkY3xxHw7nba
         NmjTmwJDyQti7N/OgH7LAOKsgUyKZvNHTjBINNJim15Zi+phSzq+RdXzs8pHvpU8Lke+
         KI0fYBLDOWBXb+eRAt6qsDKHXDOlIq0SDJYqnvW8h+b1pokJP7t2VLYkJ2YFwTm/O2oy
         7s15WHGZAvku+N1VQSL7xodhxnL0i5Npm5kPKbLafga8g6QhvdwNJDxin01sBlZl+ssu
         SACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:user-agent
         :date:message-id:mime-version;
        bh=b8dmNyW+lIIOqUag155wRRFoqs7t/8G2zh3XRH+7zPc=;
        b=yKj9IxDvAe3AMLCz+w84kVj85ScgZy2LQQI3xMctebFLzpB2La0TFGGRQ/fXUW9i3Y
         MXOYFRNuu1VJuiuwlc28cYUzjzmFHNxuCg3amfclV9ka9IWFSUowgV3HSR4z/OLAvC02
         leK9O4nqqod6ccACrkhhMPf1OSsPm1aP9VBW8xzeQwR+TUxPjPxHK4H/wYoFVzoW85G8
         4ZDdxj001DsUXF96fcXrp5dmlMk3pVRo3uZRmgkjreUoKvlVcDUtNgDUlRWVSMy+4Tsl
         gbxdawz+VpEvt7pkTsvhjni/Zvp8upbtck1PvVe8A3dZp+6JsNXdH1Fg0Ae6KkO0MImS
         OISg==
X-Gm-Message-State: AOAM53112nYYw6Y1g7t9ByXsmEkZPSqNpTih5vGJEoewZmq6sT44kS6P
        zTedlxlndO1gOevKq1jveR0=
X-Google-Smtp-Source: ABdhPJxB3WadpseETMWC4EWZLqSaARoqtcBKPCTWrP2eW4I7QCiKySe1JNBgd/ytw0r4Tt9Jm20egQ==
X-Received: by 2002:a63:fb0e:: with SMTP id o14mr25970300pgh.184.1643837562351;
        Wed, 02 Feb 2022 13:32:42 -0800 (PST)
Received: from localhost ([2620:15c:289:200:da7f:76ba:d0d5:da44])
        by smtp.gmail.com with ESMTPSA id nv13sm8890862pjb.17.2022.02.02.13.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:32:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 10/13] merge-tree: provide a list of which files have
 conflicts
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <243134dc2478e21f67a6d9cb999d6754b616f6ee.1643479633.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 02 Feb 2022 13:32:41 -0800
Message-ID: <xmqq35l1x8cm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +Conflicted file list
> +~~~~~~~~~~~~~~~~~~~~
> +
> +This is a sequence of lines containing a filename on each line, quoted
> +as explained for the configuration variable `core.quotePath` (see
> +linkgit:git-config[1]).

Makes sense.  Ideally things like this should be discoverable by
inspecting the tree object shown as the result of the (conflicted)
merge, but since the design of the output is to show only a single
tree, there is nowhere to store such an extra piece of information
per path (grepping for markers in blobs of course does not count).

I guess an alternative to show four trees when conflicted instead of
one (i.e. the primary tree may either contain only the cleanly
merged paths _or_ also blobs with conflict markers for conflicted
paths; the three other trees record three stages that would be in
the index, if we were performing the same merge using the index),
but a machine-parseable list of paths is fine.

> +		merge_get_conflicted_files(&result, &conflicted_files);
> +		for (i = 0; i < conflicted_files.nr; i++) {
> +			const char *name = conflicted_files.items[i].string;
> +			if (last && !strcmp(last, name))
> +				continue;
> +			write_name_quoted_relative(
> +				name, prefix, stdout, line_termination);
> +			last = name;

OK.  The iteration used here makes casual readers wonder why the
helper doesn't make paths unique, but the string list item holds
in its util pointer a pointer to a structure with <stage, mode, oid>
tuple, so it is natural to make the consumer, who wants uniquified
list, responsible for deduping, like this loop.

> +		}
> +		string_list_clear(&conflicted_files, 1);

And the stage-info structure associated with these paths are
deallocated with this call.  Good.

> +	}

