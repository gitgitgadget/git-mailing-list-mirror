Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE2D1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965980AbeFOQUG (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 12:20:06 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35086 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964836AbeFOQUF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 12:20:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so4884109wme.0
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cLo77K2m8VOctLo9gJm4F7Kk8ZAOHx6jMn7dgiUwP4Y=;
        b=JcsS8xUq9d6ij0FW2+aJvGEtOYt+94pbd3HqMWQgUrnbPWK+z47fDkf+lkRmWJ+gFG
         rRhNn72n4HMfvtV6KZnNMatZEF7IKsXl31Sz7iFIfh/bEWESnRUXwELQ7b/gsf/5ypo0
         txhgf1RBGiiW3AwEB/U/aD7meaoITM9sbzkU4INBlemqQm8JgadNYccrt0y169rPeX3n
         sDiOryft1QhFzRMYpz6A+2Vo4bpKPYdRZ6f+y6sXwNlGkrFCYPW9y2p7BipiZFflgNae
         EGx6qwsSsgZnEHPAofkNgk06GsfYwF6gM1jDp5wAfv1rXv5R1pjsMQb/Nq+wEfnHnwQf
         60xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cLo77K2m8VOctLo9gJm4F7Kk8ZAOHx6jMn7dgiUwP4Y=;
        b=D0u7rqkjnIWXIgKumws0DTKGQHnZW5+W/GU1rMhaqmz8e7O8CJ8w6rmETqZ1Vsc1IX
         K+puua8HlnODhGWHcYJL8uPnvl97iMrx/t94Zdk8vCRTWBowybdLRkgQYoHmmymgY08D
         1HZkMUBVSlKvA4hB7sV6wy46dsPxjZGeuAmI0W90MfC2zdsFibhB6IGFzy2BPxA7fFzG
         aGB8ePeIW9JwbzG1JIFJG19LnvYicfMhzP/MTP7pwlx/+k+bWoT8oXw0F24m4hSLVLvl
         ZIhznqHiwvxe3R71pnYc0Fv9RExM/nsIeGMbEkqAambrjn9Yw+YyK0cSKacypfEl3jtP
         b1RA==
X-Gm-Message-State: APt69E1a6K48kZS4gc8HwS/YQNS3QFw5qNP870jmBNtiJSetIK8//akj
        71DxtwCQ+GE7S32LE3tfPoqdCJuq
X-Google-Smtp-Source: ADUXVKKjQGlxF8oe0Yn14mGtLsaQWMSSaKMApZMFJARJXiTaZTC/X3Ta98PNgJ9eNoR+9A1nL60Cow==
X-Received: by 2002:a1c:454f:: with SMTP id s76-v6mr1731927wma.16.1529079604212;
        Fri, 15 Jun 2018 09:20:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w3-v6sm7742838wrr.88.2018.06.15.09.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 09:20:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Luat Nguyen <root@l4w.io>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
References: <20180615032850.GA23241@sigill.intra.peff.net>
        <20180615033112.GA20390@sigill.intra.peff.net>
        <20180615091432.7155-1-szeder.dev@gmail.com>
Date:   Fri, 15 Jun 2018 09:20:03 -0700
In-Reply-To: <20180615091432.7155-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 15 Jun 2018 11:14:32 +0200")
Message-ID: <xmqq602k2f9o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> +	bitmap=$(ls .git/objects/pack/*.bitmap) &&
>
> I think the 'ls' is unnecessary and this would do:
>
>   bitmap=.git/objects/pack/*.bitmap

Yuck.

>> +	test_when_finished "rm -f $bitmap" &&

OK, this will become "rm -f .git/objects/pack/*.bitmap" and then
eval that implements when-finished would make it work OK.

>> +	head -c 512 <$bitmap >$bitmap.tmp &&

The reading side would be OK but would the writing side also be
alright?

	makefile=Mak?file
	head -n 4 <$makefile >$makefile.tmp
	/bin/ls -t -1 | head -n 1
        Mak?file.tmp

Hmm...

>> +	mv $bitmap.tmp $bitmap &&

Likewise...

I said "yuck" because the original does not work if there happen to
be more than (or for that matter, less than) one '.bitmap' file
there.  But at least as long as there is one, it should work ;-)
