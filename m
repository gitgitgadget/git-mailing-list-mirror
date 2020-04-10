Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3399BC2BA19
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 01:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A9E20730
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 01:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6rd5aC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDJBT3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:19:29 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36677 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDJBT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 21:19:29 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so228686pjb.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=syLztrCjWwHO+KwnW3+GXbOIjefpY5kJV7n02APKQa0=;
        b=E6rd5aC0BcCYI9fyOhIBDQ146UFCP7Z6lkbilSEu4z762iSd9OLVCErHsJF6b/QHrw
         BgCUIkYStrVHW84aVxx+YjM2bizp/G6W1zMb8m/v8jXU9AnTFqAcvLGSh3RSDS1i6eCJ
         mekE94+qVZUDAoAqbZxCHC5FqI89S6+2gbCeIhHDFhCoIFYQ9EypG6Ge3B+//ryTzuNb
         HuMPrALfOii15vA41vmpttCLGcq5X0EwtBxMbT0HdNwBkjRqFJvr04M1f8AJWr6sUXcL
         Ke5RCe5xLMqktiqsyK7EMHuwYGYD1NjGP0RAfXKY6laTHJgzxO27P4garMQA93l6ZQCo
         VnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=syLztrCjWwHO+KwnW3+GXbOIjefpY5kJV7n02APKQa0=;
        b=E3Ih3vavyvGov+uqNZC4RqWOJRHUWave8pPLISQi7zrYwqxfI4QWhsS6lLaWHhTgXd
         pKk4X0/b+YUVQPzSf/91QVdN+Vi4fH1dc2HI79LfZjEaZuHJhjeOWYwkndzMNVYmXbsh
         rf0x4DkzBgunEJ741Q38iFRgdsd3Cej1ncyN+0hFF2ASrA3G4l59L2Lh2CdHqdV+kBW1
         YkfNVSDUt/JHIEsIPd0rnnMRB0gIlDXN04RkxerU5GTjCEE4m2lPpM6FHxzGsELexyWO
         yoagKnf5gt5/scwZeMssGmwgZrSsqaSgNmwLxr46PPMktsTyrCNjA5/8R4VpF1UWzUop
         4q5Q==
X-Gm-Message-State: AGi0PuYS4h3W8h/uMbxf9fztZcZnywaoNHj4QjzGJrfnNYJsTQxBQogb
        W+XYZhmh5SRvSKqMB3B1xbmM8Doz
X-Google-Smtp-Source: APiQypLDiMo5CBCHfbPc6EQmhwSG30ElGihRYp9goJ2T1gLNgBa5DWObH5zQBDVZbFDjCf4dVasv5A==
X-Received: by 2002:a17:902:c1cb:: with SMTP id c11mr2407112plc.174.1586481568477;
        Thu, 09 Apr 2020 18:19:28 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id 17sm340035pfa.8.2020.04.09.18.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 18:19:27 -0700 (PDT)
Date:   Fri, 10 Apr 2020 08:19:25 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alba Mendez via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alba Mendez <me@alba.sh>
Subject: Re: [PATCH] pack-format: document missing fields
Message-ID: <20200410011925.GB2462@danh.dev>
References: <pull.605.git.1586459494321.gitgitgadget@gmail.com>
 <xmqqlfn4mjm3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfn4mjm3.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-09 14:31:32-0700, Junio C Hamano <gitster@pobox.com> wrote:
> "Alba Mendez via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> >       4-byte version number (network byte order):
> > -	 Git currently accepts version number 2 or 3 but
> > +         Git currently accepts version number 2 or 3 but
> >           generates version 2 only.
> 
> Hmph, what is this hunk about?

The original line is "<TAB><SPACE>Git", she changed to 9 <SPACE>
to match with other lines.
I guess she set tabstop=4, this paragraph will be mis-aligned on that.

> > -     (undeltified representation)
> > -     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
> > -     compressed data
> > -
> > -     (deltified representation)
> > -     n-byte type and length (3-bit type, (n-1)*7+4-bit length)
> > -     20-byte base object name if OBJ_REF_DELTA or a negative relative
> > -	 offset from the delta object's position in the pack if this
> > -	 is an OBJ_OFS_DELTA object

Alba, if you gonna change the above <TAB> to 8 <SPACE> above, you may
want to change here, too.
This paragraph was written with tabstop=4 in mind.
And it's in the context of below hunk.

I'm not sure if changing <TAB> to 8 <SPACE> was expected in this
file because <TAB> and <SPACE> is also mixed in "Pack file entry"
section.

-- 
Danh
