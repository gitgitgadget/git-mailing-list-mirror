Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED6BC54EE9
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 23:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIQXUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Sep 2022 19:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQXUU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2022 19:20:20 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E7921E10
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 16:20:19 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id s13so19343605qvq.10
        for <git@vger.kernel.org>; Sat, 17 Sep 2022 16:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=pWtP9bOF2qt9XPJe5h7zxEedH8j9CtMDTUa39aCWrPc=;
        b=V5dFT/66ipUrbIbSZX2F/T+ERvu2KoBaIfz0Jq6MyyEDrzuDxHv90pAxym9QE0M6eo
         mpzLQ2oheYwab7wFMG0+LoZ5Qqyk61/TTtJ6yNBazMwyxYd/Ae2xBANln2c1LXbQZ/62
         yskZBehB7+EkmweDYfcSh9RbVYm7nndl4eoCKOK5BzBzxfwVms85m8hqOyCIR9KKHqGi
         ggEmTWl83M7NahuH7d7enTqLyRtOnBLcWCcMTJgZ9nut3H0SE6CR3zY7FUSbYK16p84o
         OlntaVbGRYqAk3h/HqHCDMaMVV2wJUpGiLkVKxstMwCoUFLGVpgPJazFROOmFp7G/JwA
         v99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=pWtP9bOF2qt9XPJe5h7zxEedH8j9CtMDTUa39aCWrPc=;
        b=zVpKIG2Bg08dl4h3lfbuTcWeDeJGcHS+D6EMi+3kznvLOyZvtUZtS72LNgi2QqlFIP
         k8ogS+g1/UOHke0pHv8nUQARJzjWC1xloqg2PgFiVQ9iVE2Ihu4OvPu5qGZl3b4TgV9y
         RQiOuHZHNinE+pmfYll1owq8vtvQ7dkgbE+ay3JvpDn7IlLZFxfCHMR+tDw4K174Gg72
         aTHg6FyemKYgql232jrpLwDCEb7lgG1Yj3nXtN4g2zrTXcGIXBaToJzZfDiNwXwxMufl
         r8gavVGNkd4nzvv0RAm0hO7B/XrlmIrus0nYik0OzjKwbqRPfajginbO+m6K9nzavOS3
         AkcA==
X-Gm-Message-State: ACrzQf1wOp88aQkKnbLeKON0Rms6wb7l6MQgH4+ZOg+IOqD/B1nQOO9d
        1jTHwKJ+XML4GeZzobq+zp3AomTNEQE=
X-Google-Smtp-Source: AMsMyM5qkHbyf8eTy6x/IMfvrcSlEzkTez+wpm3vTUgK+wXfz13aQCKjS2hZKGS7JDQvAXhjO/g0eA==
X-Received: by 2002:a05:6214:20e2:b0:4ac:b9a6:17be with SMTP id 2-20020a05621420e200b004acb9a617bemr9140370qvk.104.1663456818542;
        Sat, 17 Sep 2022 16:20:18 -0700 (PDT)
Received: from gmail.com (207-237-203-247.s3058.c3-0.arm-cbr1.chi-arm.il.cable.rcncustomer.com. [207.237.203.247])
        by smtp.gmail.com with ESMTPSA id u16-20020a05620a0c5000b006bbe7ded98csm9304576qki.112.2022.09.17.16.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 16:20:18 -0700 (PDT)
Date:   Sat, 17 Sep 2022 18:19:42 -0500
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] fixup commit is dropped during rebase if subject = branch
 name
Message-ID: <YyZWDkZWAkS7q+Wf@gmail.com>
References: <CA+JQ7M_Xwxa48ggu88rhA9dG6R3u820Tgu8B2Kg-uMbEVjy3Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+JQ7M_Xwxa48ggu88rhA9dG6R3u820Tgu8B2Kg-uMbEVjy3Vg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 17, 2022 at 04:45:17PM +0200, Erik Cervin Edin wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
>   dir=rebase-fixup-subject-equals-branch-name
>   mkdir $dir
>   cd $dir
>   git init --initial-branch=main
>   git commit -m init --allow-empty
>   git tag init
> 
>   # failure
>   seq 1 3 >> bar && git add bar && git commit -m main
>   git tag -f x
>   seq 4 6 >> bar && git add bar && git commit -m bar
>   seq 7 9 >> bar && git add bar && git commit --fixup :/main
>   git -c sequence.editor=: rebase --autosquash --interactive x

Huh, this silently discards the fixup commit, without applying it.

If "foo" is a valid refspec, then the autosquash machinery will apply to it
all fixup commits with subject "fixup! foo".
The problem you hit is that "foo" points to the fixup commit itself - which
is the only destination commit that definitely won't work.

Here is a possible fix:

diff --git a/sequencer.c b/sequencer.c
index 79dad522f5..7cbd8c2595 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6231,3 +6231,3 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 				 (commit2 =
-				  lookup_commit_reference_by_name(p)) &&
+				  lookup_commit_reference_by_name(p)) != item->commit &&
 				 *commit_todo_item_at(&commit_todo, commit2))
