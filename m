Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581EBC32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F212081E
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 20:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="gMBy89zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgAOUKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:10:15 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:46300 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgAOUKO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 15:10:14 -0500
Received: by mail-pl1-f172.google.com with SMTP id y8so7272915pll.13
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pQ0FK5TEAiheH4fj5024ajsp51LRFDP6NS8Pe8iqjZ4=;
        b=gMBy89zv0PkEU5UvXkp3+fiypgd69KHeE06ujN7j8ZnxYrDb6bcBiI21SbYVhlPQqz
         +rj8ZiEP54/XUMpUORM8if5lemyMjl9cQHriKuk1H3i+f043XRp4216roLxc14DUo6Z7
         kUJLCHj0iibMR/Ohw2+Mw2cioCnhHUfEK8n1dBfDdIpYSwHH4FsXyR9OYdHdNX0ADJSa
         BUS+/WSF3/gszjl4Z8rkEYNFhdRiYeG0+2q8HrBeQHBJUIpq/CWWj8cFEzEor4i8tYbs
         JtsCGSromXV7wekMe3rikgnPBq6MvfR8dDgLhBKtrGD2TnNrEdqZxvmUkr5onHp6dzOa
         eCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pQ0FK5TEAiheH4fj5024ajsp51LRFDP6NS8Pe8iqjZ4=;
        b=RjUp3eFyTqXk3s+XBfYCIdrSwbOXVyxkO3ldnc8Is2aGQxmnqER0j1IJoOrzKegQT2
         yFOD/4dCQHMea8lz9yv9gH70q8M3uJhRWdTjMNz9YOjOxxdOGmXWJZDynDnn0zmNSMcm
         8YijSFTL/WmGvFdtApC6j5F8/Np5omjtik5PMICpnr7aNzsZBLALNCKXx5rTv8aHUeVJ
         i/oOjaajqxyYh6ilHN5LlTSvf/vQwCcOd4TndfN/CTgiBXzmxXtO4bEXtFOL7imMAza3
         RcYuYjvAUnd0fpKffD/b1AxoSIxg+pE0RbQaVKsbGXj50SUyLMYUZnaopIz0NgSp+mv6
         14AA==
X-Gm-Message-State: APjAAAX2H/ZR3py2//iXNVUax40PO0CRPi9t8/7gsYCHT5Emg4fZ92BI
        li8EvUNuq4UlFXyrEVZIPw2KhQWuZbI5Mg==
X-Google-Smtp-Source: APXvYqz2zXwDMOczDCjTODP/yBenFBGG2jirXTZJ3VjZaoPMnNgV0/SikMRf/DHY4btFdkLT6FhG4A==
X-Received: by 2002:a17:90a:8d81:: with SMTP id d1mr1935762pjo.63.1579119013631;
        Wed, 15 Jan 2020 12:10:13 -0800 (PST)
Received: from localhost ([205.175.106.239])
        by smtp.gmail.com with ESMTPSA id b21sm24375123pfp.0.2020.01.15.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:10:13 -0800 (PST)
Date:   Wed, 15 Jan 2020 12:10:12 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git Contributor Summit Registration, Mar 5, 2020, Los
 Angeles
Message-ID: <20200115201012.GA62038@syl.local>
References: <20200115200705.pxFH9lItfcW1_G4jQHgU46bfNXBeU_e90Ar0IfFjdZ0@z>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200115200705.pxFH9lItfcW1_G4jQHgU46bfNXBeU_e90Ar0IfFjdZ0@z>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ugh, how embarrassing -- I fat-fingered the wrong key and re-sent this email
(twice) to the list. Sorry about that.

On Wed, Jan 15, 2020 at 12:07:05PM -0800, Jeff King wrote:
> Following up on my earlier announcement, I have some more details for
> the Contributor Summit at Git Merge this year:
>
>   When: Thursday, March 5th. 10am-5pm.
>   Where: Downtown Loft, 1054 S Olive St, Los Angeles, CA 90015
>   What: Round-table discussion about Git
>   Who: All contributors to Git or related projects in the Git ecosystem
>        are invited; if you're not sure if you qualify, please ask!
>
> Note that this is the day _after_ the main Git Merge conference, unlike
> previous years. The main conference schedule and agenda is up at:
>
>   https://git-merge.com
>
> To attend, you'll need to register online; please email me off-list for
> instructions and a special code. It's bundled with your main conference
> registration, so please DO NOT register for the main conference until
> you get the code. As with previous years, you'll have the option of
> attending for free, or paying the $125 conference fee (all of which goes
> to Software Freedom Conservancy).
>
> If you'd like to come but need financial assistance with travel costs,
> please reach out as soon as possible to the Git PLC at git@sfconservancy.org.
> We'd like to make any funding decisions soon so that people have time to
> make travel arrangements. So let's try to have all requests in by next
> Monday, January 21st.
>
> When picking a hotel, note that the contributor summit is not at the
> same venue as the main conference (but it's nearby). There are some
> hotels with special pricing listed on the conference page at
> https://git-merge.com/#experience.
>
> We're still working out details of the A/V setup, but the plan is to
> have a way for people to join remotely. I'll send details when I have
> them.
>
> The afternoon schedule for the main conference is a bit different this
> year: we'll have some round-table "Birds of Feather" discussions to get
> attendees talking to each other. Think about topics you'd like to
> discuss, and also whether you'd like to facilitate a discussion. The
> online registration will ask about both. If you're interested, we'll
> provide more information and some documentation in advance about how it
> will work.
>
> There's also a tentative "Stump the Experts" panel as one of the
> sessions. There are still logistics to be worked out (e.g., how far in
> advance questions will come), but the general idea is to take attendee
> questions about some of the more confusing parts of Git. If you're
> interested in being on the panel, let me know.
>
> Sooner is better to make our planning easier, so please let me know if
> you're interested by January 31st.
>
> I hope to see everybody there!
>
> -Peff
Thanks,
Taylor
