Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB32620D11
	for <e@80x24.org>; Fri,  2 Jun 2017 01:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbdFBBhq (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 21:37:46 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32987 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBBhp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 21:37:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so10144239pfe.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 18:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UIwFn2RWwqZC0bsqf2RzLB0bAgqwtJUVjHRyWxd+/O0=;
        b=MyLAYJFj9f5EI9OaB4eKQ9enZfqDVaaqBADiin8ER7Y80G2eQGr1QSktXOaTQUDBDS
         hRRzVvxlkZ4/NpgMbO9kdemsJSfuS1t6ziFDMs9w+McmFg2EItYylBdvgTPeCdKUsPT4
         57H59vbNiHK0HkV/nHozVVNajnvyn3iSIJnoTG1uGGbzBhNIYFzOw82JPW+qRBHI1uys
         h5LelZCVJ16v2IXuxcaiop22dmFoWSPPs8FCXYtnty4Gnaf8ER9ZdLocoy0HxlTaQNmu
         gTwzIIB0VyORtxt7I5GpEGWqT1LjdSuAynZ3DNiQO4vKXBXBsb2Skasv59n/ZXu8BRZ7
         2cmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UIwFn2RWwqZC0bsqf2RzLB0bAgqwtJUVjHRyWxd+/O0=;
        b=nHZRKDrGZNp6chjyjBg7iZG/XMK1fQ3YjogwEdT9SjnDYD9W3pwbfeMeY94YhdYsuA
         rPjMCnjGU6Hs+anJ9WWvLxwFtc+eb/ExEt4nMObvG84ZkI8groGFwTGUjI2vai75lYrO
         y8YWTFdVzMzOE77hayBwyQ7cgA+HTKksoQZSaPinSoqSsa5swLBUsAHrz8xPO6FIJqFt
         QcyVkLtMkFEjfbV89jf0pi9kpV0DzzaN+NVe991vXU/RCUJPX5QcuqPVNUxYJWxUMt2V
         E1ePQhFsXtxxN7tGbTE6pNoZMf5aJCVwAEDqvf204EkAy6s3a3+00d5pBodb+nhFc0uk
         I7vg==
X-Gm-Message-State: AODbwcANd7biG5id+2Ap0gho1E6WHRjbz6HhJA8mMkkDGRPsJghdggHk
        8e+1C/GO1T9M9Q==
X-Received: by 10.84.236.4 with SMTP id q4mr94366315plk.10.1496367464618;
        Thu, 01 Jun 2017 18:37:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id g10sm30982779pgr.18.2017.06.01.18.37.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 18:37:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 20/33] combine-diff: convert find_paths_* to struct object_id
References: <20170530173109.54904-1-bmwill@google.com>
        <20170530173109.54904-21-bmwill@google.com>
        <CAGZ79kbPaWEuZr1yXKnMwUeLzW4h_pnD-f2bEj7dyE7Q12z2sw@mail.gmail.com>
Date:   Fri, 02 Jun 2017 10:37:43 +0900
In-Reply-To: <CAGZ79kbPaWEuZr1yXKnMwUeLzW4h_pnD-f2bEj7dyE7Q12z2sw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 31 May 2017 10:49:53 -0700")
Message-ID: <xmqqvaof1860.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, May 30, 2017 at 10:30 AM, Brandon Williams <bmwill@google.com> wrote:
>> Convert find_paths_generic and find_paths_multitree to use struct
>> object_id.
>>
>>
>
> double empty line?

Is it because

	sed -e 's/^Change-ID:.*//'

insead of

	sed -e '/^Change-ID:.*/d'

is used somewhere in a commit-message-rewriting-machinery?

In any case, it doesn't bother Git at all---stripspace squishes
duplicated empty lines into one while making other whitespace
clean-ups like trailing SP removal and trailing blank line removal.

