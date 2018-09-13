Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F35F1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 20:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeINBfY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 21:35:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46669 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeINBfX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 21:35:23 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so7941429wrc.13
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K3bozmECPwI40bb4mW9SLyWNuS3FT1VH+29EFGuUn2c=;
        b=H0YNyUyDXwzEbnSuVaKU5doE2hR/v1unVBbk7zF4RE5JbYs680cDrPWlH6RweP8X8o
         TYtJTOuwTgavMrG583d+8K/0dcZ97w8AQkB1mmK7lgzZwCa9YbwqwoVCJTYSq3606HhV
         CVd+cEKtEq1gdyyU2mWGk4VNgo91vgX6YVnOhmHQFGofWQ1T7eTUVA3FuVL5W5ew9EdO
         GvOtlVoaTM/eAtjP2oW8csX5EXGqokGPaK4P+itCZAtF67NGLYIajl4nItVqcaYBZTr9
         6LBDEpyZTVdYC93b11wDPKFeAxckmY9vksrJOQByP9pGBDZJu8FSD8a/L4irkREpqL84
         r6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K3bozmECPwI40bb4mW9SLyWNuS3FT1VH+29EFGuUn2c=;
        b=XOpRM5asNjRvDdYXjFz13FcjNnh4kMV7NBE2bPYsFPVPKqP03Ix4DP4oyKxa2up58K
         1T0BRMrHAaqPkeXtGT/zDNbKvVSN+ieMCmhV3hljTO1sjXX6P4jQD2Mu7CVMOn05SqJU
         U6hqoA4l37B/BuQ7Sba8sPSR0fm3nkAsJW0NP8j+o2NNY26Qg1leSU8nDhlNNiMuorAd
         lui4ItCVq8qDp8e3TCXDkcHIoUVOcDzO5Foh5k3tQLKSRsu23lAfuq6441GAIGhCNMyv
         j4/BvziQg9n+yooq+DvwoswkhwBWzHBVf37/xhdILFrFFeeNd1H2iPQzbNE3xnG/w6pp
         vbIA==
X-Gm-Message-State: APzg51DpQoG9zxNDLzKFZ2Zp1xS8SpZmcqakKajTOziQBLgqJNGoi+BV
        9ZsAajeU6cnEEAFU6wWZYAA=
X-Google-Smtp-Source: ANB0VdZKnqPR5O+Tl5f6IF7u40zCMCouPKXgyBE46KHMrO4g5yOcLGsq+0DzTWAx19bbCTQx4e0miQ==
X-Received: by 2002:a1c:700a:: with SMTP id l10-v6mr6829340wmc.90.1536870257939;
        Thu, 13 Sep 2018 13:24:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r30-v6sm6641934wrc.90.2018.09.13.13.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 13:24:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        phillip.wood@dunelm.org.uk, johannes.schindelin@gmx.de,
        sunshine@sunshineco.com
Subject: Re: [PATCH] sequencer: fix --allow-empty-message behavior, make it smarter
References: <20180912024241.GA27036@localhost>
        <20180912211848.26949-1-newren@gmail.com>
Date:   Thu, 13 Sep 2018 13:24:15 -0700
In-Reply-To: <20180912211848.26949-1-newren@gmail.com> (Elijah Newren's
        message of "Wed, 12 Sep 2018 14:18:48 -0700")
Message-ID: <xmqqefdxf8nk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> This patch cleanly applies to both 2.19.0 and pu.  There are some related
> code cleanups that I'd like to make, but doing that cleanup conflicts with
> the various rewrite-rebase-in-C topics sitting in pu; since those are
> fairly lengthy, I really don't want to cause problems there, but I think
> SZEDER really wants this 2.19.0 regression fix before 2.20.0 and thus
> before those other topics.

Oh absolutely.  Materials for 2.19.x maintenance track can and
should jump over other topics for 2.20 and later.  Thanks for being
considerate.

> @@ -899,7 +899,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  	if ((flags & ALLOW_EMPTY))
>  		argv_array_push(&cmd.args, "--allow-empty");
>  
> -	if (opts->allow_empty_message)
> +	if (!(flags & EDIT_MSG))
>  		argv_array_push(&cmd.args, "--allow-empty-message");

Hmph.  I briefly wondered if an alternative logic would be better:

	If and only the original commit being rewritten is empty,
	then we allow the result to be empty.

But looking at EDIT_MSG would be more explicit and probably is a
better idea.  That would allow you to abort a reword of a commit
whose message is empty.

The reason why I thought about the alt logic is because I am worried
about a use case where

	$ GIT_EDITOR=: git rebase|cherry-pick ...

is used to say "I do not want you to go interactive, when the only
interaction needed from me is to edit the message---I am perfectly
happy with the messages of commits being replayed or ones you come
up with as the default".  Because "--allow-empty-message" tends to
make things _less_ interactive, the worry is unfounded.

