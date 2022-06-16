Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4500FC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 22:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378591AbiFPWHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiFPWHN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 18:07:13 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D086160C
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:07:12 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id x9so2445284vsg.13
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4YuYwzneiXSn9/jesY1EYEm7Us8yqmuslpoct0cjf+8=;
        b=EgqzN2L708UMiHHS9x8+n603raF9DK3i1Tbwn0YaWKuda6trQFrxUoG37wDzic7LMu
         FjzpR0kRpS+/IYNDAKxlGQpA6gYKckoNHl58kAHnlaeKp8XBLx1yEJeFsiWPx7LBvd7A
         V1xJHwqAQUMsCLbiWUSwVuPvXvB8mqSd02N7pyYrfEEMtLWW9ZsApOEeZkSn9FAovAZ1
         /BcGMUFCsx6E/+7qG4o1Fy/447w1TtIPCR8ftqtcLvVs20k3MoyPtZ03j0zJ93R8vju2
         N74HELOjJTEjNB6Tq20/97zFCyJmdYZFru5G2ylBbFBZAVUOoMD68A/iiuBcjx789r06
         vCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4YuYwzneiXSn9/jesY1EYEm7Us8yqmuslpoct0cjf+8=;
        b=lxJrEQmDAnhYsBqRTSAvBrYaBXv+ZklnQ4SmxZ6q1JlaoBJDV7SwQypItHpv+FC2R9
         vsYt2c6I1U6x1Ni5z/tuPoYxO8u3szRcGno6qQP6Y+1D8YCEZ5RAFxiEkDBdeH917dii
         nLjIbPVKBgZjJ9gHjjjM3PJpKVzXPGiBij6cuoap9/tK3j0Zp34p5OcnZktDjpcv0JNV
         d47E0IaXzL94FARtPDZ9zlLrNDP5guLPkMrLZbMel3IWm6tV1pH39PgqxJ8gVupbxhDj
         gviv+PsZj0F9pAulv/ayRndhH6L0IbZvgj+UBzNViUwUXxk9jz/SAjnuybAVfWGMIBCb
         TyTw==
X-Gm-Message-State: AJIora/auj1z4hBA3C7dLpprnhhlm8emt05cT07f2rtls8G7F6Cn2lSg
        7fW/Liznb8fxmO6pU+N1rhfVzIkWmS9CNWTIlaw=
X-Google-Smtp-Source: AGRyM1tyu/rvoePQYjO78abAbntOuTHeIdo5NasrZ7yuTHCUkpVthSRWT5CYFNANjj6dSMoBHXviEtVc7vF0FOXbYMs=
X-Received: by 2002:a05:6102:215c:b0:34c:1e12:afa with SMTP id
 h28-20020a056102215c00b0034c1e120afamr3270014vsg.29.1655417231968; Thu, 16
 Jun 2022 15:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
 <20220616205456.19081-4-jacob.e.keller@intel.com> <xmqq35g4s3xl.fsf@gitster.g>
In-Reply-To: <xmqq35g4s3xl.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Jun 2022 15:07:02 -0700
Message-ID: <CA+P7+xomvVK4ZvQfepbVCCgE8uXZvueZQudEa07pvWQYrU=hJQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tests: only automatically unset matching values
 from test_config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 2:18 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > +     # Only enable --fixed-value if we have two parameters
> > +     if test $# < 2
> > +     then
> > +             fixedvalue=
> > +     fi
>
> Two comments:
>
>  * Does "<" do what you expect to do?  Did you mean "-lt"?
>
>  * Using "bug in the test script: $*" and diagnosing missing
>    parameters, instead of silently ignoring the option the developer
>    wrote, would be more preferrable.

I guess we should check that it has exactly 1 or 2 arguments, yea.

>
> > +     git ${config_dir:+-C "$config_dir"} config ${global:+--global} ${fixedvalue:+--fixed-value} --unset-all "$1" "$2"
> >       config_status=$?
> >       case "$config_status" in
> >       5) # ok, nothing to unset
> > @@ -575,7 +586,7 @@ test_config () {
> >               esac
> >               shift
> >       done
> > -     test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} ${global:+--global} '$1'" &&
> > +     test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} --fixed-value ${global:+--global} '$1' '$2'" &&
>
> Why are $1 and $2 enclosed in a pair of single quotes?  Is the
> assumption that they do not contain a single quote themselves?
>
> I guess that is true also for config_dir and shares the same
> problem, so you are not introducing a new problem.
>

Yea, I wasn't sure.

> >       git ${config_dir:+-C "$config_dir"} config ${global:+--global} "$1" "$2"
> >  }
