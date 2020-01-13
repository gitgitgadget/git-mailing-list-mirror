Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F51C33CA9
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 00:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E080206DA
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 00:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="pKNesXvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgAMALq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:11:46 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:45595 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387460AbgAMALq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 19:11:46 -0500
Received: by mail-pl1-f169.google.com with SMTP id b22so3113330pls.12
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 16:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oVAyPF1J1zX7aLOpC3kv1368OPohzZN8L0n1bd6ZebE=;
        b=pKNesXvvHaiiivENbZYSPm9HEETIYt8qMQvnbxVf5SOHXYWVsGyUho4nZGf62M/KHc
         TwzERDuSWq+Z2E5Xw+2YZ/pIt9Mj3tHmF4AzvPCyIWO68amDWUi29WUI+2LpL5/Luytu
         hqxhOx+XJCai+Ry/uLeGbzXOIZO34lwz9sJP3YQH51Jexy1Vnd6Cvb7sk1Vsg6MHFdFg
         Q5YsvpHiY3CzSSJlt1rd3hhHESuaDfHTy2sQr7WwwxB/YzkZyqTkZ7aPJoS0d3YuXqOn
         6XLma/Ryl0BlIxWOGcjusxhEj4BCkYeIgo6Jl1cdQ6hOtztMPt69Dh7oefJPMWgvyD89
         Wcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oVAyPF1J1zX7aLOpC3kv1368OPohzZN8L0n1bd6ZebE=;
        b=fKGJnRfDJwp8eKRcTPBnyhW0XvOQxjrsFAabP6DKMCaB+R9ff79tIWbQrlObN9JHB8
         WKMl/TH1IdBghxEnaSAyCAUohGj+k6vKiGvGyyc1kTsUsgERdxSCJKmg+2UqL+37+rD6
         Wvsv0PFbWeF3cDyezzqHxG6pR+h3wPBx8sltpzhTJUE1+WFqX+0MyuO5FZcTc/Jesv+I
         xnDDTNJ2mh22hFq2waVgA5PDKSzRKvnSjE+1gMC8pfZdBYuLgdd+5G1REh/QB3Gjxh13
         sfOWunSfs9OinW3aGCUu6BCqn6VKX3LQJ30IbGlVRu5gfZ6/Pjdu4nBwFzJR67pPo3R7
         aIcQ==
X-Gm-Message-State: APjAAAUGfApvz52YDIaQxL8iwOtj/Iz5HzHx1R2rRwNynu9yOZq5+1ut
        GfA6Ki+9ZKBpfhRs0+0L05j83dXWobm/qg==
X-Google-Smtp-Source: APXvYqxpmYawb++/7SDF0m6uLisZ8k6QdPO3A5q5Uibl9yuS0B7gd4qtc0DwKXU6ZZp+wp3JYlvX6A==
X-Received: by 2002:a17:902:8503:: with SMTP id bj3mr11300375plb.180.1578874305516;
        Sun, 12 Jan 2020 16:11:45 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:d8d2:10f3:e6c2:e26])
        by smtp.gmail.com with ESMTPSA id a4sm10741815pjh.32.2020.01.12.16.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 16:11:44 -0800 (PST)
Date:   Sun, 12 Jan 2020 16:11:43 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jude Guan Wang <guan@clicktherapeutics.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: Issue with Git Branch
Message-ID: <20200113001143.GA13099@syl.local>
References: <56F9DC91-740F-47C7-9C2A-B6B1EC3A12B6@clicktherapeutics.com>
 <29742805-4992-47E6-9889-F55F5EFBBFF1@clicktherapeutics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29742805-4992-47E6-9889-F55F5EFBBFF1@clicktherapeutics.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jude,

On Sun, Jan 12, 2020 at 07:01:04PM -0500, Jude Guan Wang wrote:
> Hi, all:
> 	I noticed something weird with my git command. In my local
> 	environment I seem to have a branch named `-D`:
>
> 	And I don’t remember how I was able to create a branch like that. I
> 	tried to do git branch -D/-d this branch but seems not working. I’m
> 	assuming the branch infos were kept in .git folder so my question is
> 	if there’s anyway I could remove this invalid branch from that
> 	folder? My git version is 2.24.0. Thanks for any help in advance.

You can delete oddly-named branches by passing the end-of-options marker
to 'git branch', like so:

  $ git branch -D --end-of-options -D

(In fact, '--end-of-options' isn't strictly necessary here, and using
'--' as in 'git branch -D -- -D' will work as well).

If you do find a reproducible way to create branches named '-D' or
similar, please do let us know, as these are not intended to be valid
branch names in general.

Thanks,
Taylor
