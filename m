Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC46EC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 18:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85453227BF
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 18:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4707n4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfLLSIB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:08:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36031 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbfLLSIB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 13:08:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so1549073pgc.3
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z88nlwhPnOhzCngTofqQfSirOzswOsR54KH7ESeVSqo=;
        b=N4707n4sfURIoHVNFvGbdEOJLjUAo3UU5gnYjiC9UBk+9tya++NZoHkd17Z84zEG0O
         SFoywD1G4hEnbTR9u+E75mjUMI1oWPKEt8uFZUxntq9qrEEnj57cS3DbYlv7DCX67Kaq
         70iJFRz1uEQakUBWZcF8dLpwU17QH7D1a2exjcZ4cjNbAr400GSA2dJOGGRatlc4I8ai
         NZzy2v2ltGpzSASZjMPJDwJ5V8XqthO39EkccCVFM8GiQlKE4dRwTAl/k4pOS1uqfVLM
         dQ5EocqoXoURQqT2EdZIj149M0s/E1APTZ3Xx/ljAioTMIskw9zv+XVRVrbPxKzeQy6V
         5Mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z88nlwhPnOhzCngTofqQfSirOzswOsR54KH7ESeVSqo=;
        b=V/y7/Qtt6XW8MBKbFUOga6BdFUZrfr4FntkH7Lh9XqbJtjFpUtiNe0aD+hNszxewKw
         8ey0Wqy4FqZtDQlnEYXfXKNHuypFIul38KZ94ZDV1to6Mr52m4ii8DuvzS7wObeozOlI
         Y/A0iDJ2P1GUlAc8Nvml3fLxLEnyDQWpigxcvcsSoiJC4N7k0Al5Bhz8aaoWjwm7kBeK
         5gd6bb1p4QuZ7a/XKTV+N14+VVryq76LPXgAMksAw33CIz4jzcJxldtplXo5ZwUhdSqa
         YLYG53MbLbgmAGK6J/098S5AYJOtszpDAH4OszCHsto2wieeLnFl4V5H221J36rTI4Xn
         sQtg==
X-Gm-Message-State: APjAAAUTUW1mO8jE5mFeVP7ax/I7IwLfbxJBecq2jEl42JzL1k8shIEW
        d4TmUKesiUA5yc8cf/bgUDF+qBjK
X-Google-Smtp-Source: APXvYqyru0tLqUqLm78OGh6D53rzncFZdjnoxahP2t5vx6kUpSjCtkdLuv/MHh0HtQgkMy/G6EBPkw==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr11665431pgs.396.1576174080479;
        Thu, 12 Dec 2019 10:08:00 -0800 (PST)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id w11sm7922242pfn.4.2019.12.12.10.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:07:59 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:09:01 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     rottis@fea.st
Cc:     git@vger.kernel.org
Subject: Re: git checkout --autostash and git branch  --autopop
Message-ID: <20191212180901.GA35927@generichostname>
References: <8ab7d980-9584-4ce7-b4ee-9acac62c030c@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab7d980-9584-4ce7-b4ee-9acac62c030c@www.fastmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi rottis,

On Thu, Dec 12, 2019 at 02:19:50PM +0200, rottis@fea.st wrote:
> Similar to the 'git rebase --autostash', running 'git checkout --autostash' would automatically stash uncommitted changes for the
> current branch.  then running 'git branch --autopop' would automatically apply an automatic stash when switching to a branch that had one.

I currently have a WIP version of this feature but I haven't had enough
time to polish it off (tests and docs). The last RFC round can be seen
here[1] if you want to test it out. It seems to work well enough for
personal use.

[1]: https://lore.kernel.org/git/cover.1571246693.git.liu.denton@gmail.com/
