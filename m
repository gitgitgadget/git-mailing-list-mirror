Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFBDC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 18:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82111214AF
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 18:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8AVbUxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfLLSLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:11:43 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:42120 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730080AbfLLSLn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 13:11:43 -0500
Received: by mail-pf1-f180.google.com with SMTP id 4so1171678pfz.9
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 10:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W+NK7vJjlm5WQk6GKtucdHOZAKqsH2ncoQkhFW9ayEo=;
        b=t8AVbUxBbW6O3rWiGCmO0Fhfeoz5spDQOfAT3Y26uGV/n6Jy0azC8MXXad3nCtCVir
         h0qYvQDTqTWQGEI/337CKgLsYy5oG/1SGY8jvdDub8u9AkhWSzNa3PKDsakrtik1cROP
         BvfNRdsHZJQ6alcl2qjtDLJuYqxulCttYZDDuIIjN0gPvnGCRmbV+CU5558sZ1/usJBW
         b/vNo/6SgQtP82UEWjzXVlI1dIBL++6i1hTywo76cioXc7ky6EBZp8LqjmGHeS1dR0Sa
         M4pWxXc3dWjslr6Chq74FgTKBwOqhr2/S2WsPWPRs8M+OfH5zDon0Hs53wvMnjs6l/Kw
         z3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W+NK7vJjlm5WQk6GKtucdHOZAKqsH2ncoQkhFW9ayEo=;
        b=NXL1pn5ZY/MM2l8b34d9dFyQL23pk/0CVU1TtKskwlscRp9i0or9uWUDjUwIFOqfxT
         caSN7SO2+w0y3WH3gC59d5Y1U446hITZQqxW/c4/cgW8WanrbqZmpfPCCqWEN6AcerGQ
         OpIcVg+mswmaZyaoKnv2tHNMb6DvOKVhotrT3L+U41rTWgEH+rBLSOWvHzAl4OdxrTKO
         fKxVycQ3hdhuprx5Gfa7WbKzybrTvqXwxQquvtO207dL5WmTd/pck+VlRsACGPmr/K8f
         SqJQEzUHpCSX+Q0yQbZb5qrKe5EnWIMdGWUygblD5SC9SxoXppgZRi2394/rwH9Gt5TB
         JH0w==
X-Gm-Message-State: APjAAAVwmUdTCk++l0QO9FHdY2zs4zWfGXiopcTG8BeD+6sf21kyiLTf
        apo4KYBM6S4L4tWGvU4EgFA=
X-Google-Smtp-Source: APXvYqzbE3TiMQdNTFW/JzMxlgM6R1/2pQVUfvrZ9nRNZVHA+dC8MHoRH9x6nZcAWZhWpCKb+zxFzw==
X-Received: by 2002:a63:4e0e:: with SMTP id c14mr11862394pgb.237.1576174302762;
        Thu, 12 Dec 2019 10:11:42 -0800 (PST)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id 133sm7906360pfy.14.2019.12.12.10.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 10:11:42 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:12:44 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     rottis@fea.st
Cc:     git@vger.kernel.org
Subject: Re: git checkout --autostash and git branch  --autopop
Message-ID: <20191212181244.GA36165@generichostname>
References: <8ab7d980-9584-4ce7-b4ee-9acac62c030c@www.fastmail.com>
 <20191212180901.GA35927@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212180901.GA35927@generichostname>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 12, 2019 at 10:09:01AM -0800, Denton Liu wrote:
> Hi rottis,
> 
> On Thu, Dec 12, 2019 at 02:19:50PM +0200, rottis@fea.st wrote:
> > Similar to the 'git rebase --autostash', running 'git checkout --autostash' would automatically stash uncommitted changes for the
> > current branch.  then running 'git branch --autopop' would automatically apply an automatic stash when switching to a branch that had one.
> 
> I currently have a WIP version of this feature but I haven't had enough
> time to polish it off (tests and docs). The last RFC round can be seen
> here[1] if you want to test it out. It seems to work well enough for
> personal use.

Sorry, my mistake. I misread your message; my topic was for
`git merge --autostash`. However, it does generalise the autostash
machinery so perhaps it'll be simpler to implement it into checkout in
the future, if that's desired?
