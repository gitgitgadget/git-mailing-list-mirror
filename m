Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E212C35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE71C2084E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bX1qYR3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgBDWVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:21:45 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40922 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgBDWVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 17:21:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so40020pjb.5
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 14:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=E7EPwslrGbl+kI6juWCbKF4LmpSJCGXBj3mx5sp78U0=;
        b=bX1qYR3Ma/aA+OOs1QFoPFzRGKBJ62QBB8h1x2K/D7Z4H2wCe7riA1wjWHj1l93Xkk
         ZyRKYK5WfwD2EFvWXQp8vZ5m0WbiVvVFNh1xwjLam/dh21WH25aG8UAxfCIgQm+Ff9sf
         GPBnbW11E7CSOogAiGMwC1yYSs96vMgsw8qJrborx3w0KYPZq2/4cSxsoTYdWJJhkaaT
         HfKTSTMCa9259cLsMxy8VD7ZoHZQSCbCkcOy55iw8RziCJfiuBNzVMyltAhAG22XHFVQ
         26/crWZd9LnxvgErlvre+V9LA4o/zPiTZyrRHSYfUmzT2AUlbk6L7myW/bMqSumxv67x
         XPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=E7EPwslrGbl+kI6juWCbKF4LmpSJCGXBj3mx5sp78U0=;
        b=B3mLZiCbljWI1pQTPB8lkUMGXnBCiXpQhZQBmWqhDaQMNvJiO/XBHbFZjN/5tXeHL7
         qzXnc//xE9pI1D3togCNSf8KGdG3mBhHsG/xLW+YAeQ4hX0UwIqrcBbYmApWnQxFIy7e
         gnI01CCRVDaCn3RYGNLAgYNupFRZ7aQnouojtWJK+qMQJMCEkd+qY7mBGIb84ZBzVPDW
         H9ClXWeEyjsJyTK3oZIIKygMjniQrgofWWjVRPGK7y8gPattFBau571l51hZ9RRQCyXJ
         askFfUXP0nt9ZcAMaq4w7L3wAcZfJVZKi5f48EOw3JEJxibHbMzaFmcuCnvLJ/4IBXOm
         Dd8Q==
X-Gm-Message-State: APjAAAUyHCHD2CgEGCSfgOBT9UQzNBfXBoT8w07zepFev9mLr4abw3Km
        rp6lPbClGSF0NT6DTIicmQHq6g==
X-Google-Smtp-Source: APXvYqyYXwT6qvMN/gRO7XahWfKbZjUQ6vkSMtVJL5cC22P/Dvq/SC5C4JL6mJ+vTbnVTDFYxZsPYg==
X-Received: by 2002:a17:90a:cb11:: with SMTP id z17mr1704667pjt.122.1580854902846;
        Tue, 04 Feb 2020 14:21:42 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id t63sm25706336pfb.70.2020.02.04.14.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 14:21:42 -0800 (PST)
Date:   Tue, 4 Feb 2020 14:21:37 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v5 03/15] bugreport: gather git version and build info
Message-ID: <20200204222137.GD87163@google.com>
References: <20200124033436.81097-1-emilyshaffer@google.com>
 <20200124033436.81097-4-emilyshaffer@google.com>
 <CAN0heSqaeaBTCmiY=f0eD8=hsPV7BL9OCFL=Oq7je+t_o4frqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqaeaBTCmiY=f0eD8=hsPV7BL9OCFL=Oq7je+t_o4frqA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 11:19:55PM +0100, Martin Ågren wrote:
> On Fri, 24 Jan 2020 at 04:40, <emilyshaffer@google.com> wrote:
> > +static void get_system_info(struct strbuf *sys_info)
> > +{
> > +       struct strbuf version_info = STRBUF_INIT;
> > +
> > +       /* get git version from native cmd */
> > +       strbuf_addstr(sys_info, "git version:\n");
> > +       get_version_info(&version_info, 1);
> > +       strbuf_addbuf(sys_info, &version_info);
> > +       strbuf_complete_line(sys_info);
> 
> This leaks version_info.

So it does.

I think the easiest thing is to drop the 'strbuf_reset()' at the top of
help.c:get_version_info(), and just pass in sys_info from bugreport.c.

 - Emily
