Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D2C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 21:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiKIVzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiKIVzS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 16:55:18 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCFF2FFDE
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 13:54:53 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id t25so298864ejb.8
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 13:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h0MXHP8tfGLUG/N8HU9A6yPwhs1ZnQ5uZqn0hCAtcZI=;
        b=L1YPhs/mwtibE+3hK1BD0O9VV1pmhlyfRuAdrXzc5HvEIATF15mrncWer2ds2AQ3xu
         WV9loOH6Io1sOubjpW6An+ZbyfbWvUsH8cr1uhUD1t5cJq8n+5hNOFur9APjpuFCjCqO
         tpNoUoYSGwFtcOH/7KSWBijdcb0IFJvev4RjIK1dqSn6ZEMAq8kQ+yaSVZbrvgbPsdkd
         JAI7jCK8ghCREYSSFmL/5IEtbs4pexaAP5OuVaJQjG9InNHDwfSEN77eJK1DMsnGzNYC
         PviHt6EIjWTg9859Hm33L7EglQ/jfHB+CEetfL9bq1uWeetdN+0uwwiw6L8DAUHnsIki
         GWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0MXHP8tfGLUG/N8HU9A6yPwhs1ZnQ5uZqn0hCAtcZI=;
        b=6duJMmmEgp3BK2vesorgFgCi0VqdpZ6o3t3vD7qNLo62KR03H80pTq6Ubn3Qa07JI9
         madfOn72nrnAtuJLhWDMSS5LXJPChYUWjyY1BkZLClozmv3luqTm287FTbAbTHFNZeQT
         /oNVnfHwQng0bIfi9N8oqPqaJt2Ct3dI+vSBZlYKG8e+YmbIhVqdlNUiS7tI0M+zpoM7
         PkczHkEvjN4JHil0dSrMKiuCdbolItd8n6lqqMBfd7kvTlMemVJgdB0WpK9fdsVbJMn2
         bCknETwLMm5fSHzXQsLl0Wwid8oRQJwGqGlh2AGz1UlciAvJJhn3kbR3Xo0ZLUESXmDF
         G9Vw==
X-Gm-Message-State: ACrzQf26VQnZqwlaEBbvtPnAsfIgZ/mAUjSAQaddwvI7FqwaPRFLPzMT
        J/cor0WaHDdwBldao6cSDNw=
X-Google-Smtp-Source: AMsMyM71mr778Rz2EtDUG/RqAp/JKVGJsEAnjrcpYni3wYDc7gAyZh20BmoPdFcPZYQeayaYit6csQ==
X-Received: by 2002:a17:906:8a57:b0:7ad:69fb:3a with SMTP id gx23-20020a1709068a5700b007ad69fb003amr56541595ejc.179.1668030892140;
        Wed, 09 Nov 2022 13:54:52 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ca21-20020aa7cd75000000b004580862ffdbsm7515917edb.59.2022.11.09.13.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:54:51 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ost23-0018u7-0f;
        Wed, 09 Nov 2022 22:54:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
Date:   Wed, 09 Nov 2022 22:47:40 +0100
References: <20221109004708.97668-1-chooglen@google.com>
 <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <Y2wZw3eYO4ykwtA8@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2wZw3eYO4ykwtA8@nand.local>
Message-ID: <221109.86h6z7pzdg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 09 2022, Taylor Blau wrote:

> On Wed, Nov 09, 2022 at 08:34:28PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> An RFC alternative to Glen's [1], and what I *thought* he might be be
>> going for in the earlier discussion[2].
>
> I am a little puzzled with what to do with this series. For one, it
> doesn't seem to apply cleanly on top of 'ab/remove--super-prefix':
>
>     $ git log --oneline -1
>     04e36effde (HEAD -> ab/remove--super-prefix) Merge branch 'ab/submodu=
le-helper-prep-only' into ab/remove--super-prefix
>
>     $ git am -sc3 ~/patch
>     Applying: submodule--helper: don't use global --super-prefix in "abso=
rbgitdirs"
>     error: sha1 information is lacking or useless (submodule.c).
>     error: could not build fake ancestor
>     Patch failed at 0001 submodule--helper: don't use global --super-pref=
ix in "absorbgitdirs"
>     hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
>     When you have resolved this problem, run "git am --continue".
>     If you prefer to skip this patch, run "git am --skip" instead.
>     To restore the original branch and stop patching, run "git am --abort=
".

My bad, the CL says:

	and can make use of (but doesn't need) the better test coverage
	for "absorbgitdirs" that I submitted in [3]
	(https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-avarab=
@gmail.com/)".

But it actually *does* need that, sorry. But with that, this works for me:

	git checkout master
	git reset --hard @{u}
	git merge --no-edit ttaylorr/ab/submodule-helper-prep-only
	(apply https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-=
avarab@gmail.com/)

Then apply this series. I've also got it at
https://github.com/avar/git/tree/avar/nuke-global-super-prefix-use-local;
but that's a locally rebased version of ab/submodule-helper-prep-only,
then that [3], and finally this series.

I figured I was just kicking ideas back & forth with Glen, so I didn't
go through my usual sanity checking :)

> But it would be nice to have a clearer path forward between this and
> Glen's series. I understand that they are both still RFCs, but I am
> counting on you two working together to find a path forward that is
> satisfactory to you both.

*nod*, I'm sure we can manage that.
