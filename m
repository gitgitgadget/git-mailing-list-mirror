Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA51DC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7979B20724
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584034302;
	bh=N6Q+4T0SkrDpVrSouwGloXHqFVlE5HR0pBgVH6DLxPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wh1hBTXZbho/QsuEOL3EppyVdNyZTONPuZInfGibaSTzI53vKhRkEba7J8TPeyoAK
	 BRWek/S92jKYg00xuvTlniVmF/ZB4QwsMFcDekIpHz4+w+iyl5zsIBJX7gE9jfuoUZ
	 D+vjuk0I6byE3vin67BwBSqsfSpDpReQopRjXToU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgCLRbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:31:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38536 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgCLRbh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:31:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id e20so5040430qto.5
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=iRAU8HJ+ev7CUogVwi2XDEO8g3l1gWuw07lEIMauaFw=;
        b=O8+PcPXcRF2zTAiS6HqpyONl+KQib7PcQbcLCLkQ3XlWnpXydn+DFEeLcf95+hxVqH
         Kn0aSHoCxN5R+W2tltLbp1yV2lBL0qz/dhJfZmlBoMoZdEBdxj9qESY+YaQpRbpHhA0o
         e6Z7fmH1wODmKG1K63aaKgHUeqCVT9YoCz2yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=iRAU8HJ+ev7CUogVwi2XDEO8g3l1gWuw07lEIMauaFw=;
        b=e57Ay3z9GH53shDX6eCN5hrNzd5d6PwZcCLMT4Zll3sGOORmn8ao28FkKvliTDqZ6B
         g0iuzd0p1jLSVYxD06ovkdoKdcQkrultPUP7P8TGnqGEsRbpyY9GBJj7uKjhsQ7JS835
         Zp76td9FWNNQCVb0sEizNMFUgOTiG6fboCO69EjbLm0+CVxsbENcGGryCDleVunYJnta
         1l6Mz7BYj/BLFT79xFV8nggVHthzv+pEL4YhQgrkU6wL8DcYeDUfTYrKiHWdMjEGIOZ4
         rNseSLC77i9o1FIiqXpgBLCYbax0ZX6yOKgj8pQOY2qiuoiXjjNmbIWDp8dVXw+94hVs
         ZpGw==
X-Gm-Message-State: ANhLgQ0rjcERS2kPTxVtZ9CsNdn4pFvRu+VaqOetq7JmNuUXOpIut+wr
        nChRAOKpZq3PlVSWU8b1nzgqyw==
X-Google-Smtp-Source: ADFU+vs/x+QaKFeGKvyqnd4l3RhN6tWLUzeTHYAd+pXSUN5ObXZXepgc2o0hzEwDtZDc9/2uvCAr/g==
X-Received: by 2002:aed:2591:: with SMTP id x17mr8484943qtc.380.1584034296673;
        Thu, 12 Mar 2020 10:31:36 -0700 (PDT)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id m92sm1462147qtd.94.2020.03.12.10.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:31:35 -0700 (PDT)
Date:   Thu, 12 Mar 2020 13:31:34 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 16/17] =?utf-8?B?4oCcSSB3YW50IGEgcmV2aWV3ZXLigJ0=?=
Message-ID: <20200312173134.bpflnl6n3w6mywlg@chatter.i7.local>
Mail-Followup-To: Emily Shaffer <emilyshaffer@google.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <6DAC1E49-9CA0-4074-867E-F22CD26C9FEB@jramsay.com.au>
 <20200312133127.GK212281@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312133127.GK212281@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 06:31:27AM -0700, Emily Shaffer wrote:
> On Thu, Mar 12, 2020 at 03:14:25PM +1100, James Ramsay wrote:
> > 5. Jonathan N: patchwork exists, need to learn how to use it :)
> 
> We've actually got a meeting with some Patchwork folks today - if
> anybody has a burning need they want filled via Patchwork, just say so,
> and we'll try to ask.

Just to highlight this -- a long while ago someone asked me to set up a 
patchwork instance for Git, but I believe they never used it:

https://patchwork.kernel.org/project/git/list/

-K
