Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B29EC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353174AbiBCSHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353146AbiBCSHr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:07:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69733C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:07:47 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id y5so1951135pfe.4
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=edO67G3hmmX3DJlAI9V5pV+KLwpbZHq8mWnbgPVKSAc=;
        b=IGKr/TGULHmfpbeLakI/WgZ54ugWWJucAZ1Ws6gsQ0N8ZseZLP2CfiRCaqYUTrAi3d
         1qUEGDZCgye+11yagqID2BR6+KJ9XUNQTHF2KtYzbDWKjY193VBykFeL0jPIpxNiveBx
         ntzlniDkUs8A51oI0qhoVtIS98jFxwUyC1wcH5M8PG9Zgn1JKpOh2tPJnUD5gJWBWzuv
         4IqnF8CHTdH/nND85v4otrV7roAgaHzT+lpRqJ8eW9Um6KkN0dP4k564H2lynietDvMZ
         u3W9hDX7Cc2yYYNWVByFCbwWFoKA0ZT6Pbaa0Yf2yr3ca1/wjfV8ND6/x0nEfCr01te1
         U2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=edO67G3hmmX3DJlAI9V5pV+KLwpbZHq8mWnbgPVKSAc=;
        b=cErLbJooiboXrNb4+tDGP5KZ6w2InJjbOlQ50nYNn3w5yxXziV1ygxX1tAl0usBJPP
         TbEVxqeUyyLWwe9M4FT7iYJa9LKtjkHPy/gs34H4sIoPVVJ72F8FlOyzc7naRZOcvEfi
         9UHNrwyrPBeZc9Fo7+3Cbr3J2Xyff5MiHMksI38My07ZUuQsgVmRx6axL6Ja+WAn9EGR
         b0IjCz1/WOKQhgGqfCQP8BkdJwb4CKvA7vMAimoGvsUGjxGVIbZ2yRNUqomMGNuxoKle
         e8c4l3L4JgY9/aWhJtcTpNI/QCSIje3WWeUkQUwaqOkH2pK2NJ97ZeqR3OGaF0tUZVX4
         +jpg==
X-Gm-Message-State: AOAM530DcosDgAnUTrtNuwHI2OpogYX/iM+l/hXxcIQFNvadRrv6g2fC
        O1TuxpsIEXfL/HQtsF+ji48=
X-Google-Smtp-Source: ABdhPJyDG9ekfJIfwnFqXFDaDTgfPGLgAist98A7qsuXHOb+0bIT1W2jyvrJ3ZsQQ2leQKnREDVw9Q==
X-Received: by 2002:a65:4547:: with SMTP id x7mr29234311pgr.467.1643911666757;
        Thu, 03 Feb 2022 10:07:46 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id u12sm26955756pfi.1.2022.02.03.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 10:07:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Greg Hurrell <greg@hurrell.net>, git@vger.kernel.org,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
Subject: Re: git-checkout doesn't seem to respect config from include.path
References: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
        <0b8222c2-7337-7e8f-33d1-7926462daac1@gmail.com>
Date:   Thu, 03 Feb 2022 10:07:45 -0800
In-Reply-To: <0b8222c2-7337-7e8f-33d1-7926462daac1@gmail.com> (Phillip Wood's
        message of "Thu, 3 Feb 2022 15:54:23 +0000")
Message-ID: <xmqq1r0jx1qm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... What we really want in this case is to
> store the string value for each config option as we read each config
> source and then parse those values at the end, unfortunately I think
> that would break multi-valued config keys.

Thanks for raising, and looking into, the issue.

While the original "callback functions are called for each and every
configuration item defined in the files and it is the responsibility
for these callback functions to implement the semantics like the
last one wins" design that uses git_config() makes it harder, but I
think we are already halfway there, with the more recent API update
in 2014 (!) that allows config_get_value() to go directly get a
value given a key without writing callback functions.

I think builtin/add.c predates the configset API work (of course, it
is natural that we can "git add" way before 2014), and mostly uses
git_config(add_config) callback as a way to parse its configuration,
because it needs to tell other subsystems (like diff, merge, etc.)
that are even older to pay attention to the configuration variables
they care about.

So it may be a major surgery to switch to the newer
config_get_value() API.

For a "last one wins" variable, config_get_value() will only look at
the last item, so any garbage value Git does not recognize would not
trigger a fatal error.

Such an update is both good and bad.  Surely it makes the scenario
that triggered this discussion more pleasant by not dying, but it
makes it too pleasant by not even giving the user a chance to notice
a possible typo.

A incremental improvement that we can immediately make is probably
to teach the current xdiff-interface.c::git_xmerge_config() parser
to react to an unknown value differently.  It should not die() but
just ignore the unknown value, and issue a warning.  This should be
doable with minimum impact to the code.

Completely untested.  The first test that would be interesting to
run is how many tests this changes breaks to gauge how good test
coverage we have ;-)

 xdiff-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/xdiff-interface.c w/xdiff-interface.c
index 2e3a5a2943..523b04960a 100644
--- c/xdiff-interface.c
+++ w/xdiff-interface.c
@@ -322,8 +322,8 @@ int git_xmerge_config(const char *var, const char *value, void *cb)
 		 * git-completion.bash when you add new merge config
 		 */
 		else
-			die("unknown style '%s' given for '%s'",
-			    value, var);
+			warning("ignored unknown style '%s' given for '%s'",
+				value, var);
 		return 0;
 	}
 	return git_default_config(var, value, cb);
