Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83565C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A4F20717
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 20:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZGH3L6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgKWUIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgKWUIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 15:08:16 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8D8C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:08:15 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id w24so591470wmi.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 12:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=IRcX/Hg1ERPxnkQhUjqh0etjpb5gVQIzya5ZncAQPeg=;
        b=hZGH3L6tzWm0iUJ8VWLC5OS//lzh5RQ1sbPKWF9tjVG7zam5z0JcIavLPhVUIzv2KZ
         n8abW/rQ9pI00m9FDOsbBjaaBSKJrUnoLLaCl2RCR21YmhXoGlUAp5vGnsMGhiIRZ5Ki
         31FeL/DuD/UUdDlRs7E8h9W4I7jTUBiU8vFbyyppriS/k/si+8fWWbyvJOzA7rLnd+I+
         bCdOm75o9GugRJD2tZhZeD0Udan1FBbYIZdo/t1mPRws3M8CpN+heNmvqf5xz7UXMdcb
         1geI2Kjzx9JKS6iKB1++cecGs/oGufhMKoCKhEIidnmGELUPxwflWU8t8MNy2G2Psy6Z
         pTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=IRcX/Hg1ERPxnkQhUjqh0etjpb5gVQIzya5ZncAQPeg=;
        b=HoZKy02uyTd91Rsp18ychZw9khHV/o03PBmwmRej3t/phCZZce0NLfOVCACxAXRNB/
         hmEY/+odDHp6lqQnvYcBBR3iaojFoIlwJ9kxP/01Uq1bslViUfWc0F5SFx0jLB1EgkQ+
         IIKXB3OT+B+aJ7r7WROD88DzhU1Xzg8JBMDBhBtAPgeh7JlH8Cdkuss9HoDJxE1x6RtT
         dw6LUZadRo68kT1dNsNi9JJ3Z9rnaKdjJVGCvSzItNqMK/F3LYTk6zlBMTReXyZluZmu
         6k0uPFFmF2fCSc3w3ot9KhPGaMJSYBwUWYNigsgLyUOHDtUYP9xw0EXU7wkMLdwnsGN5
         uj1w==
X-Gm-Message-State: AOAM530JGqXLGJcnrQLRpsuezxoWvX41cdw2xtQxOo9if5WRSGiV3E/9
        FQ50k/RbRIcZk5AcwVvJUoVwoU+Mjrw3oA==
X-Google-Smtp-Source: ABdhPJzZz2ZaOKncNtwXoJqnlFMQOLrsQihqn3pZlfEo3aIRiVFfELAY5LvKfLQh795mvjKOCcXP7A==
X-Received: by 2002:a1c:8145:: with SMTP id c66mr563164wmd.71.1606162093918;
        Mon, 23 Nov 2020 12:08:13 -0800 (PST)
Received: from [192.168.1.66] ([46.98.122.136])
        by smtp.gmail.com with ESMTPSA id f4sm635857wmb.47.2020.11.23.12.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 12:08:13 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:08:05 +0200
From:   serg.partizan@gmail.com
Subject: Re: [PATCH] git-gui: use gray selection background for inactive
 =?UTF-8?Q?text=0D=0A?= widgets
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     me@yadavpratyush.com, git@vger.kernel.org
Message-Id: <HLM9KQ.QZTOWNY8EICB1@gmail.com>
In-Reply-To: <23d6eb6c-4c7b-b9dd-d0df-fe0feaa0dc17@haller-berlin.de>
References: <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
        <20201123114805.48800-1-stefan@haller-berlin.de>
        <JE39KQ.T4FA61XF34XT3@gmail.com>
        <23d6eb6c-4c7b-b9dd-d0df-fe0feaa0dc17@haller-berlin.de>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Mon, Nov 23, 2020 at 20:03, Stefan Haller <stefan@haller-berlin.de> 
wrote:
>>>  +        bind $i <FocusIn> {
>>>  +            foreach tag [list in_diff in_sel] {
>>>  +                %W tag conf $tag \
>>>  +                    -background $color::select_bg \
>>>  +                    -foreground $color::select_fg
>>>  +            }
>>>  +        }
>>>  +        bind $i <FocusOut> {
>>>  +            foreach tag [list in_diff in_sel] {
>> 
>>  This two `foreach` can be combined into one?
> 
> I don't see how; any concrete suggestions? But I have other ideas how 
> to
> simplify the code (by using one function set_selection_colors that 
> takes
> a has_focus bool and is used for both bindings).

I tried to do this, and now i understand why my suggestion was wrong, i 
was looking at this as "cycle inside cycle", but it's actually "cycle 
inside event handler".

> 
>>>  +                %W tag conf $tag \
>> 
>>  And this `%W`, probably should be `$i`?
> 
> No, $i wouldn't work because we're inside curly braces, so $i wouldn't
> get expanded. It would be possible to work around this by using ""
> instead of {}, but why? Using %W seems to be the idiomatic way in
> bindings, we do this everywhere else too.

Oh, now i see it's used in the same way in other places!

 > %W  The path name of the window to which the event was reported (the 
window field from the event).

Now I understand it.



