Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6651C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E35B20722
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4lk1Zk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgENVhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgENVhP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 May 2020 17:37:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3DEC061A0C;
        Thu, 14 May 2020 14:37:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so673423wrt.9;
        Thu, 14 May 2020 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UTNcFMsyU7qMTj+Msz+3dKqMrWgXHBSTaDPVzfMIy0o=;
        b=I4lk1Zk1S8ttXMbZI6jdcMANUjNUIZmOkh+aGd6dTfQgGwHOFBvx67fI9Nh/WCKZsp
         Q5VdvJmxi4jTWD+wuwGXCDT1bA9EYk0ZK5LznDIImmj4GpAn6vjjAHrSjwnQmqNjx+V6
         32YoxCvNT50ILys+3jxyBgz7EuErBOxMISu2Xpe2lSOtNGwUFP1ooWd1uzFnlY4seypc
         HMXWvJUP1K5lFl1D+HzAqix/k77IjCRx4NJhw6KKNcuCNerqRniJej0O4kmpFE+t2DuE
         PIOrtlAqwpVVmLDg4pdJSwfb7MviBpIntn/C2RnQ51B4lKjkHr3xE8zDL8DtrkJubmwS
         /Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UTNcFMsyU7qMTj+Msz+3dKqMrWgXHBSTaDPVzfMIy0o=;
        b=ahW+zNZV3CEb/1NCSCPyYTANSkKDAG9p3mhrDBxkuzqL7+H5Z5j/2Kylt8DkgBrlA2
         a8goU5IFsb+MNjBAR/jCX23UkJeDLus5iT7EoZNay42OnhyfCnDi8SoVYsJf5cOnftUG
         r+0+8YrP/aVSja1WU82NyGUf9AjktdGg/Mjp/MdxwuWwjLYkdwt0+md76kLC7tMJ7tEt
         maM/hK5cwSvagPHhYsxaWIZSzQBvswN+WXP8Gk0GoJuxm9sieBbE0C1K+6MApOuoyT7g
         kYNrAhN2y1L693Pxzzj8pbkqa5nsQMyukl2aLNH75CmrfaY+kQwgrFhN4RafFPGrJL7c
         ABPw==
X-Gm-Message-State: AOAM533ZYUuAKd578FhBJIqdIg+w4uQkkeVaKrz2dETCPMyo4Jjz86oN
        i6wgnghkOftOJNzXq4ZuzWU=
X-Google-Smtp-Source: ABdhPJwcecpM+gf6ON/f9yYLtxyj7GLZU68X/3Qk/t2c3ASoL6CMfyuvFO4GkhCsKvqX7nHLW2u9iw==
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr499173wrn.266.1589492232440;
        Thu, 14 May 2020 14:37:12 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:49b3:709e:5c4a:780d])
        by smtp.gmail.com with ESMTPSA id s8sm310188wrt.69.2020.05.14.14.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:37:11 -0700 (PDT)
Date:   Thu, 14 May 2020 23:37:10 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH 1/4] C: s/0/NULL/ for pointer type
Message-ID: <20200514213710.vxm6vrkggdfad6kd@ltop.local>
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <c4fac2ae9d10bc426cb26e4a102b808549696763.1587648870.git.congdanhqx@gmail.com>
 <1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com>
 <xmqqd07xem9l.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd07xem9l.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 23, 2020 at 05:54:30PM -0700, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
> > Actually, I have a patch somewhere which suppressed the sparse warning
> > for the '= { 0 }' token sequence used in these initializations. However,
> > I don't seem to be able to find them at the moment! :(
> 
> AHHHHHhhhhhhhh.  
> 
> Thanks for reminding.  Yeah, I recall that the concensus of those
> who were vocal in that old discussion [*1*] was that "= { 0 }"
> should be taken as an idiom and should not be subject to s/0/NULL/
> conversion.
> 
> > [Luc, this topic came up on the sparse and kernel mailing-lists at one
> > point, but I didn't get around to posting my patch to the list - something
> > came up. Hopefully, I will find some time to find it and post it soon.]
> 
> 
> [References]
> 
> *1*
> 
> https://lore.kernel.org/git/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com/

Sorry for the late reply.

I hadn't seen this old discussion but I vaguely remember 2 emails about
this problem, probaly on lkml, without a real discussion, but where the
opinion was the opposite.

Personally, I prefer '= { }' but yes it's not legit and it seems that
some compilers don't like it. I'll be glad to add an option to Sparse
to shut up the warnings now given by '{ 0 }'.

-- Luc
