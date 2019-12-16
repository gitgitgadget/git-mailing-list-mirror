Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB9CC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 23:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7EE206E6
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 23:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcW4hkmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfLPXy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 18:54:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46543 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLPXy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 18:54:27 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so5198796pll.13
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 15:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RX3wj+x4mcRVM1QFBQ6kPm48EHjtwUBSvwRRmRF7XQk=;
        b=ZcW4hkmwAnr5j2o2e9VziaflsxgsJEBroeIU7X4fTly3vXUMaZw+0Sz5CETihb01GC
         zcX3qp8E/rFTuef77eRwGULgQoPeC1WEI1yo8Ed8tmWeLrLPXpOttrVglZ1Ix86WU5Id
         Jfux1rI+uyKezPJKcWq516k913Cghqxn3CDmMcWG95TC4VN2SOisC8fPL9x1lu/AO/un
         Q549vrjGZ+onAhs3PjN9YXYFwPwboZR65Hf/4RrKCJPG3CG4Y3/OJjWkfKCfyJN54jL1
         a2IVY84rTq74VgZdSptbpXdCeWB+UlVuXx6fTOvWe8avB/byX8J7kzK+aWgWS/ctTFlK
         BZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RX3wj+x4mcRVM1QFBQ6kPm48EHjtwUBSvwRRmRF7XQk=;
        b=iV3lCqAi+rwL0veLZZuEVmo5lLDcEKR3MQw/S8bJ4g7Akaie5NMaHoanJsUgcdSOeP
         obgRejDXlB2ZvdN/HIEQSoVbRvrmo5aaEVQNwzysZQL+I6uoKp2CpB4IMlp9HBIy18C0
         uO3FrbvgU99ZsUy/I6RjGqQW6UutQZ8X4basFx5pf9fMwVet5ubBet9d6EAG4s5Hq8K0
         p6lfNm6u0xTMuZBSt8Tm8P0y/dNAdOKea2nhCze6SbQVdINUieN6k3HNlDGv4uOnOXOH
         bhTbmBlsU6Kh16U+vG3ijvq86nBO60jXYB+B8S+b0ZRkk3rJHJOgIUUJzSVnNs9kp+cW
         ReIw==
X-Gm-Message-State: APjAAAUU5Nzpw5nGFilmQIrTyrwM1RQQaCMm4ug0U/huycmR2egzWIqy
        x4X3Un3Zvctf9QXDweUq0VAYTQ==
X-Google-Smtp-Source: APXvYqwYD/L320GBLy9gl9ewcYINbyM9kH1CTQKjdVbQv+c4FvxEXlH9yRVh1cNVojDrHbZfyKO0Qw==
X-Received: by 2002:a17:90b:917:: with SMTP id bo23mr2460231pjb.13.1576540466875;
        Mon, 16 Dec 2019 15:54:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id w12sm23917704pfd.58.2019.12.16.15.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 15:54:26 -0800 (PST)
Date:   Mon, 16 Dec 2019 15:54:21 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 12/15] bugreport: count loose objects
Message-ID: <20191216235421.GM135450@google.com>
References: <20191213004312.169753-1-emilyshaffer@google.com>
 <20191213004312.169753-13-emilyshaffer@google.com>
 <xmqqv9qjhp28.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9qjhp28.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 01:51:27PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > The number of unpacked objects in a user's repository may help us
> > understand the root of the problem they're seeing, especially if a
> > command is running unusually slowly.
> >
> > Rather than directly invoking 'git-count-objects', which may sometimes
> > fail unexpectedly on Git for Windows, manually count the contents of
> > .git/objects.
> 
> Is for_each_loose_object() or for_each_loose_file_in_objdir() not
> sufficient?  We really do *not* want a redundant implementation of
> something we already use elsewhere in the system, especially for the
> purpose of this program, because you would end up reporting what you
> computed in a way that may be quite different from what the rest of
> the system that is actually used by the end users computes.
> 
Oh, thanks for the pointer. That looks sufficient - I will investigate
the differences between the two and stop filesystem browsing by hand in
this case.

 - Emily
