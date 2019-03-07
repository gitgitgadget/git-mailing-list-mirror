Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68897202BB
	for <e@80x24.org>; Thu,  7 Mar 2019 00:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfCGAkG (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 19:40:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40297 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGAkG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 19:40:06 -0500
Received: by mail-wr1-f68.google.com with SMTP id y6so292169wrn.7
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 16:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I05FJdGgmx6UQE80KxDyGq4Hop8U37vkuu2kNSQ8m0M=;
        b=YKOPPrDgcd6CI6qHxX3+NwmrM5zWOhGiUIlpBlbLVerIpCkcdZjqslQbeywcNv6Hk5
         V41Zqxusju3NWuMcc6SHlBgMd2kHmuCUfFKSYaYHzy1cQuMe+KaVSfYilJnQk/ln3F2t
         IoZ46nJwrLbjcPKToSnlFr3H2t67fXV6E5o1r7YFbzb3svFj0jju/cz5bVS7IYdYO5AL
         L5FBnge+eHThmIaXKIVAXKJoov7utkw73wxeSU6SLCijUkki3rHJo67dryk7XCF7xvgx
         QRQIz0pW9YrY3GFpgJjBCIbaOXfHN8QyfRyabHaDSWjUacFalGIDmdPmUIt7EtbVc+DD
         0Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I05FJdGgmx6UQE80KxDyGq4Hop8U37vkuu2kNSQ8m0M=;
        b=l1msIUah8HQNlRPrFolbGZL4CKaXnpuXzNX3uEt3n19KA4ZReVjTute6HwB3IupaSI
         pzfAY5hR7yzGeIwZRG+B0VxcAZL0kTWMh7NE8Zz5yTz+AACbINFh2emDCeKPgL3tZ98O
         eYHc7LHf0T+k+U5mWbQeC822Qb690HuCRXrWM2YFMH/DORvEMn4DCYkpd6D5jOade7YK
         AtJfnHCe6BSsQ/GgCTEYrTRAXs5Kohli7Pas2Z4AkjAe0dqJWfE1K+uF4p4lJuGp9D0W
         ZiNGYOmXp89L5SgBi99gtA9dRVt9E0VvskoMem4ll03MBpJSHbdh6ljSA1T1gTX43mWN
         uwuA==
X-Gm-Message-State: APjAAAUeuPj5lPUr9uRa6V7lVLNjWUfaBHFaG0u3a9Eq8lpLZsomRYsu
        SzHR+xTcW0RtUMgvn3wl4Jw=
X-Google-Smtp-Source: APXvYqzEx8zxtgBr6ulG+bYhdER29CGgrZzLzDy2M0iuWYIZ/jTD96nI/sSAKQ3INQ6d+iH69lynXg==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr4557528wrv.104.1551919204308;
        Wed, 06 Mar 2019 16:40:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o12sm5383135wrx.53.2019.03.06.16.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 16:40:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: Re: [BUG] GIT_AUTHOR_NAME was checked before prepare_fallback got called (ps/stash-in-c)
References: <20190306195236.GA22872@dev-l>
        <20190306200049.GA23315@sigill.intra.peff.net>
        <20190306220911.GZ6085@hank.intra.tgummerer.com>
Date:   Thu, 07 Mar 2019 09:40:03 +0900
In-Reply-To: <20190306220911.GZ6085@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Wed, 6 Mar 2019 22:09:11 +0000")
Message-ID: <xmqqimwvo6u4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Here's a patch that can either be squashed into 4/27 of the
> ps/stash-in-c series, applied on top, or I can re-send the series with
> the fix.  Junio, please let me know which way you'd prefer.  

Thanks for a quick turnaround.  Let me see how squashing it into
4/27 would make the resulting serues look like.

