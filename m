Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96FCC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 23:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EB220714
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 23:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WsfOIpRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKVXT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:19:28 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:37179 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVXT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 18:19:28 -0500
Received: by mail-pl1-f171.google.com with SMTP id bb5so3751077plb.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 15:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V7XmdzqEnVa5WSZQtyf9NkSr5WWRYNBlDbVJ7Ulkq98=;
        b=WsfOIpRgkc+iZH1NkgwQxpK3EO9UnhyMqxLK3ltDhx4Eyd8TqqQ6Y654SaZ5YcUXhi
         wWYnA3c7+aeRHIW9dun4Jba9hjCOLRjyUsewGgOaroXCOELgjnhPT5WXW9QygTqICdgp
         J62+OtRSZwsF7FW6u2yDsNrGNXU2gkINRRWOeURd5i0L5qnTKs4bvR7XZhh5NLP1kNT2
         V+fcuCcjaEuCZ74zj3LuaiWmt6urkJntQ2iR2uqdD0eySuHegSjIZbMOG3Sn9knDJHEz
         OGHY/dre8l6jM/3np978u4wv97diPpHbc3Dhc74GVTCZj8scrreDtEfYSayJY8Wb1t6S
         71EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V7XmdzqEnVa5WSZQtyf9NkSr5WWRYNBlDbVJ7Ulkq98=;
        b=KnCkTMBLuGmFE5cUM1YyLU5GKdXFH2nsJFnvKdpGhmWLM7J/rHiW3lsmEZcnHD2bGf
         5YDpMNxwcnbJX3Wku29wtm35Wf/FsMa5Cu+zIhl7cVZUaQzhBTTa3yHvNa+rOihK4vuC
         OZzJhKxFF1/ZBbm81vipWu/wCHpIZOdO9xIhJwOW4mHojKDxsjRdbXfX4qoY1lreYvvY
         CKww6hyzPRQiieYglla5hWikgljZBP94lCtYTTRJPK9mapf2e+hY9jpyDVQ+Pbr1Zog4
         vb0o5QKOJLTyecMStHeA9eS3uwZ/CuXa8IuSPpZ1Q4Fo9ZCasNBD93Li0HZXnrRuhbvc
         OATA==
X-Gm-Message-State: APjAAAWN6h7+YR0Amsx5QcC8AuILegAT7iV5/XsG0O31ZBuRqXOhiZMW
        y/6+eE2kcvh5aVwWykcXCHui5nqBZ2k=
X-Google-Smtp-Source: APXvYqyNVHKBuH9q2/YrQmetu2PXZB/4G/dLiRIhZGPo4LYYBQkEgwj7REcNuqKC1dlN7zEdN4xbbg==
X-Received: by 2002:a17:902:8d81:: with SMTP id v1mr16595494plo.289.1574464766055;
        Fri, 22 Nov 2019 15:19:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id m7sm9233442pfb.153.2019.11.22.15.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 15:19:25 -0800 (PST)
Date:   Fri, 22 Nov 2019 15:19:21 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: Announcing git-mentoring@googlegroups.com
Message-ID: <20191122231921.GB101478@google.com>
References: <20191114194708.GD60198@google.com>
 <20191122203127.GA5292@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122203127.GA5292@dcvr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 08:31:27PM +0000, Eric Wong wrote:
> Emily Shaffer <emilyshaffer@google.com> wrote:
> > The community expectations for the mailing list are the same as those
> > for the main Git list, but posts are only visible to members (anyone can
> > join) in order to create a more private space for beginner questions.
> 
> It would be better to promote anonymous or pseudonymous posts
> if beginners aren't comfortable...
> 
> > For now, posting is limited to members only (again, anyone can join) -
> > but if we find a high incidence of needing to forward messages to and
> > from the main list, we can change that permission as needed.
> 
> ...because anybody can expose the archives, anyways.  And right now,
> messages aren't visible to generic search engines, either; so fewer
> people can get helped...

Hm, this is a little circular, right? Part of the rationale for keeping
viewing limited was "that way it's not visible to generic search
engines". And now your rationale for opening it is "it's not visible to
generic search engines".

It sounds like based on
https://lore.kernel.org/git/xmqqy2wczliu.fsf@gitster-ct.c.googlers.com/
though, that we maybe do want to open posting to all, for the sake of CC
back and forth between the main list and the mentoring list.


With all that said.... we have yet to actually see a post on the list.
So I feel more inclined to wait and let the right ergonomics for that
list present themselves with time and use. :)

 - Emily
