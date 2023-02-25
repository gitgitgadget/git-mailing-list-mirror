Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE29C64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 22:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjBYWuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 17:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYWuL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 17:50:11 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A27214233
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 14:50:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so6555076pjh.0
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 14:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXowBGb9BEZAQQNO85UOgqNOs98T568/FwTEfqL02/Q=;
        b=hmCtaIwBNod/V0YZidatJiiA9k1oOoY6PPdkt1tCxaGL3pqmOY5WCG5pegw5g2skJA
         DNWfqYCUEKCcHcM3P+tXYfkOX6A7fLomYZVstV7oXpcHBUivEwnKrdewqJTjG7CItxKD
         9Szw5+1f7EjHRhkK0xsuWGxMnwy69l1VEKrGAh6sl2Zg/eIB1hIUkNd8Fb2zd5vOeNny
         Vl/7x/ZAOR7VvTj6uGioQZMaWA5djZpqQaNjEzGeyRloHhgX4sgQfe0z+WfgJ3IQYafE
         BJTIM8UxPCuTZ/0CetvN6KAo9jnUo5M/WbaFZoaUQJnUTdJrY/dXU1xhl+NWjhwCjM7C
         aifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXowBGb9BEZAQQNO85UOgqNOs98T568/FwTEfqL02/Q=;
        b=FtzK8NKHjK1S3+I3n0TA+OVHjV5QjtdvnYNJL5Comvv0PnUv9P5CoGGy5baJlGEoqU
         DuUQjJLRm4uu8Fe1u87XQvCSCDHxYSNiVaL4yxwWV9UQOT+O6nuuUWte3suJzjPgzMG1
         JTWeP0O02UUKc2uaQHEQIrYdHZ6F9knWUjIOI8Blf1r0tYRiDFkJlAnHxnH6697HTk3K
         9jqhXkbTe/+WBeuuhVb7frtv3u/gBz4V0+EynJgmY4TtFDf3M9xRvO02PqcZq942ESD5
         b35ikOR5w2uVVYdXfpHkDUqwj7X2IdPgR8UTwBMy5/Ahzz12w+6zCV+XMUc6IYeRKk4h
         v/oA==
X-Gm-Message-State: AO0yUKU2OJnKPdKCriNL2crxC7TSAAPKe/z6LcXqli+SdaZYIUJbPYDN
        HA6k8mhDarA/4VJ0SKNyX/+cKf4meM4=
X-Google-Smtp-Source: AK7set89yerZHj0TPpZRUMtnCTcT6eJWxEzIERHJtD369kWsLdMcL1KF666H/DN46x3ouB0GKPoHAQ==
X-Received: by 2002:a17:903:803:b0:19a:a404:af47 with SMTP id kr3-20020a170903080300b0019aa404af47mr18586861plb.4.1677365408592;
        Sat, 25 Feb 2023 14:50:08 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902d70d00b0019aeddce6casm1712367ply.205.2023.02.25.14.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 14:50:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/4] fix die_if_checked_out() when
 ignore_current_worktree
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
        <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
        <6fed3b1b-1c4e-9298-19b6-7ad9c04c87dd@gmail.com>
Date:   Sat, 25 Feb 2023 14:50:07 -0800
Message-ID: <xmqqbklhuzq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

>      +	test_when_finished "
>     -+		git worktree remove wt1 &&
>     -+		git worktree remove wt2 &&
>     -+		git branch -d shared
>     -+		git checkout -
>     ++		git worktree remove wt1 ||:
>     ++		git worktree remove wt2 ||:
>     ++		git checkout - ||:
>     ++		git branch -D shared ||:
>      +	" &&

Sorry, but I do not get the point of this construct.  The
test_cleanup variable that accumulates test_when_finished scripts is
evaled without -e shopt set, so you can just remove all these ||:
and add a single "true" at the end, like

	...
	git checkout -
	git branch -D shared
	:
    " &&

for exactly the same effect, no?


