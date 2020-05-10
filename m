Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06492C35280
	for <git@archiver.kernel.org>; Sun, 10 May 2020 06:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCA96208DB
	for <git@archiver.kernel.org>; Sun, 10 May 2020 06:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piprgwc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgEJGf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 May 2020 02:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgEJGf4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 May 2020 02:35:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE67C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 23:35:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so2464844pgv.8
        for <git@vger.kernel.org>; Sat, 09 May 2020 23:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bbRFbFYMdG0g8KvpmvfFCGojchotlzC91SlFfBT7iXw=;
        b=piprgwc0J7xV6qpJyxWXVgbaOyqafMP+DZbDDxCQuF5Kc+blKremgbWaPFgTX3uk3v
         2he1HrMqmjvbCDIxVb8bvbix886efwz9Wl/BRKvQLbgjChXbsS4ckPafiMdHg18ZTrH7
         Iuop9b5vJLBkyAZe9i93mOzfGpkhQonFfBEkwMG0OLzSjZIKlXymh2WlYdvdKNfVuwF2
         GZuG/6LV7N7fYNfe0oerA+REMkBRxcMH7omhmxdfBuH+ieMWhe2yi8L4o6hZ5rnpGGj9
         EdaCR2DecA/3sYlyWTW7g9w24tbDNBX3BTTDHblb4O1+h7jEsPz2ke9wPL+3Sw3C0DrW
         l8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bbRFbFYMdG0g8KvpmvfFCGojchotlzC91SlFfBT7iXw=;
        b=ehzShnzyBnzOJnnAMtTzgoocR/9m/6084idZFPQU2bkiWIZnHI1o5WRsmelFJIUbhv
         LTVbRWKrIohwL6MZzXB3GlXXspHU9GqCCgXhrzPVKTp+5rp5anmMEY70JIxYAzbUbkBJ
         h+a/zXsaxKWqFNWtaAh3SLruoQle1xNbHumk1CG5r8riytjlT3yEGNymnEv2qVxgLH/Q
         cOhxuwBndA0GVix8XOcd8vf/ul7qAA0eypH4/K709JfpyMQZCv8ylI+9FVLh+7YWiqDP
         pa4FV8Lfj/kBDDblhC8FhXHcmawGS6ZMy7VHf/JQMAzfsqbNm/2dF9dKV5oB/qRFLZgK
         5qkw==
X-Gm-Message-State: AGi0PuYPWY6hOPrnHV+3ytjKqfUbj5wdwc9sSpkzGb5EIXMvyuXkwL1v
        w5ghWWGzdgoPGBBfrwjUhn36s79zE1rV9D2N
X-Google-Smtp-Source: APiQypJdAq2q8WbOvgbmnnSSftABk7IBIXUrr6leV/XcYwrVzZIqv2sMXYey70m7jWRr69H0Ca6d+g==
X-Received: by 2002:a63:6c41:: with SMTP id h62mr9123778pgc.303.1589092553602;
        Sat, 09 May 2020 23:35:53 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id i4sm5159911pgd.9.2020.05.09.23.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 23:35:52 -0700 (PDT)
Date:   Sun, 10 May 2020 12:05:44 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        heba.waly@gmail.com, stolee@gmail.com, jnareb@gmail.com,
        gitster@pobox.com, Johannes.Schindelin@gmx.de, peff@peff.net
Subject: [GSoC] Shourya's blogs
Message-ID: <20200510063544.GA3561@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

I post blogs as well as my GSoC progress on
https://shouryashukla.blogspot.com/
I will try posting the GSoC blogs every saturday night (around 2300h
IST). Other blogs will come randomly. Feel free to leave a comment on
any of the blogs (there are 2 as of now but more are on the way ;)

This is my latest post about the first week of GSoC:
https://shouryashukla.blogspot.com/2020/05/gsoc-week-1.html

Thanks a lot,
Shourya Shukla
