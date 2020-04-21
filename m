Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C37AC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 06:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488D42073A
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 06:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUy3eYyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDUG7B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727062AbgDUG7A (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 02:59:00 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691B7C061A0F
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 23:59:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o185so5811392pgo.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZFcabLzmyiIx4LMf9LyQwzs+Sf0+gFnt+Xa+GWw9bpU=;
        b=kUy3eYyRjvO4vkqqyfNcDt4GVShqtFOwREqk/Ds5OUrbn7qtQ9PELZjmXuCagpUHEI
         v3Ka6DkkRrxSAZH/2VUv6/KpJczxBxEMnn2sCOKRLrlpHZSeRFZP8KlMcdKB7dksh/4N
         gZPiO2MYt2O1UVlYNj4iPjU+PdcYZcHqzH6huZltkZ4RrPhWsDrJQImWUp0xeffQz472
         zbwPAVu8WBrVpSgCnbKsh3uq79M4GYT+k+qAnh1vpTc3JJVUlZZGx7nFsDvIDdBKHFoQ
         GBY+IvmfRedbeg4Q3fU1erJGbTL2td7XX8ejy2cp3/Pz65RtR3dbD8bIqD5rDPlCBvXy
         bS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZFcabLzmyiIx4LMf9LyQwzs+Sf0+gFnt+Xa+GWw9bpU=;
        b=cfS/Zz06uM/uTiCz9kwYVTigI3nB3xmRQQgaXddaplpMi4i55RP1AWSoN0KUlzlpV1
         rZZSNtnR7fhUC78bQxHWxS/KhhKO6drBrk7wYX0MVCdVYoevWYFpk1aNww8JUk671wU2
         jG90psYMW3Ha9HQOFIvpstaQM8YluYzJnwclJpVIEpYaHipRqvGtG4H5mTT5RWNO94Y9
         h72zSeuk8/P+so6J8L0wq0PgEB4Z+v4kMiBX8iMpi8QHqqT60HtXvB+M6uCUA8G669y7
         3jDaAQPO0jNNlppESsO3PMBlrl4YFkmr6EoYXmiCoQ1g5sq3XQyW27eMdL/X/i+q2d8+
         RzZQ==
X-Gm-Message-State: AGi0PuaI7DX+oGp+3tVHykPJTeA562NmajqF++Vv2f0xpbo7OVY7yGJb
        tUVAk1DnULfZuP8Gna8bJFTp2nDvDVM=
X-Google-Smtp-Source: APiQypJ+bBUudD60XWLi0VF/hKDmxu+pCcNWN3yNK0GoJ+BuCVD51LpHMiBgV68yVn+UIAunFnxqDw==
X-Received: by 2002:a63:a511:: with SMTP id n17mr10035630pgf.33.1587452339811;
        Mon, 20 Apr 2020 23:58:59 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id k12sm1499164pfk.46.2020.04.20.23.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 23:58:58 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:28:53 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] gitfaq: append the 'Common Issues' section
Message-ID: <20200421065853.GA11800@konoha>
References: <20200413140918.4778-1-shouryashukla.oo@gmail.com>
 <20200413140918.4778-2-shouryashukla.oo@gmail.com>
 <xmqqa73bz1x9.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa73bz1x9.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/04 12:05, Junio C Hamano wrote:
> Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> "to ignore files from getting tracked in the working tree" is why
> you may want to use the '.gitignore' file.  That is OK.  But the
> connection to the next sentence, especially the subject "This
> ignores", is hard to grok.  I am guessing that you want to tell the
> users something like
> 
> 	Paths that match patterns listed in the `.gitignore` are
> 	not meant to be tracked.
> 
> 	The act of adding a pattern in `.gitignore` that matches a
> 	set of paths that are not tracked is a declaration that you
> 	do not intend to track these paths and a request by you to
> 	Git to help you achieve that goal.
> 
> but you are trying to state it in a more approachable manner.  But I
> sense that you ended up being unclear.

I apologise for this. I am understanding the concepts but I fail to put
them in words in English. I will try my best to not degrade the quality
of important documentation such as this one.
 
> This part is very much in line with the "you are declaring and
> requesting".  The user does not want to track these paths
> Having commented on this section, I am not sure why we need so much
> description here, instead of clarifying the existing documentation
> of the mechanism in the Documentation/gitignore.txt file.
> 
> I think it is better to limit the FAQ list to two kinds of entries:
> 
>  * A topic that spans multiple mechanisms and features that is not
>    easy to explain in a single documentation page may have to be
>    described in place.
> 
>  * Other topics that already have authoritative description with
>    adequate clarity in other pages should just have a summary
>    paragraph that is less than 5 sentences, and a pointer to the
>    authoritative page.
> 
> The `.gitignore` topic should fall into the latter category.  It is
> a separate issue if Documentation/gitignore.txt has rooms for
> improvement and if so, I think it is more productive to propose a
> patch to it there, not adding too much description on the topic
> here.

I have seen this problem occur a lot so I decided to put it in the FAQ.
I will try to shorten it and make it more 'to the point'.

Regards,
Shourya Shukla
