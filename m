Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2834AC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 19:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F1B613B6
	for <git@archiver.kernel.org>; Thu, 27 May 2021 19:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhE0TUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 15:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhE0TUg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 15:20:36 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D23C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 12:19:02 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so1222904otc.12
        for <git@vger.kernel.org>; Thu, 27 May 2021 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ie+2imXJ6K62FPXshZ870zxiGLquMx5w5piStvJD/1s=;
        b=nVTOpnoSE7WQGOqzfkOJ+3W8Hts8+GYP6RCJjla9xVAmUgFgAPJMR6XG98UHQ9oJuk
         IhrWBKbHB1FpEO55yDxLp8HifUs/9x+Pvy9Ob/Ew1WE/fyZC3ZpGsk/QOo0/z+y14ANe
         uc1RMX4M6ASTGK6gcXYb66GWTIoPwyNaIdieUY9tyNM/H39oRCkpvfuSz/iAU9uFKm0c
         4Il5PlJFe2ZR0zeoS/gUCRbi/k9PeP5EaLzbGQAZr2EHEjtiugA0e6ywiwgJWUcEmGWs
         diGE/XFby6CydCW6DdaA5fEFjw6I+gUnSH/YMGhRMr3Sh8dGZhI3YSJQTM9R8m8HB3M3
         LBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ie+2imXJ6K62FPXshZ870zxiGLquMx5w5piStvJD/1s=;
        b=nKa/dnSDegHhTNFvKPQuptOqZgjZUtev9xCTWZBk0g6R8E6y4iNIgDQRLkX1mbB7u0
         OZv4VZAbbiPOxmuBxSdTWwMLyNAh4vmFhLHC1BraSvp16hBLmUUSyOge8ysQCkEGBY7V
         3xfVW7UlrAfnqOjaBvcIuUtcVWDzcq3oHAadIta30XmKbdELkgY2JbNAHVLqFE8kMCsI
         ozVrptIgx5uepUUByktYl3S4TFwAgW1nqlK1LLHU2+16jFsoi5wkcW4lmpBAVy7K04pd
         Qqls+VxwIctxWEL0zN0ISrfbU3hSfXfsvzwNFFNIzhvPUFxL/Yldzrqj47TLnooWI2t8
         iYLQ==
X-Gm-Message-State: AOAM533wBKyeLHlexSclST1J6Yc+L9UHY4jP8B3hRAmtQ4nkH9wUQB6B
        y3GrwOUst1579LUaVsv1y35hu1w+BTV5DQ==
X-Google-Smtp-Source: ABdhPJzqVdvfd3QWL302lUfQOymscBp8fD1RBH3IrekW4ZHJrJUxVObpcPLMtm2hm/+A82+aYyTP7w==
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr4075640otn.50.1622143141935;
        Thu, 27 May 2021 12:19:01 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y34sm664813ota.16.2021.05.27.12.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:19:01 -0700 (PDT)
Date:   Thu, 27 May 2021 14:19:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <60aff0a416f40_265302082c@natae.notmuch>
In-Reply-To: <87tumol4tg.fsf@evledraar.gmail.com>
References: <87bl8xmipo.fsf@evledraar.gmail.com>
 <20210527115226.42539-1-zhiyou.jx@alibaba-inc.com>
 <87tumol4tg.fsf@evledraar.gmail.com>
