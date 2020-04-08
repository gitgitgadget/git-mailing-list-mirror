Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F93C2D0EA
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 07:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9982075E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 07:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bygOYt3z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDHHPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:15:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45672 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHHPu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 03:15:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id t4so2187600plq.12
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 00:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=hxI5P/rybjVuBxSYY7OaEUvXUHdQacnQsI6m1BoxNBo=;
        b=bygOYt3zIOlABt/F0MORFFcThEwy7ezZKbAjFl/Jh1A5uXRuM8sW1BfljhIS+6KU/S
         Nlc54C3JfjzHHGlRy8KZ59rq5NlNzqhthFGSLuBStliwMnexTYBP4fLMjEtuAHGP2YPG
         B/Z1VlBMVjwAIilhXqcPLpJW+nrYyA9ZA9qPX8rTu0UfhnwKRQ3S5rOo6vkUibejUahu
         9ZQKx5bwDWPy1GbJ1n7XJAfp+vcZgzZXb+ME/1FxLVpzooiJpc/gB703v4nzFxbLKCX7
         IciqAPmeI3f0k03iosUBhMeVh+BLNyyoG4ZzC4vxGjzV8zjX4mJOohcGf6G2zSFd19E1
         VCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hxI5P/rybjVuBxSYY7OaEUvXUHdQacnQsI6m1BoxNBo=;
        b=qh4vKvQvePbNH4du9PkOQzFJJ+qxRyOR5sJEQady0LYc0DnLahri0bV9zhgVMC/Kwj
         cw243YWjjYTlPwv6cFmbtniLbkGmREy+v+0NYODDiqHh1ZbSylqR5M3/Tyyho1hll4v3
         h+sXDep9kamQAUN5RIEgu9wJDa9NO3ZIy25Uy1bbk95GlSC0lC51OgGqAjC4A6JiEMYh
         RS9Fn9ZNpWQBmbW7vJF1ApqMvNB059VRcBfn2axHBsQ5AQzY8NxOOi/iXH+ZGlyE1SM3
         xGgPcYrXR/mSFMA23F6Qn/5Io76Dzim0yXcqhmgT9U8zwOKWIkjOxIh05+JTEC3iYsF3
         Q80w==
X-Gm-Message-State: AGi0PuYNWyXWt5/nVSnc0lWDboH67qPEzVZ40XnYuFdczF+9oX/0hcRs
        v/OLIeh3lpGsyzw/uSCcVfJbn7U2MOaouA==
X-Google-Smtp-Source: APiQypKf3ZnO2sjc0/vKT75nh0ElXdM1JRThGB8yRwa8AuUWydtTP9Zpzc8yU66gDwS/Hmq8YcsSOQ==
X-Received: by 2002:a17:902:760f:: with SMTP id k15mr6335665pll.0.1586330149464;
        Wed, 08 Apr 2020 00:15:49 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id nh14sm3486308pjb.17.2020.04.08.00.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:15:48 -0700 (PDT)
Date:   Wed, 8 Apr 2020 12:45:43 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Re: Happy birthday to all of us ;-)
Message-ID: <20200408071543.GA5023@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhbmpyh6.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am an extremely new contributor as compared to most of us around here,
basically just a newbie. I have learned a lot from y'all, be it ways to
write code, understanding the flow of programs or learning new tricks to
do stuff more efficiently.

I am so happy that the community was so welcoming to a newbie like me
who knew relatively very less in comparison to everyone here. Thank you
all for that :)

Thank you Junio for taking such a big responsibility over your
shoulders, you are one of the reasons Git has come such a long way!

I hope to see many more birthdays with Git ;)
Let's make this project even better! Happy birthday to all of us!

Regards,
Shourya Shukla
