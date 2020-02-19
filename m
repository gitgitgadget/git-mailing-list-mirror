Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AAAC5ACC5
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 23:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4685208C4
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 23:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSWChbqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgBSXQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:16:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33981 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSXP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 18:15:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so878660pfc.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 15:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xeWbib+0mz0wHhEQROHmlAmjHwLtJpdeCtUnvqVP0e8=;
        b=jSWChbqdssmNhu6MmpJ23DQ3HeUZNlkV381QqjaQtq2Bgqx8LC88n7x5+R43VeyJhB
         nhSZKXwceh5sT6RG1CT/D7Dvjc/637uQfOZnaJH8XfYLxV4KMEnS5Be+poLnfJLSTZB3
         QbUbOyVOQekWV6GWgV4gY8wNIFhh3IYaEhyMkbncOo+m7Fk2be/7KBL3SywJNH2hvr94
         ikil2OXne5MbTeYUUrHN1KvsojiS9Ajw8xjiSiO7Lw7Zmd5mhVfH9lj7n92KIhNtsR3L
         nvnOs3elTuYml48G06kXgNAYGenEPpXcyMcaW4djgmijAx2H81SrOqdx7aSoIiqsp3hZ
         n2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xeWbib+0mz0wHhEQROHmlAmjHwLtJpdeCtUnvqVP0e8=;
        b=HQi0ehRowmpAAd9DzqRrg7p8bLIFiu/8RKqZ/xjuWwxMrn3/k+b5Q22Ttauzhhuksh
         fAbRJsrCqWcx+D5AFw/8Sxu9ril6be6s4Erp+SBUJYNF1GpIVvu8Z5x0sdLXcSVhN4hr
         eTX/N0gazpJ497lMSaHFxT8DQMBZQ5N5rlg1/3yq22RzkBmLUhKHIbI+g5YQ4m7kq800
         X2Zwqh0bmvezyxq/v2KffqOr9DyBBjR1qhf+un6JciXyrzAHs3nvX1fowFUdK5fqoHUE
         WbN6S2U2dA1p1ArjDQFBQACZrtt6qjUbZ46cEZ8VhmE7p8/gPF8y4rkh17a25jhEMJxl
         OkgA==
X-Gm-Message-State: APjAAAUBM4ksyXf3Bj7WRtpb1J43xaR3Qmx+cbD1UwG18Opiuk3XLVGQ
        RvzWPVQZChuScsDyShFA3S4ldu256K4=
X-Google-Smtp-Source: APXvYqwMwBVx9J0leWeBV1eeDvyzwLq05cwjMI08VH6SZTkrNuOSeEG/X9USuq0wKDUa+XlP17jMOA==
X-Received: by 2002:a63:fc51:: with SMTP id r17mr30007771pgk.292.1582154159053;
        Wed, 19 Feb 2020 15:15:59 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id u1sm673896pfn.133.2020.02.19.15.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 15:15:58 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:15:54 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200219231554.GB79731@google.com>
References: <20200214015343.201946-1-emilyshaffer@google.com>
 <20200214015343.201946-4-emilyshaffer@google.com>
 <xmqqzhdlnksn.fsf@gitster-ct.c.googlers.com>
 <20200215015729.GN190927@google.com>
 <xmqq1rqvogif.fsf@gitster-ct.c.googlers.com>
 <20200218234628.GA1461@google.com>
 <20200218235622.GB1461@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218235622.GB1461@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 03:56:22PM -0800, Emily Shaffer wrote:
> On Tue, Feb 18, 2020 at 03:46:28PM -0800, Emily Shaffer wrote:
> > On Sat, Feb 15, 2020 at 10:24:40AM -0800, Junio C Hamano wrote:
> > > I am actually OK if we limit the use of this tool to "use with a
> > > repository that is not corrupt", as coping with these kinds of
> > > breakages that in the main Git executable we deem "needs manual
> > > intervention" inside a single process is too painful (it would have
> > > been easier to cope with these too if we stuck with a script that
> > > invokes many discrete commands and acts on their errors, but that is
> > > optimizing for rare case and not recommended).  But we should tell
> > > users about the limitation and encourage them to ask for help in non
> > > automatable means.
> > 
> > I think you're saying, "Mention this drawback in the manpage for
> > git-bugreport." Sounds like a good idea to me, so I'll add it for v8.
> 
> I'm pretty unsure about how you wanted this to sound; rather than
> sending a v8 only to revise it a lot, I'll send the paragraph for
> wordsmithing beforehand. Is this what you meant?
> 
>   This tool is invoked via the typical Git setup process, which means that in some
>   cases, it might not be able to launch - for example, if a relevant config file
>   is unreadable. In this kind of scenario, it may be helpful to manually gather
>   the kind of information listed above when manually asking for help.

Since I saw lots of replies from Junio elsewhere in this thread, I'll
take the silence here as assent. v8 on its way momentarily.

 - Emily
