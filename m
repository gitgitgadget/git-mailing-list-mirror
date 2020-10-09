Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF6DC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50797222BA
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUXLbL3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbgJIS5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388231AbgJIS5d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 14:57:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCE1C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 11:57:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id p11so4893884pld.5
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jU3IuGwrI6i41hvNJIPVp525ZNsQxc6uHV7UZwLhFhw=;
        b=gUXLbL3NgXMADzctOAXPoBpx5UrFa/nsmdLI25NzXZ+FaBZa6XYlzCBZ/RJM+iS0tA
         ccggo7SbQ1l1gei51YXjl5ngvFwty4EAqgAGibr6+4jzsuDE82wvcFIyk/wlk2EPqAOk
         u+X5ocs9TP8KWohjdKdS5pPusgQfEKf2YqG1m+hElJjG3hwNrHPtRd5SesC+iXLjNpnN
         RO6yesQhqGOBYiDLdE2uT8n7Ela+B6GxA8nNS3q/yXR1/smNjMV4Irk9cq7pFA8Vjs2w
         9kDAPbSv5/24mXP3AHHd+LpTorT5InmKDltWCkDjdqNL0Y1scBISfDRpY4WC6XHA71CG
         UpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jU3IuGwrI6i41hvNJIPVp525ZNsQxc6uHV7UZwLhFhw=;
        b=qEVJ1lg59AOJdwPftvQUG1enCLwe2aPAr3emNt3VtgvdEZ8IFZ/mGRRo44aPBrUFyl
         D2Of2URJQ/ZywdzVqgCv0zKNwhktUtxZsl3hvdYavvLPDyVP03EkKK3wdhiwoOWMDdFo
         bMGPIf+RkGJRQzxxbS5UqjsHwW/vFPb/zPE8/qfVYJDw7Uc0/71QiCVqWIlw6FTzZUJF
         /z4v2QiE5H3rrpgAtnScj1FFRoeHAHJDEsEbjvufFPO5DSSMEXATXS59n6teLcAXsRkW
         BSmz7TXYUnWwTEXLX5V8+LZyOrgrXuyxcokHVBOXtmx0KAo6ZddnQTYgX7LeYct1DVqI
         DsTw==
X-Gm-Message-State: AOAM530wGj2O0IAlgzaEDZsnMEHyXLlGNNVUcdT+mjp2APrlaecSm07u
        2zr8ItY0uJJbvOYakfmWMaTDTg==
X-Google-Smtp-Source: ABdhPJwrmy4sEOfHMR6zAwcpTQshNfVDURMnjU0fb79JmEnxs2blxNH3+8AD/4zJoMn4VuxKQVffKg==
X-Received: by 2002:a17:902:a40e:b029:d3:c6fa:2650 with SMTP id p14-20020a170902a40eb02900d3c6fa2650mr13090843plq.29.1602269852120;
        Fri, 09 Oct 2020 11:57:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id j8sm9976401pfj.68.2020.10.09.11.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 11:57:31 -0700 (PDT)
Date:   Fri, 9 Oct 2020 11:57:27 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Amanda Shafack <shafack.likhene@gmail.com>, git@vger.kernel.org,
        wireshark-dev@wireshark.org
Subject: Re: Introduction - An Outreachy 2020 Applicant
Message-ID: <20201009185727.GN331156@google.com>
References: <CAGxm6oXSaKoTR3btKRV4bMYUsc3-oKeWSfzrWKkCXgrRorAEAQ@mail.gmail.com>
 <20201009002541.GB2415320@google.com>
 <20201009014319.GA2429084@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009014319.GA2429084@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 08, 2020 at 06:43:19PM -0700, Jonathan Nieder wrote:
> 
> Jonathan Nieder wrote:
> 
> > +wireshark-dev@wireshark.org
> > Hi Amanda,
> >
> > Amanda Shafack wrote:
> >
> >> I am Amanda Shafack, an Outreachy 2020 applicant who wishes to
> >> contribute to the "Add Git protocol support to Wireshark" project.
> >>
> >> In addition, I have some experience coding in C and I hope to enhance
> >> my skill set by contributing to this project.
> >>
> >> I am currently going through the project description and contribution
> >> guidelines.
> >
> > Welcome!

Seconded! We're glad to have your interest. Jonathan and I tend to both
be available on IRC (#git-devel on Freenode) if you find you would
benefit from some real-time assistance; Jonathan goes by jrnieder and I
go by nasamuffin there. In general, everyone on both projects is motivated
to help you get through your application microproject as painlessly as
possible, so don't be shy if you feel stuck!

 - Emily
