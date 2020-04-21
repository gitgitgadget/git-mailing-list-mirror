Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F0C54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 15:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B55B2068F
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 15:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOTTsvqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgDUPJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUPJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 11:09:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F482C061A41
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 08:09:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so4077452wma.4
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V4dPtQplfeb952DvZ2JY7R/CYBmzalMW3W8/WkTEE4Y=;
        b=YOTTsvqD7tVwToIATx6RR9qAWw2ijWkELjM7E4KXaCMk2oTM1AOpnB7zRSEAHmlSnF
         LRtiePpSkJWC+1KfuprL420IGGnL3j700MFd9LCtm4+Sfu1lHfIuAe64HUbNYNWoYjE5
         vbISrV95F+TdtOzfe2oAmyOXhbajKPk87BnNiQROFfhqADJe/WeXoEOq3f1iVXF9QsYA
         UoECu5HpbD/Qm3pEmQWPRrFmaH7AFNHi5GGoCznGUxXXEG1LcSyT029aXja2VcvWhdbU
         i5NgqxzhBuvQjk9rc3o7Iz7yoZX1mlzv5BLaQ3LucxDue1sJAX1N7EmTA+0994oaDUR8
         PWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V4dPtQplfeb952DvZ2JY7R/CYBmzalMW3W8/WkTEE4Y=;
        b=JxCEjvDtPjy5U7t0NSju3bqSi/hpmCOOgCShgWTYrb56GLzDx70/uk0ftsY5+aHQ1e
         ZhguzuUHtlCFkbW1UWN4yUkEquzT7tZeYJk0X5YNKjkk7WAQEKwnnp45UbQ4MQeraT0Q
         wSpKat4IJkwKgjleRM1L1YcoBTI1W8sJa8dtNJYyiQBajkosT5CH+RVFi2/afXWj6IaV
         J8ScfY+BCzxV12nkftINcGCGpzyIVKnIRA4yjrR9QdEl6tNIdf7b6vENf1kvdsyRBfAw
         J9o8HHlF6OsmKkiRRoEKs1+D+MY7jR1onuhQHkONDQUFikdbFrX62AM+iXrRyNzkLiFQ
         iAYQ==
X-Gm-Message-State: AGi0PuZi60ii6EOGusu1op/18mHuksNLn15V3ckNu7ZuvN+VtF8rSo4L
        rGfLVOkoc7pmWT/P0Y5dbBs=
X-Google-Smtp-Source: APiQypLLTv3v8zwfwywzOVYRBKfF9xG6Hte2OlxtJ+PHkiyk5uW71RtL9aQBqzhOOSYWTq9EhPGg0Q==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr4992539wmc.64.1587481739151;
        Tue, 21 Apr 2020 08:08:59 -0700 (PDT)
Received: from feanor (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 1sm3988038wmz.13.2020.04.21.08.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 08:08:58 -0700 (PDT)
Date:   Tue, 21 Apr 2020 17:08:55 +0200
From:   Damien Robert <damien.olivier.robert@gmail.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2020, #02; Mon, 20)
Message-ID: <20200421150034.bgjpbsgfmzvnzjrp@feanor>
X-PGP-Key: http://www.normalesup.org/~robert/pro/files/Damien_Olivier_Robert.asc
X-Start-Date: Tue, 21 Apr 2020 16:59:41 +0200
References: <xmqq8sipppmt.fsf@gitster.c.googlers.com>
 <B6EF27DB-E72A-4854-B447-98371F911ABD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B6EF27DB-E72A-4854-B447-98371F911ABD@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From Philippe Blain, Tue 21 Apr 2020 at 09:06:21 (-0400) :
> I added my "Reviewed-by:" to this series here: 
> https://lore.kernel.org/git/7B4732CF-967E-4FF6-86F0-CE3612AB3CA4@gmail.com/
> but I see it has not been added yet to commits in the topic branch.

I think Junio merged these patches in next before your 'Reviewed-by'.

On the other hand it would be a shame if your name do not appear in these
patches, most of their contents actually come from your reviews!

Best,
Damien
