Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A84C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EF12611AE
	for <git@archiver.kernel.org>; Thu,  6 May 2021 08:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbhEFIuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 04:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhEFIuq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 04:50:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA826C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 01:49:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso3085036pjb.1
        for <git@vger.kernel.org>; Thu, 06 May 2021 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QExGGPghMogbyOb8+nhBeMqXeh0cx/eE8cjFRD9yubc=;
        b=ktnDXv14DgOshxmkJv/YrVtu3mhKJAikkWw1RZaCR6lBJeitUsNZr0UHhnw7BjfBcF
         oq0SmYHdxTQJgL9YNBznrGmO2Pa3RIQFd6HLb90lzXgrNCpuwph08j5mtFXivevaXqqL
         wR8FXkrOQd/kjYZXW/Dby+/s8MWnPtfdf13a+RaulEEqDp9+u/5xEJCZulYruD1IJl2d
         ClbnZIrtiiTM4/U5Q5qzlxyl3V1R4S6mJyeSZC5o03SZTf21Klq8aGJJUetZXPW1UExE
         EH0KA05ydJYg3MyVWMC+5xtjqGlo6FBaiC72JQGAbkWqxl2fjDV0dtK7eR6J9XtyItSu
         4eGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QExGGPghMogbyOb8+nhBeMqXeh0cx/eE8cjFRD9yubc=;
        b=DCJbNpP+Avhtc/YjRvNHfpnI1G4vv/tcLTZuOPU4f8ydZI32ATmI+7dJRESwPvzBiK
         eDxWLUBg+EUZ17rGEc560qua5N68KCqTczOYC5Q3QDz4m8mPftaLE/0YYmHri8H3SG7L
         OqeZESRtNMJdfMDvO8NAz4bCyX9A6GeH9zlGg6amff36tJt2vJe+B3aQ7plxfnNCC5rj
         B2EGz2VvbH7+VyKVUtoDX6Otnw0rUNDd/1yIjrzy9WB72s3Gp0fDuEyV+NTO/ns9eWJV
         lOmcl3Zr3Ifjybo5Y1a74e8Z3/kqi0V6QRR8nvuC8E2+VzssYQH2WKxgiuoQqVkY5L85
         ciRw==
X-Gm-Message-State: AOAM533C/vjVr9Bs3+9b1nTm2wlyQWmwxL8ZSNYbkWP8qFVLUQgUhI+5
        IQ7gJj1izX7O2Wkjw6kF2c6Szj09c6K3wuFTMRGlxAGUX+j6wke7Vi+zzQ==
X-Google-Smtp-Source: ABdhPJw+50dU1Xzi30z4pSCX/Amlf6tZL1HmdK41tysZyd1pkDlfa4OmdRtbWve51FaGxDqT8buj0oU17wObntfyZrk=
X-Received: by 2002:a17:902:f2c2:b029:ed:929a:75bc with SMTP id
 h2-20020a170902f2c2b02900ed929a75bcmr3362588plc.0.1620290987396; Thu, 06 May
 2021 01:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210506081936.29887-1-dyroneteng@gmail.com> <xmqq35v0z1uw.fsf@gitster.g>
In-Reply-To: <xmqq35v0z1uw.fsf@gitster.g>
From:   dyrone teng <dyroneteng@gmail.com>
Date:   Thu, 6 May 2021 16:49:36 +0800
Message-ID: <CADMgQSRg559o_MLSsPvAU3c7_2uWWm0LuBkPZaQ-PD=oqqAEJQ@mail.gmail.com>
Subject: Re: [PATCH] Fix a small flaw in the comment of strmap.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>The original is correct; this function returns a non-zero value if
>and only if (iff is a common abbreviation for this expression) "str"
>is in the map, implying that when "str" is not in the map, the
>caller can rest assured that the function will not return a non-zero
>value (in other words, the caller is guaranteed to receive zero).

>If you change that to "if", the comment no longer says what happens
>when "str" is *not* present in the map, which is making it worse.

Thanks, got it.

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:46=E5=86=99=E9=81=93=EF=BC=9A
>
> Teng Long <dyroneteng@gmail.com> writes:
>
> > Subject: Re: [PATCH] Fix a small flaw in the comment of strmap.h
>
> cf. Documentation/SubmittingPatches::summary-section
>
> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
> > ---
> >  strmap.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/strmap.h b/strmap.h
> > index 1e152d832d..0d1d00d14e 100644
> > --- a/strmap.h
> > +++ b/strmap.h
> > @@ -78,7 +78,7 @@ struct strmap_entry *strmap_get_entry(struct strmap *=
map, const char *str);
> >  void *strmap_get(struct strmap *map, const char *str);
> >
> >  /*
> > - * Return non-zero iff "str" is present in the map. This differs from
> > + * Return non-zero if "str" is present in the map. This differs from
>
> The original is correct; this function returns a non-zero value if
> and only if (iff is a common abbreviation for this expression) "str"
> is in the map, implying that when "str" is not in the map, the
> caller can rest assured that the function will not return a non-zero
> value (in other words, the caller is guaranteed to receive zero).
>
> If you change that to "if", the comment no longer says what happens
> when "str" is *not* present in the map, which is making it worse.
