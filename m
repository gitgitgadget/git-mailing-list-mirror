Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90ADC54FCC
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7235206B8
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 08:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BowpjXpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDTITH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTITH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 04:19:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E172DC061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:19:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l13so7747567qtr.7
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q/FiyQWsFrkJhblN27JkKYYIkweExRF9GbJre+JQUUU=;
        b=BowpjXpQ4+g+vRXf3HblF1HOEzh5/T9U5XmmjhrnodGeBp8OV3xybfwTLJRwohEhUA
         fvHe10kXo0iDJzB5gjvFj262PHMZa5+1Hf5ve5czn/GM4HIx9ecc8PZ0+edE9Q9RzXXV
         gL3JmEvr9KQiuSLrsKEIvDRmi+cSNbVq1wjRGuOWt1dvtbvU/crJ6A7Ab7H0oCmjOHmL
         butfABUZYziZwiIT7E1wdlG3wB/7Q3Zhte3deIHKoQVSOqAeR90PmzuPNJTMFqPEKEx6
         x5cL2HOgYS+tNdXqEKXLk5Q81LLbij7rcLG6e5YV5O6jFW6VvpwmoMuyot6wYHYCE9Sc
         c4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/FiyQWsFrkJhblN27JkKYYIkweExRF9GbJre+JQUUU=;
        b=PmLDEbQCJ5lbQbnr8eZMPzpMIJzqDOTT6EMhSlI0Wfd9LWbzbVTVZWkNRCjk+Hiz6M
         t/pwFMPwaF3A7iTg8Uv7AxDrWT//BUZ9bSIenoetxrOZzWK5TI5kXi45FeiJJNslw5qo
         ZMpjMeD+dvPS7I6OSw0ySQ3MEZsXudKvsE+lsOwsfXDNvNsvkVz/qGRiAKo921I2j4KE
         KW91vPWms2hD0lUfk8wm3zWgNF0l90GkHX9XD4r7fQR8apHUQE1+1+xTKE/N8d3aPhKs
         8dLzuMv58B5d21jztb2qWKe1DKJrNU8MHEu2LWWO1RCja8n11qfRFwmfTr5XoqWtpWCE
         ptCQ==
X-Gm-Message-State: AGi0PuZ0DMolSI9Rqpnl38YHJfdYeBgKr14CG1IfL/71byq6lbLF7FVo
        n5TB9lfJyKclbKQ/pnhrQfE=
X-Google-Smtp-Source: APiQypIbR1Oom0RinJr/HFYtTufn/9Iiir+5p9LFVc74xiDP3JdifhautEMvKudMDgeuHuNTXRzhVg==
X-Received: by 2002:ac8:5645:: with SMTP id 5mr14799597qtt.151.1587370746093;
        Mon, 20 Apr 2020 01:19:06 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id g4sm65234qtq.93.2020.04.20.01.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:19:05 -0700 (PDT)
Date:   Mon, 20 Apr 2020 04:19:02 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net,
        heba.waly@gmail.com, Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: Re: [RFC][PATCH 0/2] submodule: port 'set-url' from shell to C
Message-ID: <20200420081902.GA202848@generichostname>
References: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On Fri, Apr 17, 2020 at 02:34:54AM +0530, Shourya Shukla wrote:
> The issues I am facing are:
> 
> 1. The patch fails test #2 in t7420, i.e., the test to verify the working of 'set-url'
>    subcommand.

The 'set-url' command implicitly runs sync once it is changed. I would
go further than what Christian suggests and just call sync_submodule()
(in C) at the end of module_set_url().

> 2. Though not an issue affecting the patch, but the 'usage' prompt of 'git submodule'
>    does not show the subcommands 'set-url' and 'set-branch'.

Hmmm, the first of the pair, 'set-branch', was introduced in v2.22.0. It
seems like you're running an older version of Git, 2.20.1. Stupid
question but are you sure you're running the correct git? For me this
runs correctly on the latest 'master':

	$ ./bin-wrappers/git submodule -h
	usage: git submodule [--quiet] [--cached]
	   or: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
	   or: git submodule [--quiet] status [--cached] [--recursive] [--] [<path>...]
	   or: git submodule [--quiet] init [--] [<path>...]
	   or: git submodule [--quiet] deinit [-f|--force] (--all| [--] <path>...)
	   or: git submodule [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
	   or: git submodule [--quiet] set-branch (--default|--branch <branch>) [--] <path>
	   or: git submodule [--quiet] set-url [--] <path> <newurl>
	   or: git submodule [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
	   or: git submodule [--quiet] foreach [--recursive] <command>
	   or: git submodule [--quiet] sync [--recursive] [--] [<path>...]
	   or: git submodule [--quiet] absorbgitdirs [--] [<path>...]

Thanks,

Denton
