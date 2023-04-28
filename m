Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C696FC77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346426AbjD1SgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345984AbjD1SgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 14:36:11 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF919B9
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:36:09 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a92369761cso2236725ad.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682706969; x=1685298969;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buXfnl5wxZ4cH0JaW5fI7FaXRIkDhv6VwpvWvVDAZwQ=;
        b=UmDej84itLKVaBR23twbOcL2PIjEDG97PXtVz3RpQuHeKAsS2DCWb98QVAY2HG0uGT
         MIIfrgp/PexJFfb9KbjpBnGxwwoiBkS0ML01/KFcLPXtvH2kcxpesazcgE3vdr9YbBWK
         RjhCzcTppD6U/roO3NLDVkqLmjW4OXhFfkdE4UCHfp70b+f4odmdcFtecQfL6cUNnUU0
         zyKWR83jW3mg3AOzerfb0/5KCQ7oehwXhuabtWOjP3kPLStpv7AsAm+MmHLpETBE3MKX
         Y0A1vaOgwUOty80+64EiovEPOv6FAXz8zHW/d29jP7VyijlfCD+/ewlrRhg3y4NLgdW4
         BbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682706969; x=1685298969;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=buXfnl5wxZ4cH0JaW5fI7FaXRIkDhv6VwpvWvVDAZwQ=;
        b=IwPe9LEXns1TOvtCz75DBX+82falfCCmOsq8XNNB2K1SxxiLGZf0c7ql1G4YvAk3l6
         L0R/8RtMh9qrqSeDUT5untGburmY8sVzKDKkqskrHVtzWloDZg25xjb2g6FhgHjBqQOh
         36r7rMFJOwmuNz9eZwC/p7GwgCrg2Ixyb6FcVYs3XOpDL5eQYNg9aW6pzr90yyaSRl07
         sEgYdwsGuUBy5CymTic5FW/qsRmT6qsdEF3zaL0Q4q9Zi0dPiAI8olaoajyuQR4QuYS3
         c64Qgsdem5PsH60e+XX3dXG9nkexVZLOrLMZH48+uXjIxenHqAmmBNB4ahbGcntcErUZ
         ssZw==
X-Gm-Message-State: AC+VfDwM2VJirowdOo1YjRweHuYhVLAEuqQgP6sSaI/Exy+anjrVp69B
        QfalzsyXTgvHPyML+b4yqg4=
X-Google-Smtp-Source: ACHHUZ5c/XtMUuFLekvgEUrHafJQr5k7qjql2J2fLFzlmfIr1cfzJ8o1OzHaGoZKB0AKRenK3LUFSQ==
X-Received: by 2002:a17:902:ce8a:b0:1a2:76b6:c26a with SMTP id f10-20020a170902ce8a00b001a276b6c26amr7601757plg.28.1682706968821;
        Fri, 28 Apr 2023 11:36:08 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902760e00b001a972e9d4f4sm9046507pll.102.2023.04.28.11.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:35:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
Date:   Fri, 28 Apr 2023 11:35:28 -0700
In-Reply-To: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Fri, 28 Apr 2023 10:35:28 +0200")
Message-ID: <xmqqcz3netxr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> Instead of generating a silly-looking `Revert "Revert "foo""`, make it
> a more humane `Reapply "foo"`.
>
> The alternative `Revert^2 "foo"`, etc. was considered, but it was deemed
> over-engineered and "too nerdy". Instead, people should get creative
> with the subjects when they recurse reverts that deeply. The proposed
> change encourages that by example and explicit recommendation.
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---

> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index d2e10d3dce..e8fa513607 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -31,6 +31,12 @@ both will discard uncommitted changes in your working directory.
>  See "Reset, restore and revert" in linkgit:git[1] for the differences
>  between the three commands.
>  
> +The command generates the subject 'Revert "<title>"' for the resulting
> +commit, assuming the original commit's subject is '<title>'.  Reverting
> +such a reversion commit in turn yields the subject 'Reapply "<title>"'.

Clearly written.

