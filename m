Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E679A1F404
	for <e@80x24.org>; Sun,  1 Apr 2018 16:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbeDAQhy (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 12:37:54 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34649 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbeDAQhx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 12:37:53 -0400
Received: by mail-wr0-f178.google.com with SMTP id o8so11647383wra.1
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uU91o+Iaou9S5XnzIE8qg3b6VAjqPU9M2YtVy9m8CcQ=;
        b=nhT6DTBMqffyxWa234tJIOPMubTxRTZV/50GTs07icDwHjak2EErLeqdsL8aywpXN3
         b37jKa47dEeR/tUoOBcGKN6CmMnOkPmLqio08QY1glPJpfIPT57YhjY8vogIM2ZIYUPt
         6MlwxLX8EC8ww3/lpoJX8JI5PtxTe0fw55/DNpXSGjShcrgXgmFB4rguDMEbnbb6xzvb
         3/L7x1QZC17Zwo9WWQrYufFZDu1LXWhybtnCE0lgXXLmJrxTWpEHbGn5QKhiTt64JBIL
         5bM0qyjG7TMq3h0/LMH1as3m9Es27JcKtCr35o0e+SGqTxqTxSm6Ci9GMTczIu+UGGGZ
         Ia2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uU91o+Iaou9S5XnzIE8qg3b6VAjqPU9M2YtVy9m8CcQ=;
        b=DrK9VWTSmLkkNUbBGScR76UU2A6HRG+XC7nqZgR6SYuZ+NsEH6iRDlHIdD5D2R+OXs
         NW9x48FD5RDmBsyVNy51BGGPLMTYaF9BSNWJI0bbRUn8jzwGAVoJq4Szk5ey0ReIWbd0
         ZSS41yfo4Mn0xm64CMa95GBQDmLTe0oO/KYcpOVGRyyVUF/yNg0Cp6Jt59s8nyLVBzoq
         bjSDc87EASwlRB7pUfRglSiYdO97hXZIyZ7s7uqOGa58xpdWC/e8e690+FfOZePJWmsT
         0YsI2Hf5F5Ao7BgV+DeEVAqRuMa+ohHIYioSmwnaXkBIz8Bmm7D5zQtEHw0DR5EA8RSU
         hz+A==
X-Gm-Message-State: AElRT7HAxbxPqnsJW9Shqhp4caStcLus9PIpGMzTrypXyLrqZYBWEqO9
        vZRAI6jBzk4bcHidog2HzYg=
X-Google-Smtp-Source: AIpwx4+yG5dPR+UEOvVfFn78EwfiMuPBq5YqkFjdsZBv8ekok9hwzvBb5TTgbZ8QiEC9F4r3KOzgBw==
X-Received: by 10.223.131.229 with SMTP id 92mr4678859wre.249.1522600672328;
        Sun, 01 Apr 2018 09:37:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y6sm6804506wmy.16.2018.04.01.09.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Apr 2018 09:37:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Aloni <alonid@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] builtin/commit.c: prevent bad commits
References: <20180401140650.18928-1-alonid@gmail.com>
Date:   Sun, 01 Apr 2018 09:37:51 -0700
In-Reply-To: <20180401140650.18928-1-alonid@gmail.com> (Dan Aloni's message of
        "Sun, 1 Apr 2018 17:06:50 +0300")
Message-ID: <xmqq4lku2880.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Aloni <alonid@gmail.com> writes:

> These commits which have hashes starting with the hex string 'bad',
> always give me the chills. Why should a perfectly good commit be
> jinxed?
> ...
> Note that this change does not affect actual software quality maintained
> using Git. Thus, it is recommended keep testing all generated versions
> regardless of commit hash jinxes.
>
> Signed-off-by: Dan Aloni <alonid@gmail.com>
> ---

Ah, I forgot that it's that time of the year again.

> + ...
> +		oid_hex = oid_to_hex(&oid);
> +		if (prevent_bad &&
> +		    oid_hex[0] == 'b' &&
> +		    oid_hex[1] == 'a' &&
> +		    oid_hex[2] == 'd' )
> +		{
> +			parents = copy_parents;
> +			strbuf_add(&sb, "\n", 1);
> +			continue;

We used to allow a variant of this that lets you append invisible
cruft at the end of the log message by hiding it after a NUL.  You
also could loop here to turn the abbreviated commit object name to
an actively good one, not just "not bad" name ;-).

> +		}
> +
> +		free_commit_list(copy_parents);
> +		break;
>  	}
> +
>  	strbuf_release(&author_ident);
>  	free_commit_extra_headers(extra);
