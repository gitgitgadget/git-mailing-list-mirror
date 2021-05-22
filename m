Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1FDC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 18:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475A261003
	for <git@archiver.kernel.org>; Sat, 22 May 2021 18:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhEVSkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 14:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbhEVSkK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 14:40:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4372C061574
        for <git@vger.kernel.org>; Sat, 22 May 2021 11:38:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c14so22417185wrx.3
        for <git@vger.kernel.org>; Sat, 22 May 2021 11:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eajwnbnAWYzhKvt9ZXiTqARoZIHa9HdJ6ZP3A0O2iNw=;
        b=CLqGD0fMn+MvQT+gaM3gs8IiTULvRF5d/5+n0Nw7w4eISIY0ONsI6dYOXB/Qw4seig
         ZES3+AYGBnGioi1dXRXEHpnTOsua98u6HsnasN2FmQDCupX9YWuIq/6113IOpUMVH82E
         OA0roioA9TYZotEts2/+quzvR9aal/gClxsCg6ThOMgdtKwJBpZSGhf5W/VdISZdipBE
         DnYGHoYHwRWoR3BoWR8Aphuvgcu+G7Gw7bzpItPLtnYcuKOfKNZ5ibwAr5pkmrnXlFW0
         u8+6TdD5p0nhP161CDntYhtVMIdA4Hky3hcyngWE4nC9E8bUzxm2aVq0zVpsrUSTd2U7
         PvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eajwnbnAWYzhKvt9ZXiTqARoZIHa9HdJ6ZP3A0O2iNw=;
        b=FNCnVNZfZz2rdEHAtfpBRyydh+cczH+IWsFYTBBmdEh90idH6h1JO1CGWgJ5HlYXWT
         HG4yA/YqRdDJylWV613EuHsFW9DL00oIdMrWqPXGY/AXgfuyTHB02A2IfqpqI68S4DdQ
         O8RZZ6MdxNQDEBL7lsTIEPxQv3NW9pE3VqXAiyKkyZqxN3vEt6+J3d64CYzzjbkDd2fB
         xTlwkol9fVMd8VAul9cmIHTNPRScVTxk1eqLz5NxT9O/jRIYpwADsX0diZXGHgMLFUrX
         qtKdQMYdRPUZNbTxUtXr1wkksRoBdcpDrm2VdVFaKImB+0Lrbe7bQLW2rUajgA58LrHM
         CsYA==
X-Gm-Message-State: AOAM533W+2+/s8r+LR4DcZB2yKbeSuXku4sw45RS5UaH6DyL6b52c9Fx
        2PQuUN5gqAW6UXgnCAgHM6o=
X-Google-Smtp-Source: ABdhPJyRKn1RgxXMVQL5tkL/3aZwnJJcpZ31z612RG1NZqzJGNURO1/q4Eolq+FoPkz11q0mzkcxcA==
X-Received: by 2002:adf:e589:: with SMTP id l9mr15498833wrm.361.1621708722282;
        Sat, 22 May 2021 11:38:42 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.176.212])
        by smtp.gmail.com with ESMTPSA id p20sm2923291wmq.10.2021.05.22.11.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 11:38:41 -0700 (PDT)
Subject: Re: [PATCH] help: colorize man pages
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Leah Neukirchen <leah@vuxu.org>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net> <xmqqfsyj1qe1.fsf@gitster.g>
 <YKRy6oPkgS6FMSZ0@camp.crustytoothpaste.net> <xmqq1ra3z23n.fsf@gitster.g>
 <87lf8bqdv0.fsf@evledraar.gmail.com>
 <YKcFrbuuJrWAxXgm@camp.crustytoothpaste.net>
 <60a7f7427eab6_55039208ba@natae.notmuch>
 <8811383b-d5f1-2b06-8ac7-47bbc5fc9d20@gmail.com>
 <60a8243323625_77e4f208f8@natae.notmuch>
 <636007b7-c079-f8a6-1b26-eb2a55505354@gmail.com>
 <60a83c794ed4d_81cd4208f3@natae.notmuch>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <e669d76b-0bed-4eac-a942-c89b7523ca34@gmail.com>
Date:   Sat, 22 May 2021 20:38:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <60a83c794ed4d_81cd4208f3@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 22/05/2021 01:04, Felipe Contreras wrote:
> Igor Djordjevic wrote:
> >
> > ... to make the point (hopefully) even more obvious, let me 
> > quote the whole part:
> >
> >   It is reasonable to configure certain software such as a text editor 
> >   to use color or other ANSI attributes sparingly (such as the reverse 
> >   attribute for a status bar) while still desiring that other software 
> >   not add color unless configured to. It should be up to the user 
> >   whether color is used, not the software author.
> >
> > I understand it exactly as (I think) it says - it is reasonable to 
> > allow (the user, not developer!) to configure certain software to 
> > (still) use color
> 
> This does not follow.

Sure, if that is the only part you read ("followed"), taking it out 
of context while chopping the rest...

> The contraposition of that statement is that if a text editor doesn't
> use color sparingly, then the user should not be allowed to configure
> such software.
> 
> Do you really think that's what they are saying? The user should not
> have a choice? (with certain software) That's color fascism.

What I really think is that my message which you replied to - but 
decided to quote only _sparingly_ ;) - already addressed both use of 
"sparingly" and who should have the choice (not to say all the power) 
in a very clear and explicit manner (hint: user exactly), so I'm afraid 
I'd have nothing more to add, sorry.

Regards, Buga

p.s. Oh, and please do allow me to _opt-in_ the missing part of my 
message back :) (for whatever that will be worth, eh):

> > I understand it exactly as (I think) it says - it is reasonable to 
> > allow (the user, not developer!) to configure certain software to 
> > (still) use color (fully or sparingly should not even matter, and it 
> > may depend on what kind of granular configuration software allows in 
> > the first place, if any), even if his (user's) general ("default") 
> > preference is to have no colors.
> > 
> > Thus color should be user opt-in - NO_COLOR turns all of it off by 
> > default (for all software supporting it), and user decides which color 
> > to turn back on through each specific software color configuration.
> > 
> > That last sentence should make it clear - "it should be up to the 
> > user whether color is used, not the software author".
> > 
> > So it shouldn't matter what does software author think about which 
> > parts of software should be (fully or sparingly) colored (by default) 
> > - NO_COLOR's idea is to give the ultimate power to the user to 
> > decide, and on a global level, starting with no colors by default, 
> > then allowing colors where desired, per each specific software config 
> > (instead of vice-versa, being required to turn color off per each 
> > specific software, where color is otherwise used by default).
