Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3354D1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 20:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbdARUan (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:30:43 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34326 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdARUal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:30:41 -0500
Received: by mail-pf0-f169.google.com with SMTP id e4so6830741pfg.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 12:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q6wKEUwa8uVVMqQmxi3LoxLWvyfX29PEkhe8b7bPi84=;
        b=pw84Y/xk2h23ms0gV6J1/zuOITnBO84Eo322Mo9I+nTcq6CIivtfigxyyqreNyJynX
         8oIFhf4jNMka+95+gbvEI8VSihSFHmR/qAhLvOhKrOwgbrwfhch3MyMH/bh2mdPtGaH3
         IQjaO4z8vN929sxwgWZQowwH3BoOXh5nOF8Yd61BrGUN2xL8w5WMYpYPrewUPlG+cyaA
         Byb3Bpt4ost7lP7e4LKurvSKIFrtT4zNoFbTNeWF24kX5mhIzCNy2IlEy+K4FBiTZLfz
         A+l/HcomK3JdYiaWFbPBX2VPgI1sy1WXazP4OIwA2VAy1Af1yIFDJ/1auhH8xWcp+7+O
         bnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q6wKEUwa8uVVMqQmxi3LoxLWvyfX29PEkhe8b7bPi84=;
        b=AobtBMi/L5p1+J+m7MAOlc27/R87JAz5cvmJM/bEnW+DSKQCBtgieoIMSPmMbZjEkr
         sya7lK8VTdSptWNJ3mNEkLYhcKJ7wlKIkl0rP8P72R7Wxe25xIM8o4tdXuxWGlk9b0xj
         aESdnVGJyr1SIExRY+LlrAEXx5toofTmUjsjliXdr4S1UGb63Y3V2P8BfTWUYtWjobI0
         jLxCSrHF4X455rXbZXkodn6B7xAlQvHYjQYR2EPvyCngtV37biKh6gH6lTL+44H7pJqz
         PAiBk4aohqxrLU/uRCjZOIPvTA7izrd8OPa7mIRt32J6hq3IegVMp8+k/YUHcUfbzUJH
         AeqQ==
X-Gm-Message-State: AIkVDXLfSDicLHLsbdWnYHtnx+LLs5oLQ8IN+k4XOABuOm7k6vAr8OC7Plf/o4MJlWTiD4ri
X-Received: by 10.84.178.131 with SMTP id z3mr7898180plb.176.1484771032279;
        Wed, 18 Jan 2017 12:23:52 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:1d68:bc5d:3a1b:2ccb])
        by smtp.gmail.com with ESMTPSA id w65sm2839629pfw.9.2017.01.18.12.23.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Jan 2017 12:23:51 -0800 (PST)
Date:   Wed, 18 Jan 2017 12:23:50 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 21/27] attr: use hashmap for attribute dictionary
Message-ID: <20170118202350.GA10641@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170112235354.153403-22-bmwill@google.com>
 <CAGZ79kYdcVNK9KJgM0Na0MJ4QuGM+8OJxFb1oQ+VoDL--Ay48Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYdcVNK9KJgM0Na0MJ4QuGM+8OJxFb1oQ+VoDL--Ay48Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/18, Stefan Beller wrote:
> On Thu, Jan 12, 2017 at 3:53 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > +/* Initialize an 'attr_hashmap' object */
> > +void attr_hashmap_init(struct attr_hashmap *map)
> 
> In case a reroll is needed, mark this static please.

Will do.

-- 
Brandon Williams
