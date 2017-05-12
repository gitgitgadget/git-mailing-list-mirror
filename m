Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EB2F201A0
	for <e@80x24.org>; Fri, 12 May 2017 00:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757291AbdELAyu (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 20:54:50 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34930 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756954AbdELAyt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 20:54:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id u26so5044848pfd.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 17:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k8wfdPVplNvhJay6rNEzJ+q3bIwU7ihl7qjQcmdHzzU=;
        b=mSrdkAoNTy76qj4T98/PdPdF1CYRgf4CPfbjRCWOg4TYJanTK7faAW1BauQYb3n4/U
         gkEAGbz+9XYk/lVbMiXtRFShWK7l0qqFbwa4DxNWrPTHXDeWE8wwKeNL+GocOmrcMJxC
         h14hXt8/kos80O2bnkzWmHPXdUqwwFtQP6LKcHCSKGMqX+4e/xRH+4K9/YLjqestj02G
         GArijqaGOCVXm7hhXAMBCL+8IGBeRW2a8Q8zINWEwqUdmUTFjjAXzXwwvZOTU2RtP+2m
         JwKr2NpiVEvN7+WmqlZ0aF4maGb991CrjsZiSQo9sw06nndl3k0cuVnzPWRPVMCOEDik
         vToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k8wfdPVplNvhJay6rNEzJ+q3bIwU7ihl7qjQcmdHzzU=;
        b=UtcmrfKGKz9ifW4V54eIDFxIiBCKFRT9dz2NZpUppoblYfkojglOxRapOaugllQ7Bz
         +2+3fBxrnKy2qliDkVxYVbpFr11wUcaiXTRw/AeG6C4jO5ghlMvK/FK3xAaD+5s3kWCx
         ayV1UGK4Cs5ZUAYEfjlYuvcMbv7uLGlMMV+klIHNfcqJbXPR2CgkEpUsuD0FhU7/brZA
         jwZknh2ONyGTqK10cR7nUyk5fi2F9Gh8zfqbh34XW953yeLUSzWWKtCwOOFsstUWxoYC
         Hkrd6BILBo9xtceBxZ856WGdzT751eSjw912Fja9T32yui8u0fl/eMVtRm4G5jmjqvu5
         0W4g==
X-Gm-Message-State: AODbwcCkNbKBlr2HH+iPesNAynF7cscmHZmffkSGHgIbwJFLKFpasSl6
        U+oBbOtCRWAYNQptlow=
X-Received: by 10.84.215.197 with SMTP id g5mr1888282plj.131.1494550488203;
        Thu, 11 May 2017 17:54:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id i63sm2201981pgc.26.2017.05.11.17.54.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 17:54:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/8] pathspec: convert parse_pathspec to take an index
References: <20170509191805.176266-1-bmwill@google.com>
        <20170509191805.176266-9-bmwill@google.com>
        <xmqq1srxxn72.fsf@gitster.mtv.corp.google.com>
        <20170510170226.GB41649@google.com>
        <xmqqh90sw4dr.fsf@gitster.mtv.corp.google.com>
        <20170511173605.GB83655@google.com>
Date:   Fri, 12 May 2017 09:54:46 +0900
In-Reply-To: <20170511173605.GB83655@google.com> (Brandon Williams's message
        of "Thu, 11 May 2017 10:36:05 -0700")
Message-ID: <xmqqshka99nt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> ...  Note that if we go with the route to not pass
> in an index now, it doesn't necessarily mean that down the line we won't
> have to pass a 'repository' instance into parse_pathspec().

Correct.  

An attribute annotated pathspec may want to check if the attributes
used in it are used in the repository at all for validation or
optimization purposes, for example.
