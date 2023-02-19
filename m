Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCD6C61DA4
	for <git@archiver.kernel.org>; Sun, 19 Feb 2023 03:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBSD5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 22:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSD5f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 22:57:35 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780DB13DC1
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 19:57:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id qb8-20020a17090b280800b002341a2656e5so1825652pjb.1
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 19:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTgX/tjs82ONuTKvvE1eLL9J7vKG0yC0fKRGWTbrqDE=;
        b=Kdlxq3nMrIW+XroMBM69mBvddqP+kPi772zcCX+oEpsAy4tzMJp7KQ2CQLGLcmv6Ng
         YlqE259wOlouBQ4Nfzib33JC5zHSzdgG32qIQYBNVS8NjB7qVs02FKZaJvAv3jGUiYBX
         QhaL7Jm1I+Dhr7qVnGXQOpZSnghPY+1NexbbwikCPi9CB5mO4ruLNjaSpBKHyMy+lMvW
         eV4YaaHOTQNxHQFKpJlFQzt66ibmfgk/ZV5Ht2vIh1qoviRX303V1HwLPxiMKaD3AjF8
         3hNXKkIKl0zY0dWZmd4kOkYA0hnZ0Kedr+Ljrey3WV+7rfnlWyuekt/LMmvIe3QHB1NT
         1Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTgX/tjs82ONuTKvvE1eLL9J7vKG0yC0fKRGWTbrqDE=;
        b=GwFwg7LmdwsXMz3Nbbz2j6CCUMayEhC4fVWlYw6Xq/iw/QISj6DrRWHxPZYmJwoLmE
         RWDzlUH2ITRykEIEyfahemErdVg0S/W1TB5nqs+SA8uZqGUawsUejXd8rwpxfEL8SP7s
         H1Vx2EE50OsMGDVeA8WDgcLWOvfzAJ9pH5AYplb78UECP7U/gdCf+fDMEniRT6HAES+f
         bIRD6A3I+jusahQs+0jlRwtlaSZSZ25sTRiELsQ/bXsYKQbXZgGWIQorJMzIck37Qfj2
         7SqAMfoMNdnBqDV2PJNHkdjmXFMrbjs1Fm7RuV9ZWOsZkIfz7NWTEZKVSW+BoNM8gTQQ
         5kIA==
X-Gm-Message-State: AO0yUKWnxp7Y5mWnidPVxpOlJIZORwGh5jKnxvYzBovWPNy5yRQpLU/l
        4FkeRh6Pajw2J7QWZ7TDoBsLLDbTA/4KN2kz
X-Google-Smtp-Source: AK7set8z6PEhHjgymFD/ijrOPFj9RuwcvQRqVJWg4r3lx3DcIifInZBcbFmEkitGHO++n2/M4YaySA==
X-Received: by 2002:a17:902:ebd2:b0:19a:b754:4053 with SMTP id p18-20020a170902ebd200b0019ab7544053mr365703plg.26.1676779050857;
        Sat, 18 Feb 2023 19:57:30 -0800 (PST)
Received: from fivlite-virtual-machine.localdomain ([49.37.144.149])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b0019aafc422fcsm716495plb.240.2023.02.18.19.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 19:57:30 -0800 (PST)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, hariom18599@gmail.com
Subject: Re: [PATCH 0/2] [WIP] removed fetch_if_missing global
Date:   Sun, 19 Feb 2023 09:27:24 +0530
Message-Id: <20230219035724.99907-1-five231003@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAP8UFD1k4S-J0UXiFS9mdn_TqGc2kb3iaVYUP2ektrJ+uJZMWw@mail.gmail.com>
References: <CAP8UFD1k4S-J0UXiFS9mdn_TqGc2kb3iaVYUP2ektrJ+uJZMWw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 18 Feb 2023 at 22:30, Christian Couder
<christian.couder@gmail.com> wrote:

>
> I am not so sure it will be helpful for any of the GSoC project ideas
> we propose, but feel free to work on it if you want.

Well, I wanted to work on something before I started working on my application
and found this to be fun. So even if it would not really be
helpful for the project ideas proposed, I would still like to work on it as
something that could go into my application.

Thanks,
Kousik
