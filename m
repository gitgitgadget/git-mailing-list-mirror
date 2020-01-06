Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A24C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201B920731
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCr6Is8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgAFXHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:07:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34966 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgAFXHU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 18:07:20 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so27554133pgk.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 15:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BEkAJskrfQg3QuiE4B8Xz7ac7wc4c1EKMmn+efyOr2w=;
        b=HCr6Is8i3HY4nSZuFe1y4nE3uyvviTx+RM1yQxCE1dFVgYwZnRR/quyR/xuUa2R2V7
         EUGJ4CZkevye0wfrSS8YiJL6zpzUcMf6Bvsm6BnD7enFt3N8DoPo3BDBYzjGlEmRJ7Z1
         VGsy9FWCXST8/Pbvo29udYZe2wSeMQYFBAmRa5olBWAeYVhjA+H937ANI3asKPXq9VXr
         Aem4uJXqCFv1FKjv2fVqpUiTTJ0B1Rr6WCm92B5Jpn804EUNQgMQXcsV5s5M/Pqs86FQ
         oguXgPEFz2Ffu5YZ6Z+jgBrWEgzvHqV3DoBVMqg+WZn30JgJ8Q80Jfdf8dJjy2q9V53P
         DSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BEkAJskrfQg3QuiE4B8Xz7ac7wc4c1EKMmn+efyOr2w=;
        b=qTuMFwzx7io+N2uFLPrl/sQ84fzkBk+DtFMHQ2ry1hmT49WrVIdrkVW2xnof7ouI+J
         ZBHV9IhJRK0CFwmrC5Rte+9+N//ZNEtdw34RAA0P6/Sz4ne5DdXiAgR+vXf0bcUwSg1i
         Y+DrXpuCzzvzUvbNIuu7L49SGX6oIuf0dIZfsWjod/0786KY+Emoln4T2F+epejy6C1m
         KC6MHAtU/dEYyMg8MtHLO8DJ8nCJ85p5yx43+0C02qAZDc3lCerPOcoa3kVGP+0D1frg
         QTQd8R6yCsrCQn8aoZJnypZXGgHgnDVUwjyFB+AcyhSP8859EporMCFgwhz8VmIYZFnO
         MPwQ==
X-Gm-Message-State: APjAAAVOhJDmLhkbExqdNi36okzRWzDTuMy8i7bWN105gnYijCrkBlM8
        OY2Ue+l8JFzWHwuS4FdBc13vZg==
X-Google-Smtp-Source: APXvYqwxaoi1vrNQq5VISPQnS/KLnLMnqreAzs6oNhJGlvg+zl6FqlbFKKvihOyiHsCQkd2gUzb7Og==
X-Received: by 2002:a63:e545:: with SMTP id z5mr112141654pgj.209.1578352039125;
        Mon, 06 Jan 2020 15:07:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id g18sm75362951pfi.80.2020.01.06.15.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 15:07:17 -0800 (PST)
Date:   Mon, 6 Jan 2020 15:07:12 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] add: use advise function to display hints
Message-ID: <20200106230712.GA181522@google.com>
References: <pull.508.git.1577934241.gitgitgadget@gmail.com>
 <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90608636bf184de76f91e4e04d9e796a021775a0.1577934241.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 02, 2020 at 03:04:01AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> @@ -390,7 +390,7 @@ static int add_files(struct dir_struct *dir, int flags)
>  		fprintf(stderr, _(ignore_error));
>  		for (i = 0; i < dir->ignored_nr; i++)
>  			fprintf(stderr, "%s\n", dir->ignored[i]->name);
> -		fprintf(stderr, _("Use -f if you really want to add them.\n"));
> +		advise(_("Use -f if you really want to add them.\n"));

In the vein of the rest of your project, for me I'd rather see a
copy-pasteable response here:

"Use 'git add -f " + name + "' if you really want to add them."

That is, if you know the name of the file that was being added here, you
could provide it so the user can simply copy and go, rather than
retyping.


 - Emily