Subject: Re: Runaway sed memory use in test on older sed+glibc (was "Re:
 [PATCH v6 1/3] test: add helper functions for git-bundle")
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Thu, May 27 2021, Jiang Xin wrote:
> =

> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E20=
21=E5=B9=B45=E6=9C=8827=E6=97=A5=E5=91=A8=E5=9B=9B
> > =E4=B8=8A=E5=8D=882:51=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>
> >> On Mon, Jan 11 2021, Jiang Xin wrote:
> >>
> >> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >> >
> >> > Move git-bundle related functions from t5510 to a library, and thi=
s
> >> > lib
> >> > will be shared with a new testcase t6020 which finds a known
> >> > breakage of
> >> > "git-bundle".
> >> > [...]
> >> > +
> >> > +# Format the output of git commands to make a user-friendly and
> >> > stable
> >> > +# text. =C2=A0We can easily prepare the expect text without havin=
g to
> >> > worry
> >> > +# about future changes of the commit ID and spaces of the output.=

> >> > +make_user_friendly_and_stable_output () {
> >> > + =C2=A0 =C2=A0 sed \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${A%${A#???????}=
}[0-9a-f]*/<COMMIT-A>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${B%${B#???????}=
}[0-9a-f]*/<COMMIT-B>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${C%${C#???????}=
}[0-9a-f]*/<COMMIT-C>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${D%${D#???????}=
}[0-9a-f]*/<COMMIT-D>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${E%${E#???????}=
}[0-9a-f]*/<COMMIT-E>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${F%${F#???????}=
}[0-9a-f]*/<COMMIT-F>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${G%${G#???????}=
}[0-9a-f]*/<COMMIT-G>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${H%${H#???????}=
}[0-9a-f]*/<COMMIT-H>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${I%${I#???????}=
}[0-9a-f]*/<COMMIT-I>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${J%${J#???????}=
}[0-9a-f]*/<COMMIT-J>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${K%${K#???????}=
}[0-9a-f]*/<COMMIT-K>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${L%${L#???????}=
}[0-9a-f]*/<COMMIT-L>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${M%${M#???????}=
}[0-9a-f]*/<COMMIT-M>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${N%${N#???????}=
}[0-9a-f]*/<COMMIT-N>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${O%${O#???????}=
}[0-9a-f]*/<COMMIT-O>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${P%${P#???????}=
}[0-9a-f]*/<COMMIT-P>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${TAG1%${TAG1#??=
?????}}[0-9a-f]*/<TAG-1>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${TAG2%${TAG2#??=
?????}}[0-9a-f]*/<TAG-2>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/${TAG3%${TAG3#??=
?????}}[0-9a-f]*/<TAG-3>/g" \
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -e "s/ *\$//"
> >> > +}
> >>
> >> On one of the gcc farm boxes, a i386 box (gcc45) this fails because
> >> sed
> >> gets killed after >500MB of memory use (I was just eyeballing it in
> >> htop) on the "reate bundle from special rev: main^!" test. This with=

> >> GNU
> >> sed 4.2.2.
> >>
> >> I suspect this regex pattern creates some runaway behavior in sed
> >> that's
> >> since been fixed (or maybe it's the glibc regex engine?). The glibc =
is
> >> 2.19-18+deb8u10:
> >>
> >> =C2=A0 =C2=A0 + git bundle list-heads special-rev.bdl
> >> =C2=A0 =C2=A0 + make_user_friendly_and_stable_output
> >> =C2=A0 =C2=A0 + sed -e s/[0-9a-f]*/<COMMIT-A>/g -e s/[0-9a-f]*/<COMM=
IT-B>/g -e
> >> s/[0-9a-f]*/<COMMIT-C>/g -e s/[0-9a-f]*/<COMMIT-D>/g -e
> >> s/[0-9a-f]*/<COMMIT-E>/g -e s/[0-9a-f]*/<COMMIT-F>/g -e
> >> s/[0-9a-f]*/<COMMIT-G>/g -e s/[0-9a-f]*/<COMMIT-H>/g -e
> >> s/[0-9a-f]*/<COMMIT-I>/g -e s/[0-9a-f]*/<COMMIT-J>/g -e
> >> s/[0-9a-f]*/<COMMIT-K>/g -e s/[0-9a-f]*/<COMMIT-L>/g -e
> >> s/[0-9a-f]*/<COMMIT-M>/g -e s/[0-9a-f]*/<COMMIT-N>/g -e
> >> s/[0-9a-f]*/<COMMIT-O>/g -e s/[0-9a-f]*/<COMMIT-P>/g -e
> >> s/[0-9a-f]*/<TAG-1>/g -e s/[0-9a-f]*/<TAG-2>/g -e
> >> s/[0-9a-f]*/<TAG-3>/g -e s/ *$//
> >> =C2=A0 =C2=A0 sed: couldn't re-allocate memory
> >
> > I wrote a program on macOS to check memory footprint for sed and perl=
.
> > See:
> >
> > =C2=A0 =C2=A0 https://github.com/jiangxin/compare-sed-perl
> =

> Interesting use of Go for as a /usr/bin/time -v replacement :)

Here's a Ruby version:
https://dpaste.com/FYT2QKHJE

I'm not sure if will be useful in this particular case, but Ruby code
always ends up simpler ;)

-- =

Felipe Contreras=
