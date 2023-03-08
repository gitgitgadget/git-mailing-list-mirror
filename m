Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F321C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 19:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCHTk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 14:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCHTk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 14:40:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F9160D54
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 11:40:56 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id fa28so10934693pfb.12
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 11:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678304456;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfLZxwIViWtMbgVDVMnyp8+fwJLYJ0nlF7WMac49FhA=;
        b=jwrWjqfao3iyqfHNqVJG6s1jVDzti/eqXWWujHaRTXG6QMT6AdJh24s0W/Gq4pkw+c
         IOnmc8oVwIxrYkFT/x6TBhNFix8DlTm20ncLGFdi0ngigH59+v8FOwU3kfEfwoRS01qi
         Dwnn/UZKztWdIL+zbeLNBNZbO0LLZMH3m/OC5GC+THISxqpwVQiZJwxAsXO1f+apa6Y6
         ZUuOkQwG0/rvo9Wjy1j+jxv/WohjSPBuxiFJtMJnvGmAK64NQFXWQD233Xh96kBKAwCj
         KzZ9nMCTI7CAWm7X/LkO43xic9pabt9ZUS8EKJQo9j4/Ev+ulkKY2CY5bOiarRpOjGLe
         yGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678304456;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NfLZxwIViWtMbgVDVMnyp8+fwJLYJ0nlF7WMac49FhA=;
        b=I2D3gw0Y0VHy5GbTviP8BfzPOjhCdeiV2nwlOg4in+GoxeVj7jeQoSqmFEg8rvuHI/
         H0lLQSvPtTW+z67vpkA1saCjRAj9YTsMiMMvm8DhhTOuexipKOw/K+wXh86Secbq77Gc
         P/RB4cntcudCxqb+A39p8NnT0Ykg7+xxTh+RXq+i5tCWhh467v9KNaNheFuWr0zadE+J
         O24LjxTdP86OTbYV10vNlJ3HtmGMIjPqahDrh5dNPCE1VHEHN1Odt5pG3gB7np2jBHqf
         4fYw4y9P63w9rDAHis1G5EJ2PWzCA7IxSCI+hE9eoKnDhkG/JxnmggV/Jse/1Oo6Orvz
         rofw==
X-Gm-Message-State: AO0yUKVNiFM+yZrNtbjmyrlCiF6yRgPEBGhos84DDgh3HwQNrKlS0tP2
        jLzXURcDKymbPQB0n73GhjU=
X-Google-Smtp-Source: AK7set+gEn6ZA+pEoCV9lD9MhMTGjRx8ibk0NbWcomiP/sUfZKUEHBcSjehHpv4Cg4ldDE8sQvY2VA==
X-Received: by 2002:aa7:9607:0:b0:5e4:f700:f876 with SMTP id q7-20020aa79607000000b005e4f700f876mr16758637pfg.28.1678304455880;
        Wed, 08 Mar 2023 11:40:55 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78554000000b00593a1f7c3dbsm10049838pfn.10.2023.03.08.11.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:40:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     git@vger.kernel.org
Subject: Re: When exactly should REBASE_HEAD exist?
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
        <xmqqo7p4zb8d.fsf@gitster.g>
        <28b78355-e3db-d33a-c576-653740a4a1f3@haller-berlin.de>
Date:   Wed, 08 Mar 2023 11:40:54 -0800
In-Reply-To: <28b78355-e3db-d33a-c576-653740a4a1f3@haller-berlin.de> (Stefan
        Haller's message of "Wed, 8 Mar 2023 20:02:26 +0100")
Message-ID: <xmqqa60nt4jd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Haller <lists@haller-berlin.de> writes:

> On 07.03.23 19:07, Junio C Hamano wrote:
> ...
>> Stepping a bit, how does our "git status" fare here?  It shows what
>> step in a sequence "rebase -i" the user who got control back (due to
>> "break", "exec sh", "edit" or a conflicted "pick") is in.  Or at
>> least it tries to.  Does it suffer from the same "great, but ..."?
>> ...
>
> It fares a little better, but not much, and it doesn't look like I can
> use its information to implement the behavior I want.

Thanks.  That is the kind of information I was trying to find.  It
means that the current "git status" does not give our users enough
clue as to where in their "rebase -i" session they are at, and we
will help more users by teaching "git status" the trick you are
designing.  Instead of peeking into how the implementation details
like REBASE_HEAD currently happen to work, making sure underlying
"git" knows how to present the information you want and letting it
perform the heavy lifting would make sure the solution will stay
supported across versions of future git.



