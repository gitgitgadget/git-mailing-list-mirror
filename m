Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65803C4321E
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 20:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKAUMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiKAUML (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 16:12:11 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE93B1E719
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 13:12:09 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id 7so8393504ilg.11
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RC1mkOV+aMASiH7Z1+Y2hfDxO+uwGqxlQFjTdidlb5k=;
        b=UB2dJ9tA1ibOcJmAFCsjPvqpNVtXTurFz/p8CeTvbCVHYCgbtf7vThzc8lDVy6KLqZ
         XB8q3kNYl0DKHSbBUxsyfqs24zWG2WBd+ZeddwY2pKvucb6EF2YAVWuSHtQVVshkQ56q
         GHFpqaZ5wlO7vndkO6GfLC1jogNRvcxxsFRDh9/mIDhsSoqy9WaE+ZCT+5NwCOcN4GZT
         j40UPT/O1INZ1KFQBedKNVf01zFA/PIeknc3trfKGTxJq02McThJc1V7Gf9wzVKUrzfn
         sZ8dneqs/EtPoLhmNBwjGV5gvr4DFMz/P4vpqS5w4MBKlkpSiOpkXjpalEPySD2b/Z/N
         5x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RC1mkOV+aMASiH7Z1+Y2hfDxO+uwGqxlQFjTdidlb5k=;
        b=qZwftVaOpQBarpC2U5BbyB1hOdcYnoTpY9YAzbKiYfTBDyjvgL8+E6KboasX9ARNOd
         CvDsR/N1/q1rf7xVw2NpYKAu28SpUZPwYAJW9BL9x2EM5KxjiGnqPqUgEHfAVNHcTpZm
         s0+QfMaq7cPWnXlYuPUrc8toA1x0iuSqI1JtBtlh7o6f0ZQr4yKW7+b+h6+ZmcxAbLsO
         Z8LmloR/yLpZSZgvuri7CzCdBrzgA1tdeVbrxosnKANRHw3hnNNn990cAjxnrnnhqFJb
         c7RPefjhXzDkK4vIYf7BHHMvaqnB2axVf6xKIu91BrIKxjRuZatx+DiGjNHMXidvp0kF
         Xz7g==
X-Gm-Message-State: ACrzQf2OrqZDzySGPwqVq2if8cJvIiZ10POGwJyz4NyRpBzQn7uVby8O
        8I5wq/FOe7FJZVItOsktjBeKqw==
X-Google-Smtp-Source: AMsMyM4wPK93Hx73Sn30zML/fN4jupDhRCOOf+yakSe7OSxeRe9WH9e8vhpoiJAUGdKViUONR+g4ZQ==
X-Received: by 2002:a05:6e02:6c9:b0:2ff:a4d3:3ae with SMTP id p9-20020a056e0206c900b002ffa4d303aemr12359066ils.163.1667333529121;
        Tue, 01 Nov 2022 13:12:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w70-20020a022a49000000b003572ae30370sm429180jaw.145.2022.11.01.13.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:12:07 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:12:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin von Zweigbergk <martinvonz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug in `git branch --delete main` when on other orphan branch
Message-ID: <Y2F9lkCWf/2rjT2E@nand.local>
References: <CAESOdVBpsbJ0obD=qDjHBJg-wwWUL5sQ-7X_h13Vw39Q9QUzHA@mail.gmail.com>
 <Y2DxxZAFbN8juHY6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2DxxZAFbN8juHY6@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 06:15:33AM -0400, Jeff King wrote:
> On Fri, Oct 28, 2022 at 10:46:37PM -0700, Martin von Zweigbergk wrote:
>
> > I did this:
> > git init test
> > cd test
> > echo a > file
> > git add file
> > git commit -m a
> > git checkout --orphan other
> > git branch --delete main
> >
> > The last command fails with:
> > fatal: Couldn't look up commit object for HEAD
> >
> > That's a bug, right? I can of course work around it with `rm
> > .git/refs/heads/main`.
>
> Sort of. This is part of the "is the thing we are deleting merged into
> HEAD" check. It tries to look up the HEAD and calls die() when it can't.
> The more correct thing, I think, would be for it to just return "nope,
> there is no HEAD so nothing is merged into it".

Yeah, I think that it's fair to call being unable to find HEAD in 'git
branch -d' when we are detached a bug. Indeed, if we can't find a HEAD,
then that's fine (there is just nothing merged into it, as you note).

> And in that case I think the HEAD check calling die() is actively doing
> the wrong thing, and would prevent an otherwise successful deletion.
>
> The fix might be as simple as:
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 15be0c03ef..f6ff9084c8 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -235,11 +235,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  	}
>  	branch_name_pos = strcspn(fmt, "%");
>
> -	if (!force) {
> +	if (!force)
>  		head_rev = lookup_commit_reference(the_repository, &head_oid);
> -		if (!head_rev)
> -			die(_("Couldn't look up commit object for HEAD"));
> -	}
>
>  	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
>  		char *target = NULL;
>
> as the later code seems to do the right thing with the NULL head_rev. It
> would definitely need more careful investigation (and tests!) to confirm
> that, though.

Yeah, that looks reasonable to me. Presumably we want a small test, as
well, but I doubt that is any more complicated than:

--- 8< ---
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7f605f865b..6ace22f7ce 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -279,6 +279,14 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
 	test_cmp expect err
 '

+test_expect_success 'git branch -d on detached HEAD' '
+	test_when_finished "git checkout main && git branch -D other" &&
+	git branch other &&
+	git checkout --orphan orphan &&
+	test_must_fail git branch -d other 2>err &&
+	grep "not fully merged" err
+'
+
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
 	git rev-parse --verify refs/heads/t &&
--- >8 ---

I'm happy to wrap all of that up into a patch, and equally happy for you
to do so (feel free to forge my S-o-b here if you do).

Thanks,
Taylor
