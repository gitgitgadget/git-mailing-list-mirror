Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E396FC433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 08:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351587AbiELIyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 04:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351886AbiELIxm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 04:53:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B212514AF44
        for <git@vger.kernel.org>; Thu, 12 May 2022 01:53:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r71so3676100pgr.0
        for <git@vger.kernel.org>; Thu, 12 May 2022 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kq4A24B8DB2YLrvE6kI8wpj81hQORwfRV/EWnvNMdbg=;
        b=KKMMWWQXiNLym+V1u3khOb9bfw7qzeyOEerpBbydGI0ysdw+fLtQG9vzzMfrnZYcbj
         CqLkfKZrvWaW3XUSgMIYTC9hr1wnTrce6XHoCzku0KhqPA/3VbIRaWhK/ENcwUTW4dCM
         q9aNzGgGKUx1u6xCIATn04iPZLcvZ4B12PyxdOr8ItUqlpvfBNTO9W8iVEm1ZLgA5s89
         PDGi5I+MXopdqVlQAAL76HHOknhqyu8TJ6i/rAtj4llufKfk5rB4oMJK9qEeVRELPEAZ
         b2MThdb1QyIxVsRxG425KW/mUoGMnPFGPmdEaRBetAWa4XvQ7mLRTRk6ukeb35Xxw9u5
         RNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kq4A24B8DB2YLrvE6kI8wpj81hQORwfRV/EWnvNMdbg=;
        b=nbfVXcYLi8fjkqBZtyY5TRjioOEElxYEWgEIOya3mlCgx0lO1lM+y17k0XqRM2UbnB
         47LlZGgMDc39Xtups/iQeJKl03y24/w6PF8ry7sI11X1wyewMdv3AjCDGejCsEXlz2sA
         SYDrBqi4L43vanT5JdHrpvCmuu37xmAGFNKBaDX762etw8tU+grW78X6R/EBZAd0IXc6
         KbmaKKE2SEu+R8em5enmS8yoz4fv+0T8otJwKDrcscwTv2IwmqcLRT99FR2jEmkpoCFx
         4XTmVG6STk4NuaZBrb3AyRfx2Vz+DNf5sptqQ7xAIqYe+gBXx/ft/7AudDBTNzVzKpAc
         DkKw==
X-Gm-Message-State: AOAM530O/CePwyRGVMANI8bzwkH37NPerhJIGs4/TvCV43EPm0NaCwMM
        2Ae3JVy2i/kUy3hc6/tgWZ37aQEbZHahWSz0VpU=
X-Google-Smtp-Source: ABdhPJwEDWd20a4EUQ1Wipg7oB28g5I5+2iM6QRjz4swt9pw3M2n7VokIZktHV45YDYUY8Z+6T+ZEeQd6cuGQ8kwoA0=
X-Received: by 2002:a63:4101:0:b0:3aa:6375:e5f4 with SMTP id
 o1-20020a634101000000b003aa6375e5f4mr24171542pga.240.1652345591908; Thu, 12
 May 2022 01:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220502083639.610279-1-chriscool@tuxfamily.org>
 <20220504104601.136403-1-chriscool@tuxfamily.org> <20220505112114.ktki3dgjbyukzhlm@carlos-mbp.lan>
In-Reply-To: <20220505112114.ktki3dgjbyukzhlm@carlos-mbp.lan>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 12 May 2022 10:52:59 +0200
Message-ID: <CAP8UFD3UvjJzEQApiCKSknDWaTjbEMKkr17j1QN-8gwz7eWV3Q@mail.gmail.com>
Subject: Re: [PATCH v2] http: add custom hostname to IP address resolutions
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 5, 2022 at 1:21 PM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> On Wed, May 04, 2022 at 12:46:01PM +0200, Christian Couder wrote:
> > diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> > index f92c79c132..d97380be87 100755
> > --- a/t/t5551-http-fetch-smart.sh
> > +++ b/t/t5551-http-fetch-smart.sh
> > @@ -567,4 +567,11 @@ test_expect_success 'client falls back from v2 to =
v0 to match server' '
> >       grep symref=3DHEAD:refs/heads/ trace
> >  '
> >
> > +test_expect_success 'passing hostname resolution information works' '
> > +     BOGUS_HOST=3Dgitbogusexamplehost.com &&
>
> minor nitpick, but better to use example.com here which is reserved for t=
his
> type of uses and therefore unlikely to conflict with a possibly assigned
> domain.

Sorry for not replying to this earlier, but Junio previously suggested
the following:

"Perhaps invent a totally bogus domain name, map that to
localhost ::1, run a test server locally, and try to clone from that
bogus domain?"

(See: https://lore.kernel.org/git/xmqqfslrycvp.fsf@gitster.g/)

I think "a totally bogus domain name" refers to something other than
"example.com".

Also "example.com" does seem to resolve to an IP address and even has
an HTTP(S) server on it, while I think the purpose of the test would
be to check that there is not even a valid DNS resolution when the new
option is not used.