> +These can of course be modified in the editor when the reason for
> +reverting is described.

Not just the title but the entire message can be edited and that is
by design.  Having to modify what this new mechanism does when
existing users do not like the new behaviour will annoy them, and
this sentence will not be a good enough excuse to ask them
forgiveness for breaking their established practice, either.

So, I am not sure if there is a point to have this sentence here.

> diff --git a/sequencer.c b/sequencer.c
> index 3be23d7ca2..61e466470e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2227,13 +2227,27 @@ static int do_pick_commit(struct repository *r,
>  	 */
>  
>  	if (command == TODO_REVERT) {
> +		const char *orig_subject;
> +
>  		base = commit;
>  		base_label = msg.label;
>  		next = parent;
>  		next_label = msg.parent_label;
>  		if (opts->commit_use_reference) {
>  			strbuf_addstr(&msgbuf,
>  				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> +		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject)) {
> +			if (skip_prefix(orig_subject, "Revert \"", &orig_subject)) {
> +				/*
> +				 * This prevents the generation of somewhat unintuitive (even if
> +				 * not incorrect) 'Reapply "Revert "' titles from legacy double
> +				 * reverts. Fixing up deeper recursions is left to the user.
> +				 */

Good comment but in an overwide paragraph.

> +				strbuf_addstr(&msgbuf, "Revert \"Reapply \"");
> +			} else {
> +				strbuf_addstr(&msgbuf, "Reapply \"");
> +			}
> +			strbuf_addstr(&msgbuf, orig_subject);
>  		} else {
>  			strbuf_addstr(&msgbuf, "Revert \"");
>  			strbuf_addstr(&msgbuf, msg.subject);


> diff --git a/t/t3515-revert-subjects.sh b/t/t3515-revert-subjects.sh
> new file mode 100755
> index 0000000000..ea4319fd15
> --- /dev/null
> +++ b/t/t3515-revert-subjects.sh

It is a bit unexpectd that we need an entire new file to test this.
It is doubly bad that the title of the file is only about the
subject of revert commits and does not allow other things to be
added later.  Are we planning to have a lot more creativity in how
automatically generated subject of revert commits would read?

If there isn't a good enough test coverage for the "git revert"
command already, then having a new file to test "git revert" would
be an excellent idea, adding one here is a very welcome addition,
and it is perfectly fine to start such a new test with only these
new tests that protects the new "Revert Revert to Reapply" feature.

But if there is a test file already for "git revert" that covers
other behaviour of the command, "create two new commits, i.e. revert
and revert of revert, and then try reverting them and see what their
subject says" ought to be a simple addition or two to such an
existing test file.  Doesn't t3501 seem a better home for them?  The
last handful of tests there are about how the auto-generated log is
phrased, and would form a good group with this new feature, wouldn't
it?

> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +
> +test_description='git revert produces the expected subject'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'fresh reverts' '
> +    test_commit --no-tag A file1 &&
> +    test_commit --no-tag B file1 &&
> +    git revert --no-edit HEAD &&
> +    echo "Revert \"B\"" > expect &&

Style.  See Documentation/CodingGuidelines and look for "For shell
scripts specifically".

> +    git log -1 --pretty=%s > actual &&
> +    test_cmp expect actual &&
> +    git revert --no-edit HEAD &&
> +    echo "Reapply \"B\"" > expect &&
> +    git log -1 --pretty=%s > actual &&
> +    test_cmp expect actual &&
> +    git revert --no-edit HEAD &&
> +    echo "Revert \"Reapply \"B\"\"" > expect &&
> +    git log -1 --pretty=%s > actual &&
> +    test_cmp expect actual
> +'
> +
> +test_expect_success 'legacy double revert' '
> +    test_commit --no-tag "Revert \"Revert \"B\"\"" file1 &&
> +    git revert --no-edit HEAD &&
> +    echo "Revert \"Reapply \"B\"\"" > expect &&
> +    git log -1 --pretty=%s > actual &&
> +    test_cmp expect actual
> +'
> +
> +test_done

Thanks.
