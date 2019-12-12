Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAB9C04E30
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 03:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF3021655
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 03:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1J6pLfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfLLDkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 22:40:41 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:41240 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfLLDkk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 22:40:40 -0500
Received: by mail-qk1-f182.google.com with SMTP id l124so473890qkf.8
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 19:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=THCpW3wuGJVGOvECLtjGbnehJa+XkNuV+Sg/Hs0rJag=;
        b=G1J6pLfI1jIdtAijeKoPwBiCgG+Wvay3JWM+zkzWxWh8EvF2XF3q6OtNgqdvrOGAil
         dfTwZ6IsbRrhLFIycwEDcxwXMPnP/CcVmTWVicrf2XkqQnD3adhCXMs0bXVjFu0gBBl+
         LzWQ5TuQk8ffREDdNq2QQSDwoiWp5AfXcKtknJg1mfksb7J0oS05cXihMpK92LpzTFjO
         ZvOqrfc65C6pzRIlGwZBwn0IpYI3blQ63CB0CW+2VuzPd6ptUEjmG+KS+swePNsog/Xy
         vm9BneeGyjumMukEUvRttJgJura56FL8Scn9yWgwesjXr7V/msaYbr3879p8+q1QMq57
         Stfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=THCpW3wuGJVGOvECLtjGbnehJa+XkNuV+Sg/Hs0rJag=;
        b=NI3CF0pPkkgCber8CzD6WQel5t4wc3z9Bhw3o91+ri8nQl2jJngmsqWBNQI/tzJiS5
         2wU5F9ZU4ZRrEl0mctR9XQi94GK9hamKU5elBVc3Yf1AaLWbt8nbPZRFubSWVrMAM8Nd
         ECJzUOobEVgweZYoxi/QRkMqUrDGg6PtjxqrOjf37L6qea1waE/55IFvgSYwby2qFkd3
         ZieEjurD676uOBzRJeNmlivgGFwv7jRo2nvdkfMebeUxHoeCe+BlYumrrprOrA+oaYWh
         fj+WX2xCMDurWc8Kvl6lPzV7Y5ZDCW++K+93gURBxIdWVcOGAxxCmbTmC696zmcBsGKp
         V2oA==
X-Gm-Message-State: APjAAAVTDe5Nf55399jQCLlynRr1+OAPZyfkAgV+1abr7xfo8uESVhTU
        aIxdHPtRSX5/xss8CD+TCi0=
X-Google-Smtp-Source: APXvYqzuomZgp6qno6JNjwvNujtis8C+CWWwdmnK2dCYvb0FVgOV8dzccZ4ueiefpdbGUyec49Lv0w==
X-Received: by 2002:a37:4d45:: with SMTP id a66mr6361158qkb.65.1576122039762;
        Wed, 11 Dec 2019 19:40:39 -0800 (PST)
Received: from DESKTOPCTCSEL8 (ool-44c0afa6.dyn.optonline.net. [68.192.175.166])
        by smtp.gmail.com with ESMTPSA id e6sm1313243qkg.89.2019.12.11.19.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 19:40:38 -0800 (PST)
From:   <mattr94@gmail.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'Emily Shaffer'" <emilyshaffer@google.com>
Cc:     <git@vger.kernel.org>, "'Philip Oakley'" <philipoakley@iee.email>
References: <20191211233820.185153-1-emilyshaffer@google.com> <20191212031003.GA1196215@coredump.intra.peff.net>
In-Reply-To: <20191212031003.GA1196215@coredump.intra.peff.net>
Subject: RE: [PATCH v2] config: add string mapping for enum config_scope
Date:   Wed, 11 Dec 2019 22:40:37 -0500
Message-ID: <1062901d5b09d$eafbc420$c0f34c60$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
thread-index: AQH30tjAjnPM0YV1KE+yGfDJyGwfdwErKQXip2g8WYA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>=20
Sent: Wednesday, December 11, 2019 10:10 PM
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org; Matthew Rogers <mattr94@gmail.com>; Philip =
Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2] config: add string mapping for enum config_scope

On Wed, Dec 11, 2019 at 03:38:20PM -0800, Emily Shaffer wrote:

> If a user is interacting with their config files primarily by the 'git =

> config' command, using the location flags (--global, --system, etc)=20
> then they may be more interested to see the scope of the config file=20
> they are editing, rather than the filepath.

I don't mind adding this in, but I think we did discuss this same =
concept when we did "config --show-origin", and ended up showing the =
whole path, to help with a few cases:

  - you know you're getting a value from the "system" config, but you
    don't know where that is (e.g., because the baked-in sysconfdir path
    is something you didn't expect)

  - you're in a scope like "global", but the value actually comes from
    an included file

Of course there's a flip-side, which is that showing "/etc/gitconfig"
doesn't tell you that this is the "--system" file; the user has to infer =
that themselves.

There are no callers added here, so I'm not sure exactly how the new =
function is meant to be used. But I'd caution that it might be worth =
showing the scope _and_ the path, instead of one or the other.

-Peff

Just to mention, that I am working on submitting a feature to expand =
config with a --show-scope option via gitgitgadget.  I still have some =
kinks to iron out before it's ready for submission, but maybe it would =
make sense to wait for that? Or to wait for the rest of the patches this =
was taken from to actually materialize?

