Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D7EC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 12:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15C720726
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 12:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h01qzK1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLIMcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:32:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52193 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfLIMcI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 07:32:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id g206so15298462wme.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 04:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IzAFNHgcRK4TMmE5U7lskBrHXsLil5HSbQx5Or1FBA4=;
        b=h01qzK1yrjLlpiWNk+TTS1K4SafbW1vtpLd9vgO4YEruYgLtjdZdYIJTMvAm5eOe2D
         OoEnHCMsXSThmrhtSuyle8tWOv5ju4/sWU8k9hm16ktnM1Frd7UDTSdPHxie3cb4I42p
         uUP+9xxqD0FtmBpGHcUKU23GBfQWwgvUh8UD4Ass2FfGHB7xEi2hCjmQ6d1hhxc5MCV8
         aKF43f/B+HikvY44jqu4DwKEdoQ+GdrB6LpsfQrVBxDQhPGvtPpKzZp+U2ONlBySHXQz
         C0pcIpTUqpJVzHkVr/4YXNL5Wzb7c+aehTkYaI/1ZITSM4k6Tf2Bziox8wNmFvgjO0CE
         oTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IzAFNHgcRK4TMmE5U7lskBrHXsLil5HSbQx5Or1FBA4=;
        b=l5Gi5dSeL9hKh0Y/tzkBwalMK/L3BQVuQAdnerRT8nZ87/eqODhVXDbLzB0kpiXQzd
         ECrKm7v0DSC3oXF2X/RNvotr99boG2731/VXGI/647QXiefGKcN0OGDmO2CgbJ1OEEGb
         w4OBq3jWAzVGDUml9gEXcCR9omS7xyuzrmPzg9GFLnJ7/qtDb4DfC81JuTIBq4GsXlMi
         K5dPYVUY0+WKJ/cD2uybumJ97mOWvFaeAVBnCLDo04uJU7Jyxyfrz4aPwyhwQS1tLMLj
         +G4S9nSV2WmiIKYB9IjdRDAhGoDS+MYbjR4/oZhesEw99wcATW4prja6kQveA2XKegs+
         AObA==
X-Gm-Message-State: APjAAAW0JuHdSV9sOyRiTp8wQe3elL+b2eY7UZLiG16+ewvKIHo4yb26
        aeqpn4WWLQRXPIfVefAEOrc=
X-Google-Smtp-Source: APXvYqzLSeUqPnUyPUmCMoPdNcKDBsTIfHez/Cj1H8cNuAPE/VMjp10I4nqo/DnmTSJ1m3A+FjUJpA==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr25502047wmd.7.1575894726417;
        Mon, 09 Dec 2019 04:32:06 -0800 (PST)
Received: from szeder.dev (x4db55b9c.dyn.telefonica.de. [77.181.91.156])
        by smtp.gmail.com with ESMTPSA id v8sm25118329wrw.2.2019.12.09.04.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 04:32:05 -0800 (PST)
Date:   Mon, 9 Dec 2019 13:32:03 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, stolee@gmail.com, l.s.r@web.de,
        git@vger.kernel.org
Subject: Re: [PATCH v2 13/13] name-rev: cleanup name_ref()
Message-ID: <20191209123203.GC2746@szeder.dev>
References: <20191112103821.30265-14-szeder.dev@gmail.com>
 <20191127180102.167352-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191127180102.167352-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 10:01:02AM -0800, Jonathan Tan wrote:
> > Earlier patches in this series moved a couple of conditions from the
> > recursive name_rev() function into its caller name_ref(), for no other
> > reason than to make eliminating the recursion a bit easier to follow.
> > 
> > Since the previous patch name_rev() is not recursive anymore, so let's
> > move all those conditions back into name_rev().
> 
> I don't really see the need for this code movement, to be honest. There
> is no big difference in doing the checks in one place or the other, and
> if you ask me, it might even be better to do it in the caller of
> name_rev(), and leave name_rev() to handle only the naming.

I think it does make sense: in my view the cutoff handling and calling
create_or_update_name() is part of "handling the naming", and it's
better when they are constrained to only a single function.

