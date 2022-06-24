Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE5EC433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 01:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiFXB13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 21:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiFXB12 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 21:27:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677F760E01
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 18:27:26 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u15so1633046ejc.10
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Ztv6SMHfC7QE2VjKbSFahOlC/2T/gxq4PdAqBIUu8PQ=;
        b=iN7AOCoSIpYLT15eSCbQjGW3+T84a2L2cuQfwwmi1aAXXuZIK5FA+kmv8AJTWtAjKr
         +lurBOwwaoh439uZ3Z8jEQPDQZ5ZIjnsjhifwftUHq1uCwjpsDLEs1abhldtveLwK21Q
         CEWww/GzlaWQH1gSmh/VJZYBxefNeolXD9CwUDaSRbLrjpRrrU0+ryxwQ0oUeZLbZ661
         APnQmmD0tQghQBzF0gLA/Jpflz6zC96eDHi4IIZZ3HCTen8rTjTVGkIvZuh6W6xt/DNj
         xc2SPxXmamWLzPbgwcl1NOaoQyITc8DojyIGHcJhiE30cvAv1jFfguwmePq49PaWLLAu
         attA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Ztv6SMHfC7QE2VjKbSFahOlC/2T/gxq4PdAqBIUu8PQ=;
        b=F986F/a5CNWCl3zUlHDd0jCiRWJFGWf+bVUi0SG3N5o10di+hcnHoo3np5tEvOtgKP
         OUfiwsoSmY60cLzyZWPEMcPse0k+5SJeGgtgnpkKafhD5KM06BSHQlFlXykse1kM+hDc
         pIfFmXuHVuQ3eYjDW+Ke+zXygjkup/n6TbqorUYeDiVoghwb/y6PR0JeaXXNVIJ6OGm9
         wf7ghYgvxUrHbnFNvkfhThLHRe3y+XrPfNMLJRt10mLC/ux83o5U+YdmMgPLBqhdzNVI
         JNcPR7Aw0MOcARXw2vn5FwVo8r3J/d3YzLPX8/bufTYu30xx67OGvUNksKmAVVjezpqL
         ABsw==
X-Gm-Message-State: AJIora+wHo1l3dFGRdz6npSmay9IXZAsqqvzBTrYzaP+x5625d57XysU
        vT5qfImExj/pw6vVnDKINuA=
X-Google-Smtp-Source: AGRyM1sRRpsGbj6a9Dq6gvlAqeNd5S+edlJBBXrZCvH5IcAiUZXONkevRDAvivd8HUlWyHx9slemrw==
X-Received: by 2002:a17:907:96a8:b0:711:56b8:f72b with SMTP id hd40-20020a17090796a800b0071156b8f72bmr11295607ejc.152.1656034044498;
        Thu, 23 Jun 2022 18:27:24 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090609b200b006feaa22e367sm284448eje.165.2022.06.23.18.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 18:27:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4Y6V-00196l-9b;
        Fri, 24 Jun 2022 03:27:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stephen Smith <ischis2@cox.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.org>,
        Kyle Meyer <kyle@kyleam.com>
Subject: Re: SHA-256 transition
Date:   Fri, 24 Jun 2022 03:19:46 +0200
References: <12011256.O9o76ZdvQC@thunderbird>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
 <220624.86fsjvj690.gmgdl@evledraar.gmail.com>
 <12140906.O9o76ZdvQC@thunderbird>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <12140906.O9o76ZdvQC@thunderbird>
Message-ID: <220624.867d56kg04.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 23 2022, Stephen Smith wrote:

> On Thursday, June 23, 2022 3:21:05 PM MST =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Finally, I'd really like to thank you for all your work on SHA-256 so
>> far, and really hope that none of what I've said here is discouraging in
>> any way. This thread has received some attention outside this ML (on
>> LWN), so I wanted to clarify some of the points above. Thanks!
>
> I had looked on LWN before I started the thread to see if anything was be=
ing=20
> discussed and it wasn't.

It wouldn't have helped, as I'm referring to LWN having written an
article about this thread that you started :)

It's part of an ongoing series they've had about Git's SHA-256
transition.

Given how LWN makes money I don't know if it's OK to link to it, but
it's easy enough to find and/or subscribe to LWN.

> I tend to be an early adopter.   I hadn't seen any new commits in the mai=
n git=20
> repository in a while and was beginning to wonder if it had been abandone=
d.=20=20=20
> This thread has convinced me that isn't the case, but the main person doi=
ng=20
> the developing being busy.

It was a good discussion, and I'm happy you started it.

I think I've mentioned in some past discussions that it would be nice to
have some "gitsecurity" user-facing documentation, and one thing such a
thing could include is information that helped users to make an informed
decision about how much (if at all) they should be worrying about issues
arising from what hash they're using Git with.

But some documentation on the questions raised here would also be good,
i.e. "should I use the new hash?", which we could keep somewhat
up-to-date, and e.g. talk about the approximate state of major
third-party software, such as the forges.

Currently the closest thing we have to that is the rather sparse and
scary "THIS OPTION IS EXPERIMENTAL" in git-init(1) when talking about
--object-format=3Dsha256.

> I too want to say thank you (Brian) for your hard work.=20=20=20

And thank you for using & being interested in git, and contributing to
the ML!
