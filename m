Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BB2C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461DA20722
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJAt88R3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfL3XZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 18:25:57 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35354 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfL3XZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 18:25:57 -0500
Received: by mail-pj1-f67.google.com with SMTP id s7so444951pjc.0
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 15:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h7mqIVWcujp2S20Z92v51ztUT6cElVjxnzbjLEWjjD8=;
        b=LJAt88R3rBj1jlzr/Y8Yy3f2kzNr3IFPch1uc5NAFASJnIItvv4FbLKT/Jofs97fiF
         erPkPsYgBife4WCWPuuZcKoGBLxamdAZWr/GChiz5HBRZUbg+ntijTxQluNrpuRidmWn
         Q3bJieYXrxVO/kylEKMgKVVSdRlFzpdD48j16ZCRIzCbnHypJH9jPEAk4WyestR1YotM
         eN59L7rC5O+gGfCm7QYLRgwQhtix4z84Y4zrparSdRNgxebI7x9cV+2xbiGF5cwJHWK7
         LG516xGVNHYhHx6Ri9kRxxBxU/wVxC8yfF/t6h7bGdKGdRRco76fDs70rXghpheAq3SE
         6xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h7mqIVWcujp2S20Z92v51ztUT6cElVjxnzbjLEWjjD8=;
        b=t3v8lVhT8vSd/N2yBGpANbTkVMHfaHFDXODbIvxTnTWkgI6Ie3c9ndSEmnuNtr8dzH
         tobVENfrIVGfX0itsS9PqNymvh7ZQCxOOKH08LLY4MMyclijGJFFpod3Hdk3q6M9jeTW
         xlE6Tqj+iy+AVwhInb9OnWe9dyND3ePpHGQQ0jWBMMffTmi9unrbpHQwpAQt6rG562Yg
         AQEez9SVgKCvzvuePRcAp+ZEz95a7cA0bYyVG65R3ClpoSZGvvWJoAb9ff8Fpb1JhmWE
         XA4OcLXrZhTF8UR0awKLyoLFrZ12lCjT6cROdaKQoYU/zqlnJ5oJ77KDYivo/QBxO/SH
         xuOw==
X-Gm-Message-State: APjAAAWgpmYKC2qNJeur122a+peaDfXurY8igkPCSeg7+P0dteIWcYKa
        VXrCSpJ1PNToieamMhwklVQ=
X-Google-Smtp-Source: APXvYqyxdAUX2Y50pZRf2FAjDrA1l3zNuKkAvZ3I9jL90LtKyl6dSTelpK21Kjni5EfX8NE6DvUgiQ==
X-Received: by 2002:a17:902:7c95:: with SMTP id y21mr31276273pll.150.1577748356312;
        Mon, 30 Dec 2019 15:25:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b65sm50658214pgc.18.2019.12.30.15.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 15:25:55 -0800 (PST)
Date:   Mon, 30 Dec 2019 15:25:54 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Eric Wong <e@80x24.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org
Subject: Re: "gmane:" search undocumented on lore.kernel.org/git
Message-ID: <20191230232554.GA13606@google.com>
References: <03879A6A-2E8B-45D9-A06E-51926AC949F9@gmail.com>
 <20191230231350.GA16499@dcvr>
 <20191230231620.lcydd5egk4ma2rph@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230231620.lcydd5egk4ma2rph@chatter.i7.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev wrote:
> On Mon, Dec 30, 2019 at 11:13:50PM +0000, Eric Wong wrote:

>> gmane:  doesn't seem configured on lore at all.  Compare:
>>
>> 	https://lore.kernel.org/git/?q=gmane:1
>> 	https://public-inbox.org/git/?q=gmane:1
>
> I haven't configured them because I don't understand what benefit they
> serve. If someone can explain their benefit, I can consider adding this
> to the roadmap.

They allow finding the messages referred to by historic gmane.org
links.  For example,

  http://thread.gmane.org/gmane.comp.version-control.git/151297/focus=151435

refers to https://public-inbox.org/git/?q=gmane:151435, and

  $gmane/127980

refers to https://public-inbox.org/git/?q=gmane:127980.  There are
numerous examples of both kinds of references in the mailing list
archive.

Thanks,
Jonathan
