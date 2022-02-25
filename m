Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26156C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 23:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbiBYXQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiBYXQB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 18:16:01 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4719C1E5A65
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 15:15:28 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x5so9404355edd.11
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 15:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QYv/RDNrEaNSaFnjQdiSuFDUZDaC/Vr4RCtBA9PY+aU=;
        b=qsXP+YrkhLv2+Tz1Ienl+P5tO1zY7KMynebb8UwZOGd1lO5Rz5PgOF7nyF4W56UKsB
         1kCeY/NC7l9ZmXxIw11+La58YBb7FlWwuA8YffLk2OVUmfcOA7gW5FC8d0dPB94qgnHf
         Ww4Vr9WnBQGeeLAIc+zMB9ScNgwE4SqukccJx9fdwmtMvz8eW0dFu+kwl4L/YXoj4YYt
         mn636VP5ui9LOAQY9ASJFsMAgohWPmcEna6cCaCjGK1KeKM/Tl1iw9tzEkjDbbnRLlb4
         7ipAxWgU4o4aAZYalcBJ8eH8frChM7MDa2Xq25hsrkcUBRCVbFbz6/d7u7GRaLqCxHIw
         dLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QYv/RDNrEaNSaFnjQdiSuFDUZDaC/Vr4RCtBA9PY+aU=;
        b=5QSwEeqhYdDzCFTsfY3JxpAD6VvSpA7rbJKOpEhVAJujfGoZ5q0e7KwCSKb+s69HoP
         75+M7+FQlSbtRgqrSYA/0VwVylYfkXmAzTfQvY/D6p6nOvRofldwn2lp16Rr3oevLXuS
         7lvU52l28cfGop+JIC9DPLz16fdnLEGoUGqUxFDbPqmk9iVgkkT8HsdlraRv0X8vCTby
         Ps2bKzcy+h6yRVRRWvo/REZxa8JOUUZ6HkpdylsTwALWt2Y2d3y3eUvctZAzN+Kaa8kT
         7cGjMzgRcjjOBT28XAzdHpnFWnXjimM1+1F1dYjUbfuw+pvEvEHpUBCJjp/7o1jtPZw8
         4AKA==
X-Gm-Message-State: AOAM531MVlQBRIkjFx83sB5uwkbEtT8tdenOStrpgb5ZmYEoKKgDdGp0
        WkN+iZZl+7yiXG0HVMz/cbE=
X-Google-Smtp-Source: ABdhPJwmiDrj7iChD2NQyMHnQ0hXv8k7qyBo/DFAkgVargcJ/LD8hyun2xykSI4ShJ57DmZPoDWuOA==
X-Received: by 2002:a05:6402:438f:b0:412:a96b:a651 with SMTP id o15-20020a056402438f00b00412a96ba651mr9315898edc.40.1645830926650;
        Fri, 25 Feb 2022 15:15:26 -0800 (PST)
Received: from gmgdl ([109.36.128.147])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b006ce04bb8668sm1493930ejh.184.2022.02.25.15.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 15:15:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNjo4-000kFG-Rw;
        Sat, 26 Feb 2022 00:15:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/9] Makefiles: add "shared.mak", move
 ".DELETE_ON_ERROR" to it
Date:   Sat, 26 Feb 2022 00:05:49 +0100
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
 <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
 <patch-v3-2.9-96a490bec54-20220225T090127Z-avarab@gmail.com>
 <xmqqwnhi8swx.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqwnhi8swx.fsf@gitster.g>
Message-ID: <220226.861qzq7d2r.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 25 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/Makefile b/Makefile
>> index 6f0b4b775fe..d378ec22545 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1,3 +1,6 @@
>> +# Import tree-wide shared Makefile behavior and libraries
>> +include shared.mak
>> +
>>  # The default target of this Makefile is...
>>  all::
>
> Continuing with the theme of [1/9], this change to Makefile gets my
> firm NAK.  The first two lines MUST stay to be the first lines.
>
> Otherwise, a mistaken patch that adds rules to shared.make will
> make the first of these rules, not "all", as the default target.
>
> Just move it below to the third line or so and you'd be OK.

Understood, I can/will do that.

But wouldn't working this into this series be an even better option?

The ".DEFAULT_GOAL" variable is new in, 3.81 (01 Apr 2006), which I
think is old enough to hard depend on. We use $(or ...) added in the
same release in config.mak.dev.

We definitely have a hard dependency on "Version 3.80 (03 Oct 2002)"
$(eval ...) etc.

I checked and RHEL5 (which is otherwise the oldest OS we've supported)
has it, but RHEL4 doesn't (it has 3.80). So I think it's safe to have a
hard dependency on it and other things in 3.81 at this point.

diff --git a/Makefile b/Makefile
index 549ca6e7a5c..03321af7e3e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,9 +1,6 @@
 # Import tree-wide shared Makefile behavior and libraries
 include shared.mak
=20
-# The default target of this Makefile is...
-all::
-
 # Define V=3D1 to have a more verbose compile.
 #
 # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
diff --git a/shared.mak b/shared.mak
index 7ba04049c8a..1034dc758f1 100644
--- a/shared.mak
+++ b/shared.mak
@@ -1,3 +1,8 @@
+### By setting the default goal to "all" we override any implicit
+### setting once "make" sees our first target, which it'll ignore if
+### .DEFAULT_GOAL was explicitly set.
+.DEFAULT_GOAL =3D all
+
 ### Remove GNU make implicit rules
=20
 ## This speeds things up since we don't need to look for and stat() a
