Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E83C04EB5
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 14:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567FD21775
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 14:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmMtt5EM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBGOyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:54:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38643 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGOyP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 09:54:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so3035117wrh.5
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 06:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wYNM96sOXuJ2GwUMO8kflXrRXimL3FfDfPu2p9XNGZI=;
        b=nmMtt5EMpeUImtjMKVbF1FPVpHtH/8I6eMyDCxhcHeI26X01C5sdnQDgmjC0gqQTsM
         evnqdJxpzSQkdyg7Sm3HN66JxusepVbNBBuV3rQ3n7s//XIa5GsB9Cx4mN4r5pWlaPx0
         CwrVTeV0rC75KMXjdCanlSUA7eRT7AQ2xqb4a5Orf04x9kFKMEz2/xE85oGRsxUYG0gb
         4fFZUOSXkrUfMjDp5MdaRyLVKpgD8Lq7hhNzFjQhNsbuxGEjF2VML7xmUvJ/6m/uOkWT
         S1dR44NbgXhKjicwYaSxT7UgyI8DWygnTQWxo4kVfH6ptFusi6NaWQQXDOKEdMZ4mSju
         UdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wYNM96sOXuJ2GwUMO8kflXrRXimL3FfDfPu2p9XNGZI=;
        b=enULYfQUkjZSADu+D6T/OOPKTO9VqtyYt8abtonlzanFOl2U1baNcHj9gFEMrQBg5/
         KRogVk16odPF+QBzKgS+Lr8AhEZwlAvzYZe2foNTDukrJtvmUZGHkOF70rZhayuFtfO4
         qQ4PYcwQxSZyIPutlkPjy6ghuVk7mMGD1WQ+P5MkimaPO58soMHzjRHLDXXzRM3AfPOd
         JoKF1pg7cmQ31CixJrEN/hplc2tbFvoBG82xiGiMScY6XrxaY6rh2woPxXz7s7SaIqML
         wRxNMNAmiLKLqdXbS2YNM4ZtxZ7yirlDvA+IU/lTlvx8jZeRTiCzdwHx+y+ik6LcT+7Y
         NVvQ==
X-Gm-Message-State: APjAAAWhMAyRgwBFB6/NVihgJ17ljOqJ/K3lXdgd0V6s/PAlvq398vZm
        W6tlPFfDs1xEMtUtcaNzdGw=
X-Google-Smtp-Source: APXvYqwtVZSChFPtawlX/OFZBp78vej1PybVwGC53KVRtS3sRLeCr7azCelbvuXTocyZ8/NZclmpmA==
X-Received: by 2002:a05:6000:118e:: with SMTP id g14mr5405371wrx.39.1581087251637;
        Fri, 07 Feb 2020 06:54:11 -0800 (PST)
Received: from szeder.dev (x4db318d8.dyn.telefonica.de. [77.179.24.216])
        by smtp.gmail.com with ESMTPSA id 18sm3497569wmf.1.2020.02.07.06.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Feb 2020 06:54:10 -0800 (PST)
Date:   Fri, 7 Feb 2020 15:54:09 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200207145409.GG2868@szeder.dev>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-4-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200206004108.261317-4-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 05, 2020 at 04:40:56PM -0800, Emily Shaffer wrote:
> Teach Git how to prompt the user for a good bug report: reproduction
> steps, expected behavior, and actual behavior. Later, Git can learn how
> to collect some diagnostic information from the repository.
> 
> If users can send us a well-written bug report which contains diagnostic
> information we would otherwise need to ask the user for, we can reduce
> the number of question-and-answer round trips between the reporter and
> the Git contributor.
> 
> Users may also wish to send a report like this to their local "Git
> expert" if they have put their repository into a state they are confused
> by.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  .gitignore                      |  1 +
>  Documentation/git-bugreport.txt | 41 ++++++++++++++++
>  Makefile                        |  5 ++
>  bugreport.c                     | 85 +++++++++++++++++++++++++++++++++
>  t/t0091-bugreport.sh            | 49 +++++++++++++++++++
>  5 files changed, 181 insertions(+)
>  create mode 100644 Documentation/git-bugreport.txt
>  create mode 100644 bugreport.c
>  create mode 100755 t/t0091-bugreport.sh

Please add a corresponding entry to 'command-list.txt' as well.
According to the comment at the beginning of that file, all, even
external commands should be included there.

