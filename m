Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57661C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262FD65011
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 00:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhCEAbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCEAbS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 19:31:18 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5384DC061574
        for <git@vger.kernel.org>; Thu,  4 Mar 2021 16:31:18 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d12so794719pfo.7
        for <git@vger.kernel.org>; Thu, 04 Mar 2021 16:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xuBBO7o9mVL6Pn1QizzjoskX07/3EH2/rX+Cnx1hJ8E=;
        b=uH0WuaDWXyAjGFofRphJOlQDuSMrOKpGzfXHVfuwsUWUXv4TXOypEYw9aAxnVu0arf
         QDQmr6LHBS3hzLgJAX3XVA6ehZHaAOriTlz6clBYpAIKPj9RueRY+rHd1Umty4pKXYXM
         o0Px4Rky797eEqrnXkpyOXMuihCzVX8srdKBl5sa3EgFtCNUBrUU9PlaZ7r0mWEK1+zA
         hBupfAvDQbOx5+AxUjfU4GDWFY8wKkJ1lBl7xQEJ8HRESljZJxddV0652sUVg1d+UraK
         JiNjL3hfGbbGs0nDbG4AbtukHfZuBSjXxNXSlGijoS+gpezFQGxGkjwRlKsxgH4sECZA
         1atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xuBBO7o9mVL6Pn1QizzjoskX07/3EH2/rX+Cnx1hJ8E=;
        b=Ta5ELmO1t/aNzNGzF/8UM5uEzx9EUeKg3E4sXI0aSbjrVCZeLvnwk4smO8oDa0EniY
         oNPIta0feOIHZgFoPi72cMO5zMM6tS67HT2Kr8U3uryllRaNvsvMCeUbJyVFLEd/ShM5
         LJKFOdCb6u68Il13ttXgQRoR2e8ykRZ3qyHL7ZhnuP2TPZxfBifss66/2dlc53jwbd1R
         HcyFrq4AJlrcvmqtMNoYutVp36dusYZgxC2vKnSD1DkWU3IQhCysQaJ2E4rfT1D9rJyq
         PwUzfy69exrTDJHmFVvQ0QNWamJ4IXwIzKk+6d2IbZsSqslz2CfmAf/11NAvbHXA2BiP
         u+uw==
X-Gm-Message-State: AOAM532i7i0O4GeXiJwqMByBNMQawkBvqgpEq/5x384pdHVIHYEmwUXm
        k1zJUc1ymSPO7u3y65lbsjJGpnccCo4jcQ==
X-Google-Smtp-Source: ABdhPJzBTt2RVd5Wn6wFut+fFqeI+LnaGDLFeA+qwPKsDdXZlwL5g0e86VVsJHsX0Hp24+pKT/H6jg==
X-Received: by 2002:a62:5a45:0:b029:1e5:4c81:c59 with SMTP id o66-20020a625a450000b02901e54c810c59mr6440719pfb.51.1614904277591;
        Thu, 04 Mar 2021 16:31:17 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:3905:3765:1b99:68a4])
        by smtp.gmail.com with ESMTPSA id i1sm470244pfo.160.2021.03.04.16.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 16:31:16 -0800 (PST)
Date:   Thu, 4 Mar 2021 16:31:11 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Dominik Lameter <dominik@graphe.net>
Cc:     git@vger.kernel.org, git-mentoring@googlegroups.com
Subject: Re: Found error in documentation, looking for advice on how to start
 contributing
Message-ID: <YEF7z38st+4pEvdA@google.com>
References: <CAPhpCMJ-u+W5+6ckazo7JkeaPhkpGP_6hOSJcggor0CcYgU95Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhpCMJ-u+W5+6ckazo7JkeaPhkpGP_6hOSJcggor0CcYgU95Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 04, 2021 at 06:04:01PM -0600, Dominik Lameter wrote:
> 
> Hi all,

Hi and welcome!

> 
> I don't know if this is the place for this question, let me know if I
> should send it elsewhere.
> 
> I was reading a portion of the documentation today and found a
> paragraph out of place in my local documentation, as well as on
> https://git-scm.com/docs/git-log and in the git/git GitHub repository.
> I have never contributed to an open source project before and I think
> this would be a simple place to start. I've read through the readme
> and Documentation/SubmittingPatches document, however with the
> https://github.com/git/git repository being publish only, what git
> repository do I base my changes on for documentation patches?

I think the My First Contribution guide can help you, especially if you
start from here:
https://git-scm.com/docs/MyFirstContribution#add-documentation

(The rest of the guide before that anchor may also be useful to you, but
not specifically for a documentation change.)

This is definitely the right list, so do write back if you have
questions that aren't answered by that guide.

 - Emily
