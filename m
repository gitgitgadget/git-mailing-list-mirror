Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB824C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 11:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9043208C3
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 11:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJiHc+o5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfLKL6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:58:03 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44310 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfLKL6D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 06:58:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so10661764pgl.11
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 03:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cmVarcjwFIUwGHZIaPxXhYC70+n6m+Re6ZnHqJDvflE=;
        b=LJiHc+o5RTdgenXP7lln6998pFC82fI9cPWt+7yy8hFcBqQhCxGM61FlnzgxPGozDH
         Z1h5iIHSyxMPl0M43Uu75TFuEZdj/Yj1YFDN6mek1rE8RR89EYjUbZnhqWGjUw55DuXp
         Bwv4a4aDTdhpQlyvf24VoFWkvuwZgQiClqszDoj/wifTqkmz4uJ36kXMBL7Kur/7dZtX
         4MIrfJPVhFOf4jBuB0q8FdWxZF/DgzU0JQJQ808OGnFEjW0VUDO8qT7ipVMsgS0CKlcu
         gnkotu9zTH9IMgirU4SsHVeb9NfvwR3uwO+o65RTj6loByGYtouiD/OH5FiuHLhFEfeC
         0W2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cmVarcjwFIUwGHZIaPxXhYC70+n6m+Re6ZnHqJDvflE=;
        b=Z7Nk3RGzUtcT27UXoR/1m31r9ecbBgJSvLkebDIkpBoTRzK69RWdrVMUuhxClKkwkh
         pfqJG4D1cb6TDvl6Lvr1l1/IwlvZVEUtc3iV+tMVZTCxa83mJ7tfqhmqAJrhI1FbpWRo
         J9ugh4V67nQpPOIjWfl+wPWrdmfx0E+JuPKIoa/DljUFAOwxS+U5ynrpkYaifX3jgvnr
         Q6uXJOx5nSkeuxwbtUP7lWnROoQrCaS1avtol33Jm6ceg2E05zDgcaktykZ/fV7/z2sM
         hjL7M4T0uUGZ87VjwHuG+Q7tedIdvQbGXwrLio3YlcJ9wuTdP14YptibxBZFKDrdweu6
         CFoA==
X-Gm-Message-State: APjAAAVYmI8w4W3b21JDLROxCX21zBnpn7nnZ3pBp6ggmAKwvYd/5Xlm
        KLVUBXk+OB0Q3OftSZOtgIU=
X-Google-Smtp-Source: APXvYqysB49BhEsqP0MdUJc+ZtDXRT7Rs+PHrGRHP5OG1eTt3OmkoJcJoA/2zuqRfgQBQxkXabCZYA==
X-Received: by 2002:a63:338e:: with SMTP id z136mr3738569pgz.60.1576065482843;
        Wed, 11 Dec 2019 03:58:02 -0800 (PST)
Received: from generichostname (c-73-15-240-142.hsd1.ca.comcast.net. [73.15.240.142])
        by smtp.gmail.com with ESMTPSA id a17sm2413300pjv.6.2019.12.11.03.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 03:58:02 -0800 (PST)
Date:   Wed, 11 Dec 2019 03:59:00 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] git-p4: yes/no prompts should sanitize user text
Message-ID: <20191211115900.GC41678@generichostname>
References: <pull.675.git.git.1575901009.gitgitgadget@gmail.com>
 <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
 <527b7b8f8a25a9f8abc326004792507f7fe5e373.1575991374.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <527b7b8f8a25a9f8abc326004792507f7fe5e373.1575991374.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 10, 2019 at 03:22:51PM +0000, Ben Keene via GitGitGadget wrote:
> @@ -1779,7 +1790,7 @@ def edit_template(self, template_file):
>              return True
>  
>          while True:
> -            response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
> +            response = prompt("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ", ["y", "n"])
>              if response == 'y':
>                  return True
>              if response == 'n':

One more thing, since we guarantee that prompt() returns 'y' or 'n' and
it handles the looping logic, we can get rid of the surrounding while.

> @@ -2350,8 +2361,8 @@ def run(self, args):
>                          # prompt for what to do, or use the option/variable
>                          if self.conflict_behavior == "ask":
>                              print("What do you want to do?")
> -                            response = raw_input("[s]kip this commit but apply"
> -                                                 " the rest, or [q]uit? ")
> +                            response = prompt("[s]kip this commit but apply"
> +                                                 " the rest, or [q]uit? ", ["s", "q"])
>                              if not response:
>                                  continue
>                          elif self.conflict_behavior == "skip":

Same with this, we can remove the surrounding `while`.

> -- 
> gitgitgadget
> 
