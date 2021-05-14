Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E56FC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 08:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359ED613E6
	for <git@archiver.kernel.org>; Fri, 14 May 2021 08:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhENI5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 04:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhENI5a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 04:57:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ACFC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 01:56:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v5so22801981edc.8
        for <git@vger.kernel.org>; Fri, 14 May 2021 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=cuKolcHuUveqoXKziIQKlUmE7LTOrf51k7kTaEtOeSE=;
        b=oy0ytvUnNClENur9TfNbVj+vVES7PpdcKe4lLjZ0VkHbd3j1hgSVCZSEtV/+ZyGXo0
         Foewe+OEN/OjDkz6ILeUb64fzijJPeeUjvAstMouOI82aoMUntg8qJGiAEoh7PCAdplw
         wcGEv6ZAIe09XaW5ox++TfbOQQ1feT5kDJarZKVz+MxuwNU7nLjzzAc2senU0qSg0xgh
         Hea96oQbqwcN4MI9L8saN2PEaUNUoVd15GaTNw5tFApZxF3gyL3jq1Pg3kBqIpm8OvUj
         rTsYYr2pO2Qcwy0n71RiS8sP5VaB7Cqx2IbK9ly1Fm1Vol4AQXElHyN3u+H7bd51ddTF
         a2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=cuKolcHuUveqoXKziIQKlUmE7LTOrf51k7kTaEtOeSE=;
        b=SPCPC9Y9gbJl4UGcK89MjcFGjC6z38OU+cg4fnMVtLCa/BmVIg2tPw1tHyAz1l8zVj
         6ommE7P4zyvvKF+JXoU+xQ9b3bo4oW7w7e4Qn1VVlLALs4fiJQlO17zcA5T81pah5sGh
         8DjQGsRCeYoWSU7f09RrrBVxcD8Rpgfc6nN7cVuMFKE6LE1p4L8lFkxpY9ggWyqJtL1n
         ViWmrSkWBNpUQnnq1PSB2Z7UT/DfHO3qGvvkaAlL1EBXIO2Xo1nYJ0sk+1Dl7Mqw/n/J
         Xg6hST4OyGH2xX6FMQvpmzT5YKJOzjBSxyrJHo+E4IGNfpA9yBsI39hx2nGNT23ADWCp
         DvkA==
X-Gm-Message-State: AOAM5337xZ5LTW1+FwwAoKycHF7bZYChDtzdvyJpWNSOanhIe042Hx5w
        RZYLAxY4Lzy5zRItlge1O6U=
X-Google-Smtp-Source: ABdhPJyMMh1q3YsC8wHUrrEnTjat/UcfTS1bqvk36DC/zWBjAwOdGdPZAzEfBdHZgLNiJqxFLdxQ5g==
X-Received: by 2002:a05:6402:284:: with SMTP id l4mr55969955edv.299.1620982577564;
        Fri, 14 May 2021 01:56:17 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f30sm3282034ejl.62.2021.05.14.01.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 01:56:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     dwh@linuxprogrammer.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
Date:   Fri, 14 May 2021 10:49:42 +0200
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
 <87lf8mu642.fsf@evledraar.gmail.com>
 <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
 <20210513202919.GE11882@localhost> <xmqqo8de9wis.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqo8de9wis.fsf@gitster.g>
Message-ID: <875yzlsngv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 14 2021, Junio C Hamano wrote:

> dwh@linuxprogrammer.org writes:
>
>> I think Git should externalize the calculation of object digests just
>> like it externalizes the calcualtion of object digital signatures.
>
> The hashing algorithms used to generate object names has
> requirements fundamentally different from that of digital
> signatures.  I strongly suspect that that fact would change the
> equation when you rethink what you said above.
>
> We can "upgrade" digital signature algorithms fairly easily---nobody
> would complain if you suddenly choose different signing algorithm
> over a blob of data, as long as all project participants are aware
> (and self-describing datastream helps here) and are capable of
> grokking the new algorithm we are adopting.  But because object
> names are used by one object to refer to another, and most
> importantly, we do not want a single object to have multiple names,
> we cannot afford to introduce a new hashing algorithm every time we
> feel like it.  In other words, diversity of object naming algorithms
> is to be avoided as much as possible, while diversity of signature
> algorithms is naturally expected.

I agree insofar that I don't see a good reason for us to support some
plethora of hash algorithms, but I wouldn't have objections to adding
more if people find them useful for some reason. See e.g. [1] for an
implementation.

But I really don't see how anything you've said would present a
technical hurdle once we have SHA-1<->SHA-256 interop in a good enough
state. At that point we'll support re-hashing on arrival of content
hashed with algorithm X into Y, with a local lookup table between X<=>Y.

So if somebody wants to maintain content hashed with algorithm Z locally
we should easily be able to support that. The "diversity of naming"
won't matter past that local repository, any mention of Z will be
translated to X or Y on fetch/push.

1. https://lore.kernel.org/git/20191222064809.35667-1-michaeljclark@mac.com/
