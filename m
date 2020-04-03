Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F66FC2BA17
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 22:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072DB20719
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 22:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bxc3TW7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgDCW4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:56:54 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:40042 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgDCW4y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 18:56:54 -0400
Received: by mail-pl1-f174.google.com with SMTP id h11so3358064plk.7
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6NsBxSvfIQtm9CH3ZFrUFsxCP26Z3TaZVpNg9NMacEY=;
        b=Bxc3TW7VnZufTevnIRjG3CLFdQizOx0ygeCUXrd1IwmynWm+0pW6qlIjD0/ZPSp2SH
         P9AoOwWA83zck/gxk/m7w9t2WmSi8a6vHtfo2kzuBbviwun8TWsX86igd/SCPhB83fd3
         uBbAzd5NZC4ZZnONuHjHAnExhhQSGErzYvZ1jbwjxmnZy6E0mXLeFbvLkWxL9s9u0CDt
         uMUdMHt3lMfdQeF6OoiMi72fDgdMiCfBRm57HqmmT8rhOAgqmFNOY9bXvdYo4bLgbAZl
         xsjdQuZx0dzvXQJATPljVM6oJI7AyIlNuCFRy7/hM4oyRgFTMswKHJgK5eOadWb6CqsO
         Q0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NsBxSvfIQtm9CH3ZFrUFsxCP26Z3TaZVpNg9NMacEY=;
        b=WDIAqWreWJlYB7O/ypilR9SlOO6XKet0h8pX/ISFhTPI1A09AWjbgvk9ZnjwA8o+bs
         Fmou2HJb/KpxVvRV1q0X+UEVxSrn/GYmHy9/NJSSHq2yGz9/+Q9Uq0zu1FiO+7QxbgrE
         c3VeYYnwVDkXAJ6T2HtqH58MppciPDfQd8qbHlgkCprl1GRRnp03b+x635Xrgys0sQG8
         v8Y8prFovHlNfQlu4EJ3BH6IeL+VDKwARgkOaExzN9qQSFPw8zebSOVk24Rd6rDhXkIO
         8Cup1ZNyUxOtH1rrSqLm5r0c3dsXI+SGKl1bxm/OiwzId8CY3waa5Ai7MrT+0QMsE3l+
         c38g==
X-Gm-Message-State: AGi0PuZy6Z9mOVK/F9eqcLRecZjuq6RXlPQLS9OLtKGUaSVgKT3Ub9q2
        woPNpqbuZRW0+yL7jiXFoV84hbLvAbU=
X-Google-Smtp-Source: APiQypIhEJJP8BA4LBV9mGpm2keRRchaMiyueDU3HNwW9aEEoS6+2TCNjgB4NwSpZUdyyrqKf1kRnQ==
X-Received: by 2002:a17:90b:8c4:: with SMTP id ds4mr12795582pjb.44.1585954612823;
        Fri, 03 Apr 2020 15:56:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id t4sm6546159pfb.156.2020.04.03.15.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 15:56:52 -0700 (PDT)
Date:   Fri, 3 Apr 2020 15:56:47 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #10; Tue, 31)
Message-ID: <20200403225647.GA228236@google.com>
References: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 04:04:28PM -0700, Junio C Hamano wrote:
> * es/bugreport (2020-03-26) 5 commits
>  - bugreport: add compiler info
>  - bugreport: add uname info
>  - bugreport: gather git version and build info
>  - bugreport: add tool to generate debugging info
>  - help: move list_config_help to builtin/help
> 
>  The "bugreport" tool.
> 
>  Ready for 'next' to be improved/enhanced on top?  As the scope of
>  the topic got trimmed, hopefully these early parts can be polished
>  quickly enough to be merged down.

I saw one small comment from SZEDER today, but haven't heard activity
from others who had nits on earlier patches. I'll wait til at least
Monday to fix the thing SZEDER mentioned and re-send.

 - Emily
