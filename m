Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274ACC678D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 21:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjASVbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 16:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjASVaK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 16:30:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B786A731F
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 13:25:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id b10so3712531pjo.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 13:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOsqzMz5yc7EifIXyt/obvI7WK6rRgqV1vEGpmyRsts=;
        b=fRJd+xlcmd7urEDSJ6BVYM/zZpyaO+gecf7SwR17FRU1OdRAO7BUu6WAQpmillBVx4
         fuKCJbYEo7kZJjWfnGg9Z3luBChyx8eDEdVlfR8mAiJ4bvAuhp7b8diKUMp8ynYQijL1
         iCEUJcCOPvRJb/5X2Pi5Z0w6OOSkVcjcOvjRMWew2Pc4HqMf8LLAhM8ADeJic/6CEgvH
         4f75ltw9x2WkA51mEBlmC3oeeJiRGF3esUbXQibcE5hblWtkZn6Lv1McKByOGxQ3Zu13
         Ro8kxfXm7wPJ1zOe61UvqhnzcCWLSIraTL5DgOSyjbMTavEDxoku4pz95Z/zE9dsoBtV
         uxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOsqzMz5yc7EifIXyt/obvI7WK6rRgqV1vEGpmyRsts=;
        b=a784D1edNLYaQpINV5AafKvubACfishwbEpI+C81qUD8+ESpPkI2O28V6JZgBG7I1A
         xwT3Sk3Djr6Lt7vHtfqdTU11jwMJtcuo2tvNIhHzLlDNZJ9pR/8FWRHYEoIHX3obL9YJ
         k2aON4eRfMeYv5uwjLI1b7quXTdcroQ/u8ffgVIalQA/M5egptXx1o3+k7h2NOUZEhEz
         TG7FqzrAE+b+sSDi/RWzotfPn1skIbtkoGRFF7RtCBiAp3m+GNwC9qZYH3KxdyNHE8oJ
         ltvQ4aujnuxojM9TC+KFp06tYJ2CCrHsSsgpTCo9RdmpbpDkmGCUrPM5+8ZisPdRVwU8
         dcaQ==
X-Gm-Message-State: AFqh2krELxI+aF16i53+ethQC/nqFYNj8ejihzjwYrhYgnx+cmfNz4u4
        Ilj1Z197/Skfnjr6k6tryGW7xrayXSI=
X-Google-Smtp-Source: AMrXdXtpjTc/U7aEwbFa1/pBhZWvoYZNxQMXU58wLaEuSGf75U6xSVcdeetQosRFkrapjfkmzInIzw==
X-Received: by 2002:a17:90b:1992:b0:229:989e:71d5 with SMTP id mv18-20020a17090b199200b00229989e71d5mr12273487pjb.6.1674163485790;
        Thu, 19 Jan 2023 13:24:45 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a600100b002262ab43327sm91916pji.26.2023.01.19.13.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:24:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] avoid unnecessary worktrees traversing
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
        <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
        <bc82dd95-c968-146d-0dea-f82631b74765@gmail.com>
Date:   Thu, 19 Jan 2023 13:24:45 -0800
In-Reply-To: <bc82dd95-c968-146d-0dea-f82631b74765@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Mon, 16 Jan 2023 01:00:10 +0100")
Message-ID: <xmqqilh21ale.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

> -static void reject_rebase_or_bisect_branch(const char *target)
> +static int ishead_and_reject_rebase_or_bisect_branch(const char *target)

The original name was already horrible but it became much worse by
acquiring a non-word "ishead" as part of it X-<.

At least let's replace "rebase or bisect" with something a bit more
generic, extensible, and shorter phrase.  For example, isn't the
point of having the function was to give us a mechansim to see if
the branch with the given name is not to be modified because it is
being worked on elsewhere?  "The branch is in use" would be a good
phrase to express such a concept, so die_if_branch_is_in_use() or
something along that line may be easier to grok.
