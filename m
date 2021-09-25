Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6DAC433F5
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 06:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B72361268
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 06:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbhIYGPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Sep 2021 02:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347874AbhIYGPE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Sep 2021 02:15:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719D3C061613
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 23:13:30 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r16so11593956qtw.11
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 23:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZSc1T+B73YB+VUYKtuZ+PsLPMGvthQtoAqbFXEXfuX8=;
        b=oSRwKVJU1IOXG5L/fKU7PwsFvauQ/EkEw4PkiTex+BpGRoO8oNcSWLd1eU9M2fDFvN
         CSscUkfXLLoycrDg4q3Lu5KD3zkRb5S8vZqX4oLdfDY3lE5YKb/ACOrIJJX6DpV4U097
         jRNyWN9eHDUte8TenCgh92bK7cP9dM0sItuVEMac7n5oR7AVMppWBU+AKUvTN2cmpgmh
         t73+gRjnTwJ8/A7sUwXvS0CgnY2iRnxhKyKuDY5bWbYOuqIk5Wo6gPT4v3sQrw1BIJX5
         N+dmTGgMd39dseNTbBBE9EDFZkaDSwXDWqTFlFFRQtYgQTv8gm9deiN1bElGO8nlhLaR
         iv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZSc1T+B73YB+VUYKtuZ+PsLPMGvthQtoAqbFXEXfuX8=;
        b=bdM++ZwKEPF4S84dTz2B0xXlm46neV70zLsXH5upRCQ/+xUp6c6X9ofmKggkUAo/zX
         sWSJk3MuNS9U7mqrDgtAas2QccrcBvvqMosckjmwDioSgMvLWQjs9MxVm5ujI+JeCywh
         mc/tOkGWFbzK9LrL4hpQIWhZ8ZqNiPHZp38kYVsHB2ft26mA8j26LxfGuM9TQgFATNRN
         1XKXx8tKieWmBc2kbR6D7zb47ltPOfCIQYzuflXKGOW/7tFYGJ9YmgddOfR/RW3Gx5R/
         FGjX6ewbf00KY8bV6AGHdUApnQ9dIrHEXK4fHmo8N654desEWzinzP9BFdSov7+lVJAY
         EgbA==
X-Gm-Message-State: AOAM533rL3qGeGjQ+BmMt5M1xtLv6u2QlNVskmpBQRqmOKOQ+P1Dm4MR
        M2JpDB6dX5T0jiNdUmOTFf6s4x6SY/w=
X-Google-Smtp-Source: ABdhPJwB+5urjwv5/fVz5iQe8+cohDO93sFFSi2AqbK1stcAoKuoX+4Mbd4n/KwZJNmPgGx8eYoenA==
X-Received: by 2002:ac8:7d0e:: with SMTP id g14mr8113421qtb.28.1632550409563;
        Fri, 24 Sep 2021 23:13:29 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v3sm8097274qkd.20.2021.09.24.23.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 23:13:29 -0700 (PDT)
Date:   Fri, 24 Sep 2021 23:13:25 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Thiago Perrotta <tbperrotta@gmail.com>, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v5 3/3] send-email docs: add format-patch options
Message-ID: <YU6+BWC+xvGJP3b0@carlos-mbp.lan>
References: <87zgs34ccx.fsf@evledraar.gmail.com>
 <20210924024606.20542-4-tbperrotta@gmail.com>
 <9a60226c-7a35-0486-a687-31f7691e7551@gmail.com>
 <CAPUEspjxYy4GOABXkzRza-wmKnZAdq-v=OP-9+-wfV2PCnDGwQ@mail.gmail.com>
 <xmqqzgs2vvim.fsf@gitster.g>
 <CAPUEspiSh91a8MvhqhKm=DAn5_u-HoRBuL6-gBRMUtSshqpf=g@mail.gmail.com>
 <xmqqo88hspvv.fsf@gitster.g>
 <d9114e0a-cb6e-1791-51f8-6e57f313e8d5@gmail.com>
 <xmqq5yups3g8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5yups3g8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 09:07:35PM -0700, Junio C Hamano wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> > On 25/09/21 03.03, Junio C Hamano wrote:
> >> Ah, thanks for explanation.
> >>      git format-patch -2
> >> would be options-only way to "indicate some sort of revision", so
> >> perhaps
> >>      . git send-email <send-email options> files|directory
> >>      . git send-email <send-email options> <format-patch options>
> >> (where "options" is used to refer to both --options and arguments)
> >> would illustrate the differences better?
> >> 
> > But we can also directly specify revision range (commonly <common
> > ancestor>..HEAD or HEAD ^<common ancestor>).
> 
> That is exactly why I have the parenthetical definition of what
> "options" mean in my explanation.  
> 
> 	git format-patch -2
> 	git format-patch master
> 	git format-patch master..HEAD
> 
> Everything after "git format-patch", i.e. -2, master, master..HEAD,
> are usable, and there isn't much point in singling out revision
> ranges.  FWIW, I think you can even give "-- <pathspec>" at the end,
> which are not options or revision ranges.

<format-patch options> then it is; would the following be worth adding
in top so the recursive reference can be followed?

Carlo
------ >8 ------
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index fe2f69d36e..806ff93259 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -30,7 +30,7 @@ SYNOPSIS
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--filename-max-length=<n>]
 		   [--progress]
-		   [<common diff options>]
+		   [<common diff options>] [<rev-list options>]
 		   [ <since> | <revision range> ]
 
 DESCRIPTION
