Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980D71F404
	for <e@80x24.org>; Thu, 16 Aug 2018 16:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392160AbeHPTEW (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 15:04:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36540 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388322AbeHPTEV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 15:04:21 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so4819967wmc.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ePD4KujGanwcVK4MveoPJDQfOv4CFU1A/nVOgR874YI=;
        b=VuaTrnPOmTXSjDZZdBYfWDOcvUpzx9cy4NfTShksmEkIrkNuHdbexcVW/wy/dSkJlH
         +IHhuuFpNNYagjUHeX7lDV3Ebug8y+4HXGEJ88FKuykcArLSxzPfrnb2bMvurWNxrjsF
         GyfqSyzjZNYvaxVDVeaUPnVLLDp7yC6NnOBexIRxvoU7w6jI6eTBCZg0L5QtQXCXh8Ar
         vISiGvglOwPC3CIfD5NcfwvgKRloj9ANwiCd1a0/OTbFgwpwZqe3x7uiffJbzJmQefff
         Vcqe7AnOp+I1HdSCoKy1C4OiRUVOrGvGaTcSIez4fz72rs9l44LXufqiNxKPXiRChq9x
         jmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ePD4KujGanwcVK4MveoPJDQfOv4CFU1A/nVOgR874YI=;
        b=XZ/+sVWyKR4RyvGLni2vlAGNG6co3MtG79pTsCjvVGmsC7Jqm6lgUG51hcqjDXjsWy
         fLykoVWdG8ALNu2LC9nbxz/8C7eFTmMOZKZARaKq/4ciBH6+sN/PXDFrsFEfs/Gan9In
         E9tcdoU4FXQt2zT4O7ArgabH+BRovm1c8emWGSXG+hCoqki8ZBkanJFsrKuNEzsGC68j
         AOj9ORGaexxj4b+U2ttowvS5qIY2HPCM3HMSd8see7GP3959CprZNr01DEeCyz3ggUxQ
         PzQRChqDsLdnn/iAU9oDp26hukybohqfPIXJr3TtkhYC3tdb+bKwazKxP6PIHBciwj0l
         JVSg==
X-Gm-Message-State: AOUpUlGxNusXFTHGsoypsYgHQysu4e/ClnOFR4UW4L8my2qaRn7F974a
        /NHupxEvXyFr6MKVQDN/BUY=
X-Google-Smtp-Source: AA+uWPw4hwziCZQQkbRNJ7myzuBcV5ox0mb26ysEORWBDgLYuXd5AiFVYRsxXGxPjjyD/81tR4XJ6Q==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr17633860wmd.79.1534435497616;
        Thu, 16 Aug 2018 09:04:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h5-v6sm26183123wrr.19.2018.08.16.09.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 09:04:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] rebase -i: fix SIGSEGV when 'merge <branch>' fails
References: <20180815093935.10222-1-phillip.wood@talktalk.net>
        <20180815093935.10222-3-phillip.wood@talktalk.net>
Date:   Thu, 16 Aug 2018 09:04:56 -0700
In-Reply-To: <20180815093935.10222-3-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Wed, 15 Aug 2018 10:39:35 +0100")
Message-ID: <xmqqzhxmfgbb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> This commit implements a minimal fix which fixes the crash and allows
> the user to successfully commit a conflict resolution with 'git rebase
> --continue'. It does not write .git/rebase-merge/patch,
> .git/rebase-merge/stopped-sha or update REBASE_HEAD.

I think that should be OK.  When merging, a patch that shows the
diff from the merge base to the tip indeed is an interesting and
useful reference material to help the conflict resolution, but it is
not even clear what the latter two should mean while merging.

> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index 31fe4268d5..2e767d4f1e 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -129,7 +129,7 @@ test_expect_success '`reset` refuses to overwrite untracked files' '
>  	git rebase --abort
>  '
>  
> -test_expect_success 'failed `merge` writes patch (may be rescheduled, too)' '
> +test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
>  	test_when_finished "test_might_fail git rebase --abort" &&
>  	git checkout -b conflicting-merge A &&
>  
> @@ -151,6 +151,19 @@ test_expect_success 'failed `merge` writes patch (may be rescheduled, too)' '
>  	test_path_is_file .git/rebase-merge/patch
>  '
>  
> +SQ="'"

A low-hanging fruit tangent, but somebody may want to go through the
output from

    $ git grep '[Ss][Qq]_*=' t

and come up with a shared "convenience" definition of this, which
perhaps sits next to the definition of $_x40 etc.

> +test_expect_success 'failed `merge <branch>` does not crash' '
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	git checkout conflicting-G &&
> +
> +	echo "merge G" >script-from-scratch &&
> +	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
> +	test_tick &&
> +	test_must_fail git rebase -ir HEAD &&
> +	! grep "^merge G$" .git/rebase-merge/git-rebase-todo &&
> +	grep "^Merge branch ${SQ}G${SQ}$" .git/rebase-merge/message
> +'
> +
>  test_expect_success 'with a branch tip that was cherry-picked already' '
>  	git checkout -b already-upstream master &&
>  	base="$(git rev-parse --verify HEAD)" &&

